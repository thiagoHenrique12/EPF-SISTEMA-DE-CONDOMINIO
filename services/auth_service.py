from models.user import UserModel

class AuthService:
    def __init__(self):
        self.user_model = UserModel()

    def login(self, email, senha):
        todos_usuarios= self.user_model.get_all()

        for usuario in todos_usuarios:
            if usuario.email == email:
                if usuario.verificar_senha(senha):
                    return usuario
        return None
auth_service = AuthService()

