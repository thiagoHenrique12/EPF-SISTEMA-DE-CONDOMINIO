% rebase('layout.tpl', title='Formulário Usuário')

<div class="form-center">
    <h3 style="margin-top: 0; margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 10px;">
        {{'Editar Usuário' if user else 'Adicionar Usuário'}}
    </h3>

    <form action="{{action}}" method="post">
        <div class="form-group">
            <label class="form-label">Nome:</label>
            <input type="text" name="nome" class="form-control" required value="{{user.nome if user else ''}}">
        </div>
        <div class="form-group">
            <label class="form-label">Email:</label>
            <input type="email" name="email" class="form-control" required value="{{user.email if user else ''}}">
        </div>

        % if not user:
        <div class="form-group">
            <label class="form-label">Senha:</label>
            <input type="password" name="senha" class="form-control" required>
        </div>
        <div class="form-group">
            <label class="form-label">Tipo:</label>
            <select name="tipo" class="form-control" required>
                <option value="morador" {{'selected' if user and user.get_tipo() == 'morador' else ''}}>Morador</option>
                <option value="porteiro" {{'selected' if user and user.get_tipo() == 'porteiro' else ''}}>Porteiro</option>
            </select>
        </div>
        % end

        <div style="background: #f9f9f9; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
            <p style="margin: 0 0 5px 0; font-size: 0.85em; color: #666;">ℹ️ Preencha apenas o correspondente:</p>
            <div class="form-group">
                <label class="form-label">🏠 Apartamento (Morador):</label>
                <input type="text" name="apartamento" class="form-control" value="{{user.apartamento if user and hasattr(user, 'apartamento') else ''}}">
            </div>
            <div class="form-group" style="margin-bottom: 0;">
                <label class="form-label">🕒 Turno (Porteiro):</label>
                <input type="text" name="turno" class="form-control" value="{{user.turno if user and hasattr(user, 'turno') else ''}}">
            </div>
        </div>

        <button type="submit" class="btn btn-success btn-full">Salvar</button>
        <div style="text-align: center; margin-top: 15px;">
            <a href="/portaria/users" style="color: #666;">Cancelar</a>
        </div>
    </form>
</div>