# Flutter Modular
Esse package tem como proposta te auxiliar a ter um projeto escalavel e com um baixo nivel de acoplamento entre camadas independente da sopa de letrinha que você estiver usando como: **MVC, MVVM, VIPER, DDD**  e assim vai. Para alcançar esse objetivo ele possui duas funcionalidades que auxiliam muito no processo: **O Sistema de Injeção de Dependência e  a Navegação via Rotas**.

# Começando o projeto.
Antes de entrar em detalhes sobre as funcionalidades o modular exige um preset muito simples:
  - Configurar a função  **main** em ```main.dart``` para:
  
      ```
      void main() => runApp(
        ModularApp(
          module: AppModule(),
          child: AppWidget(),
        ),
      );
      ```
    
   - Configurar o **AppWiget**:
   
      ```
      class AppWidget extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
          // É obrigatório usar o Modular.routerDelegate e Modular.routeInformationParser.
          return MaterialApp.router(
            title: 'Modular Demo',
            theme: ThemeData(primarySwatch: Colors.green),
            routerDelegate: Modular.routerDelegate,
            routeInformationParser: Modular.routeInformationParser,
          );
        }
      }
      ```
  
  - Criar e configurar o móludo inicial **AppModule**:
     ```
     class AppModule extends Module {
      @override
      final List<Bind> binds = [];

      @override
      final List<ModularRoute> routes = [];
    }
    ```
 Simples não é mesmo? Apartir de agora você deve pensar no seu código como um lego de módulos. Cada Módulo tem a sua configuração, page e componentes especificos. E caso ache válido para o seu projeto, as camadas relacionadas a regras de negócio.
 
 
 # Entendendo o que é um Módulo.
 O Módulo nada mais é que um agrupamento de features com escopos semelhantes ou iguais. Cada módulo tem as  injeções de dependência, configuradas em **binds** e rotas, configurada em **routes** daquele módulo. 
 
 
 # Configurando as rotas.
 
 A rota inicial costuma ser **"/"**, podendo ser chamada de **Modular.initialRoute**. No exemplo a seguir a minha rota inicial será um outro módulo o **HomeModule**.

   ```
   class AppModule extends Module {
    @override
    final List<Bind> binds = [];

      @override
      final List<ModularRoute> routes = [
        ModuleRoute(
          Modular.initialRoute,
          module: HomeModule(),
          transition: TransitionType.downToUp,
        ),
        WildcardRoute(child: (_, args) => NotFoundPage())
      ];
    }
   ```
Note que **AppModule** não conhece nada sobre **HomeModule** ele apenas o define como rota inicial.


## ChildRoute

Define qual vai ser o **Widget** atribuído a determinada rota. O primeiro argumento é o nome da rota e o argumento **child** é uma function que
recebe um **BuildContext** e **ModularArguments** e deve retornar um **Widget** definido por você.

Em **HomeModule** temos esse exemplo:
  ```ChildRoute('/unauthorized', child: (_, args) => UnauthorizedPage())```

com isso temos que a rota **/unauthorized/** retornara **UnauthorizedPage**.

## ModuleRoute
Define qual vai ser o **Modulo** atribuído a determinada rota. O primeiro argumento é o nome da rota e **Module** é o módulo que será definido a partir daquela rota. 

Em **HomeModule** temos esse exemplo:
    ```
    ModuleRoute(
              "/news",
              module: NewsModule(),
            ),
    ```

## ModularArguments 

Objeto poderoso em que você pode recuperar os **Params, QueyParams e Data** passados naquela rota.

  - **Params**: recuperar valores passados por parametro na rota, por exemplo: 
    **/news** foi definida como **/news/:id**
      ```
      Modular.to.navigate('/news/12341231');
      // args.params['id'] == 12341231
      ```
  - **QueyParams**: Recuperar valores passados por query parametes na rota, por exemplo:
   **/news** foi definida como **/news/**
      ```
      Modular.to.navigate('/news/?name=julio&numero=1234567');
      // args.queryParams['name'] == julio e args.queryParams['numero']=1234567
      ```
    
   - **Data**: Recuperar objetos passados no segundo parâmetro da navegação.
     ```
     Modular.to.navigate("/rota, ObjetoTeste());
     //args.data == instância de ObjetoTeste
     ```
Além de estar disponível em toda definição de **ChildRoute**, também pode ser recuperado com ```Modular.args```, que retornará os argumentos da rota atual.

**PS:** Esse recurso é extremamente poderoso e util para Web.

## WildcardRoute
Essa classe define qual vai ser o **Widget** a ser mostrado caso o usuário esteja em uma rota não definida em seu módulo. 

Em **AppModule** temos esse exemplo:

  ```
  WildcardRoute(child: (_, args) => NotFoundPage())
  //Qualquer rota não definida que o usuário tente acessar levará para NotFoundPage()
  ```

## RouteGuard
Lembra o funcionamento de um **middleware**, mas ele apenas redireciona caso o usuário para outra rota desejada caso ele não atenda uma condição.
Em **HomeModule** temos esse exemplo:

- Definindo o **RouteGuard**
    ```
    class AuthGuard extends RouteGuard {
      AuthGuard() : super(redirectTo: '/unauthorized');

      @override
      FutureOr<bool> canActivate(String path, ParallelRoute route) {
        return Modular.args.queryParams['token'] != null;
      }
    }
    // Usuario será direcionado para /unauthorized, caso ele não passe um token via query parameter
    // diferente de nulo.
    ```
 - Definindo a rota que será protegida pelo **RouteGuard**
   ``` 
   ModuleRoute("/auth", module: AuthModule(), guards: [
            AuthGuard(),
          ])
    ```
  
  - Definição da rota /unauthorized:
    ```
     ChildRoute('/unauthorized', child: (_, args) => UnauthorizedPage())
    ```
Caso sua rota necessite de mais **RouteGuard** Basta defini-lo e adicionar no parâmetro **guards**

## RouterOutlet
Esse **Wiget** nos permite implementar Widgets como **BottomNavigationBar** de maneira simples. E o melhor de tudo, com rotas. Para utilizar ele você deve configurar a rota que retornará o **Widget** com **RouterOutlet**  e quais serão as rotas filhas que estarão dentro de **RouterOutlet**:


Em **HomeModule** temos esse exemplo:

- Configuração no Módulo:

```
 ChildRoute(
     "/",
      child: (_, args) => HomePage(), // Rota que retorna um Widget Com RouterOutlet.
      children: [
        ModuleRoute(
          "/news",
          module: NewsModule(),
        ),
        
        ModuleRoute(
          "/search",
          module: SearchModule(),
        ),
        ModuleRoute(
          "/config",
          module: ConfigModule(),
        ),
        ModuleRoute("/auth", module: AuthModule(), guards: [
          AuthGuard(),
        ]),
        ChildRoute('/unauthorized', child: (_, args) => UnauthorizedPage())
      ],
    )
 ```
 - Configuração do **RouterOutlet**, não é necessário implementar **NavigationRail** para que **RouterOutlet** funcione. Mas sem o uso de um **Widget** semelhante, não tem necessidade de utilizar   **RouterOutlet**.
 
 ```
 class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRailHome(),
          Expanded(child: RouterOutlet()),
        ],
      ),
    );
  }
}
```

- Configuração de **NavigationRailHome**:
```
class NavigationRailHome extends StatefulWidget {
  const NavigationRailHome({Key? key}) : super(key: key);

  @override
  State<NavigationRailHome> createState() => _NavigationRailHomeState();
}

class _NavigationRailHomeState extends State<NavigationRailHome> {
  final routes = ["/news/", "/search/", "/config/", "/auth/"];

  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    updateIndex();
    SchedulerBinding.instance?.addPersistentFrameCallback((timeStamp) {
      Modular.to.addListener(() {
        // Toda vez que auterar a rota é necessário atualizar o index do NavigationRail, para o index selecionado.
        if (mounted) setState(() => updateIndex()); 
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        Modular.to.navigate(routes[index]);
      },
      backgroundColor: Colors.green.withOpacity(.1),
      labelType: NavigationRailLabelType.selected,
      unselectedIconTheme: IconThemeData(color: Colors.grey.shade900),
      minWidth: 20,
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.newspaper_outlined),
          selectedIcon: Icon(Icons.newspaper),
          label: Text('News'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
          label: Text('Pesquisa'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: Text('Configuração'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.security),
          selectedIcon: Icon(Icons.settings),
          label: Text('Rota Autorizada'),
        ),
      ],
    );
  }

  updateIndex() {
    final path = Modular.args.uri.path;
    if (path.contains('unauthorized')) _selectedIndex = 3;

    for (int i = 0; i < routes.length; i++) {
      if (path.contains(routes[i])) _selectedIndex = i;
    }
  }
}
```
Note que de fato estamos navegando pelas rotas do App. E a cada navegação atualizamos o **\_selectedIndex** para mostrar a opção selecionada corretamente. Dessa maneira podemos navegar tanto direto via URL quanto interagindo com o **NavigationRail**.

# Conclusão

Nessa demo simples podemos aprender recursos que abrangem diversos casos de uso frequentes na **Web**. No momento a injeção de dependência não foi explorada, mas caso tenha ficado curioso de uma olhadinha na documentção em [**Flutter Modular**](https://modular.flutterando.com.br/docs/flutter_modular/dependency-injection).
   
 
 



    
