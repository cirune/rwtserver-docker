# Rimworld Together Server - Docker
Very much WiP Rimworld Together Server Docker suite

## Description
Dockerised instance of the Nova-Atomic's Rimworld Together mod server.
Auto set-up, uses the latest version, update script.

## Installation
- Install Docker and Docker-Compose on your server.
- Start the container
- Add mods to your liking.

### Docker run

### Docker compose
- Download the docker-compose file from this repository into your Rimworld Together work directory.
- Start it with : docker compose up -d
#### No Reverse Proxy

#### with Treafik


## Usage
Start the server with : docker compose up -d
Terminal access to the server : docker attach rwtserver

All server files are stored into the ./data folder where the compose file was started.


## Roadmap
- Finish core functions (cleanup and catch when server exit for function access)
- Add DLC choice options during set-up
- Add function to install mods?
- Use alpine linux for slimmer image? gcompat is required but throws error when interacting with dotnet.
- More on par with docker standards?

## Authors and acknowledgment
Thanks to Nova-Atomic and the Rimworld community for the mod and hard work. Thanks to Ludeon Studios for Rimworld..

## License
Copy and use freely. No use for comercial applications.
