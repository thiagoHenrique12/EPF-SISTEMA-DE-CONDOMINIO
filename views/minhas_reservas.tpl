<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>{{title}}</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <div style="background: #333; padding: 10px; margin-bottom: 20px;">
        <div class="container" style="display: flex; justify-content: space-between;">
            <a href="/painel" style="color: white; text-decoration: none; font-weight: bold;">⬅ Voltar ao Painel</a>
            <span style="color: #ddd;">Olá, {{usuario.nome}}</span>
        </div>
    </div>

    <div class="container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2>📅 Minhas Reservas</h2>
            <a href="/reservas/nova" class="btn-success">+ Nova Reserva</a>
        </div>

        % if not reservas:
            <div class="card" style="text-align: center; color: #666; padding: 40px;">
                <p>Você não tem nenhuma reserva ativa.</p>
            </div>
        % else:
            <table>
                <thead>
                    <tr>
                        <th>Local</th>
                        <th>Início</th>
                        <th>Fim</th>
                        <th>Status</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    % for r in reservas:
                    <tr>
                        <td><strong>{{r.recurso}}</strong></td>
                        <td>{{r.data_inicio}}</td>
                        <td>{{r.data_fim}}</td>
                        <td>
                            % if r.status == 'Confirmada':
                                <span style="color: green; font-weight: bold;">Confirmada</span>
                            % elif r.status == 'Cancelada':
                                <span style="color: red;">Cancelada</span>
                            % else:
                                {{r.status}}
                            % end
                        </td>
                        <td>
                            % if r.status == 'Confirmada':
                                <a href="/reservas/cancelar/{{r.id}}" style="color: #dc3545; font-size: 12px;" onclick="return confirm('Deseja realmente cancelar?')">Cancelar</a>
                            % else:
                                -
                            % end
                        </td>
                    </tr>
                    % end
                </tbody>
            </table>
        % end
    </div>
</body>
</html>