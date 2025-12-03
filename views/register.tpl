% rebase('layout.tpl', title='Criar Conta', active='register')

<div class="form-center">
    <h3 style="text-align: center; margin-bottom: 20px;">📝 Novo Morador</h3>
    
    % if defined('error') and error:
        <div class="alert-error">{{error}}</div>
    % end

    <form action="/register" method="post">
        <div class="form-group">
            <label class="form-label">Nome Completo</label>
            <input type="text" name="nome" class="form-control" required>
        </div>
        <div class="form-group">
            <label class="form-label">E-mail</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="form-group">
            <label class="form-label">Senha</label>
            <input type="password" name="senha" class="form-control" required>
        </div>
        <div class="form-group">
            <label class="form-label">Apartamento</label>
            <input type="text" name="apartamento" class="form-control" required placeholder="Ex: 101">
        </div>

        <button type="submit" class="btn btn-success btn-full">Criar Minha Conta</button>
    </form>
    
    <div style="text-align: center; margin-top: 20px;">
        <a href="/login" style="color: #007bff;">Voltar para Login</a>
    </div>
</div>