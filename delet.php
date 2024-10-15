<?php
//Owner By Ghost Haxor 
function kuma_hapus($nama_kuman) {
    $kumanjumlah = 0;
    $deleted_daki = [];
    $daki_permanen = [];
    $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator('.'));
    foreach ($iterator as $kuman) {
        if ($kuman->isFile() && $kuman->getFilename() == $nama_kuman) {
            $daki_path = $kuman->getPathname();
            if (unlink($daki_path)) {
                $kumanjumlah++;
                $deleted_daki[] = $daki_path;
            } else {
                $daki_permanen[] = $daki_path;
            }
        }
    }

    if ($kumanjumlah > 0) {
        echo "Total $kumanjumlah file $nama_kuman kuman judi telah dihapus." . PHP_EOL;
        echo "Path kuman judi telah dihapus:" . PHP_EOL;
        foreach ($deleted_daki as $kuman) {
            echo $kuman . PHP_EOL;
        }
    } else {
        echo "daki sudah tidak ada $nama_kuman untuk dihapus." . PHP_EOL;
    }

    if (!empty($daki_permanen)) {
        echo "Gagal menghapus daki berikut:" . PHP_EOL;
        foreach ($daki_permanen as $kuman) {
            echo $kuman . PHP_EOL;
        }
    }
}


if (isset($argv[1])) {
    $nama_kuman = $argv[1];
    kuma_hapus($nama_kuman);
} else {
    echo "Gunakan: php autohapus.php <nama_file>" . PHP_EOL;
}
