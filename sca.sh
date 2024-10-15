#!/bin/bash
#Owner By Ghost Haxor 
#kalo mau pake izin dulu anjik ke tele gwe 
#telegram @seotampanidaman
scan_directory() {
    local dir="$1"
    local log_file="$2"

    # Iterasi melalui setiap file dalam direktori
    for file in "$dir"/*; do
        if [ -d "$file" ]; then
            scan_directory "$file" "$log_file"  # Pindai direktori sub-folder
        elif [ "${file##*.}" = "php" ]; then  # Cek jika file ber-ekstensi .php
            if is_file_infected "$file"; then
                echo -e "\033[31mFile terinfeksi: $file\033[0m"
                echo "File terinfeksi: $file" >> "$log_file"
            fi
        fi
    done
}

# Fungsi untuk memeriksa apakah file terinfeksi
is_file_infected() {
    local file="$1"
    local malware_signatures=("eval(" "base64_decode(" "system(" "exec(" "shell_exec(")

    # Membaca file dan memeriksa tanda-tanda malware
    for signature in "${malware_signatures[@]}"; do
        if grep -q "$signature" "$file"; then
            return 0  # Return true jika ada tanda malware
        fi
    done

    return 1  # Return false jika tidak ditemukan tanda-tanda malware
}

# Direktori saat ini
current_directory=$(pwd)
log_file="scan_results.txt"

# Memulai scanning direktori
scan_directory "$current_directory" "$log_file"

echo "Hasil scan disimpan di: $log_file"
