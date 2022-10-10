(Get-AppXProvisionedPackage -Online | Where-Object DisplayNam -like "Microsoft.Messaging") -or (Get-AppxPackage "Microsoft.Messaging")
