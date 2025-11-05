 #!/bin/bash

# Fix Sleep Mode for Pop!_OS by setting mem_sleep_default to deep

# See https://github.com/pop-os/pop/issues/449

echo "Setting mem_sleep_default to deep for better sleep mode support..."
sudo kernelstub -a mem_sleep_default=deep
echo "mem_sleep_default has been set to deep. Please reboot your system for the changes to take effect."


# Disable touchpad tap-to-click to prevent accidental clicks
echo "Disabling touchpad tap-to-click to prevent accidental clicks..."
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false
