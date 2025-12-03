import json
import uuid
import os
from dataclasses import dataclass, asdict
from typing import List
from abc import ABC, abstractmethod

DATA_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'data')

if not os.path.exists(DATA_DIR):
    os.makedirs(DATA_DIR)


class User(ABC):
    def __init__(self, nome: str, email: str, senha: str, user_id: str = None):
        self.id = user_id if user_id else str(uuid.uuid4())
        self.nome = nome
        self.email =email
        self.__senha= senha

    @property              
    def senha(self):
        return self.__senha
    
    def verificar_senha(self, senha_digitada: str) :
        return self.__senha == senha_digitada
    
    @abstractmethod 
    def get_tipo(self): #metodo abstrato que vai obrigar as classes filhas a terem ele tambem
        pass
    
    def __repr__(self):
        return (f"User(id={self.id}, nome='{self.nome}', email='{self.email}', ")


    def to_dict(self, incluir_senha= False):
        data={
            "id":self.id, "nome": self.nome, "email": self.email ,"tipo": self.get_tipo()}
        if incluir_senha:
            data["senha"] = self.senha 
        return data


# PARTE DE HERANÇAS:

class Morador(User):
    def __init__(self, nome : str, email : str, senha : str, apartamento: str, user_id :str = None):
        super().__init__(nome, email, senha, user_id)
        self.apartamento = apartamento

    def get_tipo(self):
        return "morador"
    
    def to_dict(self, incluir_senha=False):
        data = super().to_dict(incluir_senha)
        data["apartamento"] = self.apartamento
        return data

  
    
class Porteiro(User):
    def __init__(self, nome: str, email: str, senha: str, turno: str, user_id: str = None):
        super().__init__(nome, email, senha, user_id)
        self.turno =turno  

    def get_tipo(self) :
        return "porteiro"
    

    def to_dict(self, incluir_senha=False):
        data = super().to_dict(incluir_senha)
        data["turno"] = self.turno
        return data

    


class UserModel:
    FILE_PATH = os.path.join(DATA_DIR, 'users.json')

    def __init__(self):
        self.users: List[User] = self._load()


    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        try:
           with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
                loaded_users = []
                for item in data:
                    
                    tipo = item.get("tipo")
                    user = None
                    
                    if tipo == "morador":
                        user = Morador(
                            user_id=item.get("id"),
                            nome=item.get("nome"),
                            email=item.get("email"),
                            senha=item.get("senha"),
                            apartamento=item.get("apartamento")
                        )
                    elif tipo == "porteiro":
                        user = Porteiro(
                            user_id=item.get("id"),
                            nome=item.get("nome"),
                            email=item.get("email"),
                            senha=item.get("senha"),
                            turno=item.get("turno")
                        )
                    
                    # Só vai adiciona se criou um usuário válido
                    if user:
                        loaded_users.append(user)
                
                return loaded_users
        
        except (json.JSONDecodeError, FileExistsError, ValueError) as e:
            print(f"Aviso: Não foi possível carregar o arquivo JSON.\n ERRO: {e}")
            return []
        

    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
           json.dump([u.to_dict(incluir_senha=True) for u in self.users], f, indent=4, ensure_ascii=False)


    def get_all(self):
        self.users = self._load()
        return self.users

    def get_by_email(self, email :str):
        self.users = self._load()
        return next((u for u in self.users if u.email == email), None)
    

    def get_by_id(self, user_id: str):
        self.users = self._load()
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