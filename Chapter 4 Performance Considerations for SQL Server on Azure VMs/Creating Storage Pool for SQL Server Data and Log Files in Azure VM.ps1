# The original script for Provisioning of SQL Server Azure VM was created by Sourabh Agrawal and Amit Banerjee
# The script is modified by Parikshit Savjani to suit the readers of the book SQL on Azure Succintly

$PoolCount = Get-PhysicalDisk -CanPool $True
$PhysicalDisks = Get-PhysicalDisk | Where-Object {$_.FriendlyName -like "*2" -or $_.FriendlyName -like "*3"}

New-StoragePool -FriendlyName "DataFiles" -StorageSubsystemFriendlyName "Storage Spaces*" -PhysicalDisks $PhysicalDisks |New-VirtualDisk -FriendlyName "DataFiles" -Interleave 65536 -NumberOfColumns 2 -ResiliencySettingName simple –UseMaximumSize |Initialize-Disk -PartitionStyle GPT -PassThru |New-Partition -AssignDriveLetter -UseMaximumSize |Format-Volume -FileSystem NTFS -NewFileSystemLabel "DataDisks" -AllocationUnitSize 65536 -Confirm:$false

PhysicalDisks = Get-PhysicalDisk | Where-Object {$_.FriendlyName -like "*4" -or $_.FriendlyName -like "*5"}

New-StoragePool -FriendlyName "LogFiles" -StorageSubsystemFriendlyName "Storage Spaces*" -PhysicalDisks $PhysicalDisks |New-VirtualDisk -FriendlyName "LogFiles" -Interleave 65536 -NumberOfColumns 2 -ResiliencySettingName simple –UseMaximumSize |Initialize-Disk -PartitionStyle GPT -PassThru |New-Partition -AssignDriveLetter -UseMaximumSize |Format-Volume -FileSystem NTFS -NewFileSystemLabel "LogDisks" -AllocationUnitSize 65536 -Confirm:$false
