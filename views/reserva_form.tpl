% rebase('layout.tpl', title='Nova Reserva')

<div class="form-container"> <h2 class="form-title">📅 Reservar Área Comum</h2>

    % if defined('error') and error:
        <div style="background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; border: 1px solid #f5c6cb;">
            <strong>Erro:</strong> {{error}}
        </div>
    % end

    <form action="/morador/reservas/nova" method="post">
        
        <div class="form-group">
            <label for="recurso" class="form-label">Qual área você quer reservar?</label>
            <select name="recurso" id="recurso" class="form-control" required>
                <option value="" disabled selected>Selecione...</option>
                % for opcao in recursos:
                    <option value="{{opcao}}">{{opcao}}</option>
                % end
            </select>
        </div>

        <div class="form-group">
            <label for="data_inicio" class="form-label">Data e Hora de Início:</label>
            <input type="datetime-local" id="data_inicio" name="data_inicio" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="data_fim" class="form-label">Data e Hora de Término:</label>
            <input type="datetime-local" id="data_fim" name="data_fim" class="form-control" required>
        </div>

        <div class="btn-container">
            <button type="submit" class="btn-submit">Confirmar Reserva</button>
            <a href="/morador/reservas" class="btn-cancel">Cancelar</a>
        </div>

    </form>
</div>