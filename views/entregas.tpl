<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>{{title}}</title>
    <link rel="stylesheet" href="/static/css/style.css">
    <style>
        .actions a { text-decoration: none; margin: 0 5px; font-weight: bold; }
        .btn-confirm { color: #28a745; border: 1px solid #28a745; padding: 2px 8px; border-radius: 4px; }
        .btn-confirm:hover { background-color: #28a745; color: white; }
    </style>
</head>
<body>
    <div style="background: #333; padding: 10px; margin-bottom: 20px;">
        <div class="container" style="display: flex; justify-content: space-between;">
            <a href="/painel" style="color: white; text-decoration: none;">⬅ Painel</a>
            <span style="color: #ddd;">Área da Portaria</span>
        </div>
    </div>

    <div class="container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2>📦 Controle de Encomendas</h2>
            <a href="/entregas/nova" class="btn-success">+ Registrar Chegada</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Chegada</th>
                    <th>Destinatário (Apto)</th>
                    <th>Descrição</th>
                    <th>Status</th>
                    <th>Ação</th>
                </tr>
            </thead>
            <tbody>
                % for entrega in entregas:
                <tr>
                    <td>{{entrega.data_chegada}}</td>
                    <td>
                        % morador = moradores.get(entrega.morador_id)
                        % if morador:
                            {{morador.nome}} ({{morador.apartamento}})
                        % else:
                            <span style="color:red;">Morador Removido</span>
                        % end
                    </td>
                    <td>{{entrega.descricao}}</td>
                    <td>
                        % if entrega.esta_pendente():
                            <span style="color: orange; font-weight: bold;">Pendente</span>
                        % else:
                            <span style="color: green;">Entregue</span>
                            <br><small>{{entrega.retirada}}</small>
                        % end
                    </td>
                    <td class="actions">
                        % if entrega.esta_pendente():
                            <a href="/entregas/confirmar/{{entrega.id}}" class="btn-confirm" onclick="return confirm('Confirmar que o morador retirou o pacote?');">✔ Confirmar Retirada</a>
                        % else:
                            -
                        % end
                    </td>
                </tr>
                % end
            </tbody>
        </table>
    </div>
</body>
</html>