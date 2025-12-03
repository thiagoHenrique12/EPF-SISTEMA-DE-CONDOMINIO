import json
import uuid
import os
from datetime import datetime
from enum import Enum

DATA_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'data')


class Recurso(Enum):
    SALAO_FESTAS = "Salão de Festas"
    CHURRASQUEIRA = "Churrasqueira"
    QUADRA = "Quadra Poliesportiva"
    SALA_JOGOS = "Sala de Jogos"

class Reserva:
    def __init__(self, recurso: str, morador_id: str, data_inicio: str, data_fim: str, status: str = 'Pendente', reserva_id: str = None):
        self.id = reserva_id if reserva_id else str(uuid.uuid4())
        self.recurso = recurso
        self.morador_id = morador_id
        self.data_inicio = data_inicio 
        self.data_fim = data_fim
        self.status = status

    def to_dict(self):
        return {
            "id": self.id,
            "recurso": self.recurso,
            "morador_id": self.morador_id,
            "data_inicio": self.data_inicio,
            "data_fim": self.data_fim,
            "status": self.status
        }

    @staticmethod
    def from_dict(data):
        return Reserva(
            reserva_id=data.get("id"),
            recurso=data.get("recurso"),
            morador_id=data.get("morador_id"),
            data_inicio=data.get("data_inicio"),
            data_fim=data.get("data_fim"),
            status=data.get("status")
        )

class ReservaModel:
    FILE_PATH = os.path.join(DATA_DIR, 'reservas.json')

    def __init__(self):
        self.reservas = self._load()

    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        try:
            with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
                data = json.load(f)
            return [Reserva.from_dict(item) for item in data]
        except (json.JSONDecodeError, FileNotFoundError, ValueError):
            return []


    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            json.dump([r.to_dict() for r in self.reservas], f, indent=4, ensure_ascii=False)

    def get_all(self):
        self.reservas = self._load() 
        return self.reservas


    def get_by_morador(self, morador_id: str):
        self.reservas = self._load() 
        return [r for r in self.reservas if r.morador_id == morador_id]


    def verificar_disponibilidade(self, recurso, inicio_str, fim_str):
        self.reservas = self._load() 
        
        fmt = "%Y-%m-%dT%H:%M" 
        
        try:
            novo_inicio = datetime.strptime(inicio_str, fmt)
            novo_fim = datetime.strptime(fim_str, fmt)
        except ValueError:
            return False 

        if novo_fim <= novo_inicio:
            return False

        for r in self.reservas:
          
            if r.recurso == recurso and r.status != 'Cancelada':
                try:
                    existente_inicio = datetime.strptime(r.data_inicio, fmt)
                    existente_fim = datetime.strptime(r.data_fim, fmt)
                    
                  
                    if novo_inicio < existente_fim and novo_fim > existente_inicio:
                        return False 
                except ValueError:
                    continue 

        return True 

    

    def cancelar_reserva(self, reserva_id):
        self.reservas = self._load()
        for r in self.reservas:
            if r.id == reserva_id:
                r.status = 'Cancelada'
                self._save()
                return True
        return False
    
    def add_reserva(self, reserva: Reserva):
        if self.verificar_disponibilidade(reserva.recurso, reserva.data_inicio, reserva.data_fim):
            self.reservas.append(reserva)
            self._save()
            return True 
        return False 
    
   
    def atualizar_status(self, reserva_id: str, novo_status: str):
        self.reservas = self._load() 
        for r in self.reservas:
            if r.id == reserva_id:
                r.status = novo_status
                self._save() 
                return True
        return False

reserva_model = ReservaModel()