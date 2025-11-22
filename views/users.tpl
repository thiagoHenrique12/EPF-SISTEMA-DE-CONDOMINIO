% rebase('layout.tpl', title='Gestão de Usuários')

<section class="users-section">
    <div class="section-header">
        <h1 class="section-title"><i class="fas fa-users"></i> Gestão de Usuários</h1>
        <a href="/users/add" class="btn btn-primary">
            <i class="fas fa-plus"></i> Novo Usuário
        </a>
    </div>

    <div class="table-container">
        <table class="styled-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>Tipo</th>
                    <th>Apto</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                % for u in users:
                <tr>
                    <td>{{u.id}}</td>
                    <td>{{u.nome}}</td>
                    <td><a href="mailto:{{u.email}}">{{u.email}}</a></td>
                    <td>{{u.get_tipo().upper()}}</td>
                    <td>
                        {{u.apartamento if hasattr(u, 'apartamento') else '-'}}
                    </td>
                    
                    <td class="actions">
                        <a href="/users/edit/{{u.id}}" class="btn btn-sm btn-edit">
                            Editar
                        </a>
                        <form action="/users/delete/{{u.id}}" method="post" style="display:inline;">
                            <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Tem certeza?')">
                                Excluir
                            </button>
                        </form>
                    </td>
                </tr>
                % end
            </tbody>
        </table>
    </div>
</section>