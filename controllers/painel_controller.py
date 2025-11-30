from bottle import Bottle, route, request, redirect
from controllers.base_controller import BaseController
from services.user_service import UserService
from models.entrega import entrega_model
from models.reserva import reserva_model


class PainelController(BaseController):
    @route("/painel", method="GET")
    def dashboard(self):
        user_id = request.get_cookie("user_id", secret="chave_segura")

        if not user_id:
            return redirect("/login")
        
        user_service = UserService()
        usuario = user_service.get_by_id(user_id)

        #metodo de segurança para nao fazer o programa quebrar caso um porteiro logado digite o caminho /painel
        if usuario.get_tipo() == 'porteiro':
            return redirect('/users')

        if not usuario:
            return redirect("/logout")
        minhas_entregas = entrega_model.get_by_morador(usuario.id)

        return self.render("painel", usuario=usuario, entregas=minhas_entregas, title="Painel do Morador")

painel_routes = Bottle()

painel_controller = PainelController(painel_routes)