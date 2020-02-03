	$start = get-date

        $jsonfile = ".\data.vcenter.config.json"
        $jsonconfig = get-content -path $jsonfile
        $config = $jsonconfig | convertfrom-json
        $viservers = $config.vcenters

		disconnect-viserver * -force -confirm:$false
        foreach($viserver in $viservers){

            $vicentercredsfile = "credfile-$viserver.xml"
        
            write-host "Trying to log into $viserver. Using $vicentercredsfile."
        
            if($(test-path $vicentercredsfile) -eq $false)
            {
                $vicentercreds = get-credential -Message "Enter vicenter login credentials for $viserver"
                $vicentercreds | export-clixml $vicentercredsfile -Force
            }
        
            $vicentercreds = import-clixml $vicentercredsfile
        
            get-viserver -server $viserver -credential $vicentercreds
        
        }
	
	$q = 0
	$report = @()
	foreach($vcenter in $defaultviservers){
		write-host "Processing $vcenter"
		$vms = $null
		#$vms = get-vm -server $vcenter
		$vms = get-view -viewtype virtualmachine -server $vcenter
		$i = 0
    }
