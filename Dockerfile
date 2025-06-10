# Estágio 1: Build da aplicação com Maven e Java 21
# Usamos uma imagem oficial do Maven que já tem o Java que você precisa
FROM maven:3.9.6-eclipse-temurin-21 AS build

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia todo o seu projeto para dentro do container
COPY . .

# Executa o comando do Maven para gerar o arquivo .war
# Isso vai criar o arquivo em /app/target/alugafacil.war
RUN mvn clean package

# Estágio 2: Execução da aplicação com Tomcat
# Usamos uma imagem oficial do Tomcat que já tem o Java pronto
FROM tomcat:10.1-jdk21-temurin

# Remove o conteúdo padrão da pasta de aplicações do Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia o arquivo .war que foi gerado no estágio anterior
# para a pasta de aplicações do Tomcat.
# Renomear para ROOT.war faz sua aplicação rodar na URL principal (ex: seudominio.com/)
# em vez de (seudominio.com/alugafacil)
COPY --from=build /app/target/alugafacil.war /usr/local/tomcat/webapps/ROOT.war

# Expõe a porta padrão que o Tomcat usa
EXPOSE 8080

# Comando final para iniciar o servidor Tomcat quando o container for executado
CMD ["catalina.sh", "run"]
