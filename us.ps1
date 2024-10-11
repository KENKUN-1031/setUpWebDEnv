# PowerShell Script

# Enable error handling
$ErrorActionPreference = "Stop"

# Function to execute on error
function ErrorHandler {
    Write-Host "An error has occurred. Terminating process." -ForegroundColor Red
    exit 1
}

# Set up trap (call ErrorHandler on error)
trap {
    ErrorHandler
    continue
}

function AllInstall {
    # Check if Chocolatey is installed
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "Chocolatey is already installed."
    }
    else {
        Write-Host "Chocolatey is not installed. Starting installation..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }

    # Check if Visual Studio Code is installed
    if (choco list --local-only | Select-String -Pattern "vscode") {
        Write-Host "Visual Studio Code is already installed."
    }
    else {
        Write-Host "Installing Visual Studio Code..."
        choco install vscode -y
    }

    # Installing Visual Studio Code extensions
    Write-Host "Installing Visual Studio Code extensions..."

    # Check and install Prettier extension
    $prettierExtension = & code --list-extensions | Select-String "esbenp.prettier-vscode"
    if ($prettierExtension) {
        Write-Host "Prettier extension is already installed."
    }
    else {
        Write-Host "Installing Prettier extension..."
        & code --install-extension esbenp.prettier-vscode
    }

    # Check and install Live Server extension
    $liveServerExtension = & code --list-extensions | Select-String "ritwickdey.liveserver"
    if ($liveServerExtension) {
        Write-Host "Live Server extension is already installed."
    }
    else {
        Write-Host "Installing Live Server extension..."
        & code --install-extension ritwickdey.liveserver
    }
}

# Execute the function
AllInstall

# Success message
Write-Host "All processes have been completed!" -ForegroundColor Green
