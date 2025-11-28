% rebase('layout.tpl', title='Entrar no Sistema', active='login')

<div style="max-width: 400px; margin: 50px auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px;">
    
    <h2 style="text-align: center;">🔐 Acesso ao Condomínio</h2>
    <hr>

    % if defined('error') and error:
        <div style="color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 10px; margin-bottom: 15px; border-radius: 4px;">
            <strong>Atenção:</strong> {{error}}
        </div>
    % end

    <form action="/login" method="post">
        
        <div style="margin-bottom: 15px;">
            <label for="email"><b>E-mail:</b></label><br>
            <input type="email" id="email" name="email" required style="width: 100%; padding: 8px; box-sizing: border-box;">
        </div>

        <div style="margin-bottom: 15px;">
            <label for="senha"><b>Senha:</b></label><br>
            <input type="password" id="senha" name="senha" required style="width: 100%; padding: 8px; box-sizing: border-box;">
        </div>

        <button type="submit" style="width: 100%; padding: 10px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px;">
            Entrar
        </button>
    </form>

    <br>
    <div style="text-align: center;">
        <small>Novo por aqui? <a href="/register">Cadastrar como Morador</a></small>
    </div>

</div>