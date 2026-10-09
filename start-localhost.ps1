$ErrorActionPreference = 'Stop'
$port = 8000
$pagePath = Join-Path $PSScriptRoot 'usta-kilavuz-kubik.html'
$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $port)

if (-not (Test-Path -LiteralPath $pagePath)) {
    throw "HTML file not found: $pagePath"
}

$listener.Start()
Write-Host "Usta Kilavuz is running at http://localhost:$port/"
Write-Host 'Press Ctrl+C to stop the server.'

try {
    while ($true) {
        $client = $listener.AcceptTcpClient()
        try {
            $stream = $client.GetStream()
            $reader = [System.IO.StreamReader]::new($stream, [System.Text.Encoding]::ASCII, $false, 1024, $true)
            $requestLine = $reader.ReadLine()
            while ($null -ne ($headerLine = $reader.ReadLine()) -and $headerLine.Length -gt 0) { }

            if ($requestLine -match '^GET /(?:usta-kilavuz-kubik\.html)?(?:\?.*)? HTTP/1\.[01]$') {
                $body = [System.IO.File]::ReadAllBytes($pagePath)
                $status = '200 OK'
                $contentType = 'text/html; charset=utf-8'
            }
            else {
                $body = [System.Text.Encoding]::UTF8.GetBytes('Not Found')
                $status = '404 Not Found'
                $contentType = 'text/plain; charset=utf-8'
            }

            $headers = "HTTP/1.1 $status`r`nContent-Type: $contentType`r`nContent-Length: $($body.Length)`r`nConnection: close`r`n`r`n"
            $headerBytes = [System.Text.Encoding]::ASCII.GetBytes($headers)
            $stream.Write($headerBytes, 0, $headerBytes.Length)
            $stream.Write($body, 0, $body.Length)
        }
        finally {
            $client.Dispose()
        }
    }
}
finally {
    $listener.Stop()
}