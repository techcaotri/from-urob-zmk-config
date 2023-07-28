#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Installing keymap-drawer: Need python3.10.."
python3.10 -m pip install keymap-drawer

if [[ "$(python -V)" != "Python 3"* ]]; then
  echo "Need Python version >= 3"
  exit 1
fi

pip install oyaml

# Copy urob keymap layout to qmk_layouts
site_packages_path=$(python3.10 -m site --user-site)
echo "Copying urob keymap layout to $site_packages_path/resources/qmk_layouts/"
cp $SCRIPT_DIR/adv360pro_urob.json "$site_packages_path/resources/qmk_layouts/"
