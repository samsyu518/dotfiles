$filename = "Arch.zip"
$tarUrl = "https://github.com/yuk7/ArchWSL/releases/download/22.10.16.0/$filename"
# Download the files
Invoke-WebRequest -Uri $tarUrl -OutFile ./$filename

Expand-Archive ./$filename -DestinationPath ./
$InstanceName = Read-Host -Prompt 'Input Arch Instance name'
echo "Arch Instance: $InstanceName"
mv "Arch.exe" "$InstanceName.exe"
# Invoke-Expression ./$InstanceName.exe

