Import-Module posh-git

function prompt {
    Write-Host($pwd) -nonewline
    Write-VcsStatus
    return "> "
}
