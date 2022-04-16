package configs

type PostgresConfig struct {
	User     string
	Password string
	DBName   string
	Port     string
}

func NewPostgresConfig() *PostgresConfig {
	return &PostgresConfig{
		User:     "docker",
		Password: "docker",
		DBName:   "docker",
		Port:     "5432",
	}
}
