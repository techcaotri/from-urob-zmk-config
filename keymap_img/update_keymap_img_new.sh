#!/bin/sh

echo 'Checking if the "../config/zmk-helpers" directory exists...'
if [ ! -d "../config/zmk-helpers" ]; then
    echo 'Directory "../config/zmk-helpers" does not exist. Please make the soft link to zmk-helpers include in build directory...'
    echo 'ln -s /home/tripham/Dev/Kinesis_Adv360_Pro/Sources/source_urob_zmk_eyelash_corne_dongle/zmk-helpers/include/zmk-helpers ../config/zmk-helpers'
    exit
fi

echo 'Parsing ZMK keymap...'
# keymap -c adv360pro_keymap_config.yaml parse -c 10 -z ../config/adv30pro.keymap --base-keymap adv360pro_keymap_base.yaml > adv360pro_keymap.yaml
keymap -c ../keymap_drawer.config.yaml parse -z ../config/eyeslash_corne.keymap > eyelash_corne_keymap.yaml

echo 'Drawing keymap...'
keymap -c ../keymap_drawer.config.yaml draw -j ../config/eyeslash_corne.json eyelash_corne_keymap.yaml > eyelash_corne_keymap.svg
keymap -c ../keymap_drawer.config.yaml draw --keys-only --select-layers base fn num sys mouse  -j ../config/eyeslash_corne.json eyelash_corne_keymap.yaml > eyelash_corne_keymap_keys.svg
keymap -c ../keymap_drawer.config.yaml draw --combos-only --select-layers base fn num sys mouse -j ../config/eyeslash_corne.json  eyelash_corne_keymap.yaml > eyelash_corne_keymap_combos.svg
