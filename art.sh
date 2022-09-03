#!/bin/bash

SD_DIR=~/dev/tools/stable-diffusion

cd $SD_DIR
source venv/bin/activate

echo -n "Enter a prompt: "
read prompt

echo -n "Quality (0-100, default 50): "
read steps

if [[ -z "$steps" ]]; then
  steps=50
fi

declare -A art_styles

art_styles["Landscape Painting"]=", by Caspar David Friedrich, matte painting trending on artstation HQ"

art_styles["Photorealistic"]=", dlsr photography, sharp focus, perfect light"

art_styles["Fantasy Art"]=", trending on artstation, style Greg Rutkowski"

art_styles["Cinematic"]=", cinematic photo, highly detailed, cinematic lighting, ultra-detailed, ultrarealistic, photorealism, 8k, octane render"

art_styles["CG Art"]=", colorful, artstation, cgsociety"

art_styles["none"]=""

echo "What kind of style do you want?"

select art_style in "${!art_styles[@]}"; do
  art_style_value="${art_styles[$art_style]}"

  # Generate image:
  python scripts/txt2img.py \
    --prompt "$prompt$art_style_value" \
    --n_samples 1 --n_iter 1 --plms --ddim_steps "$steps"

  # Go to output dir:
  cd "$SD_DIR/outputs/txt2img-samples"

  # Open last modified file in directory:
  open $(ls -Art | tail -n 1)
done

