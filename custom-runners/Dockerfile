FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y && useradd -m docker
RUN apt install -y --no-install-recommends curl jq build-essential libssl-dev libffi-dev libicu-dev
RUN apt install -y --no-install-recommends python3 python3-venv python3-dev python3-pip
    
ARG RUNNER_VERSION="2.320.0"

RUN mkdir /home/docker/actions-runner
WORKDIR /home/docker/actions-runner

RUN curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
RUN tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN chown -R docker ~docker && /home/docker/actions-runner/bin/installdependencies.sh

COPY start.sh start.sh
RUN chmod +x start.sh

USER docker
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

ENTRYPOINT ["./start.sh"]