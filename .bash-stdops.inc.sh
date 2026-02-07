#!/usr/bin/env bash

# Function to detect Wayland without environment variables
is_wayland() {
  local user_id
  user_id=$(id -u)

  # Method 1: Environment variables
  if [[ "${XDG_SESSION_TYPE:-}" == "wayland" ]] \
    || [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
    return 0
  fi

  # Method 2: Query loginctl (Systemd login manager)
  # This is the most robust method for modern Linux systems.
  if type -P loginctl &>/dev/null; then
    # List all sessions for the current user ID
    while IFS= read -r session; do
      local type state
      type=$(loginctl show-session "$session" -p Type --value 2>/dev/null)
      state=$(loginctl show-session "$session" -p State --value 2>/dev/null)

      # Check if the user has a session that is both active and running Wayland
      if [[ "$type" == "wayland" && "$state" == "active" ]]; then
        return 0
      fi
    done < <(loginctl list-sessions --no-legend \
      | awk -v uid="$user_id" '$2 == uid { print $1 }')
  fi

  # Method 3: Check for Wayland socket existence
  # Fallback if loginctl is unavailable or returns no active session. Wayland
  # compositors create a socket (usually wayland-0) in the user runtime dir.
  if [[ -n "${XDG_RUNTIME_DIR:-}" ]]; then
    local runtime_path="$XDG_RUNTIME_DIR"
  else
    local runtime_path="/run/user/$user_id"
  fi

  if [[ -d "$runtime_path" ]]; then
    # Look for any socket file starting with "wayland-"
    # We use find to avoid shell expansion issues if no files exist
    if find "$runtime_path" -maxdepth 1 -name "wayland-*" -type s \
      | grep -q .; then
      return 0
    fi
  fi

  return 1
}
