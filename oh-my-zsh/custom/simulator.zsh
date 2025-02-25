#!/bin/zsh

# Lists the available iOS Simulators
function list_simulators() {
  xcrun simctl list devices available
}

# List booted apps
function list_booted_apps() {
  xcrun simctl listapps booted | grep CFBundleIdentifier
}

# Starts the specified iOS Simulator, by UDID
#
# param $1: The UDID of the iOS Simulator
#  - e.g., 5EA9227B-3DCA-48DB-A773-A0314EE30EE7
function start_simulator() {
  simulator_id=$1
  validate_udid $simulator_id
  echo "Starting simulator $simulator_id..."
  xcrun simctl boot ${simulator_id}
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
