#!/bin/bash

# Kullanıcıdan taranacak klasör yolunu al
read -p "Lütfen taranacak klasörün yolunu girin: " folder_path

# Klasörün var olup olmadığını kontrol et
if [ -d "$folder_path" ]; then
    echo "Tarama seçenekleri:"
    echo "1. Request Tarama ($_GET, $_POST, $_REQUEST)"
    echo "2. Code Execution Tarama (PHP işletim sistemi komutları)"
    echo "3. File Tarama (PHP dosya işlemleri)"

    # Kullanıcıdan tarama türünü seçmesini iste
    read -p "Lütfen bir tarama türü seçin (1, 2 veya 3): " scan_option

    # Kullanıcıdan sonuçları kaydetmek için dosya yolunu al (isteğe bağlı)
    read -p "Sonuçları kaydetmek istediğiniz dosya yolunu girin (boş bırakabilirsiniz): " result_file

    case $scan_option in
        1)
            echo "Request Tarama başlatılıyor..."
            if [ -z "$result_file" ]; then
                # Sadece terminalde göster
                find "$folder_path" -type f -name "*.php" | xargs grep --color=always -HnE '\$_GET|\$_POST|\$_REQUEST' | tee /dev/tty | grep -HnE '\$_GET|\$_POST|\$_REQUEST' | tee >(wc -l >&2)
            else
                # Terminalde göster ve dosyaya kaydet
                find "$folder_path" -type f -name "*.php" | xargs grep --color=always -HnE '\$_GET|\$_POST|\$_REQUEST' | tee /dev/tty | grep -HnE '\$_GET|\$_POST|\$_REQUEST' | tee >(wc -l >&2) > "$result_file"
                echo "Request Tarama tamamlandı. Sonuçlar: $result_file dosyasına kaydedildi."
            fi
            ;;
        2)
            echo "Code Execution Tarama başlatılıyor..."
            if [ -z "$result_file" ]; then
                # Sadece terminalde göster
                find "$folder_path" -type f -name "*.php" | xargs grep --color=always -HnE 'exec\(|eval\(|passthru\(|system\(|shell_exec\(|`|popen\(|proc_open\(|pcntl_exec\(' | tee /dev/tty | grep -HnE 'exec\(|eval\(|passthru\(|system\(|shell_exec\(|`|popen\(|proc_open\(|pcntl_exec\(' | tee >(wc -l >&2)
            else
                # Terminalde göster ve dosyaya kaydet
                find "$folder_path" -type f -name "*.php" | xargs grep --color=always -HnE 'exec\(|eval\(|passthru\(|system\(|shell_exec\(|`|popen\(|proc_open\(|pcntl_exec\(' | tee /dev/tty | grep -HnE 'exec\(|eval\(|passthru\(|system\(|shell_exec\(|`|popen\(|proc_open\(|pcntl_exec\(' | tee >(wc -l >&2) > "$result_file"
                echo "Code Execution Tarama tamamlandı. Sonuçlar: $result_file dosyasına kaydedildi."
            fi
            ;;
        3)
            echo "File Tarama başlatılıyor..."
            if [ -z "$result_file" ]; then
                # Sadece terminalde göster
                find "$folder_path" -type f -name "*.php" | xargs grep --color=always -HnE 'fopen\(|tmpfile\(|bzopen\(|gzopen\(|chgrp\(|chmod\(|chown\(|copy\(|file_put_contents\(|mkdir\(|move_uploaded_file\(|touch\(|readfile\(|is_uploaded_file\(' | tee /dev/tty | grep -HnE 'fopen\(|tmpfile\(|bzopen\(|gzopen\(|chgrp\(|chmod\(|chown\(|copy\(|file_put_contents\(|mkdir\(|move_uploaded_file\(|touch\(|readfile\(|is_uploaded_file\(' | tee >(wc -l >&2)
            else
                # Terminalde göster ve dosyaya kaydet
                find "$folder_path" -type f -name "*.php" | xargs grep --color=always -HnE 'fopen\(|tmpfile\(|bzopen\(|gzopen\(|chgrp\(|chmod\(|chown\(|copy\(|file_put_contents\(|mkdir\(|move_uploaded_file\(|touch\(|readfile\(|is_uploaded_file\(' | tee /dev/tty | grep -HnE 'fopen\(|tmpfile\(|bzopen\(|gzopen\(|chgrp\(|chmod\(|chown\(|copy\(|file_put_contents\(|mkdir\(|move_uploaded_file\(|touch\(|readfile\(|is_uploaded_file\(' | tee >(wc -l >&2) > "$result_file"
                echo "File Tarama tamamlandı. Sonuçlar: $result_file dosyasına kaydedildi."
            fi
            ;;
        *)
            echo "Geçersiz seçim. Lütfen 1, 2 veya 3 seçin."
            ;;
    esac
else
    echo "Geçersiz klasör yolu. Lütfen tekrar deneyin."
fi

