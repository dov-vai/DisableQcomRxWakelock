# Disable qcom_rx_wakelock
Magisk module for disabling qcom_rx_wakelock.

# What does it do?
Finds all the `WCNSS_qcom_cfg.ini` files inside `/system/vendor/etc/wifi/` and adds `rx_wakelock_timeout=0` flag. Hopefully fixing the wakelock.

# Okay, and?
Useful if you are on a wireless network with lots of multicast packets (dorm, school networks for example).

# The story doesn't end there

Checking logcat I noticed a mass error spam from the system mDNS service. No surprise here, when there's a barrage of multicast packets trying to pulverize the device.

If you want to further reduce CPU time spent, here's the weapon against it.

Block all incoming packets on port `5353`, using a terminal emulator (Termux for example):
```bash
su
iptables -A INPUT -p udp --dport 5353 -j DROP
iptables -A OUTPUT -p udp --dport 5353 -j DROP
ip6tables -A INPUT -p udp --dport 5353 -j DROP
ip6tables -A OUTPUT -p udp --dport 5353 -j DROP
```
A reboot will revert these changes.

The side effect is that this will break automatic discovery (Apple Bonjour, Avahi and others) for many devices.

# 

The result is still not satisfactory, CPU cores are still staying locked on the lowest frequencies, never deep sleeping.

To be continued...
