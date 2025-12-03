% rebase('layout.tpl', title='Gestão de Encomendas')

<div style="font-family: Arial, sans-serif; max-width: 1000px; margin: 20px auto; padding: 20px;">

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
        <h2 style="color: #333; margin: 0;">📦 Controle de Encomendas</h2>
        
        <div>
            <a href="/portaria" style="text-decoration: none; color: #666; margin-right: 15px; border: 1px solid #ccc; padding: 8px 12px; border-radius: 4px;">
                ⬅ Voltar
            </a>
            
            <a href="/portaria/entregas/nova" style="background-color: #28a745; color: white; text-decoration: none; padding: 8px 15px; border-radius: 4px; font-weight: bold;">
                + Registrar Chegada
            </a>
        </div>
    </div>

    <table border="1" cellpadding="10" cellspacing="0" style="width: 100%; border-collapse: collapse; background: white;">
        <thead>
            <tr style="background-color: #343a40; color: white; text-align: left;">
                <th>Descrição / Pacote</th>
                <th>Destinatário</th>
                <th>Data Chegada</th>
                <th>Status</th>
                <th style="text-align: center;">Ação</th>
            </tr>
        </thead>
        <tbody>
            % for e in entregas:
            <tr style="border-bottom: 1px solid #ddd;">
                <td><strong>{{e.descricao}}</strong></td>
                
                <td>
                    {{nomes.get(e.morador_id, 'Morador Desconhecido')}}
                </td>
                
                <td>{{e.data_chegada}}</td>
                
                <td>
                    % if e.retirada:
                        <span style="color: green; font-weight: bold;">✅ Entregue</span>
                        <br><small style="color: #666;">{{e.retirada}}</small>
                    % else:
                        <span style="color: orange; font-weight: bold;">🕒 Aguardando</span>
                    % end
                </td>
                
                <td style="text-align: center;">
                    % if not e.retirada:
                        <a href="/portaria/entregas/confirmar/{{e.id}}" 
                           onclick="return confirm('Confirma que o morador retirou este pacote?')"
                           style="background-color: #007bff; color: white; padding: 6px 12px; text-decoration: none; border-radius: 4px; font-size: 0.9em;">
                           Baixar (Entregar)
                        </a>
                    % else:
                        <span style="color: #ccc;">-</span>
                    % end
                </td>
            </tr>
            % end
        </tbody>
    </table>

    % if not entregas:
        <div style="text-align: center; padding: 40px; color: #777;">
            Nenhuma encomenda registrada no sistema.
        </div>
    % end

</div>