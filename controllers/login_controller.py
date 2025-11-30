from bottle import route, request, redirect, response
from controllers.base_controller import BaseController
from services.auth_service import auth_service
from models.user import UserModel, Morador

class LoginController(BaseController):
    def __init__(self):
        self.user_model = UserModel()

    @route('/login', method='GET')
    def login_form(self):

        user_id= request.get_cookie("user_id", secret='chave_segura')
        if user_id:
             user = self.user_model.get_by_id(user_id)
             if user:
                  if user.get_tipo() == 'porteiro':
                       return redirect('/portaria')
                  
                  elif user.get_tipo() == "morador":
                    return redirect('/painel')
             
             return self.render('login', title="Entrar no Sistema")
        
            
        return self.render('login', title="Entrar no Sistema")

    @route('/login', method ="POST")
    def do_login(self):
        email= request.forms.get("email")
        senha = request.forms.get("senha")
        usuario = auth_service.login(email, senha)

        if usuario:
            response.set_cookie("user_id", usuario.id, secret='chave_segura', path='/')
            if usuario.get_tipo() == "porteiro":
                    return redirect('/portaria')
            else:
                    return redirect('/painel')
        else:
                return self.render('login', title="Entrar", error="Email ou senha incorretos.")


    @route("/register", method="GET")
    def register_form(self):
         return self.render("register", title="Criar conta de morador")
    
    @route("/register", method="POST")
    def do_register(self):
    
         nome = request.forms.get("nome")
         email = request.forms.get("email")
         senha = request.forms.get("senha")
         apartamento= request.forms.get("apartamento")


         if not nome or not email or not senha or not apartamento:

              return self.render("register", error="Todos os campos são obrigatórios.", title="Criar Conta")
         
         #verificando se esse email ja foi cadastrado
         usuario_existente = self.user_model.get_by_email(email)
         
         if usuario_existente:
           
            return self.render("register", title="Criar Conta", error="Este e-mail já está cadastrado!")
         
         novo_morador= Morador(nome=nome, email=email, senha=senha, apartamento=apartamento)
         self.user_model.add_user(novo_morador)
         return redirect("/login")
    
    
    @route("/logout", method="GET")
    def logout(self):
         response.delete_cookie("user_id", path='/')
         return redirect("/login")
    

login_controller = LoginController()