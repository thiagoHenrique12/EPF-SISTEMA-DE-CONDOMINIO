from bottle import route, request, redirect
from controllers.base_controller import BaseController
from services.user_service import user_service
from models.reserva import Reserva, reserva_model, Recurso

class ReservaController(BaseController):

    @route('/minhas_reservas', method='GET')
    def minhas_reservas(self):
        user_id = request.get_cookie("user_id", secret='minha_chave_secreta_super_segura')
        if not user_id: return redirect('/login')
        
        usuario = user_service.get_by_id(user_id)
        if not usuario: return redirect('/login')
        reservas = reserva_model.get_by_morador(usuario.id)
        return self.render('minhas_reservas', title="Minhas Reservas", usuario=usuario, reservas=reservas)

    @route('/reservas/nova', method='GET')
    def nova_reserva_form(self):
        recursos = [r.value for r in Recurso]
        return self.render('reserva_form', title="Nova Reserva", recursos=recursos)

    @route('/reservas/nova', method='POST')
    def nova_reserva_post(self):
        user_id = request.get_cookie("user_id", secret='minha_chave_secreta_super_segura')
        if not user_id: return redirect('/login')

        recurso = request.forms.get('recurso')
        data_inicio = request.forms.get('data_inicio') 
        data_fim = request.forms.get('data_fim')
        data_inicio = data_inicio.replace('T', ' ')
        data_fim = data_fim.replace('T', ' ')
        nova_reserva = Reserva(recurso=recurso, morador_id=user_id, data_inicio=data_inicio, data_fim=data_fim)
        
        
        sucesso = reserva_model.add_reserva(nova_reserva)
        
        if sucesso:
            return redirect('/minhas_reservas')
        else:
            return redirect('/minhas_reservas')

    @route('/reservas/cancelar/<reserva_id>', method='GET')
    def cancelar_reserva(self, reserva_id):
        reserva_model.cancel_reserva(reserva_id)
        return redirect('/minhas_reservas')

reserva_controller = ReservaController()