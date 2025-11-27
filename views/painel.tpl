<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>{{title}}</title>
    <link rel="stylesheet" href="/static/css/style.css">
    <style>
        .dashboard-container { max-width: 900px; margin: 40px auto; padding: 20px; }
        
        .welcome-banner {
            background-color: #e3f2fd;
            border-left: 5px solid #2196F3;
            padding: 20px;
            border-radius: 4px;
            margin-bottom: 30px;
        }
        
        .section-card {
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        h3 { border-bottom: 2px solid #f0f0f0; padding-bottom: 10px; margin-top: 0; color: #444; }
        
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th { text-align: left; background: #f8f9fa; padding: 12px; color: #666; font-size: 14px; }
        td { padding: 12px; border-bottom: 1px solid #eee; color: #333; }
        
        .status-badge {
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .status-pendente { background: #fff3cd; color: #856404; }
        .status-entregue { background: #d4edda; color: #155724; }
        
        .logout-btn { float: right; text-decoration: none; color: #d9534f; font-weight: bold; }
    </style>
</head>
<body>

    <div class="dashboard-container">
        <!-- Cabeçalho com Logout -->
        <div style="margin-bottom: 20px; overflow: hidden;">
            <a href="/logout" class="logout-btn">Sair do Sistema (Logout) ➜</a>
        </div>

        <!-- Boas-vindas -->
        <div class="welcome-banner">
            <h2 style="margin: 0;">Olá, {{usuario.nome}}!</h2>
            <!-- .capitalize() deixa a primeira letra maiúscula (ex: morador -> Morador) -->
            <p style="margin: 5px 0 0;">Unidade: <strong>{{usuario.apartamento}}</strong> | Tipo: {{usuario.tipo.capitalize()}}</p>
        </div>

        <!-- Seção de Encomendas -->
        <div class="section-card">
            <h3>📦 Suas Encomendas e Correspondências</h3>
            
            % if not entregas:
                <p style="color: #777; font-style: italic;">Nenhuma encomenda registrada para você no momento.</p>
            % else:
                <table>
                    <thead>
                        <tr>
                            <th>Descrição</th>
                            <th>Chegada</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        % for entrega in entregas:
                        <tr>
                            <td>{{entrega.descricao}}</td>
                            <td>{{entrega.data_chegada}}</td>
                            <td>
                                <!-- Lógica visual: Se pendente mostra amarelo, se retirado mostra verde -->
                                % if entrega.esta_pendente():
                                    <span class="status-badge status-pendente">Na Portaria</span>
                                % else:
                                    <span class="status-badge status-entregue">Retirado</span>
                                    <div style="font-size: 10px; color: #999; margin-top: 2px;">{{entrega.retirada}}</div>
                                % end
                            </td>
                        </tr>
                        % end
                    </tbody>
                </table>
            % end
        </div>

        <!-- Seção de Reservas (Preparada para o Futuro) -->
        <div class="section-card">
            <h3>📅 Suas Reservas</h3>
            <p style="color: #999;">Funcionalidade de visualização de reservas será implementada em breve.</p>
        </div>

    </div>

</body>
</html>