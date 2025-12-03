% rebase('layout.tpl', title='Painel do Morador')

<div class="container">
    
    <div class="header-box">
        <div class="header-title">
            <h2>👋 Olá, {{usuario.nome}}!</h2>
            <div class="header-info">
                <p>🏠 Unidade: <strong>{{usuario.apartamento}}</strong></p>
            </div>
        </div>
        <div>
            <a href="/logout" class="btn btn-danger">Sair 🚪</a>
        </div>
    </div>

    <h3 class="section-title">📌 Suas Informações</h3>

    <div class="dashboard-grid">
        
        <div class="card">
            <div>
                <h3>📦 Encomendas</h3>
                % if not entregas:
                    <p>Nenhuma encomenda pendente na portaria.</p>
                % else:
                    <p style="color: #e67e22; font-weight: bold;">
                        Você tem {{len(entregas)}} pacote(s) aguardando!
                    </p>
                    <ul style="text-align: left; color: #666; font-size: 0.9em;">
                        % for e in entregas:
                            <li>{{e.descricao}} ({{e.data_chegada}})</li>
                        % end
                    </ul>
                % end
            </div>
            <button class="btn btn-success btn-full" disabled style="opacity: 0.7;">Ver Detalhes (Na Portaria)</button>
        </div>

        <div class="card">
            <div>
                <h3>📅 Reservas</h3>
                <p>Agende o salão de festas ou churrasqueira.</p>
            </div>
            <a href="/morador/reservas" class="btn btn-primary btn-full">Minhas Reservas</a>
        </div>

    </div>
</div>