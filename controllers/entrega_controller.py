from bottle import route, request, redirect
from controllers.base_controller import BaseController
from models.entrega import Entrega, entrega_model
from services.user_service import user_service
from models.user import UserRole

class EntregaController(BaseController):
    @route('/entregas', method='GET')
    def listar_entregas(self):
        entregas= entrega_model.get_all()
        moradores = {u.id: u for u in user_service.get_all()}
        return self.render ("entregas", entregas=entregas, moreadores=moradores, title= "Gestão de Encomendas")
    
    @route("/entregas/nova", method="GET")
    def nova_entrega_form(self):
        todos_usuarios = user_service.get_all()
        destinatarios=[u for u in todos_usuarios if u.get_tipo() in ['morador', 'síndico']]
        return self.render('entrega_form', destinatarios=destinatarios, title="Registrar Encomenda")
    
    @route('/entregas/nova', method='POST')
    def nova_entrega_post(self):
        descricao = request.forms.get("descricao")
        morador_id = request.forms.get("morador_id")
        
        nova_entrega = Entrega(descricao=descricao, morador_id=morador_id)
        entrega_model.add_entrega(nova_entrega)

        return redirect("/entregas")
    
    @route('/entregas/confirmar/<entrega_id>', method='GET')
    def confirmar_retirada(self, entrega_id):
        entrega_model.registrar_retirada(entrega_id)
        return redirect("/entregas")
entrega_controller = EntregaController()    
    
    
