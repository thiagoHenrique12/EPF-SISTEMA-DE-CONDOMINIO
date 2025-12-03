% rebase('layout.tpl', title='Painel do Morador')

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
        padding: 4px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; text-transform: uppercase;
    }
    .status-pendente { background: #fff3cd; color: #856404; }
    .status-entregue { background: #d1e7dd; color: #0f5132; }
    
    .logout-btn { float: right; text-decoration: none; color: #d9534f; font-weight: bold; }
</style>

<div class="dashboard-container">
    <div style="margin-bottom: 20px; overflow: hidden;">
        <a href="/logout" class="logout-btn">Sair do Sistema (Logout) ➜</a>
    </div>

    <div class="welcome-banner">
        <h2 style="margin: 0;">Olá, {{usuario.nome}}!</h2>
        <p style="margin: 5px 0 0;">
            🏠 Unidade: <strong>{{usuario.apartamento}}</strong>
        </p>
    </div>

    <div class="section-card">
        <h3>📦 Suas Encomendas</h3>
        
        % if not entregas:
            <p style="color: #777; font-style: italic; padding: 20px; text-align: center;">
                Nenhuma encomenda pendente.
            </p>
        % else:
            <table>
                <thead>
                    <tr>
                        <th>Descrição</th>
                        <th>Data Chegada</th>
                        <th>Situação</th>
                    </tr>
                </thead>
                <tbody>
                    % for e in entregas:
                    <tr>
                        <td><strong>{{e.descricao}}</strong></td>
                        <td>{{e.data_chegada}}</td>
                        <td>
                            % if e.retirada:
                                <span class="status-badge status-entregue">Entregue</span>
                                <div style="font-size: 10px; color: #999; margin-top: 2px;">{{e.retirada}}</div>
                            % else:
                                <span class="status-badge status-pendente">Na Portaria</span>
                            % end
                        </td>
                    </tr>
                    % end
                </tbody>
            </table>
        % end
    </div>

    <div class="section-card">
        <h3>📅 Suas Reservas</h3>
        <p style="color: #999;">O módulo de reservas será implementado em breve.</p>
    </div>

</div>