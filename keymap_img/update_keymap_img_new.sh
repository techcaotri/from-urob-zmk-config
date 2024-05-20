#!/bin/sh

echo 'Parsing ZMK keymap...'
# keymap -c adv360pro_keymap_config.yaml parse -c 10 -z ../config/adv360pro.keymap --base-keymap adv360pro_keymap_base.yaml > adv360pro_keymap.yaml
keymap -c corne_keymap_config.yaml parse -c 10 -z ../config/corne.keymap > corne_keymap.yaml

echo 'Adjusting keymap yaml...'
./keymap_img_adjuster.py corne_keymap.yaml

echo 'Drawing keymap...'
keymap -c corne_keymap_config.yaml draw --select-layers base nav fn num sys mouse  -k corne_rotated corne_keymap.yaml > corne_keymap.svg
keymap -c corne_keymap_config.yaml draw --keys-only --select-layers base nav fn num sys mouse  -k corne_rotated corne_keymap.yaml > corne_keymap_keys.svg
keymap -c corne_keymap_config.yaml draw --combos-only --select-layers base nav fn num sys mouse  -k corne_rotated corne_keymap.yaml > corne_keymap_combos.svg
