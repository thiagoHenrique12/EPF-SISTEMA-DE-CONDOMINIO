<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>{{title}}</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <h2>📅 Reservar Espaço</h2>
            <p>Selecione o local e o horário desejado.</p>
            
            <form action="/reservas/nova" method="POST" class="form-box">
                
                <div class="form-group">
                    <label>Local / Recurso:</label>
                    <select name="recurso" required style="width: 100%; padding: 10px;">
                        % for r in recursos:
                            <option value="{{r}}">{{r}}</option>
                        % end
                    </select>
                </div>

                <div class="form-group">
                    <label>Data e Hora de Início:</label>
                    <input type="datetime-local" name="data_inicio" required style="width: 100%; padding: 10px;">
                </div>

                <div class="form-group">
                    <label>Data e Hora de Término:</label>
                    <input type="datetime-local" name="data_fim" required style="width: 100%; padding: 10px;">
                </div>
                
                <button type="submit" class="btn-success full-width">Confirmar Reserva</button>
                <a href="/minhas_reservas" style="display: block; text-align: center; margin-top: 15px; color: #666;">Cancelar</a>
            </form>
        </div>
    </div>
</body>
</html>