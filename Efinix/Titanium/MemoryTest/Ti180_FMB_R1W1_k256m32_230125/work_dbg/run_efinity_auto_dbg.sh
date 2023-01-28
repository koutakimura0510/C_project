python3  -m "efx_dbg.DbgWizard" --device  "Ti180M484" --family  "Titanium" --in_profile_name  "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/debug_profile.wizard.json" --out_dbg_vdb  "debug_top.post.vdb" --out_profile_name  "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/debug_profile.wizard.json" --out_dir  "work_dbg"
efx_map  --mode "speed" --max_ram "-1" --max_mult "-1" --infer-clk-enable "3" --infer-sync-set-reset "1" --min-sr-fanout "0" --min-ce-fanout "0" --fanout-limit "0" --bram_output_regs_packing "1" --retiming "1" --seq_opt "1" --blast_const_operand_adders "1" --operator-sharing "0" --optimize-adder-tree "0" --seq-opt-sync-only "0" --blackbox-error "1" --allow-const-ram-index "0" --hdl-compile-unit "1" --create-onehot-fsms "0" --dsp-mac-packing "1" --dsp-output-regs-packing "1" --dsp-input-regs-packing "1" --pack-luts-to-comb4 "0" --I "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125" --family "Titanium" --device "Ti180M484" --keep-gclk-in-module "1" --root "edb_top" --v "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/work_dbg/debug_top.v" --write-postmap-module "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/work_dbg/debug_top.post.vdb" --generate_sig_profile "false" --work-dir "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/work_dbg" --output-dir "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/outflow"
efx_map  --family "Titanium" --device "Ti180M484" --mode "speed" --max_ram "-1" --max_mult "-1" --infer-clk-enable "3" --infer-sync-set-reset "1" --min-sr-fanout "0" --min-ce-fanout "0" --fanout-limit "0" --bram_output_regs_packing "1" --retiming "1" --seq_opt "1" --blast_const_operand_adders "1" --operator-sharing "0" --optimize-adder-tree "0" --seq-opt-sync-only "0" --blackbox-error "1" --allow-const-ram-index "0" --hdl-compile-unit "1" --create-onehot-fsms "0" --dsp-mac-packing "1" --dsp-output-regs-packing "1" --dsp-input-regs-packing "1" --pack-luts-to-comb4 "0" --I "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125" --root "MTopFmbTester" --vdb "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/outflow/Ti180_FMB_R1W1_k256m32_230125.elab.vdb" --vdb "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/work_dbg/debug_top.post.vdb" --write-efx-verilog "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/work_dbg/Ti180_FMB_R1W1_k256m32_230125.dbg.map.v" --binary-db "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/work_dbg/Ti180_FMB_R1W1_k256m32_230125.dbg.vdb" --merge_vdbs=1 --conn "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/debug_profile.wizard.json" --generate_sig_profile "false" --work-dir "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/work_dbg" --output-dir "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/outflow"
python3  "/tools/efinity/2022.2/scripts/efx_pt_jtag_util.py" --device "Ti180M484" --project "Ti180_FMB_R1W1_k256m32_230125" --design_file "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/Ti180_FMB_R1W1_k256m32_230125.peri.xml" --action "add" --jtag_user "JTAG_USER2" --output "/home/kimura/workspace/ProjectFolder/Efinix/Titanium/MemoryTest/Ti180_FMB_R1W1_k256m32_230125/Ti180_FMB_R1W1_k256m32_230125.dbg.peri.xml"
python 
