from bottle import request
from controllers.base_controller import BaseController
from services.user_service import UserService

class UserController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.user_service = UserService()
     #   self.setup_routes()

    # def setup_routes(self):
    
    #     self.app.route('/users', method='GET', callback=self.list_users)
    #     self.app.route('/users/add', method=['GET', 'POST'], callback=self.add_user)
    #     self.app.route('/users/edit/<user_id>', method=['GET', 'POST'], callback=self.edit_user)
    #     self.app.route('/users/delete/<user_id>', method=['GET', 'POST'], callback=self.delete_user)


    #pelo oq entendi isso daqui nao é necessario pois ja tem as rotas no init, se acontecer algum erro descomenta a função e o 
    # atributo de UserController para testar

    def list_users(self):
        self.verificar_permissao_porteiro()

        nome_buscado = request.query.get('q')# diretamente ligado ao html e a caixa de pesquisa que ele vai criar

        if nome_buscado:
            users = self.user_service.filtrar_por_nome(nome_buscado)
        else:
            users = self.user_service.get_all()

        return self.render('users', users=users, nome_buscado=nome_buscado)
    

    def add_user(self):
        self.verificar_permissao_porteiro()

        if request.method == 'GET':
            return self.render('user_form', user=None, action="/portaria/users/add")
        else:
            self.user_service.save()
            return self.redirect('/portaria/users')


    def edit_user(self, user_id):
        self.verificar_permissao_porteiro()

        user = self.user_service.get_by_id(user_id)
        if not user:
            return "Usuário não encontrado"

        if request.method == 'GET':
            return self.render('user_form', user=user, action=f"/portaria/users/edit/{user_id}")
        else:
            user.nome = request.forms.get('nome')
            user.email = request.forms.get('email')

            if hasattr(user, 'apartamento'):
                user.apartamento = request.forms.get('apartamento')
            
            if hasattr(user, 'turno'):
                user.turno = request.forms.get('turno')
            
            self.user_service.update_user(user)
            return self.redirect('/portaria/users')


    def delete_user(self, user_id):
        self.verificar_permissao_porteiro()

        self.user_service.delete_user(user_id)
        return self.redirect('/portaria/users')
    
    
    #esse metodo de segurança vai garantir que apenas porteiros acessem a area de porteiros
    def verificar_permissao_porteiro(self):
        user_id = request.get_cookie("user_id", secret='chave_segura') 
        
        if not user_id:
            return self.redirect('/login')
            
        usuario = self.user_service.get_by_id(user_id)
        
        if not usuario or usuario.get_tipo() != 'porteiro':
            return self.redirect('/painel')


from bottle import Bottle
user_routes = Bottle()
user_controller = UserController(user_routes)




