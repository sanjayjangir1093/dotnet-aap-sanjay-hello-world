# Use the official ASP.NET runtime image as the base
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app

# Use the official .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
COPY . /src
WORKDIR /src

# List files for debugging
RUN ls

# Restore dependencies and build the application
RUN dotnet build "sanjay.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "sanjay.csproj" -c Release -o /app/publish

# Use the base image for the final stage
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Specify the command to run the application
ENTRYPOINT ["dotnet", "HelloSanjay.dll"]
