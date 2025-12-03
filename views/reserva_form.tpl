% rebase('layout.tpl', title='Nova Reserva')

<div class="form-center">
    
    <h3 style="margin-top: 0; margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 10px; color: #333;">
        📅 Reservar Área Comum
    </h3>

    % if defined('error') and error:
        <div class="alert-error">
            <strong>Atenção:</strong> {{error}}
        </div>
    % end

    <form action="/morador/reservas/nova" method="post">
        
        <div class="form-group">
            <label class="form-label">Qual área você quer reservar?</label>
            <select name="recurso" class="form-control" required>
                <option value="" disabled selected>Selecione uma opção...</option>
                % for opcao in recursos:
                    <option value="{{opcao}}">{{opcao}}</option>
                % end
            </select>
        </div>

        <div class="form-group">
            <label class="form-label">Data e Hora de Início:</label>
            <input type="datetime-local" name="data_inicio" class="form-control" required>
        </div>

        <div class="form-group">
            <label class="form-label">Data e Hora de Término:</label>
            <input type="datetime-local" name="data_fim" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-success btn-full">Confirmar Reserva</button>
        
        <div style="text-align: center; margin-top: 15px;">
            <a href="/morador/reservas" style="color: #666; text-decoration: none; font-size: 14px;">Cancelar</a>
        </div>

    </form>
</div>