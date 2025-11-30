% rebase('layout.tpl', title='Gestão de Usuários')

<div style="font-family: Arial, sans-serif; max-width: 1000px; margin: 20px auto; padding: 20px;">

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
        <h2 style="color: #333; margin: 0;">👥 Gestão de Usuários</h2>
        
        <div>
            <a href="/portaria" style="text-decoration: none; color: #666; margin-right: 15px; border: 1px solid #ccc; padding: 8px 12px; border-radius: 4px;">
                ⬅ Voltar
            </a>
            
            <a href="/users/add" style="background-color: #28a745; color: white; text-decoration: none; padding: 8px 15px; border-radius: 4px; font-weight: bold;">
                + Novo Usuário
            </a>
        </div>
    </div>

    <div style="background-color: #f8f9fa; padding: 15px; border-radius: 5px; margin-bottom: 20px; border: 1px solid #ddd;">
        <form action="/users" method="get" style="display: flex; gap: 10px;">
            <input type="text" name="q" value="{{nome_buscado or ''}}" placeholder="Buscar por nome..." 
                   style="flex: 1; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
            
            <button type="submit" style="background-color: #007bff; color: white; border: none; padding: 8px 15px; border-radius: 4px; cursor: pointer;">
                Buscar
            </button>
            
            % if nome_buscado:
                <a href="/users" style="padding: 8px 15px; color: #dc3545; text-decoration: none; border: 1px solid #dc3545; border-radius: 4px;">
                    Limpar
                </a>
            % end
        </form>
    </div>

    <table style="width: 100%; border-collapse: collapse; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
        <thead>
            <tr style="background-color: #343a40; color: white; text-align: left;">
                <th style="padding: 12px;">ID</th>
                <th style="padding: 12px;">Nome</th>
                <th style="padding: 12px;">Email</th>
                <th style="padding: 12px;">Tipo</th>
                <th style="padding: 12px;">Detalhes</th>
                <th style="padding: 12px; text-align: center;">Ações</th>
            </tr>
        </thead>
        <tbody>
            % for u in users:
            <tr style="border-bottom: 1px solid #ddd;">
                <td style="padding: 10px;">{{u.id}}</td>
                <td style="padding: 10px;"><strong>{{u.nome}}</strong></td>
                <td style="padding: 10px; color: #555;">{{u.email}}</td>
                
                <td style="padding: 10px;">
                    <span style="padding: 4px 8px; border-radius: 12px; font-size: 0.85em; 
                          background-color: {{'#e2e6ea' if u.get_tipo() == 'morador' else '#d1ecf1'}}; 
                          color: {{'#333' if u.get_tipo() == 'morador' else '#0c5460'}};">
                        {{u.get_tipo().upper()}}
                    </span>
                </td>

                <td style="padding: 10px;">
                    % if u.get_tipo() == 'morador':
                        🏠 Apto: {{u.apartamento}}
                    % elif u.get_tipo() == 'porteiro':
                        🕒 Turno: {{u.turno}}
                    % end
                </td>
                
                <td style="padding: 10px; text-align: center;">
                    <a href="/users/edit/{{u.id}}" style="text-decoration: none; color: #ffc107; font-weight: bold; margin-right: 10px;">
                        Editar
                    </a>
                    
                    <form action="/users/delete/{{u.id}}" method="post" style="display:inline;">
                        <button type="submit" onclick="return confirm('Tem certeza que deseja excluir {{u.nome}}?')" 
                                style="background: none; border: none; color: #dc3545; font-weight: bold; cursor: pointer; padding: 0;">
                            Excluir
                        </button>
                    </form>
                </td>
            </tr>
            % end
        </tbody>
    </table>

    % if not users:
        <div style="text-align: center; padding: 40px; color: #777;">
            Nenhum usuário encontrado.
        </div>
    % end

</div>











