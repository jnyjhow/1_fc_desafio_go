FROM golang:1-alpine as build_golang

#definindo diretorio e copiando arquivos local para o container
WORKDIR /go/src/app
COPY . .

#rodando script apenas para teste
RUN go run main.go
#gerando build para ser utilizado na otimizacao de mb
RUN go build main.go

FROM scratch

#definindo diretorio
WORKDIR /go/src/app

#otimizacao multistage building
COPY --from=build_golang /go/src/app/main ./main

EXPOSE 8000
CMD ["./main"]
