import json
import uuid
import os
from datetime import datetime
from enum import Enum

DATA_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'data')

if not os.path.exists(DATA_DIR):
    os.makedirs(DATA_DIR)

class Recurso(Enum):
    SALAO_A = "Salão de festas A"
    SALAO_B = "Salão de festas B"
    QUADRA = "Quadra de futebol"
    CHURRASQUEIRA = "Área de Churrasqueira"
    SALA_JOGOS  = "Sala de jogos"

class StatusReserva(Enum):
    CONFIRMADA = "Confirmada"
    CANCELADA = "Cancelada"
    CONCLUIDA = "Concluída"

class Reserva:
    def __init__(self, recurso: str, morador_id: str, data_inicio: str, data_fim: str, status: str = StatusReserva.CONFIRMADA.value, reserva_id: str = None):
        self.id = reserva_id if reserva_id else str(uuid.uuid4())
        self.recurso = recurso
        self.morador_id = morador_id

        self.data_inicio = data_inicio
        self.data_fim = data_fim
        self.status = status

    def cancelar(self):
        self.status = StatusReserva.CANCELADA.value

    def __repr__(self):
        return (f"Reserva(id='{self.id}', recurso='{self.recurso}', "
                f"morador='{self.morador_id}', inicio='{self.data_inicio}', status='{self.status}')")
    
    def to_dict(self):
        return {
            "id": self.id, "recurso": self.recurso, "morador_id": self.morador_id,"data_inicio": self.data_inicio,"data_fim": self.data_fim, "status": self.status
        }
    
    @staticmethod
    def from_dict(data):
        return Reserva(
            reserva_id=data.get("id"), recurso=data.get("recurso"), morador_id=data.get("morador_id"), data_inicio=data.get("data_inicio"), data_fim=data.get("data_fim"), 
            status=data.get("status", StatusReserva.CONFIRMADA.value)
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
        except (json.JSONDecodeError, FileNotFoundError, ValueError) as e:
            print(f"Erro ao carregar reservas: {e}")
            return []

    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            data_to_save = [r.to_dict() for r in self.reservas]
            json.dump(data_to_save, f, indent=4, ensure_ascii=False)

    def get_all(self):
        return self.reservas
     
    def get_by_id(self, reserva_id: str):
        return next((r for r in self.reservas if r.id == reserva_id), None)
     
    def get_by_morador(self, morador_id: str):
        return [r for r in self.reservas if r.morador_id == morador_id]
     
    def add_reserva(self, reserva: Reserva):
        if self.verificar_disponibilidade(reserva.recurso, reserva.data_inicio, reserva.data_fim):
            self.reservas.append(reserva)
            self._save()
            return True
        else:
            print(f"Conflito: O recurso {reserva.recurso} já está reservado neste horário.")
            return False
     
    def cancel_reserva(self, reserva_id: str):
        reserva = self.get_by_id(reserva_id)
        if reserva:
            reserva.cancelar()
            self._save()
            return True
        return False
     
    def verificar_disponibilidade(self, recurso: str, inicio_str: str, fim_str: str):
        formato = "%Y-%m-%d %H:%M"
        try:
            inicio_nova = datetime.strptime(inicio_str, formato)
            fim_nova = datetime.strptime(fim_str, formato)
        except ValueError:
            print("Erro de formato de data. AAAA-MM-DD HH:MM")
            return False
         
        for r in self.reservas:
            if r.recurso == recurso and r.status != StatusReserva.CANCELADA.value:
                inicio_existente = datetime.strptime(r.data_inicio, formato)
                fim_existente = datetime.strptime(r.data_fim, formato)
                if inicio_nova < fim_existente and inicio_existente < fim_nova:
                    return False
        return True
     
    def get_reservas_do_dia(self, data_str: str, recurso: str = None):
        reservas_do_dia = []
        for r in self.reservas:
            if r.data_inicio.startswith(data_str) and r.status != StatusReserva.CANCELADA.value:
                if recurso is None or r.recurso == recurso:
                    reservas_do_dia.append(r)
        return reservas_do_dia

reserva_model = ReservaModel()