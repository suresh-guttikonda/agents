#!/bin/bash

gpu_c="0"
gpu_g="0"

if [[ -z "${CONFIG_FILE}" ]]; then
  config_file="examples/configs/locobot_social_nav.yaml"
else
  config_file="${CONFIG_FILE}"
fi

if [[ -z "${LOG_DIR}" ]]; then
  log_dir="test"
else
  log_dir="${LOG_DIR}"
fi

echo "config_file:" $config_file
echo "log_dir:" $log_dir

python -u train_eval.py \
    --root_dir $log_dir \
    --config_file $config_file \
    --initial_collect_steps 500 \
    --collect_steps_per_iteration 1 \
    --batch_size 256 \
    --train_steps_per_iteration 1 \
    --replay_buffer_capacity 10000 \
    --num_eval_episodes 10 \
    --eval_interval 10000000 \
    --gpu_c $gpu_c \
    --gpu_g $gpu_g \
    --num_parallel_environments 8 \
    --model_ids Rs_int,Benevolence_0_int,Pomaria_0_int,Ihlen_1_int,Merom_0_int,Beechwood_1_int,Ihlen_0_int,Wainscott_1_int
