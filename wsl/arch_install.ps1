param(
    [string]$Version = "2025.04.14.124939"
)

# Construct paths and URLs dynamically
$FileName = "archlinux-$Version.wsl"
$ShaFile = "$FileName.SHA256"
$WslUrl = "https://gitlab.archlinux.org/api/v4/projects/85684/packages/generic/image/$Version/$FileName"
$Sha256FilePath = "$PWD\$ShaFile"
$LocalWslPath = "$PWD\$FileName"

if (Test-Path -Path $LocalWslPath) {
    Write-Output "The $FileName already exists. Skipping download."
} else {
    $aria2Command = "aria2c.exe --max-connection-per-server=16 --split=16 --dir=$PWD --out=$FileName $WslUrl"
    Write-Output "Downloading $FileName with aria2c..."
    Invoke-Expression $aria2Command
    Write-Output "Download completed."
}

# Generate SHA256 hash
$fileHash = (Get-FileHash -Path $LocalWslPath -Algorithm SHA256).Hash

# Read expected checksum
$expectedChecksum = (Get-Content -Path $Sha256FilePath).Split(" ")[0].Trim()

# Compare checksum
if ($fileHash -eq $expectedChecksum) {
    Write-Output "The checksum matches. The file is valid."
    $InstanceName = Read-Host -Prompt 'Input Arch Instance name'
    $installCommand = "wsl --install --from-file=$LocalWslPath --location=$PWD --name=$InstanceName"
    Invoke-Expression $installCommand
    Write-Output "Arch Instance: $InstanceName"
} else {
    Write-Output "The checksum does not match. The file may be corrupted."
}
