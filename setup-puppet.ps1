# Stop if things go wrong, so we can fix state
$ErrorActionPreference = 'STOP'

# Install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# make installs easier
choco feature enable -n allowGlobalConfirmation

# Install a more complete Python 3 (add to path, register extensions, etc)
# This will byte compile the standard library and include debug symbols
choco install python3 -ia "CompileAll=1 Include_debug=1 Include_symbols=1"
choco install ruby --version=2.6.5.1
refreshenv

# Install openssh with the ssh-server functionality on
choco install openssh -params '"/SSHServerFeature"'
refreshenv

# Set sshd and ssh-agent to start automatically, and start ssh-agent for puppet
Set-Service sshd -StartupType Automatic
Set-Service ssh-agent -StartupType Automatic
Start-Service ssh-agent

choco install gpg4win
refreshenv
# Get my public key
gpg --keyserver hkps://keys.openpgp.org --recv 6A812295D9BF330E5E393B182D8FF4BE4BD6E988

mkdir $env:LOCALAPPDATA\personal-puppet
