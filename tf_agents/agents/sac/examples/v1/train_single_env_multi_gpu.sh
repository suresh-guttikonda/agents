#!/bin/bash

algo="sac"
robot="locobot"
config_file="../examples/configs/"$robot"_interactive_nav_s2r_mp_continuous.yaml"
lr="3e-4"
gamma="0.999"
env_type="gibson_sim2real"

gpu_c="1"
gpu_g="0"
collision_reward_weight="0.0"
max_collisions_allowed="0"
seed="0"

### change default arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --gpu_c) gpu_c="$2"; shift ;;
        --gpu_g) gpu_g="$2"; shift ;;
        --collision_reward_weight) collision_reward_weight="$2"; shift ;;
        --max_collisions_allowed) max_collisions_allowed="$2"; shift ;;
        --seed) seed="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

log_dir="/result/coll_rwd_wgt_"$collision_reward_weight"_max_coll_allowed_"max_collisions_allowed"_"$seed
mkdir -p $log_dir
echo "log_dir:" $log_dir
echo "gpu_c:" $gpu_c
echo "gpu_g:" $gpu_g
echo "collision_reward_weight:" $collision_reward_weight
echo "max_collisions_allowed:" $max_collisions_allowed
echo "seed:" $seed

python -u train_eval.py \
    --root_dir $log_dir \
    --env_type $env_type \
    --config_file $config_file \
    --initial_collect_steps 500 \
    --collect_steps_per_iteration 1 \
    --num_iterations 100000000 \
    --batch_size 256 \
    --train_steps_per_iteration 1 \
    --replay_buffer_capacity 10000 \
    --num_eval_episodes 10 \
    --eval_interval 2500 \
    --gpu_c $gpu_c \
    --gpu_g $gpu_g \
    --num_parallel_environments 9 \
    --actor_learning_rate $lr \
    --critic_learning_rate $lr \
    --alpha_learning_rate $lr \
    --gamma $gamma \
    --collision_reward_weight $collision_reward_weight \
    --max_collisions_allowed $max_collisions_allowed \
    --eval_deterministic > $log_dir/log 2>&1
