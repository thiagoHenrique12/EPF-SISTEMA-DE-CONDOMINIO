% rebase('layout.tpl', title='Formulário Usuário')

<div class="form-container">

    <h2 class="form-title">{{'Editar Usuário' if user else 'Adicionar Usuário'}}</h2>

    <form action="{{action}}" method="post">
        
        <div class="form-group">
            <label for="nome" class="form-label">Nome:</label>
            <input type="text" id="nome" name="nome" class="form-control" required 
                   value="{{user.nome if user else ''}}">
        </div>

        <div class="form-group">
            <label for="email" class="form-label">Email:</label>
            <input type="email" id="email" name="email" class="form-control" required 
                   value="{{user.email if user else ''}}">
        </div>

        % if not user:
        <div class="form-group">
            <label for="senha" class="form-label">Senha:</label>
            <input type="password" id="senha" name="senha" class="form-control" required>
        </div>
        % end

        <div class="form-group">
            <label for="tipo" class="form-label">Tipo de Usuário:</label>
            <select name="tipo" id="tipo" class="form-control" required>
                <option value="morador" {{'selected' if user and user.get_tipo() == 'morador' else ''}}>Morador</option>
                <option value="porteiro" {{'selected' if user and user.get_tipo() == 'porteiro' else ''}}>Porteiro</option>
            </select>
        </div>

        <div class="info-box">
            <p class="info-text">ℹ️ Preencha apenas o campo correspondente ao tipo escolhido:</p>

            <div class="form-group">
                <label for="apartamento" class="form-label">🏠 Apartamento (Se for Morador):</label>
                <input type="text" id="apartamento" name="apartamento" class="form-control"
                       value="{{user.apartamento if user and hasattr(user, 'apartamento') else ''}}">
            </div>

            <div class="form-group">
                <label for="turno" class="form-label">🕒 Turno (Se for Porteiro):</label>
                <input type="text" id="turno" name="turno" class="form-control" placeholder="Ex: Manhã"
                       value="{{user.turno if user and hasattr(user, 'turno') else ''}}">
            </div>
        </div>

        <div class="btn-container">
            <button type="submit" class="btn-submit">Salvar</button>
            <a href="/portaria/users" class="btn-cancel">Cancelar</a>
        </div>

    </form>
</div>