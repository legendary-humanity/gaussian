#!/bin/bash

declare -a prune_percents=(0.4 0.4 0.4 0.4 0.4 0.6 0.6 0.6 0.6 0.6 0.9 0.9 0.9 0.9 0.9) 
declare -a prune_decays=(0.1 0.3 0.5 0.7 0.9 0.1 0.3 0.5 0.7 0.9 0.1 0.3 0.5 0.7 0.9)   
declare -a v_pow=(0.1 0.1 0.15 0.1 0.1 0.4 0.1 0.1 0.1 0.3 0.1 0.2 0.1 0.1 0.1)


# Prune types (TODO)
# "max_v_important_score" 
# "v_important_score"
# "k_mean" (TODO)
# "important_score"
declare -a prune_types=(
  "v_important_score"
  )

# Check that prune_percents and prune_decays arrays have the same length
if [ "${#prune_percents[@]}" -ne "${#prune_decays[@]}" ]; then
  echo "The number of prune percents does not match the number of prune decays."
  exit 1
fi

declare -a savepath = "../results"
# Loop over the arguments array
for i in "${!prune_percents[@]}"; do
    prune_percent="${prune_percents[i]}"
    prune_decay="${prune_decays[i]}"
    vp="${v_pow[i]}"

    for prune_type in "${prune_types[@]}"; do
        # Wait for an available GPU
        m = "${savepath}/models${i}/"
        mkdir -p m
        echo "GPU  is available. Starting train_densify_prune.py with dataset 'bonsai', prune_percent '$prune_percent', prune_type '$prune_type', prune_decay '$prune_decay', and v_pow '$vp'"
        # python train_densify_prune.py \
        # -s "/datasets/bonsai" \
        # -m "${m}" \
        # --prune_percent $prune_percent \
        # --prune_decay $prune_decay \
        # --prune_iterations 20000 \
        # --v_pow $vp\
        # --eval
        
    done  # End loop over v_pow values
done
# Wait for all background processes to finish
wait
echo "All train_densify_prune.py runs completed."
