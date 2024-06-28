FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

WORKDIR /workspaces/projects/

# Create virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN echo 'alias venv="source /opt/venv/bin/activate"' >> /home/vscode/.bashrc

# Set terminal prompt
RUN echo 'branch() { git branch --show-current 2>/dev/null; }' >> /home/vscode/.bashrc
RUN echo 'branchif() { if [ $(branch) ]; then echo \($(branch)\); fi; }' >> /home/vscode/.bashrc
RUN echo 'export PS1="\e[0;32m\u@\$(cat /etc/os-release | grep -e ^ID= | cut -f 2 -d =)[\e[0;34m\w\e[0;32m]\e[0;35m\$(branchif)$ \e[0m"' >> /home/vscode/.bashrc
