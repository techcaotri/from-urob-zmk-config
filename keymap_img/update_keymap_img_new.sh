#!/bin/sh

echo 'Parsing ZMK keymap...'
# keymap -c adv360pro_keymap_config.yaml parse -c 10 -z ../config/adv360pro.keymap --base-keymap adv360pro_keymap_base.yaml > adv360pro_keymap.yaml
keymap -c ../keymap_drawer.config.yaml parse -z ../config/eyelash_corne.keymap > eyelash_corne_keymap.yaml

echo 'Drawing keymap...'
keymap -c ../keymap_drawer.config.yaml draw -j ../config/eyelash_corne.json eyelash_corne_keymap.yaml > eyelash_corne_keymap.svg
keymap -c ../keymap_drawer.config.yaml draw --keys-only --select-layers base fn num sys mouse  -j ../config/eyelash_corne.json eyelash_corne_keymap.yaml > eyelash_corne_keymap_keys.svg
keymap -c ../keymap_drawer.config.yaml draw --combos-only --select-layers base fn num sys mouse -j ../config/eyelash_corne.json  eyelash_corne_keymap.yaml > eyelash_corne_keymap_combos.svg
