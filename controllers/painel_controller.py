from bottle import route, request, redirect
from controllers.base_controller import BaseController
from services.user_service import UserService
from models.entrega import entrega_model
from models.reserva import reserva_model

class PainelController(BaseController):
    