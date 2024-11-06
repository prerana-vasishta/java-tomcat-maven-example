# Stage 1: Build the app with Maven
FROM maven:3.8-openjdk-17 as build

WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the application using Maven (this will create the WAR file)
RUN mvn clean package

# Stage 2: Deploy the app with Tomcat
FROM tomcat:9-jdk17

# Expose Tomcat's default port
EXPOSE 80

# Start Tomcat
CMD ["catalina.sh", "run"]
