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

 ```class AppModule extends Module {
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

##






