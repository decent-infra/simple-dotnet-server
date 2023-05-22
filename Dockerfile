# Base image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set the working directory
WORKDIR /app

# Copy the source code to the container
COPY . .

# Restore dependencies
RUN dotnet restore

# Build the app
RUN dotnet build -c Release --no-restore

# Publish the app
RUN dotnet publish -c Release -o out

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet AS runtime



# ENV ASPNETCORE_URLS=http://+:5000
# Set the working directory
WORKDIR /app

# Copy the published app from the build image to the runtime image
COPY --from=build /app/out .

RUN echo "Starting the app.."

# Set the entry point for the container
ENTRYPOINT ["dotnet", "SimpleServer.dll"]

# docker run -d -p 80:80 --name medapp medapp