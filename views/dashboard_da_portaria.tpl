<div class="alert alert-info" style="display: flex; justify-content: space-between; align-items: center;">
        
        <div>
            <h4 style="margin-bottom: 5px;">👮‍♂️ Olá, {{usuario.nome}}!</h4>
            <p style="margin: 0;">
                Turno: <strong>{{usuario.turno}}</strong> | 
                <span style="font-size: 0.9em;">Bom trabalho.</span>
            </p>
        </div>

        <div>
            <a href="/logout" style="
                background-color: #cc0000; 
                color: white; 
                padding: 10px 20px; 
                text-decoration: none; 
                font-weight: bold; 
                border-radius: 5px; 
                font-family: Arial, sans-serif;">
                Sair do Sistema 🚪
            </a>
        </div>
    </div>
    <hr>

    <h3>📌 O que deseja fazer?</h3>
    <br>

    <div class="row" style="display: flex; gap: 20px; flex-wrap: wrap;">
        
        <div class="card" style="width: 18rem; border: 1px solid #ccc; padding: 15px;">
            <div class="card-body">
                <h5 class="card-title">👥 Moradores & Funcionários</h5>
                <p class="card-text">Cadastrar, editar ou remover usuários do sistema.</p>
                <a href="/portaria/users" class="btn btn-primary" style="width: 100%;">Gerenciar Usuários</a>
            </div>
        </div>

        <div class="card" style="width: 18rem; border: 1px solid #ccc; padding: 15px;">
            <div class="card-body">
                <h5 class="card-title">📦 Entregas e Encomendas</h5>
                <p class="card-text">Registrar chegada de pacotes e retiradas.</p>
                <a href="#" class="btn btn-secondary" style="width: 100%;">Em breve...</a>
            </div>
        </div>

        <div class="card" style="width: 18rem; border: 1px solid #ccc; padding: 15px;">
            <div class="card-body">
                <h5 class="card-title">📅 Reservas de Áreas</h5>
                <p class="card-text">Aprovar ou rejeitar solicitações de reservas.</p>
                <a href="#" class="btn btn-secondary" style="width: 100%;">Em breve...</a>
            </div>
        </div>

    </div>
</div>