$logs = $args[0]

function Get-FileName($line)
{
    $index = $_.IndexOf("log:"); 
    return $_.Substring(0, $index) + "log" 
}

New-Item $logs\LogAnalysis -type directory -force

# UnobservedTask exceptions
gci -recurse $logs\*.log | select-string "unobserved" | group Filename | select Name | out-string -width 1000 > $logs\LogAnalysis\unobserved_exceptions.txt

# ObjectDisposed exceptions
gci -recurse $logs\*.log | select-string "disposed" | group Filename | select Name | out-string -width 1000 > $logs\LogAnalysis\ode_exceptions.txt

# Network errors exceptions
gci -recurse $logs\*.log | select-string "unexpected" | group Filename | select Name | out-string -width 1000 > $logs\LogAnalysis\unexpected.txt

# Connection Forcibly closed Errors
gci -recurse $logs\*.log | select-string "An existing connection was forcibly closed" | group Filename | select Name | out-string -width 1000 > $logs\LogAnalysis\connection_closed.txt