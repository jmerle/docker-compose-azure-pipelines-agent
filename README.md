# Docker Compose Azure Pipelines Agent

A Docker Compose configuration to run a self-hosted [Azure Pipelines Agent](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops) including some languages and tools that I use frequently in my pipelines.

## Usage

1. Clone this repository.
2. Copy `.env.example` to `.env` and modify the variables.
3. Run `docker-compose up -d`.
4. After the agent shows up in the pool, click on the agent, go to Capabilities and add a user-defined capability with `java` as name and an empty value.
