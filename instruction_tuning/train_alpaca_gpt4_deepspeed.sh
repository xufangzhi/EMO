export CUDA_VISIBLE_DEVICES=0,1,2,3
model_path=$1
output_path=$2
mode=$3


deepspeed --num_gpus=4 train.py \
    --model_name_or_path $model_path \
    --mode $mode \
    --data_path alpaca_gpt4_data.json \
    --bf16 True \
    --output_dir $output_path \
    --num_train_epochs 3 \
    --per_device_train_batch_size 4 \
    --per_device_eval_batch_size 4 \
    --gradient_accumulation_steps 8 \
    --evaluation_strategy "no" \
    --save_strategy "steps" \
    --save_steps 2000 \
    --save_total_limit 1 \
    --learning_rate 2e-5 \
    --weight_decay 0. \
    --warmup_ratio 0.03 \
    --lr_scheduler_type "cosine" \
    --logging_steps 1 \
    --deepspeed ./ds_config/deepspeed_zero3.json \
    --report_to none \
    --tf32 True