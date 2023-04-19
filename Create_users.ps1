$Header = 'Prenom','Nom','Société','Site','Service','fonction','Manager','email','Téléphone fixe','Téléphone portable','Nomadisme - Télétravail'
$CSVFile = "C:\Users\Administrator\Desktop\temp-aduser.csv"
$CSVData =  Import-CSV -Path $CSVFile -Delimiter "," -Encoding UTF8 -Header $Header | Where-Object { $_.PSObject.Properties.Value -ne '' } 
$compta = "CN=Comptabilite_user,OU=Utilisateurs,DC=BillU,DC=lan"
$logistique = "CN=Logistique_user,OU=Utilisateurs,DC=BillU,DC=lan"
$devlog = "CN=DeveloppementLogiciel_user,OU=Utilisateurs,DC=BillU,DC=lan"
$rh = "CN=RH_user,OU=Utilisateurs,DC=BillU,DC=lan"
$dg = "CN=DirectionGenerale_user,OU=Utilisateurs,DC=BillU,DC=lan"
$marketing = "CN=Marketing_user,OU=Utilisateurs,DC=BillU,DC=lan"
$commu = "CN=Communication_user,OU=Utilisateurs,DC=BillU,DC=lan"
$dc = "CN=DirectionCommerciale_user,OU=Utilisateurs,DC=BillU,DC=lan"
$it = "CN=IT_user,OU=Utilisateurs,DC=BillU,DC=lan"
$juri =  "CN=Juridique_user,OU=Utilisateurs,DC=BillU,DC=lan"
$finance = "CN=Finance_user,OU=Utilisateurs,DC=BillU,DC=lan"
$Presta = "CN=Externe_user,OU=Utilisateurs,DC=BillU,DC=lan"
$international= "CN=International_user,OU=Utilisateurs,DC=BillU,DC=lan"


Foreach($Utilisateur in $CSVDATA )
{   
$DomainName = 'BillU'
$Firstname  = [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($Utilisateur.Prenom.ToLower()))
$Lastname = [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($Utilisateur.Nom.ToLower()))
$Name = "$Firstname.$Lastname"
$SamAccountName = "$Firstname.$Lastname"
$UserPrincipalName = "$Firstname$Lastname@billu.lan"
$password = "billucomp@ny2Reset"
$UtilisateurSite = [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($Utilisateur.Site.ToLower()))
$UtilisateurService=[Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($Utilisateur.Service.ToLower()))





if ($UtilisateurService -eq "comptabilite")
{$Path = $compta}
elseif($UtilisateurService -eq "logistique")
{$Path = $logistique}
elseif($UtilisateurService -eq "developpement logiciel")
{$Path = $devlog}
elseif($UtilisateurService -eq "rh")
{$Path = $rh}
elseif($UtilisateurService -eq "direction generale")
{ $dg}
elseif($UtilisateurService -eq "marketing")
{$Path = $marketing}
elseif($UtilisateurService -eq "communication")
{$Path = $commu}
elseif($UtilisateurService -eq "direction commerciale")
{$Path = $dc}
elseif($UtilisateurService -eq "it")
{$Path = $it}
elseif($UtilisateurService -eq "juridique")
{$Path = $juri}
elseif($UtilisateurService -eq "finance")
{$Path = $finance}
elseif($UtilisateurService -eq "prestataire")
{$Path = $Presta}
elseif($UtilisateurService -eq "international")
{$Path = $international}
else{$Path = "OU=Utilisateurs,DC=BillU,DC=lan"}
try{

New-ADUser `
-SamAccountName $SamAccountName `
-UserPrincipalName "$UserPrincipalName" `
-Name "$Name" `
-GivenName $Firstname `
-Surname $Lastname `
-Enabled $True `
-ChangePasswordAtLogon $True `
-DisplayName "$Lastname, $Firstname" `
-AccountPassword (convertto-securestring $password -AsPlainText -Force)`
-Office $UtilisateurSite

Add-ADGroupMember -Identity "$path" -Members "$SamAccountName"
Write-Host "le compte est créé : $($SamAccountName)" -ForegroundColor white -BackgroundColor green}
catch{Write-Host "Une erreur est survenue : $($SamAccountName)" -ForegroundColor white -BackgroundColor red
}
}