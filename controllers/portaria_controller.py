from bottle import redirect, request
from controllers.base_controller import BaseController
from services.user_service import UserService

class PortariaController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.user_service = UserService()
        self.setup_routes()


    def setup_routes(self):
        self.app.route('/portaria', method='GET', callback=self.dashboard)


    def dashboard(self):
    
        user_id = request.get_cookie("user_id", secret='chave_segura')
        if not user_id:
            return redirect('/login')

        usuario = self.user_service.get_by_id(user_id)
        if not usuario or usuario.get_tipo() != 'porteiro':
            return redirect('/painel')

        return self.render('dashboard_da_portaria', usuario=usuario)


from bottle import Bottle
portaria_routes = Bottle()
portaria_controller = PortariaController(portaria_routes)