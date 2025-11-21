from models.user import UserModel

class AutenticacaoService:
    def __init__(self):
        self.user_model = UserModel()

    def autenticar_user(self, email, senha):
        user = self.user_model.get_by_email(email)

        if not user:
            return None
        
        if user.verificar_senha(senha):
            return user  
        
        return None