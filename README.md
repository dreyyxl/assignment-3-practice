# Assignment 3 — DevOps CLI with Docker and CI/CD

## Project Overview

This project is a Bash-based command-line application that provides system information, hostname resolution, and TCP connectivity checks.

The project demonstrates Bash scripting, automated testing, Docker containerization, Docker Compose, and GitHub Actions CI.

## Project Structure

```text
assignment-3-practice/
├── app/
│   └── app.sh
├── scripts/
│   ├── lint.sh
│   └── build.sh
├── tests/
│   └── test.sh
├── .github/
│   └── workflows/
│       └── ci.yml
├── Dockerfile
├── compose.yaml
├── .dockerignore
├── README.md
└── grade.sh
```

## Application Commands

Display help:

```bash
./app/app.sh help
```

Display system information:

```bash
./app/app.sh system-info
```

Resolve a hostname:

```bash
./app/app.sh check-host google.com
```

Check TCP connectivity:

```bash
./app/app.sh check-port google.com 443
```

## Exit Codes

- `0`: Successful execution
- `1`: Operation failed
- `2`: Invalid command or arguments

## Linting and Testing

Run lint checks:

```bash
./scripts/lint.sh
```

Run eight automated tests:

```bash
./tests/test.sh
```

## Docker

Build the image:

```bash
docker build -t diagnostic-app .
```

Run the application:

```bash
docker run --rm diagnostic-app help
```

Run automated Docker build and smoke tests:

```bash
./scripts/build.sh
```

## Docker Compose

Validate the configuration:

```bash
docker compose config
```

Run the application:

```bash
docker compose run --rm diagnostic-app system-info
```

## CI/CD Pipeline

GitHub Actions is configured to run automatically on pushes and pull requests.

The pipeline contains three dependent jobs:

1. **Validate:** Check required files and Bash syntax.
2. **Test:** Execute eight automated Bash tests.
3. **Docker:** Build the Docker image and run smoke tests.

Job execution order:

Validate → Test → Docker

The pipeline stops progressing if a required job fails.

## Technologies

- Bash
- Linux
- Git and GitHub
- Docker
- Docker Compose
- GitHub Actions