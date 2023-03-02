import UIKit

class ProblemTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ProblemTableViewCell"
    
    var nameLabel = UILabel()
    var dateLabel = UILabel()
    var problemImageView = UIImageView()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Configurar a célula
        accessoryType = .disclosureIndicator
        
        // Configurar as subviews
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        problemImageView.contentMode = .scaleAspectFit
        
        // Adicionar as subviews à contentView
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(problemImageView)
        
        // Configurar as restrições de layout
        problemImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            problemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            problemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            problemImageView.widthAnchor.constraint(equalToConstant: 60),
            problemImageView.heightAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: problemImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: problemImageView.trailingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with problem: Problem) {
        nameLabel.text = problem.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateLabel.text = dateFormatter.string(from: problem.date)
        
        if let image = problem.photo {
            problemImageView.image = image
        } else {
            problemImageView.image = UIImage(named: "placeholder_image")
        }
    }
    
}
