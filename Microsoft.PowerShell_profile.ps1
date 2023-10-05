Import-Module posh-git
Import-Module oh-my-posh
Import-Module Terminal-Icons
Set-PoshPrompt -Theme paradox
Set-PSReadlineOption -Colors @{Parameter = "Green"}
Set-PSReadlineOption -Colors @{Operator = "Green"}

Set-Location C:\Users\ryan.mccartney

#-----------------------
#git aliases
Function GitStashList {git stash list}
Set-Alias -Name gsl -Value GitStashList
Function gaa {git add --all}
Function gclean
{
    git reset
    git checkout .
    git clean -f
}
Function gr {git reset}
Function gai {git add -i}
Function gs {git status}
#-----------------------
# apply one or more stashes in one go
Function gsa([string[]]$stashindexes)
{
    foreach($index in $stashindexes)
    {
        git stash apply "stash@{$index}"
    }
}
Function prmake {gh pr create -B dev}
Function prstaging {gh pr create -B staging}
Function ignition {npm i --legacy-peer-deps;npm start}
Function repo {gh repo view -w}
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
