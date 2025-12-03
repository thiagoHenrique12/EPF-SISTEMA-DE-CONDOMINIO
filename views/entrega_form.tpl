% rebase('layout.tpl', title='Registrar Encomenda')

<div class="form-center">
    <h3 style="margin-top: 0; margin-bottom: 20px;">📦 Nova Encomenda</h3>

    <form action="/portaria/entregas/nova" method="post">
        <div class="form-group">
            <label class="form-label">Descrição do Pacote</label>
            <input type="text" name="descricao" class="form-control" required placeholder="Ex: Caixa Amazon">
        </div>

        <div class="form-group">
            <label class="form-label">Para quem é?</label>
            <select name="morador_id" class="form-control" required>
                <option value="" disabled selected>Selecione...</option>
                % for m in moradores:
                    <option value="{{m.id}}">Apto {{m.apartamento}} - {{m.nome}}</option>
                % end
            </select>
        </div>

        <button type="submit" class="btn btn-success btn-full">Registrar Chegada</button>
        <div style="text-align: center; margin-top: 15px;">
            <a href="/portaria/entregas" style="color: #666;">Cancelar</a>
        </div>
    </form>
</div>