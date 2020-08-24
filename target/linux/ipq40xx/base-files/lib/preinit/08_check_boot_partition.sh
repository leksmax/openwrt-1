. /lib/functions.sh

check_boot_partition() {
	local current_boot_partition

	case $(board_name) in
	netgear,srk60)
		# Currenlty this board support only booting from partition 1.
		# If booted from partition 2, reboot
		current_boot_partition=$(hexdump -v -s 297 -n 1 -e '1 "%_p"' /dev/mmcblk0p12)
		echo "Current boot partition: $current_boot_partition"
		if [ "$current_boot_partition" != "1" ]; then
			echo "Wrong boot partition! Please use partition 1"
		fi
		;;
	esac
}

boot_hook_add preinit_main check_boot_partition