# Use official Tomcat image
FROM tomcat:9.0

# Set working directory inside Tomcat
WORKDIR /usr/local/tomcat/webapps/ROOT/

# Copy all files to Tomcat
COPY . .

# Disable shutdown port in server.xml
RUN sed -i 's/port="8005"/port="-1"/' /usr/local/tomcat/conf/server.xml

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
