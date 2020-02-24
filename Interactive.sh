#!/system/bin/sh

# Pause script execution a little for Magisk Boot Service;
sleep 60;

#GMS TWEAKS;
busybox killall -9 com.google.android.gms
busybox killall -9 com.google.android.gms.persistent
busybox killall -9 com.google.process.gapps
busybox killall -9 com.google.android.gsf
busybox killall -9 com.google.android.gsf.persistent

# Completely stop & disable performance daemon at boot;
stop performanced

# Disable sysctl.conf;
if [ -e /system/etc/sysctl.conf ]; then
  mount -o remount,rw /system;
  mv /system/etc/sysctl.conf /system/etc/sysctl.conf.bak;
  mount -o remount,ro /system;
fi;

#Cpu tweaks;
echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
echo "91" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay 
echo "60000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
echo "960000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 
echo "480000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack 
echo "80 460800:70 600000:99" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads 
echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 
echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost 
echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/align_windows 
echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif 
echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load 
echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration 
echo "interactive" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor 
echo "633600" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq 
echo "91" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/go_hispeed_load
echo "0" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/above_hispeed_delay 
echo "30000" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/timer_rate 
echo "960000" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/hispeed_freq 
echo "480000" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/timer_slack 
echo "70 960000:90 1440000:99" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/target_loads 
echo "0" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/min_sample_time 
echo "0" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/boost 
echo "1" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/align_windows 
echo "1" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/use_migration_notif 
echo "0" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/use_sched_load 
echo "0" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/max_freq_hysteresis 
echo "0" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/boostpulse_duration 
echo "1" > /sys/module/cpu_boost/parameters/input_boost_enabled 
echo "0:600000 1:600000 2:600000 3:600000 4:0 5:0" > /sys/module/cpu_boost/parameters/input_boost_freq 
echo "0" > /sys/module/cpu_boost/parameters/boost_ms 
echo "1920" > /sys/module/cpu_boost/parameters/input_boost_ms 
echo "0" > /sys/module/msm_performance/parameters/touchboost 
echo "1" > /sys/devices/system/cpu/cpuidle/use_deepest_state
chmod 644 /sys/module/workqueue/parameters/power_efficient
echo Y > /sys/module/workqueue/parameters/power_efficient
echo "1000000" > /dev/cpuctl/cpu.rt_period_us
echo "950000" > /dev/cpuctl/cpu.rt_period_us
echo "0" > /sys/module/lpm_levels/parameters/sleep_disabled

#GPU TWEAKS;
echo "133000000" > /sys/class/devfreq/b00000.qcom,kgsl-3d0/min_freq
echo "510000000" > /sys/class/devfreq/b00000.qcom,kgsl-3d0/max_freq
echo "133000000" > /sys/class/devfreq/b00000.qcom,kgsl-3d0/cur_freq
echo "170" > /sys/class/leds/blue/max_brightness
echo "170" > /sys/class/leds/green/max_brightness
echo "170" > /sys/class/leds/lcd-backlight/max_brightness
echo "170" > /sys/class/leds/led:switch_0/max_brightness
echo "170" > /sys/class/leds/led:switch_1/max_brightness
echo "170" > /sys/class/leds/red/max_brightness

#MISC;
echo "Y" > /sys/module/mdss_fb/parameters/backlight_dimmer
echo "0" > /sys/module/sync/parameters/fsync_enabled
echo "0" > /sys/android_touch/sweep2sleep
echo "N" > /sys/module/wakeup/parameters/enable_ipa_ws
echo "N" > /sys/module/wakeup/parameters/enable_netlink_ws
echo "N" > /sys/module/wakeup/parameters/enable_netmgr_wl_ws
echo "N" > /sys/module/wakeup/parameters/enable_qcom_rx_wakelock_ws
echo "N" > /sys/module/wakeup/parameters/enable_timerfd_ws
echo "N" > /sys/module/wakeup/parameters/enable_wlan_extscan_wl_ws
echo "N" > /sys/module/wakeup/parameters/enable_wlan_wow_wl_ws
echo "N" > /sys/module/wakeup/parameters/enable_wlan_ws
echo "1" > /sys/kernel/fast_charge/force_fast_charge
echo "128" > /proc/sys/net/core/netdev_max_backlog
echo "0" > /proc/sys/net/core/netdev_tstamp_prequeue
echo "24" > /proc/sys/net/ipv4/ipfrag_time
echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control
echo "1" > /proc/sys/net/ipv4/tcp_ecn
echo "0" > /proc/sys/net/ipv4/tcp_fwmark_accept
echo "320" > /proc/sys/net/ipv4/tcp_keepalive_intvl
echo "21600" > /proc/sys/net/ipv4/tcp_keepalive_time
echo "1" > /proc/sys/net/ipv4/tcp_no_metrics_save
echo "0" > /proc/sys/net/ipv4/tcp_slow_start_after_idle
echo "48" > /proc/sys/net/ipv6/ip6frag_time
setprop debug.sf.hw 1
setprop ro.ril.power_collapse 0
setprop ro.ril.disable.power.collapse 1
setprop persist.sys.use_dithering 0
setprop wifi.supplicant_scan_interval 180
setprop power_supply.wakeup enable
setprop power.saving.mode 1
setprop ro.config.hw_power_saving 1
setprop ro.config.hw_power_saving true
setprop persist.radio.add_power_save 1

# Trim selected partitions at boot;
fstrim /data;
fstrim /cache; 
fstrim /system;

