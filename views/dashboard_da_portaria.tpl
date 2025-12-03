% rebase('layout.tpl', title='Painel da Portaria')

<div class="container">
    
    <div class="header-box">
        <div class="header-title">
            <h2>👮‍♂️ Olá, {{usuario.nome}}!</h2>
            <div class="header-info">
                <p>Turno: <strong>{{usuario.turno}}</strong> | Bom trabalho.</p>
            </div>
        </div>
        
        <div>
            <a href="/logout" class="btn btn-danger">Sair do Sistema 🚪</a>
        </div>
    </div>

    <h3 class="section-title">📌 Painel de Controle</h3>

    <div class="dashboard-grid">
        
        <div class="card">
            <div>
                <h3>👥 Moradores & Staff</h3>
                <p>Cadastrar, editar ou remover usuários e moradores do sistema.</p>
            </div>
            <a href="/portaria/users" class="btn btn-primary btn-full">Gerenciar Usuários</a>
        </div>

        <div class="card">
            <div>
                <h3>📦 Encomendas</h3>
                <p>Registrar chegada de pacotes e confirmar retiradas.</p>
            </div>
            <a href="/portaria/entregas" class="btn btn-primary btn-full">Gerenciar Entregas</a>
        </div>

        <div class="card">
            <div>
                <h3>📅 Reservas</h3>
                <p>Visualizar calendário, aprovar ou rejeitar solicitações de áreas.</p>
            </div>
            <a href="/portaria/reservas" class="btn btn-primary btn-full">Gerenciar Reservas</a>
        </div>

    </div>
</div>