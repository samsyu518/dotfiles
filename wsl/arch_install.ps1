# Define the URLs and local file paths
$wslUrl = "https://gitlab.archlinux.org/api/v4/projects/85684/packages/generic/image/2025.03.04.121374/archlinux-2025.03.04.121374.wsl"
$sha256FilePath = "$PWD\archlinux-2025.03.04.121374.wsl.SHA256"
$localWslPath = "$PWD\archlinux-2025.03.04.121374.wsl"

if (Test-Path -Path $localWslPath) {
    Write-Output "The .wsl file already exists. Skipping download."
} else {
    # Use aria2c to download the .wsl file
    $aria2Command = "aria2c.exe --max-connection-per-server=16 --split=16 --dir=$PWD --out=archlinux-2025.03.04.121374.wsl $wslUrl"
    Write-Output "Downloading with aria2c..."
    Invoke-Expression $aria2Command
    Write-Output "Download completed."
}

# Generate the SHA256 hash of the .wsl file
$fileHash = (Get-FileHash -Path $localWslPath -Algorithm SHA256).Hash

# Read the checksum from the .SHA256 file and extract only the hash
$expectedChecksum = (Get-Content -Path $sha256FilePath).Split(" ")[0].Trim()

# Compare the checksum
if ($fileHash -eq $expectedChecksum) {
    Write-Output "The checksum matches. The file is valid."
    $InstanceName = Read-Host -Prompt 'Input Arch Instance name'
    $installCommand = "wsl --install --from-file=$PWD\archlinux-2025.03.04.121374.wsl --location=$PWD --name=$InstanceName"
    Invoke-Expression $installCommand
    echo "Arch Instance: $InstanceName"
} else {
    Write-Output "The checksum does not match. The file may be corrupted."
}

