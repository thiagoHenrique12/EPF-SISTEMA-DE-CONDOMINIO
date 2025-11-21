Este documento tem a finalidade de ir documentando as atualizações e mudanças de codigo dentro do projeto 


## USER:

### usuario abstrato:
passei a classe de users para abstrata (ABC), isso indica ao programa que essa classe so vai servir como um molde e nenhum usuario deve ser puramente instanciado (apenas as suas heranças devem)

### Implementação da chave tipo no dicionario: 
dentro do metodo to_dict na classe User existe uma nova chave indicando 'tipo', ao chamarmos o to_dict de uma das heranças será chamado o super() presente dentro do método, esse super volta para o to_dict definido na classe pai (user), que por sua vez atribui o valor self.get_tipo() para a chave 'tipo'. O método get_tipo() está definido dentro de cada uma das classes filhas e retornará 'sindico' ou 'morador'

#### Motivo para essa mudança:
quando jogarmos os dados no json vamos precisar de uma forma de decifrar à qual instancia aqueles dados pertencem (json nao sabe identificar qual objeto aquilo era antes de salvar os dados), a chave tipo vai cuidar dessa separação quando o programa estiver lendo os dados

#### Problema:
Seguindo como consequência, agora dentro de UserModel, no método load, cada umas das classes filhas está sendo instanciada através de um if relacionado ao tipo. O problema disso é que se por acaso eu criarmos uma nova classe Porteiro, vai ser preciso ir dentro de load e fazer toda uma nova logica para if tipo =='porteiro': Porteiro()... .Isso vai deixar o codigo pouco funcionou e engessado mas acho que vai funcionar. (É feio mas funciona)
    Pesquisando o gpt deu uma solução usando um conceito de Introspecção de Classes (talvez no futuro vale a pena ver, agora acho melhor seguir com o que tem) 
    