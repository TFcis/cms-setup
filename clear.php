<?php
$ok=file_put_contents("ip.txt", "");
if ($ok===false) {
	exit("[ERROR] Write \"ip.txt\" failed. Please chmod 777.\n");
}
echo "[OK] Cleared";
