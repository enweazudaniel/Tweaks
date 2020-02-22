#!/system/bin/sh

# Pause script execution a little for Magisk Boot Service;
sleep 60;

# System mounting tweak;
busybox mount -o remount,nosuid,nodev,noatime,nodiratime -t auto /;
busybox mount -o remount,nosuid,nodev,noatime,nodiratime -t auto /proc;
busybox mount -o remount,nosuid,nodev,noatime,nodiratime -t auto /sys;
busybox mount -o remount,nosuid,nodev,noatime,nodiratime,barrier=0,noauto_da_alloc,discard -t auto /data;
busybox mount -o remount,nodev,noatime,nodiratime,barrier=0,noauto_da_alloc,discard -t auto /system;

# Completely stop & disable performance daemon at boot;
stop performanced

# Disable sysctl.conf to prevent ROM interference
if [ -e /system/etc/sysctl.conf ]; then
  mount -o remount,rw /system;
  mv /system/etc/sysctl.conf /system/etc/sysctl.conf.bak;
  mount -o remount,ro /system;
fi;

#Cpu tweaks;
echo "sched" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "sched" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo "sched" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo "sched" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor

# CPU0;
echo "85000000" > /sys/devices/system/cpu/cpu0/cpufreq/sched/down_throttle_nsec
echo "125000" > /sys/devices/system/cpu/cpu0/cpufreq/sched/up_throttle_nsec

# CPU1;
echo "85000000" > /sys/devices/system/cpu/cpu1/cpufreq/sched/down_throttle_nsec
echo "125000" > /sys/devices/system/cpu/cpu1/cpufreq/sched/up_throttle_nsec

# CPU2;
echo "85000000" > /sys/devices/system/cpu/cpu1/cpufreq/sched/down_throttle_nsec
echo "125000" > /sys/devices/system/cpu/cpu1/cpufreq/sched/up_throttle_nsec

# CPU3;
echo "85000000" > /sys/devices/system/cpu/cpu1/cpufreq/sched/down_throttle_nsec
echo "125000" > /sys/devices/system/cpu/cpu1/cpufreq/sched/up_throttle_nsec

echo "0" > /sys/module/msm_performance/parameters/touchboost 
echo "1" > /sys/module/msm_thermal/core_control/enabled 
echo "1" > /sys/devices/system/cpu/cpuidle/use_deepest_state
chmod 644 /sys/module/workqueue/parameters/power_efficient
echo Y > /sys/module/workqueue/parameters/power_efficient
echo "0" > /sys/module/lpm_levels/parameters/sleep_disabled

#GPU TWEAKS;
echo "133000000" > /sys/class/devfreq/5000000.qcom,kgsl-3d0/min_freq
echo "510000000" > /sys/class/devfreq/5000000.qcom,kgsl-3d0/max_freq
echo "133000000" > /sys/class/devfreq/5000000.qcom,kgsl-3d0/target_freq

# Decrease both battery as well as power consumption that is being caused by the screen by lowering how much light the pixels, the built-in LED switches and the LCD backlight module is releasing & "kicking out" by carefully tuning / adjusting their maximum values a little bit to the balanced overall range of their respective spectrums;
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

# Network tweaks for slightly reduced battery consumption when being "actively" connected to a network connection;
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

busybox killall -9 com.google.android.gms
busybox killall -9 com.google.android.gms.persistent
busybox killall -9 com.google.process.gapps
busybox killall -9 com.google.android.gsf
busybox killall -9 com.google.android.gsf.persistent

#Activating battery improvements;
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

# Trim selected partitions at boot for a more than well-deserved and nice speed boost;
fstrim /data;
fstrim /cache; 
fstrim /system;

# Script log file location
LOG_FILE=/storage/emulated/0/logs

export TZ=$(getprop persist.sys.timezone);
echo $(date) > /storage/emulated/0/logs/enweazudaniel@XDA.log
if [ $? -eq 0 ]
then
  echo "enweazudaniel@XDA have been more than just successfully executed. Enjoy!" >> /storage/emulated/0/logs/enweazudaniel@XDA.log
  exit 0
else
  echo "enweazudaniel@XDA have for some strange and unforeseen reasons failed, so lets try again and please, do it right this time!" >> /storage/emulated/0/logs/enweazudaniel@XDA.log
  exit 1
fi
  
# Wait..
# Done!
#