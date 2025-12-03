% rebase('layout.tpl', title='Minhas Reservas')

<div style="font-family: Arial, sans-serif; max-width: 1000px; margin: 20px auto; padding: 20px;">

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
        <h2 style="color: #333; margin: 0;">📅 Minhas Reservas</h2>
        
        <div>
            <a href="/painel" style="text-decoration: none; color: #666; margin-right: 15px; border: 1px solid #ccc; padding: 8px 12px; border-radius: 4px;">
                ⬅ Voltar ao Painel
            </a>
            
            <a href="/morador/reservas/nova" style="background-color: #28a745; color: white; text-decoration: none; padding: 8px 15px; border-radius: 4px; font-weight: bold;">
                + Nova Reserva
            </a>
        </div>
    </div>

    <table border="1" cellpadding="10" cellspacing="0" style="width: 100%; border-collapse: collapse; background: white; box-shadow: 0 2px 5px rgba(0,0,0,0.05);">
        <thead>
            <tr style="background-color: #0d6efd; color: white; text-align: left;">
                <th>Local / Área</th>
                <th>Início</th>
                <th>Fim</th>
                <th>Status</th>
                <th style="text-align: center;">Ação</th>
            </tr>
        </thead>
        <tbody>
            % for r in reservas:
            <tr style="border-bottom: 1px solid #eee;">
                <td><strong>{{r.recurso}}</strong></td>
                
                <td>{{r.data_inicio.replace('T', ' ')}}</td>
                <td>{{r.data_fim.replace('T', ' ')}}</td>
                
                <td>
                    % if r.status == 'Confirmada':
                        <span style="background-color: #d1e7dd; color: #0f5132; padding: 4px 8px; border-radius: 12px; font-size: 0.9em; font-weight: bold;">
                            ✅ Confirmada
                        </span>
                    % elif r.status == 'Cancelada':
                        <span style="background-color: #f8d7da; color: #842029; padding: 4px 8px; border-radius: 12px; font-size: 0.9em; font-weight: bold;">
                            ❌ Cancelada
                        </span>
                    % else:
                        <span style="background-color: #fff3cd; color: #664d03; padding: 4px 8px; border-radius: 12px; font-size: 0.9em; font-weight: bold;">
                            🕒 {{r.status}}
                        </span>
                    % end
                </td>
                
                <td style="text-align: center;">
                    % if r.status != 'Cancelada':
                        <a href="/morador/reservas/cancelar/{{r.id}}" 
                           onclick="return confirm('Tem certeza que deseja cancelar esta reserva?')"
                           style="color: #dc3545; text-decoration: underline; cursor: pointer; font-size: 0.9em;">
                           Cancelar
                        </a>
                    % else:
                        <span style="color: #ccc;">-</span>
                    % end
                </td>
            </tr>
            % end
        </tbody>
    </table>

    % if not reservas:
        <div style="text-align: center; padding: 40px; background-color: #f9f9f9; border-radius: 8px; margin-top: 10px; color: #777;">
            <i>Você ainda não fez nenhuma reserva. Aproveite as áreas de lazer!</i>
        </div>
    % end

</div>