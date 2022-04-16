package main

import (
	"clever/configs"
	"fmt"
	"github.com/gorilla/mux"
	"github.com/jackc/pgx"
	"log"
	"net/http"
	"os"
)

func main() {
	router := mux.NewRouter()

	logger := log.New(os.Stderr, "ERROR\t", log.Ldate|log.Ltime|log.Lshortfile)

	dbConfig := configs.NewPostgresConfig()

	connStr := fmt.Sprintf("user=%s password=%s dbname=%s sslmode=disable port=%s",
		dbConfig.User,
		dbConfig.Password,
		dbConfig.DBName,
		dbConfig.Port)

	pgxConn, err := pgx.ParseConnectionString(connStr)
	if err != nil {
		logger.Fatalf(err.Error())
	}
	pgxConn.PreferSimpleProtocol = true

	connectorConfig := pgx.ConnPoolConfig{
		ConnConfig:     pgxConn,
		MaxConnections: 100,
		AfterConnect:   nil,
		AcquireTimeout: 0,
	}
	
	_, err = pgx.NewConnPool(connectorConfig)
	if err != nil {
		logger.Fatalf(err.Error())
	}

	// TODO: repos/usecases/handlers

	fmt.Println("server start on :8080")
	if err := http.ListenAndServe(":8080", router); err != nil {
		logger.Fatalf("error of starting server")
	}
}
