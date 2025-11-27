from bottle import route, request, redirect
from controllers.base_controller import BaseController
from services.user_service import UserService
from models.entrega import entrega_model
from models.reserva import reserva_model

class PainelController(BaseController):
    @route("/painel", method="GET")
    def dashboard(self):
        user_id = request.get.cookie("user_id", secret="minha_chave_segura")

        if not user_id:
            return redirect("/login")
        usuario = UserService.get_by_id(user_id)

        if not usuario:
            return redirect("/logout")
        minhas_entregas = entrega_model.get_by_morador(usuario.id)

        return sel.render("painel", usuario=usuario, entregas=minhas_entregas, title="Painel do Morador")
painel_controller = PainelController()   
    