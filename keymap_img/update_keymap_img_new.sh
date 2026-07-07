#!/bin/sh
#
# Regenerate the keymap images with keymap-drawer (https://github.com/caksoylar/keymap-drawer)
# from the CURRENT eyelash_corne.keymap. Produces, in this directory:
#   - eyelash_corne_keymap.yaml         (the parsed keymap-drawer model)
#   - eyelash_corne_keymap.svg          (full: keys + combos, all layers)
#   - eyelash_corne_keymap_keys.svg     (keys only)
#   - eyelash_corne_keymap_combos.svg   (combos only)
# covering ALL six layers, including the pointer-triggered AUTOMOUSE layer (Part F).
#
# Requires the `keymap` CLI:  pipx install keymap-drawer   (or pip install --user)
set -e
cd "$(dirname "$0")"   # run from keymap_img/ regardless of caller CWD

DRAWER_CFG=../keymap_drawer.config.yaml
KEYMAP=../config/eyelash_corne.keymap
LAYOUT=../config/eyelash_corne.json
# Layer order matches the keymap (base=0 .. automouse=5); automouse is the AML.
LAYERS="base fn num sys mouse automouse"

if ! command -v keymap >/dev/null 2>&1; then
    echo 'error: the `keymap` CLI (keymap-drawer) is not on PATH.' >&2
    echo '       install it with:  pipx install keymap-drawer' >&2
    exit 1
fi

# keymap-drawer's C-preprocessor pass needs the zmk-helpers headers the keymap
# #includes (ZMK_LAYER, ZMK_COMBO, ...). Expose them at ../config/zmk-helpers as a
# relative symlink into this workspace's checkout, created on demand.
if [ ! -e ../config/zmk-helpers ]; then
    echo 'Linking ../config/zmk-helpers -> ../../zmk-helpers/include/zmk-helpers ...'
    ln -s ../../zmk-helpers/include/zmk-helpers ../config/zmk-helpers
fi

echo 'Parsing ZMK keymap...'
keymap -c "$DRAWER_CFG" parse -z "$KEYMAP" > eyelash_corne_keymap.yaml

echo 'Drawing keymap (full / keys-only / combos-only)...'
keymap -c "$DRAWER_CFG" draw                              -j "$LAYOUT" eyelash_corne_keymap.yaml > eyelash_corne_keymap.svg
keymap -c "$DRAWER_CFG" draw --keys-only   --select-layers $LAYERS -j "$LAYOUT" eyelash_corne_keymap.yaml > eyelash_corne_keymap_keys.svg
keymap -c "$DRAWER_CFG" draw --combos-only --select-layers $LAYERS -j "$LAYOUT" eyelash_corne_keymap.yaml > eyelash_corne_keymap_combos.svg

echo 'Done. Wrote eyelash_corne_keymap{,_keys,_combos}.svg'
