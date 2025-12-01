from bottle import Bottle
from bottle import redirect
from controllers.user_controller import user_routes
from controllers.user_controller import user_controller
from controllers.login_controller import login_controller
from controllers.painel_controller import painel_controller
from controllers.portaria_controller import portaria_controller

def init_controllers(app: Bottle):
    print('🔧 Configurando rotas dos controladores...')
    
    @app.route('/')
    def index():
        return redirect('/login')

    app.route('/login',    method='GET',  callback=login_controller.login_form)
    app.route('/login',    method='POST', callback=login_controller.do_login)
    app.route('/register', method='GET',  callback=login_controller.register_form)
    app.route('/register', method='POST', callback=login_controller.do_register)
    app.route('/logout',   method='GET',  callback=login_controller.logout)

    app.route('/painel',   method='GET',  callback=painel_controller.dashboard)

    app.route('/portaria', method='GET', callback=portaria_controller.dashboard)

    app.route('/portaria/users',                method='GET',  callback=user_controller.list_users)
    #user_form não foi implementado ainda
    # app.route('/users/new',            method='GET',  callback=user_controller.new_user_form)
    app.route('/portaria/users/add', method=['GET', 'POST'], callback=user_controller.add_user)   
    app.route('/portaria/users/delete/<user_id>', method=['GET', 'POST'], callback=user_controller.delete_user)

    app.route('/portaria/users/edit/<user_id>', method=['GET', 'POST'], callback=user_controller.edit_user)

    print('✅ Todas as rotas registradas com sucesso!')


