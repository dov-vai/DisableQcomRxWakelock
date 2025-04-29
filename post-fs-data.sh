#!/system/bin/sh
MODDIR=${0%/*}

search_base_dir="/system/vendor/etc/wifi/"
config_file="WCNSS_qcom_cfg.ini"
# rx_wakelock_timeout=0 flag
insert_flag="rx_wakelock_timeout=0\n"

find "$search_base_dir" -type f -name "$config_file" -print0 | while IFS= read -r -d $'\0' target_file; do
    # get full path relative to root
    relative_path="${target_file#/}"

    # create destination path
    save_file="$MODDIR/$relative_path"
    save_file_dir=$(dirname "$save_file")

    # create directory structure
    mkdir -p "$save_file_dir"

    # insert flag before END, it won't parse the config after it (xiaomi specific I think)
    # if END is not found, still insert it
    awk -v flag="$insert_flag" '
        /^END$/ && !inserted {
            print flag
            inserted=1
        }
        { print }
        END {
            if (!inserted) {
                print flag
            }
        }
    ' "$target_file" > "$save_file"
done
