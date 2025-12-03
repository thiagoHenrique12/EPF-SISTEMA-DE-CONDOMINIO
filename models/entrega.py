import json
import uuid
import os
from datetime import datetime

DATA_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'data')

if not os.path.exists(DATA_DIR):
    os.makedirs(DATA_DIR)

class Entrega:
    def __init__(self, descricao: str, morador_id: str, 
                 entrega_id: str = None, data_chegada: str = None, retirada: str = None):
        
        self.id = entrega_id if entrega_id else str(uuid.uuid4())
        self.descricao = descricao
        self.morador_id = morador_id

        if data_chegada:
            self.data_chegada = data_chegada
        else:
            self.data_chegada = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            
        self.retirada = retirada

    def registrar_retirada(self):
        self.retirada = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    def esta_pendente(self):
        return self.retirada is None
    
    def __repr__(self):
        status = "Entregue" if self.retirada else "Pendente"
        return f"Entrega(id={self.id}, desc={self.descricao}, morador={self.morador_id}, status={status})"

    def to_dict(self):
        return {
            "id": self.id,"descricao": self.descricao,"morador_id": self.morador_id, "data_chegada": self.data_chegada,"retirada": self.retirada
        }

    @staticmethod
    def from_dict(data):
        return Entrega(entrega_id=data.get("id"), descricao=data.get("descricao"), morador_id=data.get("morador_id"),data_chegada=data.get("data_chegada"), 
            retirada=data.get("retirada")) 

class EntregaModel:
    FILE_PATH = os.path.join(DATA_DIR, 'entregas.json')

    def __init__(self):
        self.entregas = self._load()

    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        try:
            with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
                data = json.load(f)
                return [Entrega.from_dict(item) for item in data]
        except (json.JSONDecodeError, FileNotFoundError, ValueError) as e:
            print(f"Erro ao carregar entregas: {e}")
            return []

    def _save(self):

        with open(self.FILE_PATH, "w", encoding="utf-8") as f:
            data_to_save = [e.to_dict() for e in self.entregas]
            json.dump(data_to_save, f, indent=4, ensure_ascii=False)
    
    def get_all(self):
        self.entregas = self._load()
        return self.entregas
    
    def get_by_id(self, entrega_id: str):
        self.entregas = self._load()
        return next((e for e in self.entregas if e.id == entrega_id), None)
    
    def get_by_morador(self, morador_id: str):
        self.entregas = self._load()
        return [e for e in self.entregas if e.morador_id == morador_id]

    def get_pendentes(self):
        self.entregas = self._load()
        return [e for e in self.entregas if e.esta_pendente()]

    def add_entrega(self, entrega: Entrega):
        self.entregas.append(entrega)
        self._save()
    
    def update_entrega(self, updated_entrega: Entrega):
        for i, entrega in enumerate(self.entregas):
            if entrega.id == updated_entrega.id:
                self.entregas[i] = updated_entrega
                self._save()
                break

    def registrar_retirada(self, entrega_id: str):
        entrega = self.get_by_id(entrega_id)
        if entrega:
            entrega.registrar_retirada()
            self.update_entrega(entrega)
            return True
        return False

    def delete_entrega(self, entrega_id: str):
        initial_len = len(self.entregas)
        self.entregas = [e for e in self.entregas if e.id != entrega_id]
        if len(self.entregas) < initial_len:
            self._save()
            return True
        return False

entrega_model = EntregaModel()