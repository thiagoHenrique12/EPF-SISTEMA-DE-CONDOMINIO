from bottle import request, redirect
from controllers.base_controller import BaseController
from models.entrega import Entrega, EntregaModel
from services.user_service import UserService

class EntregaController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.entrega_model = EntregaModel()
        self.user_service = UserService()
        # Não chamamos setup_routes aqui, pois faremos no __init__.py central

    # --- SEGURANÇA (O Guarda-Costas) ---
    def checar_permissao(self):
        user_id = request.get_cookie("user_id", secret='chave_segura')
        if not user_id:
            redirect('/login')
        
        usuario = self.user_service.get_by_id(user_id)
        # Se não existe ou não é porteiro -> RUA!
        if not usuario or usuario.get_tipo() != 'porteiro':
            redirect('/painel')

    # --- AÇÕES ---

    def listar_entregas(self):
        self.checar_permissao() # 🔒
        
        # 1. Busca todas as entregas
        entregas = self.entrega_model.get_all()
        
        # 2. Busca todos os moradores para sabermos os nomes
        # (Truque: Criamos um dicionário {id: nome} para facilitar a busca na View)
        usuarios = self.user_service.get_all()
        mapa_nomes = {u.id: u.nome for u in usuarios}
        
        return self.render("entregas", entregas=entregas, nomes=mapa_nomes)

    def nova_entrega(self):
        self.checar_permissao() # 🔒
        
        if request.method == 'GET':
            # Filtra: Só queremos que apareça MORADOR na lista
            todos = self.user_service.get_all()
            moradores = [u for u in todos if u.get_tipo() == 'morador']
            
            return self.render("entrega_form", moradores=moradores)
        
        else:
            # Lógica de Salvar (POST)
            descricao = request.forms.get('descricao')
            morador_id = request.forms.get('morador_id')
            
            if descricao and morador_id:
                nova = Entrega(descricao=descricao, morador_id=morador_id)
                self.entrega_model.add_entrega(nova)
            
            return redirect('/portaria/entregas')

    def confirmar_retirada(self, entrega_id):
        self.checar_permissao() # 🔒
        
        # Chama o método da Model que muda o status
        # (Assumindo que sua Model Entrega tem esse método registrar_retirada ou similar)
        # Se não tiver, usamos update_entrega manualmente.
        entrega = self.entrega_model.get_by_id(entrega_id)
        if entrega:
            entrega.registrar_retirada() # Ou entrega.retirada = True
            self.entrega_model.update_entrega(entrega)
            
        return redirect('/portaria/entregas')

# Instância para exportar
from bottle import Bottle
entrega_routes = Bottle()
entrega_controller = EntregaController(entrega_routes)