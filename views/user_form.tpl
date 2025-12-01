% rebase('layout.tpl', title='Formulário Usuário')

<section class="form-section">
    <h1>{{'Editar Usuário' if user else 'Adicionar Usuário'}}</h1>

    <form action="{{action}}" method="post" class="form-container">
        
        <div class="form-group">
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" required 
                   value="{{user.nome if user else ''}}">
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required 
                   value="{{user.email if user else ''}}">
        </div>

        % if not user:
        <div class="form-group">
            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" required>
        </div>

        <div class="form-group">
            <label for="tipo">Tipo de Usuário:</label>
            <select name="tipo" id="tipo" required style="width: 100%; padding: 8px;">
                <option value="morador">Morador</option>
                <option value="porteiro">Porteiro</option>
            </select>
        </div>

        % end

        <div class="form-group">
            <label for="apartamento">Apartamento / Bloco:</label>
            <input type="text" id="apartamento" name="apartamento"  
                   value="{{user.apartamento if user and hasattr(user, 'apartamento') else ''}}">
        </div>

        <div class="form-group">
            <label for="turno">Turno :</label>
            <input type="text" id="turno" name="turno" 
                   value="{{user.turno if user and hasattr(user, 'turno') else ''}}">
        </div>

        <div class="form-actions">
            <button type="submit" class="btn-submit">Salvar</button>
            <a href="/portaria/users" class="btn-cancel">Voltar</a>
        </div>
    </form>
</section>