#!/bin/sh

echo 'Parsing ZMK keymap...'
# keymap -c adv360pro_keymap_config.yaml parse -c 10 -z ../config/adv360pro.keymap --base-keymap adv360pro_keymap_base.yaml > adv360pro_keymap.yaml
keymap -c adv360pro_keymap_config.yaml parse -c 10 -z ../config/adv360pro.keymap > adv360pro_keymap.yaml
keymap -c adv360pro_keymap_config.yaml parse -c 10 -z ../config/sofle.keymap > sofle_keymap.yaml

echo 'Adjusting keymap yaml...'
./keymap_img_adjuster.py adv360pro_keymap.yaml
./keymap_img_adjuster.py sofle_keymap.yaml

echo 'Drawing keymap...'
keymap -c adv360pro_keymap_config.yaml draw --select-layers base nav fn num sys mouse  -k adv360pro_urob adv360pro_keymap.yaml > adv360pro_keymap.svg
keymap -c adv360pro_keymap_config.yaml draw --select-layers base nav fn num sys mouse  -k sofle sofle_keymap.yaml > sofle_keymap.svg
