#!/usr/bin/env bash
# Install pyenv
curl https://pyenv.run | bash

# Add pyenv to the bash profile
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> .activate-pyenv
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> .activate-pyenv
echo 'eval "$(pyenv init -)"' >> .activate-pyenv

# Add pyenv to the bash profile
cat .activate-pyenv >> .bashrc

# Apply changes to the current session
. .activate-pyenv

# Install Python 3.10.6 using pyenv
pyenv install 3.10.14

# Set Python 3.10.6 as the global default
pyenv global 3.10.14

# Verify installation
python --version