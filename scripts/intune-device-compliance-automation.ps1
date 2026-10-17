### FILE: index.php
<?php 

// Fetch device compliance status using the Microsoft Graph API
$deviceId = $_GET['deviceId'];
$accessToken = $_SESSION['ms_access_token'];

$deviceStatus = $ms->graphCall("/deviceManagement/managedDevices/$deviceId", $accessToken);

if ($deviceStatus->status === 'Compliant') {
  render_premium_card('Device Compliance Status', 'Compliant');
} else {
  render_premium_card('Device Compliance Status', 'Non-Compliant', null, 'down');
}

?>

### FILE: scripts/Automation.ps1
<#
.SYNOPSIS
   Check device compliance status using Microsoft Graph API.

.DESCRIPTION
   This script retrieves the compliance status of a device managed by Intune using the Microsoft Graph API.
   Requires the DeviceManagementConfiguration.ReadWrite.All permission scope.

.EXAMPLE
   Check-DeviceComplianceStatus -DeviceId "device-id"

.NOTES
   Author:      Souhaiel Morhag
   Company:     MSEndpoint.com
   Blog:        https://msendpoint.com
   Academy:     https://app.msendpoint.com/academy
   LinkedIn:    https://linkedin.com/in/souhaiel-morhag
   GitHub:      https://github.com/Msendpoint
   License:     MIT
#>

[CmdletBinding(SupportsShouldProcess)]
param(
  [string]$DeviceId
)

try {
  # Fetch device details from Microsoft Graph
  $device = Get-MgDeviceManagementManagedDevice -DeviceId $DeviceId

  if ($device.Status -eq 'Compliant') {
    Write-Output "Device is compliant."
  } else {
    Write-Output "Device is non-compliant."
  }
}
catch {
  Write-Error "Failed to retrieve device status: $_"
}