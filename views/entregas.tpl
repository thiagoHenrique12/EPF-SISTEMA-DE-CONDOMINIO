% rebase('layout.tpl', title='Gestão de Encomendas')

<div class="container">
    <div class="header-box">
        <div class="header-title"><h2>📦 Controle de Encomendas</h2></div>
        <div>
            <a href="/portaria" style="text-decoration: none; color: #666; margin-right: 15px; border: 1px solid #ccc; padding: 8px 12px; border-radius: 4px;">
                ⬅ Voltar
            </a>
            
            <a href="/portaria/entregas/nova" style="background-color: #28a745; color: white; text-decoration: none; padding: 8px 15px; border-radius: 4px; font-weight: bold;">
                + Registrar Chegada
            </a>
        </div>
    </div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Descrição</th>
                    <th>Destinatário</th>
                    <th>Chegada</th>
                    <th>Status</th>
                    <th style="text-align: center;">Ação</th>
                </tr>
            </thead>
            <tbody>
                % for e in entregas:
                <tr>
                    <td><strong>{{e.descricao}}</strong></td>
                    <td>{{nomes.get(e.morador_id, 'Desconhecido')}}</td>
                    <td>{{e.data_chegada}}</td>
                    <td>
                        % if e.retirada:
                            <span style="color: green; font-weight: bold;">✅ Entregue</span>
                        % else:
                            <span style="color: orange; font-weight: bold;">🕒 Aguardando</span>
                        % end
                    </td>
                    <td style="text-align: center;">
                        % if not e.retirada:
                            <a href="/portaria/entregas/confirmar/{{e.id}}" onclick="return confirm('Confirmar retirada?')" class="btn btn-primary" style="padding: 5px 10px; font-size: 12px;">Baixar</a>
                        % else:
                            <span style="color: #ccc;">-</span>
                        % end
                    </td>
                </tr>
                % end
            </tbody>
        </table>
    </div>
</div>










