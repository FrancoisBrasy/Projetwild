# Création de l'unité d'organisation BillU
$MonDomaine="BillU"
New-ADOrganizationalUnit -Name "BillU" -Path "DC=$MonDomaine,DC=lan"

# Création des sous-unités d'organisation Machines, Utilisateurs et Serveurs sous BillU
$UO_Name = "Machines", "Utilisateurs", "Serveurs"

foreach($UO in $UO_Name){
    try {
New-ADOrganizationalUnit -Name "$UO" -Path "DC=$MonDomaine,DC=lan" -ProtectedFromAccidentalDeletion 0
Write-Host "UO est créé : $($UO)" -ForegroundColor white -BackgroundColor green
}
catch {Write-Host "Une erreur est survenue : $($UO)" -ForegroundColor white -BackgroundColor red}}



# Ajout des groupes aux sous-unités Machines et Utilisateurs
$ouMachines = Get-ADOrganizationalUnit -Filter {Name -eq "Machines"}
$ouUtilisateurs = Get-ADOrganizationalUnit -Filter {Name -eq "Utilisateurs"}

$groupes_machine = "Logistique_machine","RH_machine","International_machine","DirectionGenerale_machine","Marketing_machine","Comptabilite_machine","Finance_machine","DirectionCommerciale_machine","Communication_machine","DeveloppementLogiciel_machine","IT_machine","Juridique_machine","Externe_machine"
$groupes_user = "Logistique_user","RH_user","International_user","DirectionGenerale_user","Marketing_user","Comptabilite_user","Finance_user","DirectionCommerciale_user","Communication_user","DeveloppementLogiciel_user","IT_user","Juridique_user","Externe_user"

foreach ($groupe_ma in $groupes_machine) {
    try {
        New-ADGroup -Name $groupe_ma -GroupCategory Security -GroupScope Global -Path $ouMachines.DistinguishedName
        Write-Host "le groupe est créé : $($groupe_ma)" -ForegroundColor white -BackgroundColor green
    } 
    catch {Write-Host "Une erreur est survenue : $($groupe_ma)" -ForegroundColor white -BackgroundColor red}}

foreach ($groupe_us in $groupes_user) {
    try {
        New-ADGroup -Name $groupe_us -GroupCategory Security -GroupScope Global -Path $ouUtilisateurs.DistinguishedName
        Write-Host "le groupe est créé : $($groupe_us)" -ForegroundColor white -BackgroundColor green} 
        catch {
    Write-Host "Une erreur est survenue : $($groupe_us)" -ForegroundColor white -BackgroundColor red
    }}