% rebase('layout.tpl', title='Cadastro de Morador', active='register')

<div style="max-width: 500px; margin: 30px auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px;">
    
    <h2 style="text-align: center;">📝 Novo Morador</h2>
    <p style="text-align: center; color: #666;">Preencha seus dados para acessar o condomínio.</p>
    <hr>

    % if defined('error') and error:
        <div style="color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 10px; margin-bottom: 15px; border-radius: 4px;">
            {{error}}
        </div>
    % end

    <form action="/register" method="post">
        
        <div style="margin-bottom: 15px;">
            <label for="nome"><b>Nome Completo:</b></label>
            <input type="text" name="nome" required style="width: 100%; padding: 8px; box-sizing: border-box;" placeholder="Ex: João da Silva">
        </div>

        <div style="margin-bottom: 15px;">
            <label for="email"><b>E-mail:</b></label>
            <input type="email" name="email" required style="width: 100%; padding: 8px; box-sizing: border-box;" placeholder="seu@email.com">
        </div>

        <div style="margin-bottom: 15px;">
            <label for="senha"><b>Senha:</b></label>
            <input type="password" name="senha" required style="width: 100%; padding: 8px; box-sizing: border-box;">
        </div>

        <div style="display: flex; gap: 10px; margin-bottom: 15px;">
            <div style="flex: 1;">
                <label for="apartamento"><b>Apartamento:</b></label>
                <input type="text" name="apartamento" required style="width: 100%; padding: 8px; box-sizing: border-box;" placeholder="Ex: 101">
            </div>
           
        </div>

        <button type="submit" style="width: 100%; padding: 10px; background-color: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px;">
            Criar Conta
        </button>
    </form>

    <br>
    <div style="text-align: center;">
        <small>Já tem cadastro? <a href="/login">Voltar para Login</a></small>
    </div>

</div>