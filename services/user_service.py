from bottle import request
from models.user import UserModel, Morador, Sindico

class UserService:
    def __init__(self):
        self.user_model = UserModel()

    def get_all(self):
        return self.user_model.get_all()

    def get_by_id(self, user_id):
        return self.user_model.get_by_id(user_id)

    def save(self):
        # Pegando os dados do formulário
        nome = request.forms.get('nome')
        email = request.forms.get('email')
        senha = request.forms.get('senha')
        tipo = request.forms.get('tipo')
        apartamento = request.forms.get('apartamento')

       # até o momento os atributos de ambas as heranças são os mesmos, mas futuramente isso provavelmente vai musar
        novo_user = None
        if tipo == 'morador':
            novo_user = Morador(nome=nome, email=email, senha=senha, apartamento=apartamento)
        elif tipo == 'sindico':
            novo_user = Sindico(nome=nome, email=email, senha=senha, apartamento=apartamento)
    
        if novo_user:
            self.user_model.add_user(novo_user)


    def update_user(self, user):
        self.user_model.update_user(user)


    def delete_user(self, user_id):
        self.user_model.delete_user(user_id)


