# Use an official Maven image to build the app
FROM maven:3.8-openjdk-17 as build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code to the container
COPY pom.xml .
COPY src ./src

# Build the application using Maven (package will compile and package the WAR file)
RUN mvn clean package

# Second stage for the Tomcat server
FROM tomcat:9-jdk17

# Copy the built WAR file into the Tomcat webapps directory
COPY --from=build /app/target/java-tomcat-maven-example.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat's default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
