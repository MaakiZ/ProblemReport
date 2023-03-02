import UIKit

class ListProblemsViewController: UITableViewController {
    
    // MARK: - Properties
    
    var problems = [Problem]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configura a tabela
        tableView.register(ProblemTableViewCell.self, forCellReuseIdentifier: ProblemTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        
        // Configura a barra de navegação
        navigationItem.title = "Problemas"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        // Carrega os dados
        loadProblems()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return problems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProblemTableViewCell.reuseIdentifier, for: indexPath) as! ProblemTableViewCell
        
        // Configura a célula com os dados do problema correspondente
        let problem = problems[indexPath.row]
        cell.configure(with: problem)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let problem = problems[indexPath.row]
        let detailVC = ProblemDetailViewController(problem: problem)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove o problema da lista de problemas
            let problem = problems[indexPath.row]
            ProblemService.shared.deleteProblem(problem)
            problems.remove(at: indexPath.row)
            
            // Remove a célula correspondente da tabela
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapAdd() {
        let createVC = CreateProblemViewController()
        createVC.delegate = self
        let navController = UINavigationController(rootViewController: createVC)
        present(navController, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    private func loadProblems() {
        problems = ProblemService.shared.getProblems()
        tableView.reloadData()
    }
    
}

// MARK: - CreateProblemViewControllerDelegate

extension ListProblemsViewController: CreateProblemViewControllerDelegate {
    
    func didCreateProblem(_ problem: Problem) {
        // Adiciona o novo problema à lista de problemas
        problems.append(problem)
        
        // Atualiza a tabela
        let indexPath = IndexPath(row: problems.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        // Fecha a tela de criação de problema
        dismiss(animated: true, completion: nil)
    }
    
}
