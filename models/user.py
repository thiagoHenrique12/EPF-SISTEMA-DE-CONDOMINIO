import json
import uuid
import os
from dataclasses import dataclass, asdict
from typing import List

DATA_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'data')

if not os.path.exists(DATA_DIR):
    os.makedirs(DATA_DIR)


# necessario implementar o encapsulamento e fazer os getters e setters
class User:
    def __init__(self, nome: str, email: str, senha: str, user_id: str = None):
        self.id = user_id if user_id else str(uuid.uuid4())
        self.nome = nome
        self.email =email
        self.__senha= senha

        @property               #isso é um decorator que transforma um metodo em atributo
        def senha(self):
            return self.__senha
        #isso aq é como se fosse um get disfarçado, toda vez que tentar passar a vriavel senha ao inves de buscar a variavel 
        # o python vai buscar esse metodo 

    def __repr__(self):
        return (f"User(id={self.id}, nome='{self.nome}', email='{self.email}', ")


    def to_dict(self, incluir_senha= False):
        data={
            "id":self.id, "nome": self.nome, "email": self.email }
        if incluir_senha:
            data["senha"] = self.senha  # estamos aplicando o decorator aqui, por exemplo
        return data
    
    @staticmethod
    def from_dict(data):
        senha = data.get("senha")
        if not senha:
            raise ValueError("SEnha necessária para carregar usúari.")
        
        return User(user_id=data.get("id"), nome= data.get("nome"), email=data.get("email"), senha=senha)


class UserModel:
    FILE_PATH = os.path.join(DATA_DIR, 'users.json')

    def __init__(self):
        self.users = List[User] = self._load()


    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        try:
            with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
                data = json.load(f)
            return [User.from_dict(item) for item in data]
        
        except (json.JSONDecodeError, FileExistsError, ValueError) as e:
            print(f"Aviso: Não foi possível carregar o arquivo JSON.\n ERRO: {e}")
            return []
        


    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            data_to_save = [u.to_dict(incluir_senha=True)for u in self.users]
            json.dump(data_to_save, f, indent=4, ensure_ascii=False)


    def get_all(self):
        return self.users


    def get_by_id(self, user_id: str):
        return next((u for u in self.users if u.id == user_id), None)


    def add_user(self, user: User):
        self.users.append(user)
        self._save()


    def update_user(self, updated_user: User):
        for i, user in enumerate(self.users):
            if user.id == updated_user.id:
                self.users[i] = updated_user
                self._save()
                break


    def delete_user(self, user_id: str):
        contagem = len(self.users)
        self.users = [u for u in self.users if u.id != user_id]
        if len(self.users) < contagem:
            self._save()
            return True
        return False


# HERANÇAS

class Morador(User):
    def __init__(self, nome : str, email : str, senha : str, apartamento: str, user_id :str = None):
        super().__init__(nome, email, senha, apartamento, UserRole.MORADOR.value, user_id)

    @staticmethod
    def from_dict(data):
        return Morador(uder_id =data.get("id"), nome= data.get("nome"), email=data.get("email"), senha=data.get("senha"),
        apartamento= data.get("apartamento"))

    
class Sindico(User):
    def __init__(self, nome: str, email: str, senha: str, apartamento: str, user_id: str = None):
        super().__init__(nome, email, senha, apartamento, UserRole.SINDICO.value, user_id)
    
    @staticmethod
    def from_dict(data):
        return Sindico(uder_id =data.get("id"), nome= data.get("nome"), email=data.get("email"), senha=data.get("senha"),
        apartamento= data.get("apartamento"))
    
    def emitir_comunicado(self, titulo: str, mensagem: str):
        return(f"COMUNICADO DO CONDOMÍNIO\n"
               f"Autor: Síndico {self.nome}\n"
               f"{mensagem}\n"
               f"Muito obrigado e tenham um bom dia!")