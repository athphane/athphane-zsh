# Python Aliases  
alias python-venv="source venv/bin/activate"

# Upgrade all python packages in the venv
alias python-upgrade="pip freeze --local | cut -d '=' -f 1 | xargs -n1 pip install -U"