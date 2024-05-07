postgres:
	sudo docker run --name postgres12-new -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=password -d postgres:12-alpine

createdb:
	sudo docker exec -it postgres12-new createdb --username=root --owner=root simple_bank

dropdb:
	sudo docker exec -it postgres12-new dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:password@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:password@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	sudo go test -v -cover ./...

.PHONY: createdb dropdb postgres migrateup migratedown sqlc test