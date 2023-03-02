# Project Structure
```
ProblemReport
├─ Assets.xcassets
│  └─ Images.xcassets
│     └─ Placeholder.imageset
│        └─ placeholder_image.png
├─ Controllers
│  ├─ EditProblemViewController.swift
│  ├─ ListProblemsViewController.swift
│  └─ ProblemDetailViewController.swift
├─ Models
│  └─ Problem.swift
├─ README.md
├─ Supporting Files
│  ├─ AppDelegate.swift
│  └─ Main.storyboard
└─ Views
   └─ ProblemTableViewCell.swift

```


# Structre Description
- AppDelegate.swift: o arquivo do delegado do aplicativo que gerencia o ciclo de vida do aplicativo, incluindo o carregamento do aplicativo, a manipulação de eventos e a limpeza de recursos.
- Assets.xcassets: um arquivo de catálogo de ativos que contém as imagens usadas no aplicativo.
- Supporting Files/Main.storyboard: o arquivo de storyboard principal que define a interface do usuário do aplicativo.
- Controllers: um diretório que contém todos os controladores de visualização (view controllers) do aplicativo.
    - Controllers/EditProblemViewController.swift: um controlador de visualização que permite editar ou criar um problema, adicionando informações sobre o nome, a localização, a descrição e uma foto do problema.
    - Controllers/ProblemsListViewController.swift: um controlador de visualização que exibe uma lista de problemas existentes, permitindo a exclusão de problemas e a navegação para a tela de edição de problemas.
    - Controllers/ProblemDetailViewController.swifté:  um controlador que herda de UIViewController e é responsável por mostrar os detalhes de um problema específico. Essa tela exibe informações como nome do problema, localização, descrição e uma foto (se houver).
- CoreData: um diretório que contém os arquivos necessários para o uso do Core Data no aplicativo.
- Models: um diretório que contém todos os modelos de dados do aplicativo.
    - Models/Problem.swift: um modelo de dados que representa um problema, contendo informações sobre o nome, a localização, a descrição e uma foto do problema.
- Supporting Files: um diretório que contém todos os arquivos de suporte do aplicativo.
    - Supporting Files/AppDelegate.swift: o arquivo do delegado do aplicativo que gerencia o ciclo de vida do aplicativo, incluindo o carregamento do aplicativo, a manipulação de eventos e a limpeza de recursos.
- Views: um diretório que contém as visualizações personalizadas usadas no aplicativo.
    - Views/ProblemTableViewCell.swift: uma visualização personalizada usada para exibir informações sobre um problema em uma célula de tabela na lista de problemas

# Student info
- Name: Maklei Alves Rodrigues Filho
- Course: Desenvolvimento Mobile
- Discipline: Desenvolvimento Nativo para iOS
