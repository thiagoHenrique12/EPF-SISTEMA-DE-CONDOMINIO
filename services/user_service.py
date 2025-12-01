from bottle import request
from models.user import UserModel, Morador, Porteiro

class UserService:
    def __init__(self):
        self.user_model = UserModel()

    def get_all(self):
        return self.user_model.get_all()

    def get_by_id(self, user_id):
        return self.user_model.get_by_id(user_id)

    def save(self):
        nome = request.forms.get('nome')
        email = request.forms.get('email')
        senha = request.forms.get('senha')
        tipo = request.forms.get('tipo')
        apartamento = request.forms.get('apartamento')
        turno = request.forms.get('turno')

        novo_user = None
        if tipo == 'morador':
            novo_user = Morador(nome=nome, email=email, senha=senha, apartamento=apartamento)
        elif tipo == 'porteiro':
            novo_user = Porteiro(nome=nome, email=email, senha=senha, turno=turno)
    
        if novo_user:
            self.user_model.add_user(novo_user)


    def update_user(self, user):
        self.user_model.update_user(user)


    def delete_user(self, user_id):
        self.user_model.delete_user(user_id)


    def filtrar_por_nome(self, nome_buscado):
        todos_usuarios = self.get_all()
        
        if not nome_buscado:
            return todos_usuarios
        
        return [u for u in todos_usuarios if nome_buscado.lower() in u.nome.lower()]


