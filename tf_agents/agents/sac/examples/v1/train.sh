#!/bin/bash

gpu="1"
robot="turtlebot"
config_file="../examples/configs/"$robot"_p2p_nav_house.yaml"
col="0.0"

log_dir="test"
echo $log_dir

nohup python -u train_eval.py \
    --root_dir $log_dir \
    --env_type gibson \
    --random_position \
    --config_file $config_file \
    --initial_collect_steps 500 \
    --collect_steps_per_iteration 1 \
    --batch_size 256 \
    --train_steps_per_iteration 1 \
    --replay_buffer_capacity 10000 \
    --num_eval_episodes 1 \
    --eval_interval 10000000 \
    --gpu_c $gpu \
    --gpu_g $gpu \
    --num_parallel_environments 8 \
    --collision_reward_weight $col > $log_dir".log" &

