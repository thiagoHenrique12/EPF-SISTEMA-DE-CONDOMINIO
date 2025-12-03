% rebase('layout.tpl', title='Gestão de Reservas')

<div class="container" style="max-width: 1000px; margin: 20px auto;">

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
        <h2 style="color: #333; margin: 0;">📅 Solicitações de Reservas</h2>
        <a href="/portaria" style="text-decoration: none; color: #666; border: 1px solid #ccc; padding: 8px 12px; border-radius: 4px;">
            ⬅ Voltar
        </a>
    </div>

    <table border="1" cellpadding="10" cellspacing="0" style="width: 100%; border-collapse: collapse; background: white;">
        <thead>
            <tr style="background-color: #343a40; color: white; text-align: left;">
                <th>Quem pediu?</th>
                <th>Local</th>
                <th>Data Início</th>
                <th>Status Atual</th>
                <th style="text-align: center;">Ação</th>
            </tr>
        </thead>
        <tbody>
            % for r in sorted(reservas, key=lambda x: x.status != 'Pendente'):
            <tr style="border-bottom: 1px solid #ddd; background-color: {{'#fff9e6' if r.status == 'Pendente' else 'white'}};">
                
                <td>
                    % dono = usuarios.get(r.morador_id)
                    % if dono:
                        <strong>{{dono.nome}}</strong><br>
                        <small style="color: #666;">Unidade: {{dono.apartamento}}</small>
                    % else:
                        <span style="color:red;">(Usuário Removido)</span>
                    % end
                </td>

                <td>{{r.recurso}}</td>

                <td>{{r.data_inicio.replace('T', ' ')}}</td>

                <td>
                    % if r.status == 'Confirmada':
                        <span style="color: green; font-weight: bold;">✅ Confirmada</span>
                    % elif r.status == 'Rejeitada':
                        <span style="color: red; font-weight: bold;">❌ Rejeitada</span>
                    % elif r.status == 'Pendente':
                        <span style="color: #d9a406; font-weight: bold;">⚠️ Pendente</span>
                    % else:
                        <span style="color: #999;">{{r.status}}</span>
                    % end
                </td>

                <td style="text-align: center;">
                    % if r.status == 'Pendente':
                        <a href="/portaria/reservas/acao/{{r.id}}/aprovar" 
                           style="background-color: #28a745; color: white; padding: 5px 10px; text-decoration: none; border-radius: 4px; margin-right: 5px;">
                           Aprovar
                        </a>
                        <a href="/portaria/reservas/acao/{{r.id}}/rejeitar" 
                           onclick="return confirm('Rejeitar esta reserva?')"
                           style="background-color: #dc3545; color: white; padding: 5px 10px; text-decoration: none; border-radius: 4px;">
                           Rejeitar
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
        <p style="text-align: center; color: #777; margin-top: 30px;">Nenhuma solicitação no sistema.</p>
    % end

</div>