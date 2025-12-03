% rebase('layout.tpl', title='Gestão de Usuários')

<div class="container">

    <div class="header-box">
        <div class="header-title">
            <h2>👥 Gestão de Usuários</h2>
        </div>
        <div>
            <a href="/portaria" class="btn btn-warning" style="margin-right: 10px;">⬅ Voltar</a>
            
            <a href="/portaria/users/add" class="btn btn-success">+ Novo Usuário</a>
        </div>
    </div>

    <div class="card" style="margin-bottom: 20px; padding: 20px; flex-direction: row; align-items: center;">
        <form action="/portaria/users" method="get" style="display: flex; width: 100%; gap: 10px;">
            <input type="text" name="q" value="{{nome_buscado or ''}}" placeholder="Buscar por nome..." class="form-control" style="flex: 1;">
            
            <button type="submit" class="btn btn-primary">Buscar</button>
            
            % if nome_buscado:
                <a href="/portaria/users" class="btn btn-danger">Limpar</a>
            % end
        </form>
    </div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>Tipo</th>
                    <th>Detalhes</th> <th style="text-align: center;">Ações</th>
                </tr>
            </thead>
            <tbody>
                % for u in users:
                <tr>
                    <td><strong>{{u.nome}}</strong></td>
                    
                    <td>{{u.email}}</td>
                    
                    <td>
                        <span style="background: #eee; padding: 4px 8px; border-radius: 4px; font-size: 0.85em; font-weight: bold; color: #555;">
                            {{u.get_tipo().upper()}}
                        </span>
                    </td>

                    <td>
                        % if u.get_tipo() == 'morador':
                            🏠 Apto: <strong>{{u.apartamento}}</strong>
                        % elif u.get_tipo() == 'porteiro':
                            🕒 Turno: <strong>{{u.turno}}</strong>
                        % end
                    </td>
                    
                    <td style="text-align: center;">
                        <a href="/portaria/users/edit/{{u.id}}" class="btn btn-warning" style="padding: 5px 10px; font-size: 12px; margin-right: 5px;">
                            Editar
                        </a>
                        
                        <form action="/portaria/users/delete/{{u.id}}" method="post" style="display:inline;">
                            <button type="submit" onclick="return confirm('Tem certeza que deseja apagar {{u.nome}}?')" 
                                    class="btn btn-danger" style="padding: 5px 10px; font-size: 12px;">
                                Excluir
                            </button>
                        </form>
                    </td>
                </tr>
                % end
            </tbody>
        </table>

        % if not users:
            <div style="padding: 40px; text-align: center; color: #777;">
                <p>Nenhum usuário encontrado.</p>
            </div>
        % end
    </div>

</div>