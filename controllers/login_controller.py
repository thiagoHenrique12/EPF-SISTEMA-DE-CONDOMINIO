from bottle import route, request, redirect, response
from controllers.base_controller import BaseController
from services.auth_service import auth_service
from models.user import UserModel, Morador

class LoginController(BaseController):
    def __init__(self):
        self.user_model = UserModel()

    @route('/login', method='GET')
    def login_form(self):
        if request.get_cookie("user_id", secret='chave_segura'):
            return redirect('/painel')
            
        return self.render('login', title="Entrar no Sistema")

    @route('/login', method ="POST")
    def do_login(self):
        email= request.forms.get("email")
        senha = request.forms.get("senha")
        usuario = auth_service.login(email, senha)

        if usuario:
            response.set_cookie("user_id", usuario.id, secret='chave_segura', path='/')
            if usuario.get_tipo() == "porteiro":
                    return redirect('/users')
            else:
                    return redirect('/painel')
        else:
                return self.render('login', title="Entrar", error="Email ou senha incorretos.")


    @route("/register", method="GET")
    def register_form(self):
         return self.render("register", title="Criar conta de morador")
    
    @route("/register", method="POST")
    def do_register(self):
         print("➡️ INICIANDO REGISTRO...") # RASTREADOR 1
         nome = request.forms.get("nome")
         email = request.forms.get("email")
         senha = request.forms.get("senha")
         apartamento= request.forms.get("apartamento")
         print(f"📦 DADOS RECEBIDOS: Nome={nome}, Email={email}, Apto={apartamento}") # RASTREADOR 2

         if not nome or not email or not senha or not apartamento:
              print("❌ ERRO: Campos obrigatórios faltando!") # RASTREADOR 3
              return self.render("register", error="Todos os campos são obrigatórios.", title="Criar Conta")
         
         #verificando se esse email ja foi cadastrado
         usuario_existente = self.user_model.get_by_email(email)
         
         if usuario_existente:
            print("❌ ERRO: Email já existe!") # RASTREADOR 4
            return self.render("register", title="Criar Conta", error="Este e-mail já está cadastrado!")
         
         novo_morador= Morador(nome=nome, email=email, senha=senha, apartamento=apartamento)
         self.user_model.add_user(novo_morador)
         return redirect("/login")
    
    
    @route("/logout", method="GET")
    def logout(self):
         response.delete_cookie("user_id", path='/')
         return redirect("/login")
    

login_controller = LoginController()