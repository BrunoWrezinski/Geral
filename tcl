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
ios_config "vlan 24" "name Cxs_Corp" "exit"
ios_config "vlan 30" "name Cxs_Teceiros" "exit"
ios_config "vlan 36" "name Cxs_IoT_Industrialsec" "exit"
ios_config "vlan 48" "name Cxs_Cameras" "exit"
ios_config "vlan 56" "name Cxs_Guest" "exit"
ios_config "vlan 60" "name Cxs_Mobile" "exit"
ios_config "vlan 64" "name Cxs_Ramais" "exit"
ios_config "vlan 68" "name Cxs_TI_Computadores" "exit"
ios_config "vlan 70" "name _Cxs_TI_Infra_Pc" "exit"
ios_config "vlan 90" "name Cxs_IPs_Fixos" "exit"
ios_config "vlan 96" "name Cxs_Impressoras" "exit"
ios_config "vlan 100" "name Cxs_Computadores100" "exit"
ios_config "vlan 108" "name Cxs_IoT_Industrial" "exit"
ios_config "vlan 260" "name Cxs_ThirdParties" "exit"
ios_config "vlan 353" "name Cxs_Gerenciamento" "exit" "end"
}

tclsh
puts [open "flash:deldat.tcl" w+] {
ios_config  "do delete vlan.dat" "end"
}
