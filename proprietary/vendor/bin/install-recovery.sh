#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):82825216:d77b015a604acc54736699e000819c8c3993d2b9; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/bootdevice/by-name/boot$(getprop ro.boot.slot_suffix):67108864:ef3030b5536b6119f65581e3b035c6e3eb7707db \
          --target EMMC:/dev/block/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):82825216:d77b015a604acc54736699e000819c8c3993d2b9 && \
      (/vendor/bin/log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (/vendor/bin/log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  /vendor/bin/log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

