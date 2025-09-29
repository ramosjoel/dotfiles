#!/bin/zsh

# Lists the available iOS Simulators
function list_simulators() {
  xcrun simctl list devices available
}

# Lists available iOS Simulators via `idb`
function idb_list_simulators() {
  idb list-targets
}

# List booted apps
function list_booted_apps() {
  xcrun simctl listapps booted | grep CFBundleIdentifier
}

# Starts the specified iOS Simulator, by UDID
function start_iphone_simulator() {
  targets=("${(@f)$(idb list-targets | grep iPhone)}")
  select target in "${targets[@]}"
  do
    target_name="$(echo $target | awk 'BEGIN { FS = "|"} {print $1}')"
    target_udid="$(echo $target | awk 'BEGIN { FS = "|"} {print $2}' | sed 's/ //g')"
    target_state="$(echo $target | awk 'BEGIN { FS = "|"} {print $3}' | sed 's/ //g')"
    target_type="$(echo $target | awk 'BEGIN { FS = "|"} {print $4}' | sed 's/ //g')"
    target_os_version="$(echo $target | awk 'BEGIN { FS = "|"} {print $5}' | sed 's/ //g')"
    target_arch="$(echo $target | awk 'BEGIN { FS = "|"} {print $6}' | sed 's/ //g')"
    target_companion_state="$(echo $target | awk 'BEGIN { FS = "|"} {print $7}' | sed 's/ //g')"
    echo "
    Starting simulator:
        📱 Device: $target_name 
             UDID: $target_udid
             Type: $target_type
       OS Version: $target_os_version
     Architecture: $target_arch
    "
    if [[ $target_state == "Booted" ]]; then
      echo "Simulator is already booted."
      # xcrun simctl launch booted
      open -a Simulator.app
      return 0
    fi
    idb boot $target_udid
    # xcrun simctl launch booted
    open -a Simulator.app
    break
  done
}

# Stops the specified iOS Simulator, by UDID
#
# param $1: The UDID of the iOS Simulator
#  - e.g., 5EA9227B-3DCA-48DB-A773-A0314EE30EE7
function stop_simulator() {
  simulator_id=$1
  validate_udid $simulator_id
  echo "Stopping simulator $simulator_id..."
  xcrun simctl shutdown ${simulator_id}
}


# Restarts the specified iOS Simulator, by UDID
#
# param $1: The UDID of the iOS Simulator
#  - e.g., 5EA9227B-3DCA-48DB-A773-A0314EE30EE7
function restart_simulator() {
  simulator_id=$1
  validate_udid $simulator_id
  echo "Restarting Simulator $simulator_id... "
  stop_simulator $simulator_id
  start_simulator $simulator_id
}

# Install the .app onto the booted simulator
#
# param $1: Path to .app
function install_app() {
  path_to_app=$1
  xcrun simctl install booted $path_to_app
}
