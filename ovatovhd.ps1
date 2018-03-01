#Author Lewis McKee
#twitter @shotbylewism

#Convert OVA to VHD
#Virtualbox to Hyper-V

#Prerequisites: Oracle Virtual Box, 7zip, Windows

#you may need to change C:\ to your particular drives.



function ovaToVhd ($sourceOVA) {

    #7zip extract the vmdk file from the OVA
    set-location 'C:\Program Files\7-Zip\'

    ./7z.exe x $sourceOVA -oC:\output  #cannot pass the output directory as a variable, so have to specify it here.
    $outdir = 'C:\output' # can pass the output directory as a variable later, so have created as a variable.

    
    
    
    
    #Create the variables for output files

    $sourceOVAName = Get-ItemProperty $sourceOVA
    $sourceOVAName = $sourceOVAName.Name
    $sourceOVANameVMDK = $sourceOVAName -replace '.ova', '-disk001.vmdk'
    $sourceOVANameVHD = $sourceOVAName -replace '.ova', '-disk001.vhd'

    #convert the vmdk to vhd
    Set-Location 'C:\Program Files\Oracle\VirtualBox\'
    ./VBoxManage.exe clonehd --format vhd $outdir\$sourceOVANameVMDK $outdir\$sourceOVANameVHD
}

ovaToVhd -SourceOVA C:\VM\Window10.ova


