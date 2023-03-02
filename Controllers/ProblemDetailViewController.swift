import UIKit

class ProblemDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var problem: Problem?
    
    var nameLabel = UILabel()
    var locationLabel = UILabel()
    var descriptionLabel = UILabel()
    var problemImageView = UIImageView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Detalhes"
        
        // Configurar as subviews
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        
        locationLabel.font = UIFont.systemFont(ofSize: 16)
        locationLabel.numberOfLines = 0
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        
        problemImageView.contentMode = .scaleAspectFit
        problemImageView.clipsToBounds = true
        
        // Adicionar as subviews à view
        view.addSubview(nameLabel)
        view.addSubview(locationLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(problemImageView)
        
        // Configurar as restrições de layout
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        problemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            problemImageView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            problemImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            problemImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            problemImageView.heightAnchor.constraint(equalToConstant: 200),
            
            descriptionLabel.topAnchor.constraint(equalTo: problemImageView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        // Configurar os dados da view
        if let problem = problem {
            nameLabel.text = problem.name
            locationLabel.text = problem.location
            descriptionLabel.text = problem.problemDescription
            
            if let image = problem.photo {
                problemImageView.image = image
            } else {
                problemImageView.image = UIImage(named: "placeholder_image")
            }
        }
    }
    
}
