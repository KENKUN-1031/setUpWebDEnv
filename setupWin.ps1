# PowerShell Script

# Enable error handling
$ErrorActionPreference = "Stop"

# Function to execute on error
function ErrorHandler {
  Write-Host "An error has occurred at step: $CurrentStep" -ForegroundColor Red
  Write-Host "Error message: $($_.Exception.Message)" -ForegroundColor Red
  exit 1
}

# Set up trap (call ErrorHandler on error)
trap {
  ErrorHandler
  continue
}

# Variable to track the current step
$CurrentStep = ""

function AllInstall {
  # Track step
  $CurrentStep = "Checking if Chocolatey is installed"

  # Check if Chocolatey is installed
  Write-Host "Step: $CurrentStep"
  if (Get-Command choco -ErrorAction SilentlyContinue) {
    Write-Host "Chocolatey is already installed."
  }
  else {
    Write-Host "Chocolatey is not installed. Starting installation..."
    $CurrentStep = "Installing Chocolatey"
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  }

  # Track step
  $CurrentStep = "Checking if Visual Studio Code is installed"

  # Check if Visual Studio Code is installed
  Write-Host "Step: $CurrentStep"
  if (choco list --local-only | Select-String -Pattern "vscode") {
    Write-Host "Visual Studio Code is already installed."
  }
  else {
    Write-Host "Installing Visual Studio Code..."
    $CurrentStep = "Installing Visual Studio Code"
    choco install vscode -y
  }

  # Track step
  $CurrentStep = "Installing Visual Studio Code extensions"

  # Installing Visual Studio Code extensions
  Write-Host "Step: $CurrentStep"

  # Track step
  $CurrentStep = "Checking and installing Prettier extension"

  # Check and install Prettier extension
  Write-Host "Step: $CurrentStep"
  $prettierExtension = & code --list-extensions | Select-String "esbenp.prettier-vscode"
  if ($prettierExtension) {
    Write-Host "Prettier extension is already installed."
  }
  else {
    Write-Host "Installing Prettier extension..."
    $CurrentStep = "Installing Prettier extension"
    & code --install-extension esbenp.prettier-vscode
  }

  # Track step
  $CurrentStep = "Checking and installing Live Server extension"

  # Check and install Live Server extension
  Write-Host "Step: $CurrentStep"
  $liveServerExtension = & code --list-extensions | Select-String "ritwickdey.liveserver"
  if ($liveServerExtension) {
    Write-Host "Live Server extension is already installed."
  }
  else {
    Write-Host "Installing Live Server extension..."
    $CurrentStep = "Installing Live Server extension"
    & code --install-extension ritwickdey.liveserver
  }
}

# Execute the function
AllInstall

# Success message
Write-Host "All processes have been completed!" -ForegroundColor Green
