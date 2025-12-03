from bottle import request, redirect
from controllers.base_controller import BaseController
from models.reserva import Reserva, reserva_model, Recurso
from services.user_service import UserService

class ReservaController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.user_service = UserService()
        # Rotas no init.py

    # --- SEGURANÇA ---
    def checar_morador(self):
        user_id = request.get_cookie("user_id", secret='chave_segura')
        if not user_id:
            redirect('/login')
        
        usuario = self.user_service.get_by_id(user_id)
        if not usuario or usuario.get_tipo() != 'morador':
            # Se porteiro tentar reservar, manda pra portaria
            redirect('/portaria')
        return usuario

    # --- AÇÕES ---

    def minhas_reservas(self):
        usuario = self.checar_morador() # 🔒
        
        reservas = reserva_model.get_by_morador(usuario.id)
        return self.render('reservas', title="Minhas Reservas", usuario=usuario, reservas=reservas)

    def nova_reserva(self):
        usuario = self.checar_morador() # 🔒
        
        # Pega a lista de recursos do Enum para o Select
        opcoes_recursos = [r.value for r in Recurso]

        if request.method == 'GET':
            return self.render('reserva_form', recursos=opcoes_recursos, error=None)
        
        else:
            # POST - Tentativa de Agendar
            recurso = request.forms.get('recurso')
            data_inicio = request.forms.get('data_inicio')
            data_fim = request.forms.get('data_fim')

            # Tenta criar o objeto
            nova_reserva = Reserva(
                recurso=recurso, 
                morador_id=usuario.id, 
                data_inicio=data_inicio, 
                data_fim=data_fim
            )
            
            # Tenta salvar (O Model verifica conflito de horário)
            sucesso = reserva_model.add_reserva(nova_reserva)
            
            if sucesso:
                print(f"✅ Reserva criada: {recurso} para {usuario.nome}")
                return redirect('/morador/reservas')
            else:
                print("❌ Conflito de horário!")
                return self.render('reserva_form', recursos=opcoes_recursos, error="⚠️ Horário indisponível ou " \
                "Já existe uma reserva para este local neste período.")

    def cancelar(self, reserva_id):
        self.checar_morador() # 🔒
        reserva_model.cancelar_reserva(reserva_id)
        return redirect('/morador/reservas')

from bottle import Bottle
reserva_routes = Bottle()
reserva_controller = ReservaController(reserva_routes)