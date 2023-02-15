kron occurrence addvlans in 2 recurring
 policy-list addvlans
!
kron occurrence reboot in 5 recurring
 policy-list reboot
!
kron occurrence deldat in 2 recurring
 policy-list deldat
!
kron policy-list addvlans
 cli tclsh flash:createvlans.tcl
!
kron policy-list deldat
 cli tclsh flash:deldat.tcl
!
kron policy-list reboot
 cli reload
!

tclsh
puts [open "flash:createvlans.tcl" w+] {
ios_config "vlan 24" "name Randon_Cxs_Corp" "exit"
ios_config "vlan 30" "name Implementos_Cxs_Teceiros" "exit"
ios_config "vlan 36" "name Randon_Cxs_IoT_Industrialsec" "exit"
ios_config "vlan 48" "name Randon_Cxs_Cameras" "exit"
ios_config "vlan 56" "name Randon_Cxs_Guest" "exit"
ios_config "vlan 60" "name Randon_Cxs_Mobile" "exit"
ios_config "vlan 64" "name Randon_Cxs_Ramais" "exit"
ios_config "vlan 68" "name Implementos_Cxs_TI_Computadores" "exit"
ios_config "vlan 70" "name Implementos_Cxs_TI_Infra_Computa" "exit"
ios_config "vlan 90" "name Randon_Cxs_IPs_Fixos" "exit"
ios_config "vlan 96" "name Randon_Cxs_Impressoras" "exit"
ios_config "vlan 100" "name Implementos_Cxs_Computadores100" "exit"
ios_config "vlan 108" "name Implementos_Cxs_IoT_Industrial" "exit"
ios_config "vlan 260" "name Randon_Cxs_ThirdParties" "exit"
ios_config "vlan 353" "name Randon_Cxs_Gerenciamento" "exit" "end"
}

tclsh
puts [open "flash:deldat.tcl" w+] {
ios_config  "do delete vlan.dat" "end"
}
