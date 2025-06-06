# Flutter App Ecommerce

Repositório referente a um aplicativo de agendamento e exibição de posts por data feito com Flutter.


# Decisões arquiteturais
  
  Optei por uma arquitetura Clean Code para a aplicação, por estar mais habituado com esse tipo de arquitetura e considero essencial para tornar o código mais legível, mais fácil de ser mantido e mais compreensível, além de facilitar a implementação de testes em cada funcionalidade do sistema pelo fato de isolar a aplicação em diferentes camadas.
  
  Há basicamente quatro camadas:

  Data Layer: Camada responsável pelo recebimento de dados de várias fontes, sejam elas remotas, como uma API remota, ou locais, como um banco de dados local. Nessa camada, é inserida a implementação do repositório e de serviços que se comunicam com as fontes de dados.

  Domain Layer: Camada responsável pela lógica de negócios da aplicação. Em suma, essa camada abstrai as implementações do repositório, dos casos de uso em diferentes interfaces que apenas definem o comportamento das implementações concretas, onde cada uma possui uma única atribuição. Essa ideia segue os princípios da responsabilidade única e da inversão de dependências do S.O.L.I.D. Além diso, nessa camada, é inserido as Entities, que são entidades responsáveis por encapsular todas as regras de negócio da aplicação. Por isso, não é recomendável mudanças nelas, pois haverá dessa forma impactos em várias partes da aplicação que as utilizam.

  Presentation Layer: Camada responsável pela exibição das diferentes páginas, widgets e lógica de estados que compõe a interface de usuário e as interações com a tela.

  Core Layer: Essa é uma camada adicional, que possui recursos importantes da aplicação, como métodos utils, constantes, widgets globais, padronização de textos e cores, injeção de dependências e abstração para lidar com o retorno dos dados.

# Conceitos e premissas

  A arquitetura Clean Code foi implementada para reduzir o acoplamento entre os objetos, o que vai de encontro a alguns princípios do SOLID, como o da responsabilidade única, dessa forma, cada camada será responsável apenas por uma função. Percebemos a divisão do sistema em features, posts e schedule. Dessa forma, a estrutura do código fica bem organizada e fácil de implementar alterações em features existentes ou novas features. Nesse caso, optei por dividir apenas a camada de presentation da aplicação em features, pois tanto o módulo de post, com a listagem de posts por data, e o módulo de schedule, com o agendamento de um novo post, compartilham do mesmo Model/Entity (PostModel) e alguns casos de uso. Então, na minha visão só acrescentaria complexidade ao código, dividir cada modulo em várias camadas.


  Para a lógica de estados, foi utilizado o gerenciamento de estados com Provider, para isso, no arquivo router.dart foram inseridos os providers que seriam utilizados em cada tela, repassando o estado para cada view. Estado esse gerenciado dentro de cada controller, que será responsável por chamar cada caso de uso, atualizar o estado e alterar a interface de usuário de acordo com tais mudanças. No caso dos posts, o carregamento da listagem é chamado assim que o usuário entra na tela ou reinicializa o app, pois os dados são salvos corretamente no cache por meio da lib SharedPreferences, Hive seria uma outra boa opção que utilizei em diversos projetos do mercado. No módulo de Agendamento, foi feita uma validação que exibe uma snack bar para o usuário com uma mensagem de erro, se por acaso ocorrer uma tentativa de agendamento em um horário inserido num intervalo de 30 min para mais ou para menos de algum outro horário já agendado na mesma data. Essa foi uma regra de negócio pensada por mim, pois é uma regra comum no agendamento de algumas aplicações reais.
  
  Grande parte dos elementos que compõem a interface de usuário foram separados em diferentes componentes ou widgets, para que sejam reutilizados no sistema, o que também facilita os testes de widgets e a manutenção da aplicação, como o custom text field, custom button, app bar, mock image. Esses citados foram englobados no core, pois são widgets globais. Utilizei também widgets específicos para cada módulo, como o calendar widget. Poderia ser feitos componentes customizados para o seletor de data e horário também, caso fosse necessário para o tema da aplicação. 
  
  No caso do repositório, é feita toda a manipulação de dados, com busca de posts por data e inserção de novos posts através do agendamento. Esses dados são salvos no cache do dispostivo utilizando-se da lib SharedPreferences. Entretanto, ocorre a persistência local dos dados após reinicialização da aplicação. Foram implementados alguns testes unitários para as funções do repositório através da lib Flutter Test, o que valida também casos específicos, como o agendamento no mesmo horário e data. Todos os 4 testes passaram ao rodar o comando flutter test no terminal.

  Se tratando da navegação, a geração de rotas nomeadas foi utilizada para cada tela e cada rota é separada dentro do arquivo router.dart, que define as condições de chamada de cada rota.

  Obs.: A imagem de cada post está mockada na listagem com um link externo da web e um pequeno efeito de animcação e na tela de agendamento não foi inserida a opção de imagem como está no figma, pois não está especificado nos requisitos do desafio. Também foi inserida uma app bar para a tela de agendamento, para que o usuário consiga voltar para a tela anterior de listagem de posts por data.


  
 # Como rodar a aplicação
  
  - É necessário instalar o [Dart SDK](https://dart.dev/get-dart) e  o [Flutter SDK](https://docs.flutter.dev/get-started/install)
  - Utilizei a seguinte versão do Flutter e do Dart:
        
        Dart SDK version: 3.6.1
        Flutter 3.27.2 

  - É preciso instalar o [Android Studio](https://developer.android.com/studio) também, onde a versão do Flutter deve suportar a versão do Java e do Gradle no sistema.
  - Se quiser rodar em emulador iOS ou Iphone físico, instale o [Xcode](https://developer.apple.com/xcode/)
  - Após instalação dos SDKs e ajuste das configurações de build para que as versões estejam competíveis, basta executar o seguinte comando para instalar todas as dependências e bibliotecas utilizadas.

```
flutter pub get
```

- Rodar a aplicação: 

```
flutter run
```

- Acessar a aplicação

```
Utilizei o dispositivo físico Iphone 15 e um emulador Android Pixel 7a API 34 para rodar a aplicação e garantir que funcione tanto para o Android como para o iOS 
```

# Rodando a aplicação

  [Demonstração](https://www.youtube.com/shorts/1AaV4Vsy1Us?feature=shared)


