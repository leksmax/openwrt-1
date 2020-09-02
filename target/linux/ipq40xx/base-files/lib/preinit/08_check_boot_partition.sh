. /lib/functions.sh

check_boot_partition() {
	local current_boot_partition

	case $(board_name) in
	netgear,rbr50|\
	netgear,rbs50|\
	netgear,srr60|\
	netgear,srs60)
		# Currently this board supports only booting from partition 1.
		# If booted from partition 2, the system wont be usable
		current_boot_partition=$(hexdump -v -s 297 -n 1 -e '1 "%_p"' /dev/mmcblk0p12)
		echo "Current boot partition: $current_boot_partition"
		if [ "$current_boot_partition" != "1" ]; then
			echo "Wrong boot partition! Please use partition 1"
		fi
		;;
	esac
}

boot_hook_add preinit_main check_boot_partition