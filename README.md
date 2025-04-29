# Disable qcom_rx_wakelock
Magisk module for disabling qcom_rx_wakelock.

# What does it do?
Finds all the `WCNSS_qcom_cfg.ini` files inside `/system/vendor/etc/wifi/` and adds `rx_wakelock_timeout=0` flag. Hopefully fixing the wakelock.

# Okay, and?
Useful if you are on a wireless network with lots of multicast packets (dorm, school networks for example).

Instantly added at least 2 hours of screen on time on my device.
