% rebase('layout.tpl', title='Registrar Encomenda')

<div class="form-container"> <h2 class="form-title">📦 Registrar Nova Encomenda</h2>

    <form action="/portaria/entregas/nova" method="post">
        
        <div class="form-group">
            <label for="descricao" class="form-label">O que chegou?</label>
            <input type="text" id="descricao" name="descricao" class="form-control" 
                   required placeholder="Ex: Caixa Amazon, Envelope do Banco...">
        </div>

        <div class="form-group">
            <label for="morador_id" class="form-label">Para quem é?</label>
            <select name="morador_id" id="morador_id" class="form-control" required>
                <option value="" disabled selected>Selecione um morador...</option>
                
                % for m in moradores:
                    <option value="{{m.id}}">
                        Apto {{m.apartamento}} - {{m.nome}}
                    </option>
                % end
            </select>
        </div>

        <div class="btn-container">
            <button type="submit" class="btn-submit">Registrar Chegada</button>
            <a href="/portaria/entregas" class="btn-cancel">Cancelar</a>
        </div>

    </form>
</div>