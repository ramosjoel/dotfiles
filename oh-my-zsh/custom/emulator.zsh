#!/bin/zsh

# ----- Android Emulators -----

function list_emulators() {
  echo "Running: emulator -list-avds"
  emulator -list-avds
}

# Starts an Android Emulator.
#
# Defaults to Pixel_6_Pro_API_34
#
# Current emulators
# - Pixel_3a_API_34_extension_level_7_arm64-v8a
# - Pixel_9_API_31
# - Pixel_6_Pro_API_34
function start_emulator() {
  AVD=${1:-Pixel_6_Pro_API_34}
  echo "Running: emulator -avd $AVD -wipe-data -no-snapshot"
  # -avd $AVD - which emulator to start
  # -wipe-data -
    # Deletes user data and copies data from the initial data file. 
    # This option clears the data for the virtual device and returns it to the same state as when it was first defined. 
    # All installed apps and settings are removed
  # -no-snapshot - Disables the Quick Boot feature completely and doesn't load or save the emulator state.
  emulator \
    -avd $AVD \
    -wipe-data \
    -no-snapshot
}

# Start emulator as writable to install cert
#
# From https://docs.mitmproxy.org/stable/howto-install-system-trusted-ca-android/#instructions-for-api-level--28-using--writable-system:
#   By default, the /system partition is mounted as read-only. The following steps describe how to gain write permissions on the /system partition and how to copy the certificate created in chapter 2.
#
#   Starting from API LEVEL 29 (Android 10), it seems to be impossible to mount the “/” partition as read-write. Google provided a workaround for this issue using OverlayFS. Unfortunately, at the time of writing this (11. April 2021), the instructions in this workaround will result in your emulator getting stuck in a boot loop. Some smart guy on Stackoverflow found a way to get the /system directory writable anyway.
#
#   Keep in mind: You always have to start the emulator using the -writable-system option if you want to use your certificate. Otherwise Android will load a “clean” system image.
#
#   Tested on emulators running API LEVEL 29 and 30
function start_emulator_as_writable() {
  # Current emulators
  AVD=${1:-Pixel_6_Pro_API_34}
  echo "Running: emulator -avd $AVD -wipe-data -no-snapshot -writable-system -show-kernel"
  # -avd $AVD - which emulator to start
  # -wipe-data -
    # Deletes user data and copies data from the initial data file. 
    # This option clears the data for the virtual device and returns it to the same state as when it was first defined. 
    # All installed apps and settings are removed
  # -no-snapshot - Disables the Quick Boot feature completely and doesn't load or save the emulator state.
  # -writable-system - Makes the /system dir writable.
  # -show-kernel - Show kernel logs.
  echo "Starting $AVD..."
  emulator \
    -avd $AVD \
    -wipe-data \
    -no-snapshot \
    -writable-system \
    -show-kernel
  # Push cert file onto emulator
  install_cert "$HOME/.mitmproxy/"
}


function install_apk() {
  apk=$1
  [[ -f $apk ]] || echo "Couldn't find $apk" && exit 1;
  echo "Installing $apk..."
  adb install $1
}

function _disable_secure_boot_verification() {
  echo "Disable secure boot verification..."
  adb shell avbctl disable-verification
}

function _restart_adb_as_root() {
  echo "Restarting adb as root..."
  adb root
}

function reboot_emulator() {
  echo "Rebooting device..."
  adb reboot
}

# Installs the Mitmproxy certificate for capturing HTTPS requests.
#
# Requires the Emulator to be started as "writable"
#  - (i.e., with the -writable-system flag).
#
# Steps in this function follow those outlined in the Mitmproxy documentation for
# devices > API 28 using the {-writable-system} flag.
# See: https://docs.mitmproxy.org/stable/howto-install-system-trusted-ca-android/#instructions-for-api-level--28-using--writable-system
function install_cert_on_emulator() {
  cert=$1
  echo "Installing cert: $cert ..."
  [[ -f $cert ]] || echo "Could not find $cert file" && exit 1;
  # Restart adb as root
  restart_adb_as_root
  # Disable secure boot verification
  _disable_secure_boot_verfication
  # Reboot device
  reboot_emulator
  # Restart adb as root
  _restart_adb_as_root
  # Perform remount of partitions as read-write: adb remount.
  #   (If adb tells you that you need to reboot, 
  #   reboot again adb reboot and run adb remount again.)
  adb remount
  # Push cert onto device
  echo "Pushing $cert onto emulator..."
  adb push $1 /system/etc/security/cacerts
  echo "Setting certificate permissions..."
  adb shell chmod 664 "/system/etc/security/cacerts/$cert"
  echo "Rebooting the emulator..."
  reboot
}

