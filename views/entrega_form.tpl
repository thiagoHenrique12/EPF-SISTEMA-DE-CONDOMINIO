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
            <h2>📦 Registrar Nova Encomenda</h2>
            
            <form action="/entregas/nova" method="POST" class="form-box">
                
                <div class="form-group">
                    <label>Para qual morador?</label>
                    <select name="morador_id" required style="width: 100%; padding: 10px;">
                        <option value="">Selecione um morador...</option>
                        % for morador in destinatarios:
                            <option value="{{morador.id}}">
                                {{morador.apartamento}} - {{morador.nome}}
                            </option>
                        % end
                    </select>
                </div>

                <div class="form-group">
                    <label>Descrição do Pacote:</label>
                    <input type="text" name="descricao" required placeholder="Ex: Caixa Amazon, Carta Registrada...">
                </div>
                
                <button type="submit" class="btn-success full-width">Registrar Entrada</button>
                <a href="/entregas" style="display: block; text-align: center; margin-top: 15px; color: #666;">Cancelar</a>
            </form>
        </div>
    </div>
</body>
</html>