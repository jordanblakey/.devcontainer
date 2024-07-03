FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

WORKDIR /workspaces/projects/

# Install software
RUN apk add nodejs npm

# Create virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Set aliases
RUN echo 'alias vi="vim"' >> /home/vscode/.bashrc
RUN echo 'alias venv="source /opt/venv/bin/activate"' >> /home/vscode/.bashrc


# Modify bash prompt
RUN cat ~/.bashrc | sed -E "s/(;31m|;36m)/;35m/g" > ~/.bashrc
