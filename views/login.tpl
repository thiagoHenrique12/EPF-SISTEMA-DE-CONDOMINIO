% rebase('layout.tpl', title='Login')

<div class="form-center">
    <h2 style="text-align: center; margin-bottom: 20px; color: #333;">SISTEMA DE CONDOMÍNIO</h2>
    
    % if defined('error') and error:
        <div class="alert-error">{{error}}</div>
    % end

    <form action="/login" method="post">
        <div class="form-group">
            <label class="form-label">E-mail</label>
            <input type="email" name="email" class="form-control" required placeholder="seu@email.com">
        </div>
        
        <div class="form-group">
            <label class="form-label">Senha</label>
            <input type="password" name="senha" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary btn-full">Entrar</button>
    </form>

    <div style="text-align: center; margin-top: 20px; font-size: 0.9em;">
        <a href="/register" style="color: #007bff;">Criar conta de Morador</a>
    </div>
</div>