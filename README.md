# Utilisations

## Dependences : 

`brew install gum`

`brew install expect`

## Configuration : 
- Copiez le .env.template et renomez le .env
- Modifier le .env avec vos parametrages

- Importez et modifiez votre `configuration.php`
```php
    
        public $dbtype = 'mysqli';
	public $host = 'db';
	public $user = 'joomla';
	public $password = 'examplepass';
	public $db = 'joomla_db';
	public $dbprefix = 'g7wnk_';
```

## Commandes :
| Commande      | Utilité                                             |
|---------------|-----------------------------------------------------|
| `./setup.sh`  | Lance l'installation d'un environement de dev       |
| `./import.sh` | Lance le gestionnaire d'import de données           |
| `./sync.sh`   | Lance le gestionnaire de synchronisation de projets |
