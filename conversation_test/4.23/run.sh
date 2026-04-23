#!/usr/bin/env bash
set -euo pipefail

ROOT="/home/shentong/index-tts-main"
PY="/home/shentong/miniconda3/envs/indextts2/bin/python"
RUN_TAG="${RUN_TAG:-$(date +%Y%m%d_%H%M%S)}"

export PYTHONPATH="$ROOT"
cd "$ROOT"
export CUDA_VISIBLE_DEVICES=1

# 用法示例：
#   bash conversation_test/4.23/run.sh --lines 1
#   bash conversation_test/4.23/run.sh --lines 1-20 --with_conversation --merge
#   RUN_TAG=voice_eval_round1 bash conversation_test/4.23/run.sh --lines 1-20 --with_conversation --merge
# 说明：
#   - 每次 run 的 out_root 会带 RUN_TAG，方便你做“保留/淘汰”对比
#   - 建议先只开 --with_conversation，听完再把不好的音频文件名写进 config.yaml 的 speaker_pool.exclude_list

exec "$PY" -X faulthandler conversation_test/4.23/export_single_axis.py \
  --input axis_pack/all_冒充快递派件.jsonl \
  --cfg checkpoints/config.yaml \
  --model_dir checkpoints/IndexTTS-2 \
  --configs_dir conversation_test/4.23 \
  --out_root "conversation_test/4.23/output_冒充快递派件_${RUN_TAG}" \
  --merge \
  "$@"
