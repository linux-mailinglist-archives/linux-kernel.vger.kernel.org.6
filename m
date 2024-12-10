Return-Path: <linux-kernel+bounces-438961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA869EA8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A895D169C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8F114A0AA;
	Tue, 10 Dec 2024 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="iblAMyVh"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FBD22B8D9;
	Tue, 10 Dec 2024 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733812220; cv=none; b=ZAhgIIcLrXjc2QnjC5F03LZ3as37M5fB4/kNqEXWNrH+BYvviBgdzUNZzLKfhYbYV0ogKKkzkEfu2nD5v5mA0qYMSSkxBDrWwl3t3iD9CB43eRFmZ45zYoknYbTkXP30nmJLTa7WpY0obFM64RJh9Y/xKs6uwwxfz18bo4RsP7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733812220; c=relaxed/simple;
	bh=y/eBCOsebP47ZnZmE1l3ZnQBC+tsAE8GLq5L1usGhkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oKvzlTQVw3yj5HU3JFjpVkJbGw9x2LeYXE7CdgyLkH+dK9AjQBlO+5l2X8UWN9i8qFwy/DRSefGeS24WNy1/CniT2p2fJ/j4YVuZZTbx23YC6iyP9OAotN/yGSmAS/+CYcH68BLP14FeW+raZza6yDELaR3Z4P6BAxlSb2J47Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=iblAMyVh; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733812175; x=1734416975; i=w_armin@gmx.de;
	bh=IjX+gNymmv1IxRQxtiK4GpLZWso+s9nv44bl95t56Mk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iblAMyVhApwyxpTb+fEjkKmahovVUMtfDd8CqzTyeDo3LSCIDCmWr/KPcH0+PniQ
	 8Hyn6fBwEJLZlU5fvGaJS3/eAzwvESTD4JBnWK+xL/K7iNXGxsrSoVWbJehbI1pJV
	 T9b0KESwTj2i+Qpr9JJUgSXJK8unzaeKMYC6nuSTx9vExR4zxUyFAmCz9w/zFE3Ff
	 hsTgV9O423mMcIEVLk8J6+MIh8K609JV1kuBSbh/rrn62ekD7G9jc3I822q391rie
	 j+1AI01N8qqsy3u08NsB35LqvRa3ZLtjtENWwiz4fqMBoP2MnMYGqVWIBWEqUMESe
	 +Rxf6nyNSgmdyZ3mlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv31W-1tcI2g2cXw-014cEc; Tue, 10
 Dec 2024 07:29:34 +0100
Message-ID: <53c5075b-1967-45d0-937f-463912dd966d@gmx.de>
Date: Tue, 10 Dec 2024 07:29:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: samsung-galaxybook: Add samsung-galaxybook
 driver
To: Joshua Grisham <josh@joshuagrisham.com>, ilpo.jarvinen@linux.intel.com,
 hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241209163720.17597-1-josh@joshuagrisham.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241209163720.17597-1-josh@joshuagrisham.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4pOb0xgfErEhSmUeoF2da/L0C6fCe5zNBopAGGsjxdmVvp2RVv7
 9j5Vnio6ua0YS76aNHhLikvNQT+iYBaOT5AOSjLVMRUDtktxtTFvGaJw5XgWjGVNAsjpohv
 RbE0xMbUuPSBgFbbn738CKY0lcxYV7PlXFjAWx5Gd8vFVU2ObBAA9A3osH/wQJbQH7kB1RH
 h3J2xKnWWoJP34fimCAFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LYs8Nz/ZQyw=;ETgSadY9N8LGpi7VHa+Go3+TJf/
 Vb69GrBgoANgF7ER+7jxUsGHZJ7vz7w7dey4F10tqesJPJcnD3kayR2Z59lmLwAo/KTJfY/Bx
 7KIwmB50Bv6ZuaSrcu3f+mpKe7Hk6hYfgb1zJIo77v2xW9NvoAFnGOw772QNb4RhKcCndF6JT
 XlV3iO9q4s+apkv/HBBZRJlBncHujWKw57bjBKsu56fIwkh9E/ySAqmZYnX2QhBU6f9gZ9Fpi
 8kv+NQnx5izMIvXNKNW+TuT0bCm+dPn6Q6Oo41oYqtIj5jiQkwZPfl69D0NYOZEmFuGfxRonp
 0ZTFddF3wPggi6+lj2FX/M0P5Vs4WVtYiAG+SFg1ebx4l4wpDowSjPbpq8qTTjBTsSrkm9V0x
 M/3fkLXRY7E9Um9p0HcUvSk67rrJD0lovIYa45O4mawqDw+jJRwAbrWr+3RTQSG90zL2jRclf
 iZtH4OG4KQE+D82lzEnpz4V+Tfz1fDaP1sUw4pTMV3Hwas9Z+30dRuVwDeWZtwSktY/MyhB5H
 bPN88a4b4SFoyZNcJTzLs6hZtyK4LvzuCdWf7fVM2gPjC85sdf5WRHe8VSgbTJe54NJHQJPAD
 ZXFTVA7iAqD1e17FvfYHNFMa/k2X5MLX7pvyxXe1UQdgyPJzGOP1cBqx59bT3TN3ER47vvPT8
 1hTxeWGOk9lfERH3pf6eGLvTl17EKZIag8WxxPqauAYcg2/KzQP2O2W5eiB/rJ74IXYNcUzPw
 F1ZfeUytcByKHXD4SaX8CXcATObqMTx3gZm3tT0nIrXvIM2sGlAkRqCm9J0yKCFjlgmgePhX5
 inNhYjpPXrp9o31IBLXIr9KnzG75Q8h7Ny7IBtqabQNiQMIYuz4Bdaj4o+L6kOgiDOk/Gm9Go
 PMnPe6XltjJkk6713ElvOw1pZZkIrmicVEh5pbWCUhdoDIRBo8DYFX+5yuMptNf7ILfjrc46y
 F8Eu7ikJcdXMUIS4u/kC2EspTQphVpUhK034aNG250iyx44mhEb3Tp/JK/VZNColiUubjBgQT
 MAxrR5oLbahYsLFTWbXWV9LgZe72oam18oJE3LrxEY1iH4qU5NV6mDRO+3Rmsl4jcA4kuiPd5
 7lTM/U1qr0T6sRM8WXrrU/W4PPanLz

Am 09.12.24 um 17:37 schrieb Joshua Grisham:

> This patch will add a new driver for Samsung Galaxy Book series notebook
> devices. This should hopefully include all suggestions from my original
> mailing list feedback thread [1], as well as a first version for
> associated updates to the documentation, Kconfig, Makefile, and the
> MAINTAINERS file related to this new driver.
>
> I have tested the driver both using m and y in the config, as well as
> with various other options mentioned in the patch checklist of the
> documentation.
>
> Other users with other device IDs have also tested successfully using
> a version of these same driver updates which I have maintained in a
> separate branch of my GitHub repository [2].
>
> I have made an attempt with the coding style to find a balance between w=
hat
> is written in the kernel documentation and what actually exists in curre=
nt
> x86 platform drivers, but any feedback on this (or anything else) is
> certainly welcome!

Nice, this might finally fix https://bugzilla.kernel.org/show_bug.cgi?id=
=3D217143.

> [1]: https://lore.kernel.org/platform-driver-x86/CAMF+KeYus9dW00WNJMLVxL=
LHdG9JgCfrGJ491fu7NM8GAEqqCg@mail.gmail.com/
> [2]: https://github.com/joshuagrisham/samsung-galaxybook-extras/pull/44
>
> Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
> ---
>   Documentation/admin-guide/laptops/index.rst   |    1 +
>   .../laptops/samsung-galaxybook.rst            |  301 +++
>   MAINTAINERS                                   |    6 +
>   drivers/platform/x86/Kconfig                  |   19 +
>   drivers/platform/x86/Makefile                 |    5 +-
>   drivers/platform/x86/samsung-galaxybook.c     | 1972 +++++++++++++++++
>   6 files changed, 2302 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/admin-guide/laptops/samsung-galaxyboo=
k.rst
>   create mode 100644 drivers/platform/x86/samsung-galaxybook.c
>
> diff --git a/Documentation/admin-guide/laptops/index.rst b/Documentation=
/admin-guide/laptops/index.rst
> index cd9a1c269..e71c8984c 100644
> --- a/Documentation/admin-guide/laptops/index.rst
> +++ b/Documentation/admin-guide/laptops/index.rst
> @@ -11,6 +11,7 @@ Laptop Drivers
>      disk-shock-protection
>      laptop-mode
>      lg-laptop
> +   samsung-galaxybook
>      sony-laptop
>      sonypi
>      thinkpad-acpi
> diff --git a/Documentation/admin-guide/laptops/samsung-galaxybook.rst b/=
Documentation/admin-guide/laptops/samsung-galaxybook.rst
> new file mode 100644
> index 000000000..ab12f0001
> --- /dev/null
> +++ b/Documentation/admin-guide/laptops/samsung-galaxybook.rst
> @@ -0,0 +1,301 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Samsung Galaxy Book Extras
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +December 9, 2024
> +
> +Joshua Grisham <josh@joshuagrisham.com>
> +
> +This is a Linux x86 platform driver for Samsung Galaxy Book series note=
book
> +devices which utilizes Samsung's ``SCAI`` ACPI device in order to contr=
ol
> +extra features and receive various notifications.
> +
> +
> +Supported devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +"SAMSUNG ELECTRONICS CO., LTD." devices of type "Notebook" which have o=
ne of the
> +supported ACPI device IDs should be supported. This covers most of the =
"Samsung
> +Galaxy Book" series notebooks that are currently available as of this w=
riting,
> +and could include other Samsung notebook devices as well.
> +
> +
> +Status
> +=3D=3D=3D=3D=3D=3D
> +
> +The following features are currently supported:
> +
> +- :ref:`Keyboard backlight <keyboard-backlight>` control
> +- :ref:`Performance mode <performance-mode>` control implemented using =
the
> +  platform profile interface
> +- :ref:`Battery charge control end threshold
> +  <battery-charge-control-end-threshold>` (stop charging battery at giv=
en
> +  percentage value) implemented as a battery device extension
> +- :ref:`Fan speed <fan-speed>` monitoring via ``fan_speed_rpm`` sysfs a=
ttribute
> +  plus a new hwmon device
> +- :ref:`Settings Attributes <settings-attributes>` to allow control of =
various
> +  device settings
> +- :ref:`Handling of Fn hotkeys <keyboard-hotkey-actions>` for various a=
ctions
> +
> +Because different models of these devices can vary in their features, t=
here is
> +logic built within the driver which attempts to test each implemented f=
eature
> +for a valid response before enabling its support (registering additiona=
l devices
> +or extensions, adding sysfs attributes, etc). Therefore, it can be impo=
rtant to
> +note that not all features may be supported for your particular device.
> +
> +The following features might be possible to implement but will require
> +additional investigation and are therefore not supported at this time:
> +
> +- "Dolby Atmos" mode for the speakers
> +- "Outdoor Mode" for increasing screen brightness on models with ``SAM0=
427``
> +- "Silent Mode" on models with ``SAM0427``
> +
> +
> +Parameters
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The driver includes a list of boolean parameters that allow for manuall=
y
> +enabling or disabling various features:
> +
> +- ``kbd_backlight``: Enable Keyboard Backlight control (default on)
> +- ``performance_mode``: Enable Performance Mode control (default on)
> +- ``battery_threshold``: Enable battery charge threshold control (defau=
lt on)
> +- ``fan_speed``: Enable fan speed (default on)
> +- ``allow_recording``: Enable control to allow or block access to camer=
a and
> +  microphone (default on)
> +- ``i8042_filter``: Enable capture and execution of keyboard-based hotk=
ey events
> +  (default on)
> +
> +.. note::
> +  Even if you explicitly try to enable a feature using its parameter, s=
upport
> +  for it will still be evaluated by the driver, and the feature will be
> +  disabled if it does not appear to be supported on your device.
> +
> +The availability of various sysfs file-based "settings" attributes
> +(``usb_charge``, ``start_on_lid_open``, etc) will be determined automat=
ically
> +and cannot be manually disabled at this time.
> +
> +
> +.. _keyboard-backlight:
> +
> +Keyboard backlight
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controlled by parameter: ``kbd_backlight``
> +
> +A new LED class named ``samsung-galaxybook::kbd_backlight`` is created =
which
> +will then expose the device using the standard sysfs-based LED interfac=
e at
> +``/sys/class/leds/samsung-galaxybook::kbd_backlight``. Brightness can b=
e
> +controlled by writing values 0 to 3 to the ``brightness`` sysfs attribu=
te or
> +with any other desired userspace utility.
> +
> +.. note::
> +  Most of these devices have an ambient light sensor which also turns
> +  off the keyboard backlight under well-lit conditions. This behavior d=
oes not
> +  seem possible to control at this time, but can be good to be aware of=
.
> +
> +
> +.. _performance-mode:
> +
> +Performance mode
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controlled by parameter: ``performance_mode``
> +
> +This driver implements the
> +Documentation/userspace-api/sysfs-platform_profile.rst interface for wo=
rking
> +with the "performance mode" function of the Samsung ACPI device.
> +
> +Mapping of each Samsung "performance mode" to its respective platform p=
rofile is
> +done dynamically based on a list of the supported modes reported by the=
 device
> +itself. Preference is given to always try and map ``low-power``, ``bala=
nced``,
> +and ``performance`` profiles, as these seem to be the most common profi=
les
> +utilized (and sometimes even required) by various userspace tools.
> +
> +The result of the mapping will be printed in the kernel log when the mo=
dule is
> +loaded. Supported profiles can also be retrieved from
> +``/sys/firmware/acpi/platform_profile_choices``, while
> +``/sys/firmware/acpi/platform_profile`` can be used to read or write th=
e
> +currently selected profile.
> +
> +The ``balanced`` platform profile will be set during module load if no =
profile
> +has been previously set.
> +
> +
> +.. _battery-charge-control-end-threshold:
> +
> +Battery charge control end threshold
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controlled by parameter: ``battery_threshold``
> +
> +This platform driver will add the ability to set the battery's charge c=
ontrol
> +end threshold, but does not have the ability to set a start threshold.
> +
> +This feature is typically called "Battery Saver" by the various Samsung
> +applications in Windows, but in Linux we have implemented the standardi=
zed
> +"charge control threshold" sysfs interface on the battery device to all=
ow for
> +controlling this functionality from the userspace.
> +
> +The sysfs attribute
> +``/sys/class/power_supply/BAT1/charge_control_end_threshold`` can be us=
ed to
> +read or set the desired charge end threshold.
> +
> +If you wish to maintain interoperability with Windows, then you should =
set the
> +value to 80 to represent "on", or 0 to represent "off", as these are th=
e values
> +currently recognized by the various Windows-based Samsung applications =
and
> +services as "on" or "off". Otherwise, the device will accept any value =
between 0
> +(off) and 99 as the percentage that you wish the battery to stop chargi=
ng at.
> +
> +.. note::
> +  If you try to set a value of 100, the driver will also accept this in=
put, but
> +  will set the attribute value to 0 (i.e. 100% will "remove" the end th=
reshold).
> +
> +
> +.. _fan-speed:
> +
> +Fan speed
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controlled by parameter: ``fan_speed``
> +
> +The number and type of fans on these devices can vary, and different me=
thods
> +must be used in order to be able to successfully read their status.
> +
> +In cases where Samsung has implemented the standard ACPI method ``_FST`=
` for a
> +fan device, the other methods in the ACPI specification which would cau=
se
> +the kernel to automatically add the ``fan_speed_rpm`` attribute are not=
 always
> +present. On top of this, it seems that there are some bugs in the firmw=
are that
> +throw an exception when the ``_FST`` method is executed.
> +
> +This platform driver attempts to resolve all PNP fans that are present =
in the
> +ACPI of supported devices, and add support for reading their speed usin=
g the
> +following decision tree:
> +
> +1. Do all 4 required methods exist so that the fan speed should be repo=
rted
> +   out-of-the-box by ACPI? If yes, then assume this fan is already set =
up and
> +   available.
> +
> +2. Does the method ``_FST`` exist and appears to be working (returns a =
speed
> +   value greater than 0)? If yes, add an attribute ``fan_speed_rpm`` to=
 this fan
> +   device and add a fan input channel for it to the hwmon device. The r=
eturned
> +   value will be directly read from the ``_FST`` method.
> +
> +3. Does the field ``FANS`` (fan speed level) exist on the embedded cont=
roller,
> +   and the table ``FANT`` (fan speed level table) exist on the fan devi=
ce? If
> +   yes, add the ``fan_speed_rpm`` attribute to this fan device and add =
a fan
> +   input channel for it to the hwmon device. The returned value will be=
 based
> +   on a match of the current value of ``FANS`` compared to a list of le=
vel
> +   speeds from the ``FANT`` table.
> +
> +The fan speed for all supported fans can be monitored using hwmon senso=
rs or by
> +reading the ``fan_speed_rpm`` sysfs attribute of each fan device.
> +
> +
> +.. _settings-attributes:
> +
> +Settings Attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Various hardware settings can be controlled by the following sysfs attr=
ibutes:
> +
> +- ``allow_recording`` (allows or blocks usage of built-in camera and mi=
crophone)
> +- ``start_on_lid_open`` (power on automatically when opening the lid)
> +- ``usb_charge`` (allows USB ports to provide power even when device is=
 off)
> +
> +These attributes will be available under the path for your supported AC=
PI Device
> +ID's platform device (``SAM0428``, ``SAM0429``, etc), and can most reli=
ably
> +be found by seeing which device has been bound to the ``samsung-galaxyb=
ook``
> +driver. Here are some examples: ::
> +
> +  # find which device ID has been bound to the driver
> +  ls /sys/bus/platform/drivers/samsung-galaxybook/ | grep SAM
> +
> +  # see SAM0429 attributes
> +  ls /sys/bus/platform/drivers/samsung-galaxybook/SAM0429\:00
> +
> +  # see attributes no matter the device ID (using wildcard expansion)
> +  ls /sys/bus/platform/drivers/samsung-galaxybook/SAM*
> +
> +Most shells should support using wildcard expansion to directly read an=
d write
> +these attributes using the above pattern. Example: ::
> +
> +  # read value of start_on_lid_open
> +  cat /sys/bus/platform/drivers/samsung-galaxybook/SAM*/start_on_lid_op=
en
> +
> +  # turn on start_on_lid_open
> +  echo true | sudo tee /sys/bus/platform/drivers/samsung-galaxybook/SAM=
*/start_on_lid_open
> +
> +It is also possible to use a udev rule to create a fixed-path symlink t=
o your
> +device under ``/dev`` (e.g. ``/dev/samsung-galaxybook``), no matter the=
 device
> +ID, to further simplify reading and writing these attributes in the use=
rspace.
> +
> +Allow recording (allow_recording)
> +---------------------------------
> +
> +``/sys/bus/platform/drivers/samsung-galaxybook/SAM*/allow_recording``
> +
> +Controlled by parameter: ``allow_recording``
> +
> +Controls the "Allow recording" setting, which allows or blocks usage of=
 the
> +built-in camera and microphone (boolean).
> +
> +Start on lid open (start_on_lid_open)
> +-------------------------------------
> +
> +``/sys/bus/platform/drivers/samsung-galaxybook/SAM*/start_on_lid_open``
> +
> +Controls the "Start on lid open" setting, which sets the device to powe=
r on
> +automatically when the lid is opened (boolean).
> +
> +USB charge (usb_charge)
> +-----------------------
> +
> +``/sys/bus/platform/drivers/samsung-galaxybook/SAM*/usb_charge``
> +
> +Controls the "USB charge" setting, which allows USB ports to provide po=
wer even
> +when the device is turned off (boolean).
> +
> +.. note::
> +  For most devices, this setting seems to only apply to the USB-C ports=
.
> +
> +
> +.. _keyboard-hotkey-actions:
> +
> +Keyboard hotkey actions (i8042 filter)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controlled by parameter: ``i8042_filter``
> +
> +The i8042 filter will swallow the keyboard events for the Fn+F9 hotkey =
(Multi-
> +level keyboard backlight toggle) and Fn+F10 hotkey (Allow/block recordi=
ng
> +toggle) and instead execute their actions within the driver itself.
> +
> +Fn+F9 will cycle through the brightness levels of the keyboard backligh=
t. A
> +notification will be sent using ``led_classdev_notify_brightness_hw_cha=
nged``
> +so that the userspace can be aware of the change. This mimics the behav=
ior of
> +other existing devices where the brightness level is cycled internally =
by the
> +embedded controller and then reported via a notification.
> +
> +Fn+F10 will toggle the value of the "Allow recording" setting.
> +
> +
> +ACPI notifications and ACPI hotkey actions
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +There is a new "Samsung Galaxy Book extra buttons" input device created=
 which
> +will send input events for the following notifications from the ACPI de=
vice:
> +
> +- Notification when the battery charge control end threshold has been r=
eached
> +  and the "battery saver" feature has stopped the battery from charging
> +- Notification when the device has been placed on a table (not availabl=
e on all
> +  models)
> +- Notification when the device has been lifted from a table (not availa=
ble on
> +  all models)
> +
> +The Fn+F11 Performance mode hotkey is received as an ACPI notification.=
 It will
> +be handled in a similar way as the Fn+F9 and Fn+F10 hotkeys; namely, th=
at the
> +keypress will be swallowed by the driver and each press will cycle to t=
he next
> +available platform profile.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3809931b9..21b4fc504 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20733,6 +20733,12 @@ L:	linux-fbdev@vger.kernel.org
>   S:	Maintained
>   F:	drivers/video/fbdev/s3c-fb.c
>
> +SAMSUNG GALAXY BOOK EXTRAS DRIVER
> +M:	Joshua Grisham <josh@joshuagrisham.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/samsung-galaxybook.c
> +
>   SAMSUNG INTERCONNECT DRIVERS
>   M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
>   M:	Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879..b6d28b6a4 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -778,6 +778,25 @@ config BARCO_P50_GPIO
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called barco-p50-gpio.
>
> +config SAMSUNG_GALAXYBOOK
> +	tristate "Samsung Galaxy Book extras driver"
> +	depends on ACPI
> +	depends on ACPI_BATTERY
> +	depends on INPUT
> +	depends on SERIO_I8042
> +	depends on HWMON || HWMON =3D n

Please just use "depends on HWMON" here, see the hwmon part for more detai=
ls.

> +	select ACPI_PLATFORM_PROFILE
> +	select INPUT_SPARSEKMAP
> +	select NEW_LEDS
> +	select LEDS_CLASS
> +	help
> +	  This is a driver for Samsung Galaxy Book series notebooks. It adds
> +	  support for the keyboard backlight control, performance mode control=
, fan
> +	  speed reporting, function keys, and various other device controls.
> +
> +	  For more information about this driver, see
> +	  <file:Documentation/admin-guide/laptops/samsung-galaxybook.rst>.
> +
>   config SAMSUNG_LAPTOP
>   	tristate "Samsung Laptop driver"
>   	depends on RFKILL || RFKILL =3D n
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index e1b142947..32ec4cb9d 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -95,8 +95,9 @@ obj-$(CONFIG_PCENGINES_APU2)	+=3D pcengines-apuv2.o
>   obj-$(CONFIG_BARCO_P50_GPIO)	+=3D barco-p50-gpio.o
>
>   # Samsung
> -obj-$(CONFIG_SAMSUNG_LAPTOP)	+=3D samsung-laptop.o
> -obj-$(CONFIG_SAMSUNG_Q10)	+=3D samsung-q10.o
> +obj-$(CONFIG_SAMSUNG_GALAXYBOOK)	+=3D samsung-galaxybook.o
> +obj-$(CONFIG_SAMSUNG_LAPTOP)		+=3D samsung-laptop.o
> +obj-$(CONFIG_SAMSUNG_Q10)		+=3D samsung-q10.o
>
>   # Toshiba
>   obj-$(CONFIG_TOSHIBA_BT_RFKILL)	+=3D toshiba_bluetooth.o
> diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platfor=
m/x86/samsung-galaxybook.c
> new file mode 100644
> index 000000000..ce8b76d91
> --- /dev/null
> +++ b/drivers/platform/x86/samsung-galaxybook.c
> @@ -0,0 +1,1972 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Samsung Galaxy Book series extras driver
> + *
> + * Copyright (c) 2024 Joshua Grisham <josh@joshuagrisham.com>
> + *
> + * With contributions to the SCAI ACPI device interface:
> + * Copyright (c) 2024 Giulio Girardi <giulio.girardi@protechgroup.it>
> + *
> + * Implementation inspired by existing x86 platform drivers.
> + * Thank you to the authors!
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/i8042.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/nls.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
> +#include <linux/serio.h>
> +#include <linux/workqueue.h>
> +#include <acpi/battery.h>
> +
> +#define SAMSUNG_GALAXYBOOK_CLASS  "samsung-galaxybook"

Please call this define "DRIVER_NAME".

> +#define SAMSUNG_GALAXYBOOK_NAME   "Samsung Galaxy Book Extras"

This is only used once, maybe omit this define and use this string directl=
y?

> +
> +/*
> + * Module parameters
> + */
> +
> +static bool kbd_backlight =3D true;
> +static bool battery_threshold =3D true;
> +static bool performance_mode =3D true;
> +static bool allow_recording =3D true;
> +static bool fan_speed =3D true;
> +static bool i8042_filter =3D true;
> +
> +module_param(kbd_backlight, bool, 0644);
> +MODULE_PARM_DESC(kbd_backlight, "Enable Keyboard Backlight control (def=
ault on)");
> +module_param(battery_threshold, bool, 0644);
> +MODULE_PARM_DESC(battery_threshold, "Enable battery charge threshold co=
ntrol (default on)");
> +module_param(performance_mode, bool, 0644);
> +MODULE_PARM_DESC(performance_mode, "Enable Performance Mode control (de=
fault on)");
> +module_param(allow_recording, bool, 0644);
> +MODULE_PARM_DESC(allow_recording,
> +		 "Enable control to allow or block access to camera and microphone (d=
efault on)");
> +module_param(fan_speed, bool, 0644);
> +MODULE_PARM_DESC(fan_speed, "Enable fan speed (default on)");
> +module_param(i8042_filter, bool, 0644);
> +MODULE_PARM_DESC(i8042_filter, "Enable capturing keyboard hotkey events=
 (default on)");

Is there a reason why those module params have a visibility of 0644? If no=
t, then please change it to 0.

> +
> +/*
> + * Device definitions and matching
> + */
> +
> +static const struct acpi_device_id galaxybook_device_ids[] =3D {
> +	{ "SAM0427" },
> +	{ "SAM0428" },
> +	{ "SAM0429" },
> +	{ "SAM0430" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, galaxybook_device_ids);
> +
> +static const struct dmi_system_id galaxybook_dmi_ids[] =3D {
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
> +			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
> +		},
> +	},
> +	{}
> +};

Since you already use the ACPI ids, i suggest that you drop this DMI check=
.

> +
> +struct galaxybook_fan {
> +	struct acpi_device fan;
> +	char *description;
> +	bool supports_fst;
> +	unsigned int *fan_speeds;
> +	int fan_speeds_count;
> +	struct dev_ext_attribute fan_speed_rpm_ext_attr;
> +};
> +
> +#define MAX_FAN_COUNT 5
> +
> +struct samsung_galaxybook {
> +	struct platform_device *platform;
> +	struct acpi_device *acpi;
> +
> +	struct led_classdev kbd_backlight;
> +	struct work_struct kbd_backlight_hotkey_work;
> +
> +	struct input_dev *input;
> +	struct key_entry *keymap;
> +
> +	u8 *profile_performance_modes;
> +	struct platform_profile_handler profile_handler;
> +	struct work_struct performance_mode_hotkey_work;
> +
> +	struct work_struct allow_recording_hotkey_work;
> +
> +	struct galaxybook_fan fans[MAX_FAN_COUNT];
> +	int fans_count;
> +
> +#if IS_ENABLED(CONFIG_HWMON)
> +	struct device *hwmon;
> +#endif
> +};
> +static struct samsung_galaxybook *galaxybook_ptr;

Please use the state container pattern (https://www.kernel.org/doc/html/la=
test/driver-api/driver-model/design-patterns.html) instead of
having this global variable. The reason for this is that this will break b=
adly should this driver somehow get instantiated multiple times.

> +
> +struct sawb {
> +	u16 safn;
> +	u16 sasb;
> +	u8 rflg;
> +	union {
> +		struct {
> +			u8 gunm;
> +			u8 guds[250];
> +		};
> +		struct {
> +			u8 caid[16];
> +			u8 fncn;
> +			u8 subn;
> +			u8 iob0;
> +			u8 iob1;
> +			u8 iob2;
> +			u8 iob3;
> +			u8 iob4;
> +			u8 iob5;
> +			u8 iob6;
> +			u8 iob7;
> +			u8 iob8;
> +			u8 iob9;
> +		};
> +		struct {
> +			u8 iob_prefix[18];
> +			u8 iob_values[10];
> +		};
> +	};
> +};
> +
> +#define SAWB_LEN_SETTINGS         0x15
> +#define SAWB_LEN_PERFORMANCE_MODE 0x100
> +
> +#define SAFN  0x5843
> +
> +#define SASB_KBD_BACKLIGHT     0x78
> +#define SASB_POWER_MANAGEMENT  0x7a
> +#define SASB_USB_CHARGE_GET    0x67
> +#define SASB_USB_CHARGE_SET    0x68
> +#define SASB_NOTIFICATIONS     0x86
> +#define SASB_ALLOW_RECORDING   0x8a
> +#define SASB_PERFORMANCE_MODE  0x91
> +
> +#define SAWB_RFLG_POS  4
> +#define SAWB_GUNM_POS  5
> +
> +#define RFLG_SUCCESS  0xaa
> +#define GUNM_FAIL     0xff
> +
> +#define GUNM_FEATURE_ENABLE          0xbb
> +#define GUNM_FEATURE_ENABLE_SUCCESS  0xdd
> +#define GUDS_FEATURE_ENABLE          0xaa
> +#define GUDS_FEATURE_ENABLE_SUCCESS  0xcc
> +
> +#define GUNM_GET  0x81
> +#define GUNM_SET  0x82
> +
> +#define GUNM_POWER_MANAGEMENT  0x82
> +
> +#define GUNM_USB_CHARGE_GET              0x80
> +#define GUNM_USB_CHARGE_ON               0x81
> +#define GUNM_USB_CHARGE_OFF              0x80
> +#define GUDS_START_ON_LID_OPEN           0xa3
> +#define GUDS_START_ON_LID_OPEN_GET       0x81
> +#define GUDS_START_ON_LID_OPEN_SET       0x80
> +#define GUDS_BATTERY_CHARGE_CONTROL      0xe9
> +#define GUDS_BATTERY_CHARGE_CONTROL_GET  0x91
> +#define GUDS_BATTERY_CHARGE_CONTROL_SET  0x90
> +#define GUNM_ACPI_NOTIFY_ENABLE          0x80
> +#define GUDS_ACPI_NOTIFY_ENABLE          0x02
> +
> +#define FNCN_PERFORMANCE_MODE       0x51
> +#define SUBN_PERFORMANCE_MODE_LIST  0x01
> +#define SUBN_PERFORMANCE_MODE_GET   0x02
> +#define SUBN_PERFORMANCE_MODE_SET   0x03
> +
> +/* guid 8246028d-8bca-4a55-ba0f-6f1e6b921b8f */
> +static const guid_t performance_mode_guid_value =3D
> +	GUID_INIT(0x8246028d, 0x8bca, 0x4a55, 0xba, 0x0f, 0x6f, 0x1e, 0x6b, 0x=
92, 0x1b, 0x8f);
> +#define PERFORMANCE_MODE_GUID performance_mode_guid_value
> +
> +#define PERFORMANCE_MODE_ULTRA               0x16
> +#define PERFORMANCE_MODE_PERFORMANCE         0x15
> +#define PERFORMANCE_MODE_SILENT              0xb
> +#define PERFORMANCE_MODE_QUIET               0xa
> +#define PERFORMANCE_MODE_OPTIMIZED           0x2
> +#define PERFORMANCE_MODE_PERFORMANCE_LEGACY  0x1
> +#define PERFORMANCE_MODE_OPTIMIZED_LEGACY    0x0
> +#define PERFORMANCE_MODE_UNKNOWN             0xff
> +
> +#define DEFAULT_PLATFORM_PROFILE PLATFORM_PROFILE_BALANCED
> +
> +#define ACPI_METHOD_ENABLE           "SDLS"
> +#define ACPI_METHOD_ENABLE_ON        1
> +#define ACPI_METHOD_ENABLE_OFF       0
> +#define ACPI_METHOD_SETTINGS         "CSFI"
> +#define ACPI_METHOD_PERFORMANCE_MODE "CSXI"
> +
> +#define ACPI_FAN_DEVICE_ID    "PNP0C0B"
> +#define ACPI_FAN_SPEED_LIST   "FANT"
> +#define ACPI_FAN_SPEED_VALUE  "\\_SB.PC00.LPCB.H_EC.FANS"

Looking at the fan device, it seems that it only supports the _FST ACPI 4 =
method and is thus being treated
like a ACPI 1.0 fan device by the fan driver.

According to https://learn.microsoft.com/de-de/windows-hardware/design/dev=
ice-experiences/design-guide,
Windows seems to only support the _FST method, so that might be the reason=
 why the other (mandatory)
ACPI methods seem to be missing.

I think we should rather extend the ACPI fan driver to handle this case. P=
lease remove the fan-related code
from the driver and talk to the maintainers of the ACPI fan driver instead=
.

> +
> +#define KBD_BACKLIGHT_MAX_BRIGHTNESS  3
> +
> +#define ACPI_NOTIFY_BATTERY_STATE_CHANGED    0x61
> +#define ACPI_NOTIFY_DEVICE_ON_TABLE          0x6c
> +#define ACPI_NOTIFY_DEVICE_OFF_TABLE         0x6d
> +#define ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE  0x70
> +
> +#define GB_KEY_KBD_BACKLIGHT_KEYDOWN    0x2c
> +#define GB_KEY_KBD_BACKLIGHT_KEYUP      0xac
> +#define GB_KEY_ALLOW_RECORDING_KEYDOWN  0x1f
> +#define GB_KEY_ALLOW_RECORDING_KEYUP    0x9f
> +
> +static const struct key_entry galaxybook_acpi_keymap[] =3D {
> +	{ KE_KEY, ACPI_NOTIFY_BATTERY_STATE_CHANGED,   { KEY_BATTERY } },
> +	{ KE_KEY, ACPI_NOTIFY_DEVICE_ON_TABLE,         { KEY_F14 } },
> +	{ KE_KEY, ACPI_NOTIFY_DEVICE_OFF_TABLE,        { KEY_F15 } },
> +	{ KE_KEY, ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE, { KEY_UNKNOWN } },

Can you explain what the original purpose of those ACPI events is? Also if=
 you
already handle ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE the associated key mapp=
ing
is unnecessary.

> +	{ KE_END, 0 },
> +};
> +
> +/*
> + * ACPI method handling
> + */
> +
> +#define pr_debug_prefixed(...) pr_debug("[DEBUG] " __VA_ARGS__)

Maybe dev_dbg() is more suitable here?

> +
> +#define print_acpi_object_buffer_debug(header_str, buf_ptr, buf_len)	\
> +	do {								\
> +		pr_debug_prefixed("%s\n", header_str);			\
> +		print_hex_dump_debug("samsung_galaxybook: [DEBUG]   ",	\
> +				     DUMP_PREFIX_NONE, 16, 1, buf_ptr,	\
> +				     buf_len, false);			\
> +	} while (0)
> +

Please remove this, it would make the driver very noisy when enabled. You =
can either
use the linux tracepoint infrastructure for that or create a debugfs inter=
face.

Those things however are entirely optional, but please remove this debug m=
acro.

> +static char *get_acpi_device_description(struct acpi_device *acpi_dev)
> +{
> +	struct acpi_buffer str_buf =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *str_obj;
> +	struct acpi_buffer name_buf =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status status;
> +	int result;
> +
> +	/* first try to get value of _STR (and also convert it to utf8)  */
> +	if (!acpi_has_method(acpi_dev->handle, "_STR"))
> +		goto use_name;
> +	status =3D acpi_evaluate_object_typed(acpi_dev->handle, "_STR", NULL,
> +					   &str_buf, ACPI_TYPE_BUFFER);
> +	if (ACPI_SUCCESS(status) && str_buf.length > 0) {
> +		str_obj =3D str_buf.pointer;
> +		char *buf =3D kzalloc(sizeof(*buf) * str_obj->buffer.length, GFP_KERN=
EL);
> +
> +		result =3D utf16s_to_utf8s((wchar_t *)str_obj->buffer.pointer,
> +					 str_obj->buffer.length,
> +					 UTF16_LITTLE_ENDIAN, buf,
> +					 PAGE_SIZE - 1);
> +		kfree(str_obj);
> +		if (result > 0)
> +			return buf;
> +		/* if no result then free buf */
> +		kfree(buf);
> +	}
> +
> +	kfree(str_buf.pointer);
> +
> +use_name:
> +	/* if _STR is missing then just use the device name */
> +	status =3D acpi_get_name(acpi_dev->handle, ACPI_SINGLE_NAME, &name_buf=
);
> +	if (ACPI_SUCCESS(status) && name_buf.length > 0)
> +		return name_buf.pointer;
> +
> +	kfree(name_buf.pointer);
> +
> +	return NULL;
> +}

The ACPI core already provides a helper function for that, but since this =
function is only used
by the fan-related code please just drop it.

> +
> +static int galaxybook_acpi_method(struct samsung_galaxybook *galaxybook=
, acpi_string method,
> +				  struct sawb *buf, u32 len, const char *purpose_str,
> +				  struct sawb *ret)

len should be size_t. Also please remove the purpose string, it adds no va=
lue in the end.

> +{
> +	union acpi_object in_obj, *out_obj;
> +	struct acpi_object_list input;
> +	struct acpi_buffer output =3D {ACPI_ALLOCATE_BUFFER, NULL};
> +	acpi_status status;
> +
> +	in_obj.type =3D ACPI_TYPE_BUFFER;
> +	in_obj.buffer.length =3D len;
> +	in_obj.buffer.pointer =3D (u8 *)buf;
> +
> +	input.count =3D 1;
> +	input.pointer =3D &in_obj;
> +
> +	print_acpi_object_buffer_debug(purpose_str, in_obj.buffer.pointer, in_=
obj.buffer.length);
> +
> +	status =3D acpi_evaluate_object(galaxybook->acpi->handle, method, &inp=
ut, &output);
> +
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("failed %s with ACPI method %s; got %s\n", purpose_str, method=
,
> +		       acpi_format_exception(status));
> +		return status;
> +	}
> +
> +	out_obj =3D output.pointer;
> +
> +	if (out_obj->type !=3D ACPI_TYPE_BUFFER) {
> +		pr_err("failed %s with ACPI method %s; response was not a buffer\n",
> +			purpose_str, method);
> +		status =3D -EIO;
> +		goto out_free;
> +	}
> +
> +	print_acpi_object_buffer_debug("response was: ", out_obj->buffer.point=
er,
> +				       out_obj->buffer.length);
> +
> +	if (out_obj->buffer.length !=3D len) {
> +		pr_err("failed %s with ACPI method %s; response length mismatch\n",
> +		       purpose_str, method);
> +		status =3D -EIO;
> +		goto out_free;
> +	}
> +	if (out_obj->buffer.length < SAWB_GUNM_POS + 1) {
> +		pr_err("failed %s with ACPI method %s; response from device was too s=
hort\n",
> +		       purpose_str, method);
> +		status =3D -EIO;
> +		goto out_free;
> +	}
> +	if (out_obj->buffer.pointer[SAWB_RFLG_POS] !=3D RFLG_SUCCESS) {
> +		pr_err("failed %s with ACPI method %s; "
> +		       "device did not respond with success code 0x%x\n",
> +		       purpose_str, method, RFLG_SUCCESS);
> +		status =3D -EIO;
> +		goto out_free;
> +	}
> +	if (out_obj->buffer.pointer[SAWB_GUNM_POS] =3D=3D GUNM_FAIL) {
> +		pr_err("failed %s with ACPI method %s; device responded with failure =
code 0x%x\n",
> +		       purpose_str, method, GUNM_FAIL);
> +		status =3D -EIO;
> +		goto out_free;
> +	}

I think replacing the error messages with a unique error code (ENXIO, ENOD=
ATA, ...) would make this code
more readable. But i will leave it up to you to decide about this.

> +
> +	memcpy(ret, out_obj->buffer.pointer, len);
> +
> +out_free:
> +	kfree(output.pointer);
> +	return status;

acpi_status is a ACPICA-internal type. Please use "int" for return code ha=
ndling.

> +}
> +
> +static int galaxybook_enable_acpi_feature(struct samsung_galaxybook *ga=
laxybook, const u16 sasb)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D sasb;
> +	buf.gunm =3D GUNM_FEATURE_ENABLE;
> +	buf.guds[0] =3D GUDS_FEATURE_ENABLE;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "enabling ACPI feature", &buf);
> +	if (err)
> +		return err;
> +
> +	if (buf.gunm !=3D GUNM_FEATURE_ENABLE_SUCCESS && buf.guds[0] !=3D GUDS=
_FEATURE_ENABLE_SUCCESS)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +/*
> + * Keyboard Backlight
> + */
> +
> +static int kbd_backlight_acpi_set(struct samsung_galaxybook *galaxybook=
,
> +				  const enum led_brightness brightness)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_KBD_BACKLIGHT;
> +	buf.gunm =3D GUNM_SET;
> +
> +	buf.guds[0] =3D brightness;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "setting kbd_backlight brightness", &buf);
> +	if (err)
> +		return err;
> +
> +	galaxybook->kbd_backlight.brightness =3D brightness;

You probably need to have some locking here, but see my comment regarding =
galaxybook_kbd_backlight_hotkey_work()
for details.

> +
> +	pr_debug_prefixed("set kbd_backlight brightness to %d\n", brightness);
> +
> +	return 0;
> +}
> +
> +static int kbd_backlight_acpi_get(struct samsung_galaxybook *galaxybook=
,
> +				  enum led_brightness *brightness)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_KBD_BACKLIGHT;
> +	buf.gunm =3D GUNM_GET;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "getting kbd_backlight brightness", &buf);
> +	if (err)
> +		return err;
> +
> +	*brightness =3D buf.gunm;
> +	galaxybook->kbd_backlight.brightness =3D buf.gunm;
> +
> +	pr_debug_prefixed("current kbd_backlight brightness is %d\n", buf.gunm=
);
> +
> +	return 0;
> +}
> +
> +static int kbd_backlight_store(struct led_classdev *led,
> +			       const enum led_brightness brightness)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(led, struct samsung_galaxybook, kbd_backlight);
> +	int err;
> +
> +	err =3D kbd_backlight_acpi_set(galaxybook, brightness);
> +	if (err)
> +		return err;
> +
> +	return 0;

Use "return kbd_backlight_acpi_set(galaxybook, brightness);" here and remo=
ve the err variable please.

> +}
> +
> +static enum led_brightness kbd_backlight_show(struct led_classdev *led)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(led, struct samsung_galaxybook, kbd_backlight);
> +	enum led_brightness brightness;
> +	int err;
> +
> +	err =3D kbd_backlight_acpi_get(galaxybook, &brightness);
> +	if (err)
> +		return err;
> +
> +	return brightness;
> +}
> +
> +static int galaxybook_kbd_backlight_init(struct samsung_galaxybook *gal=
axybook)
> +{
> +	enum led_brightness brightness;
> +	struct led_init_data init_data =3D {};
> +	int err;
> +
> +	err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_KBD_BACKLIGHT)=
;
> +	if (err)
> +		return err;
> +
> +	/* verify we can read the value, otherwise init should stop and fail *=
/
> +	err =3D kbd_backlight_acpi_get(galaxybook, &brightness);
> +	if (err)
> +		return err;
> +
> +	init_data.devicename =3D SAMSUNG_GALAXYBOOK_CLASS;
> +	init_data.default_label =3D ":kbd_backlight";

Use LED_FUNCTION_KBD_BACKLIGHT here.

> +	init_data.devname_mandatory =3D true;
> +
> +	galaxybook->kbd_backlight =3D (struct led_classdev){
> +		.brightness_get =3D kbd_backlight_show,
> +		.brightness_set_blocking =3D kbd_backlight_store,
> +		.flags =3D LED_BRIGHT_HW_CHANGED,
> +		.max_brightness =3D KBD_BACKLIGHT_MAX_BRIGHTNESS,
> +	};

Please assign those values one-by-one.

> +
> +	pr_info("registering LED class using default name of %s:%s\n",
> +		init_data.devicename, init_data.default_label);

This debug info is unnecessary, please remove.

> +
> +	return led_classdev_register_ext(&galaxybook->platform->dev, &galaxybo=
ok->kbd_backlight,
> +					 &init_data);

Consider using devm_led_classdev_register_ext(), it would allow you to hav=
e this LED device be cleaned
up automatically in case of an probe error or driver removal.

> +}
> +
> +static void galaxybook_kbd_backlight_exit(struct samsung_galaxybook *ga=
laxybook)
> +{
> +	led_classdev_unregister(&galaxybook->kbd_backlight);
> +}
> +
> +/*
> + * Platform device attributes (configuration properties which can be co=
ntrolled via userspace)
> + */
> +
> +/* Start on lid open (device should power on when lid is opened) */
> +
> +static int start_on_lid_open_acpi_set(struct samsung_galaxybook *galaxy=
book, const bool value)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_POWER_MANAGEMENT;
> +	buf.gunm =3D GUNM_POWER_MANAGEMENT;
> +	buf.guds[0] =3D GUDS_START_ON_LID_OPEN;
> +	buf.guds[1] =3D GUDS_START_ON_LID_OPEN_SET;
> +	buf.guds[2] =3D value;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "setting start_on_lid_open", &buf);
> +	if (err)
> +		return err;
> +
> +	pr_debug_prefixed("turned start_on_lid_open %s\n", value ? "on (1)" : =
"off (0)");
> +
> +	return 0;
> +}
> +
> +static int start_on_lid_open_acpi_get(struct samsung_galaxybook *galaxy=
book, bool *value)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_POWER_MANAGEMENT;
> +	buf.gunm =3D GUNM_POWER_MANAGEMENT;
> +	buf.guds[0] =3D GUDS_START_ON_LID_OPEN;
> +	buf.guds[1] =3D GUDS_START_ON_LID_OPEN_GET;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "getting start_on_lid_open", &buf);
> +	if (err)
> +		return err;
> +
> +	*value =3D buf.guds[1];
> +
> +	pr_debug_prefixed("start_on_lid_open is currently %s\n",
> +			  (buf.guds[1] ? "on (1)" : "off (0)"));
> +
> +	return 0;
> +}
> +
> +static ssize_t start_on_lid_open_store(struct device *dev, struct devic=
e_attribute *attr,
> +				       const char *buffer, size_t count)
> +{
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	if (!count || kstrtobool(buffer, &value))
> +		return -EINVAL;

Please us the return value of kstrtobool as the error code if appropriate.

> +
> +	err =3D start_on_lid_open_acpi_set(galaxybook, value);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +static ssize_t start_on_lid_open_show(struct device *dev, struct device=
_attribute *attr,
> +				      char *buffer)
> +{
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	err =3D start_on_lid_open_acpi_get(galaxybook, &value);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buffer, "%u\n", value);
> +}
> +
> +static DEVICE_ATTR_RW(start_on_lid_open);
> +
> +/* USB Charge (USB ports can charge other devices even when device is p=
owered off) */
> +
> +static int usb_charge_acpi_set(struct samsung_galaxybook *galaxybook, c=
onst bool value)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_USB_CHARGE_SET;
> +	buf.gunm =3D value ? GUNM_USB_CHARGE_ON : GUNM_USB_CHARGE_OFF;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "setting usb_charge", &buf);
> +	if (err)
> +		return err;
> +
> +	pr_debug_prefixed("turned usb_charge %s\n", value ? "on (1)" : "off (0=
)");
> +
> +	return 0;
> +}
> +
> +static int usb_charge_acpi_get(struct samsung_galaxybook *galaxybook, b=
ool *value)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_USB_CHARGE_GET;
> +	buf.gunm =3D GUNM_USB_CHARGE_GET;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "getting usb_charge", &buf);
> +	if (err)
> +		return err;
> +
> +	*value =3D buf.gunm;
> +
> +	pr_debug_prefixed("usb_charge is currently %s\n", (buf.gunm ? "on (1)"=
 : "off (0)"));
> +
> +	return 0;
> +}
> +
> +static ssize_t usb_charge_store(struct device *dev, struct device_attri=
bute *attr,
> +				const char *buffer, size_t count)
> +{
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	if (!count || kstrtobool(buffer, &value))
> +		return -EINVAL;

Same as above.

> +
> +	err =3D usb_charge_acpi_set(galaxybook, value);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +static ssize_t usb_charge_show(struct device *dev, struct device_attrib=
ute *attr, char *buffer)
> +{
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	err =3D usb_charge_acpi_get(galaxybook, &value);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buffer, "%u\n", value);
> +}
> +
> +static DEVICE_ATTR_RW(usb_charge);
> +
> +/* Allow recording (allows or blocks access to camera and microphone) *=
/
> +
> +static int allow_recording_acpi_set(struct samsung_galaxybook *galaxybo=
ok, const bool value)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_ALLOW_RECORDING;
> +	buf.gunm =3D GUNM_SET;
> +	buf.guds[0] =3D value;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "setting allow_recording", &buf);
> +	if (err)
> +		return err;
> +
> +	pr_debug_prefixed("turned allow_recording %s\n", value ? "on (1)" : "o=
ff (0)");
> +
> +	return 0;
> +}
> +
> +static int allow_recording_acpi_get(struct samsung_galaxybook *galaxybo=
ok, bool *value)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_ALLOW_RECORDING;
> +	buf.gunm =3D GUNM_GET;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "getting allow_recording", &buf);
> +	if (err)
> +		return err;
> +
> +	*value =3D buf.gunm;
> +
> +	pr_debug_prefixed("allow_recording is currently %s\n", (buf.gunm ? "on=
 (1)" : "off (0)"));
> +
> +	return 0;
> +}
> +
> +static ssize_t allow_recording_store(struct device *dev, struct device_=
attribute *attr,
> +				     const char *buffer, size_t count)
> +{
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	if (!count || kstrtobool(buffer, &value))
> +		return -EINVAL;

Same as above.

> +
> +	err =3D allow_recording_acpi_set(galaxybook, value);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +static ssize_t allow_recording_show(struct device *dev, struct device_a=
ttribute *attr, char *buffer)
> +{
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	err =3D allow_recording_acpi_get(galaxybook, &value);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buffer, "%u\n", value);
> +}
> +
> +static DEVICE_ATTR_RW(allow_recording);
> +
> +/*
> + * Battery Extension (adds charge_control_end_threshold to the battery =
device)
> + */
> +
> +static int charge_control_end_threshold_acpi_set(struct samsung_galaxyb=
ook *galaxybook,
> +						 const u8 value)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	if (value > 100)
> +		return -EINVAL;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_POWER_MANAGEMENT;
> +	buf.gunm =3D GUNM_POWER_MANAGEMENT;
> +	buf.guds[0] =3D GUDS_BATTERY_CHARGE_CONTROL;
> +	buf.guds[1] =3D GUDS_BATTERY_CHARGE_CONTROL_SET;
> +
> +	buf.guds[2] =3D (value =3D=3D 100 ? 0 : value); /* if setting to 100, =
should be set to 0 (off) */
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "setting battery charge_control_end_threshold", &buf);
> +	if (err)
> +		return err;
> +
> +	pr_debug_prefixed("set battery charge_control_end_threshold to %d\n",
> +			  (value =3D=3D 100 ? 0 : value));
> +
> +	return 0;
> +}
> +
> +static int charge_control_end_threshold_acpi_get(struct samsung_galaxyb=
ook *galaxybook, u8 *value)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_POWER_MANAGEMENT;
> +	buf.gunm =3D GUNM_POWER_MANAGEMENT;
> +	buf.guds[0] =3D GUDS_BATTERY_CHARGE_CONTROL;
> +	buf.guds[1] =3D GUDS_BATTERY_CHARGE_CONTROL_GET;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> +				     "getting battery charge_control_end_threshold", &buf);
> +	if (err)
> +		return err;
> +
> +	*value =3D buf.guds[1];
> +
> +	pr_debug_prefixed("battery charge control is currently %s; "
> +			  "battery charge_control_end_threshold is %d\n",
> +			  (buf.guds[1] > 0 ? "on" : "off"), buf.guds[1]);
> +
> +	return 0;
> +}
> +
> +static ssize_t charge_control_end_threshold_store(struct device *dev, s=
truct device_attribute *attr,
> +						  const char *buffer, size_t count)
> +{
> +	u8 value;
> +	int err;
> +
> +	if (!count || kstrtou8(buffer, 0, &value))
> +		return -EINVAL;

Same as above regarding the error code.

> +
> +	err =3D charge_control_end_threshold_acpi_set(galaxybook_ptr, value);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +static ssize_t charge_control_end_threshold_show(struct device *dev, st=
ruct device_attribute *attr,
> +						 char *buffer)
> +{
> +	u8 value;
> +	int err;
> +
> +	err =3D charge_control_end_threshold_acpi_get(galaxybook_ptr, &value);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buffer, "%d\n", value);
> +}
> +
> +static DEVICE_ATTR_RW(charge_control_end_threshold);

As a side note: take a look at the dell-wmi-ddv driver on how to handle th=
ose battery device attributes without
having to use global variables like galaxybook_ptr.

> +
> +static int galaxybook_battery_add(struct power_supply *battery, struct =
acpi_battery_hook *hook)
> +{
> +	if (device_create_file(&battery->dev, &dev_attr_charge_control_end_thr=
eshold))
> +		return -ENODEV;

Please return the error code of the function here.

> +	return 0;
> +}
> +
> +static int galaxybook_battery_remove(struct power_supply *battery, stru=
ct acpi_battery_hook *hook)
> +{
> +	device_remove_file(&battery->dev, &dev_attr_charge_control_end_thresho=
ld);
> +	return 0;
> +}
> +
> +static struct acpi_battery_hook galaxybook_battery_hook =3D {
> +	.add_battery =3D galaxybook_battery_add,
> +	.remove_battery =3D galaxybook_battery_remove,
> +	.name =3D "Samsung Galaxy Book Battery Extension",
> +};
> +
> +static int galaxybook_battery_threshold_init(struct samsung_galaxybook =
*galaxybook)
> +{
> +	u8 value;
> +	int err;
> +
> +	err =3D charge_control_end_threshold_acpi_get(galaxybook, &value);
> +	if (err)
> +		return err;
> +
> +	battery_hook_register(&galaxybook_battery_hook);
> +	return 0;

Please do proper error handling here, as battery_hook_register() can fail.=
 You should also
consider using devm_battery_hook_register().

> +}
> +
> +static void galaxybook_battery_threshold_exit(struct samsung_galaxybook=
 *galaxybook)
> +{
> +	battery_hook_unregister(&galaxybook_battery_hook);
> +}
> +
> +/*
> + * Fan speed
> + */
> +
> +static int fan_speed_get_fst(struct galaxybook_fan *fan, unsigned int *=
speed)
> +{
> +	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *response_obj =3D NULL;
> +	acpi_status status;
> +	int ret =3D 0;
> +
> +	status =3D acpi_evaluate_object(fan->fan.handle, "_FST", NULL, &respon=
se);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("Get fan state failed\n");
> +		return -ENODEV;
> +	}
> +
> +	response_obj =3D response.pointer;
> +	if (!response_obj || response_obj->type !=3D ACPI_TYPE_PACKAGE ||
> +	    response_obj->package.count !=3D 3 ||
> +	    response_obj->package.elements[2].type !=3D ACPI_TYPE_INTEGER) {
> +		pr_err("Invalid _FST data\n");
> +		ret =3D -EINVAL;
> +		goto out_free;
> +	}
> +
> +	*speed =3D response_obj->package.elements[2].integer.value;
> +
> +	pr_debug_prefixed("fan device %s (%s) reporting fan speed of %d\n",
> +			  dev_name(&fan->fan.dev), fan->description, *speed);
> +
> +out_free:
> +	ACPI_FREE(response.pointer);
> +	return ret;
> +}
> +
> +static int fan_speed_get_fans(struct galaxybook_fan *fan, unsigned int =
*speed)
> +{
> +	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *response_obj =3D NULL;
> +	acpi_status status;
> +	int ret =3D 0;
> +	int speed_level =3D -1;
> +
> +	status =3D acpi_evaluate_object(NULL, ACPI_FAN_SPEED_VALUE, NULL, &res=
ponse);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("Get fan state failed\n");
> +		return -ENODEV;
> +	}
> +
> +	response_obj =3D response.pointer;
> +	if (!response_obj || response_obj->type !=3D ACPI_TYPE_INTEGER ||
> +	    response_obj->integer.value > INT_MAX ||
> +	    (int)response_obj->integer.value > fan->fan_speeds_count) {
> +		pr_err("invalid fan speed data\n");
> +		ret =3D -EINVAL;
> +		goto out_free;
> +	}
> +
> +	speed_level =3D (int)response_obj->integer.value;
> +	*speed =3D fan->fan_speeds[speed_level];
> +
> +	pr_debug_prefixed("fan device %s (%s) reporting fan speed of %d (level=
 %d)\n",
> +			  dev_name(&fan->fan.dev), fan->description, *speed, speed_level);
> +
> +out_free:
> +	ACPI_FREE(response.pointer);
> +	return ret;
> +}
> +
> +static int fan_speed_get(struct galaxybook_fan *fan, unsigned int *spee=
d)
> +{
> +	if (!fan)
> +		return -ENODEV;
> +	if (fan->supports_fst)
> +		return fan_speed_get_fst(fan, speed);
> +	else
> +		return fan_speed_get_fans(fan, speed);
> +}
> +
> +static ssize_t fan_speed_rpm_show(struct device *dev, struct device_att=
ribute *attr, char *buffer)
> +{
> +	struct dev_ext_attribute *ea =3D container_of(attr, struct dev_ext_att=
ribute, attr);
> +	struct galaxybook_fan *fan =3D ea->var;
> +	unsigned int speed;
> +	int ret =3D 0;
> +
> +	if (!fan)
> +		return -ENODEV;
> +
> +	ret =3D fan_speed_get(fan, &speed);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buffer, "%u\n", speed);
> +}
> +
> +static int __init fan_speed_list_init(acpi_handle handle, struct galaxy=
book_fan *fan)
> +{
> +	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *response_obj =3D NULL;
> +	acpi_status status;
> +	unsigned int speed;
> +	int i;
> +
> +	status =3D acpi_evaluate_object(handle, ACPI_FAN_SPEED_LIST, NULL, &re=
sponse);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("failed to read fan speed list\n");
> +		return -ENODEV;
> +	}
> +
> +	response_obj =3D response.pointer;
> +	if (!response_obj || response_obj->type !=3D ACPI_TYPE_PACKAGE ||
> +	    response_obj->package.count =3D=3D 0) {
> +		pr_err("invalid fan speed list data\n");
> +		status =3D -EINVAL;
> +		goto out_free;
> +	}
> +
> +	/*
> +	 * fan_speeds[] starts with a hard-coded 0 (fan is off), then has some=
 "funny" logic:
> +	 *  - fetch the speed level values read in from FANT and add 0x0a to e=
ach value
> +	 *  - _FST method in the DSDT seems to indicate that level 3 and 4 sho=
uld have same value,
> +	 *    however real-life observation suggests that the speed actually d=
oes change
> +	 *  - _FST says that level 5 should give the 4th value from FANT but i=
t seems significantly
> +	 *    louder -- we will just "guess" it is 1000 RPM faster than the hi=
ghest value from FANT?
> +	 */
> +
> +	fan->fan_speeds =3D kzalloc(sizeof(unsigned int) * (response_obj->pack=
age.count + 2),
> +				  GFP_KERNEL);
> +	if (!fan->fan_speeds)
> +		return -ENOMEM;
> +
> +	/* hard-coded "off" value (0) */
> +	fan->fan_speeds[0] =3D 0;
> +	fan->fan_speeds_count =3D 1;
> +
> +	/* fetch and assign the next values from FANT response */
> +	i =3D 0;
> +	for (i =3D 1; i <=3D response_obj->package.count; i++) {
> +		if (response_obj->package.elements[i - 1].type !=3D ACPI_TYPE_INTEGER=
) {
> +			pr_err("invalid fan speed list value at position %d; "
> +			       "expected type %d, got type %d\n",
> +			       i - 1, ACPI_TYPE_INTEGER,
> +			       response_obj->package.elements[i - 1].type);
> +			status =3D -EINVAL;
> +			goto err_fan_speeds_free;
> +		}
> +		fan->fan_speeds[i] =3D response_obj->package.elements[i - 1].integer.=
value + 0x0a;
> +		fan->fan_speeds_count++;
> +	}
> +
> +	/* add the missing final level where we "guess" 1000 RPM faster than h=
ighest from FANT */
> +	if (fan->fan_speeds_count > 1) {
> +		fan->fan_speeds[i] =3D fan->fan_speeds[i - 1] + 1000;
> +		fan->fan_speeds_count++;
> +	}
> +
> +	/* test that it actually works to read the speed, otherwise the init s=
hould fail */
> +	status =3D fan_speed_get_fans(fan, &speed);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("failed to read fan speed level from FANS\n");
> +		goto err_fan_speeds_free;
> +	}
> +
> +	pr_info("initialized fan speed reporting for device %s (%s) with the f=
ollowing levels:\n",
> +		dev_name(&fan->fan.dev), fan->description);
> +	for (i =3D 0; i < fan->fan_speeds_count; i++)
> +		pr_info("  %s (%s) fan speed level %d =3D %d\n",
> +			dev_name(&fan->fan.dev), fan->description, i, fan->fan_speeds[i]);
> +
> +out_free:
> +	ACPI_FREE(response.pointer);
> +	return status;
> +
> +err_fan_speeds_free:
> +	kfree(fan->fan_speeds);
> +	goto out_free;
> +}
> +
> +static acpi_status galaxybook_add_fan(acpi_handle handle, u32 level, vo=
id *context,
> +				      void **return_value)
> +{
> +	struct acpi_device *adev =3D acpi_fetch_acpi_dev(handle);
> +	struct samsung_galaxybook *galaxybook =3D context;
> +	struct galaxybook_fan *fan;
> +	int speed =3D -1;
> +
> +	pr_info("found fan device %s\n", dev_name(&adev->dev));
> +
> +	/* if fan meets acpi4 fan device requirements, assume it is added alre=
ady under ACPI */
> +	if (acpi_has_method(handle, "_FIF") &&
> +	    acpi_has_method(handle, "_FPS") &&
> +	    acpi_has_method(handle, "_FSL") &&
> +	    acpi_has_method(handle, "_FST")) {
> +		pr_info("fan device %s should already be available as an ACPI fan; sk=
ipping\n",
> +			dev_name(&adev->dev));
> +		return 0;
> +	}
> +
> +	if (galaxybook->fans_count >=3D MAX_FAN_COUNT) {
> +		pr_err("maximum number of %d fans has already been reached\n", MAX_FA=
N_COUNT);
> +		return 0;
> +	}
> +
> +	fan =3D &galaxybook->fans[galaxybook->fans_count];
> +	fan->fan =3D *adev;
> +	fan->description =3D get_acpi_device_description(&fan->fan);
> +
> +	/* try to get speed from _FST */
> +	if (ACPI_FAILURE(fan_speed_get_fst(fan, &speed))) {
> +		pr_debug_prefixed("_FST is present but failed on fan device %s (%s); =
"
> +				  "will attempt to add fan speed support using FANT and FANS\n",
> +				  dev_name(&fan->fan.dev), fan->description);
> +		fan->supports_fst =3D false;
> +	}
> +	/* if speed was 0 and FANT and FANS exist, they should be used anyway =
due to bugs in ACPI */
> +	else if (speed <=3D 0 &&
> +		 acpi_has_method(handle, ACPI_FAN_SPEED_LIST) &&
> +		 acpi_has_method(NULL, ACPI_FAN_SPEED_VALUE)) {
> +		pr_debug_prefixed("_FST is present on fan device %s (%s) but returned=
 value of 0; "
> +				  "will attempt to add fan speed support using FANT and FANS\n",
> +				  dev_name(&fan->fan.dev), fan->description);
> +		fan->supports_fst =3D false;
> +	} else {
> +		fan->supports_fst =3D true;
> +	}
> +
> +	if (!fan->supports_fst) {
> +		/* since FANS is a field on the EC, it does not make sense to use mor=
e than once */
> +		for (int i =3D 0; i < galaxybook->fans_count; i++) {
> +			if (!galaxybook->fans[i].supports_fst) {
> +				pr_err("more than one fan using FANS is not supported\n");
> +				return 0;
> +			}
> +		}
> +		if (ACPI_FAILURE(fan_speed_list_init(handle, fan))) {
> +			pr_err("unable to initialize fan speeds for fan device %s (%s)\n",
> +			       dev_name(&fan->fan.dev), fan->description);
> +			return 0;
> +		}
> +	} else {
> +		pr_info("initialized fan speed reporting for device %s (%s) using met=
hod _FST\n",
> +			dev_name(&fan->fan.dev), fan->description);
> +	}
> +
> +	/* set up RO dev_ext_attribute */
> +	fan->fan_speed_rpm_ext_attr.attr.attr.name =3D "fan_speed_rpm";
> +	fan->fan_speed_rpm_ext_attr.attr.attr.mode =3D 0444;
> +	fan->fan_speed_rpm_ext_attr.attr.show =3D fan_speed_rpm_show;
> +	/* extended attribute var points to this galaxybook_fan so it can used=
 in the show method */
> +	fan->fan_speed_rpm_ext_attr.var =3D fan;
> +
> +	if (sysfs_create_file(&adev->dev.kobj, &fan->fan_speed_rpm_ext_attr.at=
tr.attr))
> +		pr_err("unable to create fan_speed_rpm attribute for fan device %s (%=
s)\n",
> +		       dev_name(&fan->fan.dev), fan->description);
> +
> +	galaxybook->fans_count++;
> +
> +	return 0;
> +}
> +
> +static int __init galaxybook_fan_speed_init(struct samsung_galaxybook *=
galaxybook)
> +{
> +	acpi_status status;
> +
> +	/* get and set up all fans matching ACPI_FAN_DEVICE_ID */
> +	status =3D acpi_get_devices(ACPI_FAN_DEVICE_ID, galaxybook_add_fan, ga=
laxybook, NULL);
> +
> +	if (galaxybook->fans_count =3D=3D 0)
> +		return -ENODEV;
> +
> +	return status;
> +}
> +
> +static void galaxybook_fan_speed_exit(struct samsung_galaxybook *galaxy=
book)
> +{
> +	for (int i =3D 0; i < galaxybook->fans_count; i++)
> +		sysfs_remove_file(&galaxybook->fans[i].fan.dev.kobj,
> +				  &galaxybook->fans[i].fan_speed_rpm_ext_attr.attr.attr);
> +}

Regarding the whole fan logic:

This belongs into the ACPI fan driver. The FANT value seems to be availabl=
e thru a _DSM on the ACPI fan device
using GUID a7611840-99fe-41ae-a488-35c75926c8eb. This GUID is documented i=
n the Microsoft design guide, see
https://learn.microsoft.com/de-de/windows-hardware/design/device-experienc=
es/design-guide for details.

If you want to add support for this, please talk with the maintainers of t=
he ACPI fan driver.

> +
> +/*
> + * Hwmon device
> + */
> +
> +#if IS_ENABLED(CONFIG_HWMON)
> +static umode_t galaxybook_hwmon_is_visible(const void *drvdata, enum hw=
mon_sensor_types type,
> +					   u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		if (channel < galaxybook_ptr->fans_count &&
> +		    (attr =3D=3D hwmon_fan_input || attr =3D=3D hwmon_fan_label))
> +			return 0444;
> +		return 0;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int galaxybook_hwmon_read(struct device *dev, enum hwmon_sensor_=
types type,
> +				 u32 attr, int channel, long *val)
> +{
> +	unsigned int speed;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		if (channel < galaxybook_ptr->fans_count && attr =3D=3D hwmon_fan_inp=
ut) {
> +			if (fan_speed_get(&galaxybook_ptr->fans[channel], &speed))
> +				return -EIO;
> +			*val =3D speed;
> +			return 0;
> +		}
> +		return -EOPNOTSUPP;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int galaxybook_hwmon_read_string(struct device *dev, enum hwmon_=
sensor_types type,
> +					u32 attr, int channel, const char **str)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		if (channel < galaxybook_ptr->fans_count && attr =3D=3D hwmon_fan_lab=
el) {
> +			*str =3D galaxybook_ptr->fans[channel].description;
> +			return 0;
> +		}
> +		return -EOPNOTSUPP;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct hwmon_ops galaxybook_hwmon_ops =3D {
> +	.is_visible =3D galaxybook_hwmon_is_visible,
> +	.read =3D galaxybook_hwmon_read,
> +	.read_string =3D galaxybook_hwmon_read_string,
> +};
> +
> +static const struct hwmon_channel_info *const galaxybook_hwmon_info[] =
=3D {
> +	/* note: number of max possible fan channel entries here should match =
MAX_FAN_COUNT */
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info galaxybook_hwmon_chip_info =3D {
> +	.ops =3D &galaxybook_hwmon_ops,
> +	.info =3D galaxybook_hwmon_info,
> +};
> +
> +static int galaxybook_hwmon_init(struct samsung_galaxybook *galaxybook)
> +{
> +	int ret =3D 0;
> +
> +	char *hwmon_device_name =3D devm_hwmon_sanitize_name(&galaxybook->plat=
form->dev,
> +							   SAMSUNG_GALAXYBOOK_CLASS);
> +
> +	galaxybook->hwmon =3D devm_hwmon_device_register_with_info(
> +		&galaxybook->platform->dev, hwmon_device_name, NULL,
> +		&galaxybook_hwmon_chip_info, NULL);
> +	if (PTR_ERR_OR_ZERO(galaxybook->hwmon)) {
> +		ret =3D PTR_ERR(galaxybook->hwmon);
> +		galaxybook->hwmon =3D NULL;
> +	}
> +
> +	return ret;
> +}
> +
> +static void galaxybook_hwmon_exit(struct samsung_galaxybook *galaxybook=
)
> +{
> +	if (galaxybook->hwmon)
> +		hwmon_device_unregister(galaxybook->hwmon);
> +}
> +#endif

This code should be dropped too since the ACPI fan driver should handle th=
ose fans and already
contains hwmon support.

> +
> +/*
> + * Platform Profile / Performance mode
> + */
> +
> +static int performance_mode_acpi_set(struct samsung_galaxybook *galaxyb=
ook,
> +				     const u8 performance_mode)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_PERFORMANCE_MODE;
> +	export_guid(buf.caid, &PERFORMANCE_MODE_GUID);
> +	buf.fncn =3D FNCN_PERFORMANCE_MODE;
> +	buf.subn =3D SUBN_PERFORMANCE_MODE_SET;
> +	buf.iob0 =3D performance_mode;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MOD=
E, &buf,
> +				     SAWB_LEN_PERFORMANCE_MODE, "setting performance_mode", &buf);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int performance_mode_acpi_get(struct samsung_galaxybook *galaxyb=
ook, u8 *performance_mode)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_PERFORMANCE_MODE;
> +	export_guid(buf.caid, &PERFORMANCE_MODE_GUID);
> +	buf.fncn =3D FNCN_PERFORMANCE_MODE;
> +	buf.subn =3D SUBN_PERFORMANCE_MODE_GET;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MOD=
E, &buf,
> +				     SAWB_LEN_PERFORMANCE_MODE, "getting performance_mode", &buf);
> +	if (err)
> +		return err;
> +
> +	*performance_mode =3D buf.iob0;
> +
> +	return 0;
> +}
> +
> +static enum platform_profile_option
> +profile_performance_mode(struct samsung_galaxybook *galaxybook, const u=
8 performance_mode)
> +{
> +	for (int i =3D 0; i < PLATFORM_PROFILE_LAST; i++)
> +		if (galaxybook->profile_performance_modes[i] =3D=3D performance_mode)
> +			return i;
> +	return -1;
> +}
> +
> +/* copied from platform_profile.c; better if this could be fetched from=
 a public function, maybe? */
> +static const char *const profile_names[] =3D {
> +	[PLATFORM_PROFILE_LOW_POWER] =3D "low-power",
> +	[PLATFORM_PROFILE_COOL] =3D "cool",
> +	[PLATFORM_PROFILE_QUIET] =3D "quiet",
> +	[PLATFORM_PROFILE_BALANCED] =3D "balanced",
> +	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] =3D "balanced-performance",
> +	[PLATFORM_PROFILE_PERFORMANCE] =3D "performance",
> +};
> +static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST);

This is only used for debugging, please remove this and the associated pri=
nt statements as they
add no real value.

> +
> +static int galaxybook_platform_profile_set(struct platform_profile_hand=
ler *pprof,
> +					   enum platform_profile_option profile)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(pprof, struct samsung_galaxybook, profile_handler);
> +	int err;
> +
> +	err =3D performance_mode_acpi_set(galaxybook, galaxybook->profile_perf=
ormance_modes[profile]);
> +	if (err)
> +		return err;
> +
> +	pr_debug_prefixed("set platform profile to '%s' (performance mode 0x%x=
)\n",
> +			  profile_names[profile], galaxybook->profile_performance_modes[prof=
ile]);
> +	return 0;
> +}
> +
> +static int galaxybook_platform_profile_get(struct platform_profile_hand=
ler *pprof,
> +					   enum platform_profile_option *profile)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(pprof, struct samsung_galaxybook, profile_handler);
> +	u8 performance_mode;
> +	int err;
> +
> +	err =3D performance_mode_acpi_get(galaxybook, &performance_mode);
> +	if (err)
> +		return err;
> +
> +	*profile =3D profile_performance_mode(galaxybook, performance_mode);
> +	if (*profile =3D=3D -1)
> +		return -EINVAL;
> +
> +	pr_debug_prefixed("platform profile is currently '%s' (performance mod=
e 0x%x)\n",
> +			  profile_names[*profile], performance_mode);
> +
> +	return 0;
> +}
> +
> +#define IGNORE_PERFORMANCE_MODE_MAPPING  -1
> +
> +static int galaxybook_profile_init(struct samsung_galaxybook *galaxyboo=
k)
> +{
> +	struct sawb buf =3D { 0 };
> +	int mode_profile, err;
> +	u8 current_performance_mode;
> +
> +	galaxybook->profile_handler.profile_get =3D galaxybook_platform_profil=
e_get;
> +	galaxybook->profile_handler.profile_set =3D galaxybook_platform_profil=
e_set;
> +
> +	/* fetch supported performance mode values from ACPI method */
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_PERFORMANCE_MODE;
> +	export_guid(buf.caid, &PERFORMANCE_MODE_GUID);
> +	buf.fncn =3D FNCN_PERFORMANCE_MODE;
> +	buf.subn =3D SUBN_PERFORMANCE_MODE_LIST;
> +
> +	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MOD=
E,
> +				     &buf, SAWB_LEN_PERFORMANCE_MODE,
> +				     "get supported performance modes", &buf);
> +	if (err)
> +		return err;
> +
> +	/* set up profile_performance_modes with "unknown" as init value */
> +	galaxybook->profile_performance_modes =3D
> +		kzalloc(sizeof(u8) * PLATFORM_PROFILE_LAST, GFP_KERNEL);
> +	if (!galaxybook->profile_performance_modes)
> +		return -ENOMEM;
> +	for (int i =3D 0; i < PLATFORM_PROFILE_LAST; i++)
> +		galaxybook->profile_performance_modes[i] =3D PERFORMANCE_MODE_UNKNOWN=
;
> +
> +	/*
> +	 * Value returned in iob0 will have the number of supported performanc=
e modes.
> +	 * The performance mode values will then be given as a list after this=
 (iob1-iobX).
> +	 * Loop backwards from last value to first value (to handle fallback c=
ases which come with
> +	 * smaller values) and map each supported value to its correct platfor=
m_profile_option.
> +	 */
> +	err =3D -ENODEV; /* set err to "no device" to signal that we have not =
yet mapped profiles */
> +	for (int i =3D buf.iob0; i > 0; i--) {
> +		/*
> +		 * Prefer mapping to at least performance, balanced, and low-power pr=
ofiles, as they
> +		 * are the profiles which are typically supported by userspace tools
> +		 * (power-profiles-daemon, etc).
> +		 * - performance =3D "ultra", otherwise "performance"
> +		 * - balanced    =3D "optimized", otherwise "performance" when "ultra=
" is supported
> +		 * - low-power   =3D "silent", otherwise "quiet"
> +		 * Different models support different modes. Additional supported mod=
es will be
> +		 * mapped to profiles that fall in between these 3.
> +		 */
> +		switch (buf.iob_values[i]) {
> +
> +		case PERFORMANCE_MODE_ULTRA:
> +			/* ultra always maps to performance */
> +			mode_profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +			break;
> +
> +		case PERFORMANCE_MODE_PERFORMANCE:
> +			/* if ultra exists, map performance to balanced-performance */
> +			if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_PERFORMAN=
CE] !=3D
> +			    PERFORMANCE_MODE_UNKNOWN)
> +				mode_profile =3D PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> +			else /* otherwise map it to performance instead */
> +				mode_profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +			break;
> +
> +		case PERFORMANCE_MODE_SILENT:
> +			/* silent always maps to low-power */
> +			mode_profile =3D PLATFORM_PROFILE_LOW_POWER;
> +			break;
> +
> +		case PERFORMANCE_MODE_QUIET:
> +			/* if silent exists, map quiet to quiet */
> +			if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_LOW_POWER=
] !=3D
> +			    PERFORMANCE_MODE_UNKNOWN)
> +				mode_profile =3D PLATFORM_PROFILE_QUIET;
> +			else /* otherwise map it to low-power for better userspace tool supp=
ort */
> +				mode_profile =3D PLATFORM_PROFILE_LOW_POWER;
> +			break;
> +
> +		case PERFORMANCE_MODE_OPTIMIZED:
> +			/* optimized always maps to balanced */
> +			mode_profile =3D PLATFORM_PROFILE_BALANCED;
> +			break;
> +
> +		case PERFORMANCE_MODE_PERFORMANCE_LEGACY:
> +			/* map to performance if performance is not already supported */
> +			if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_PERFORMAN=
CE] =3D=3D
> +			    PERFORMANCE_MODE_UNKNOWN)
> +				mode_profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +			else /* otherwise, ignore */
> +				mode_profile =3D IGNORE_PERFORMANCE_MODE_MAPPING;
> +			break;
> +
> +		case PERFORMANCE_MODE_OPTIMIZED_LEGACY:
> +			/* map to balanced if balanced is not already supported */
> +			if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_BALANCED]=
 =3D=3D
> +			    PERFORMANCE_MODE_UNKNOWN)
> +				mode_profile =3D PLATFORM_PROFILE_BALANCED;
> +			else /* otherwise, ignore */
> +				mode_profile =3D IGNORE_PERFORMANCE_MODE_MAPPING;
> +			break;
> +
> +		default: /* any other value is not supported */
> +			mode_profile =3D IGNORE_PERFORMANCE_MODE_MAPPING;
> +			break;
> +		}
> +
> +		/* if current mode value mapped to a supported platform_profile_optio=
n, set it up */
> +		if (mode_profile > IGNORE_PERFORMANCE_MODE_MAPPING) {
> +			err =3D 0; /* clear err to signal that at least one profile is now m=
apped */
> +			galaxybook->profile_performance_modes[mode_profile] =3D buf.iob_valu=
es[i];
> +			set_bit(mode_profile, galaxybook->profile_handler.choices);
> +			pr_info("will support platform profile '%s' (performance mode 0x%x)\=
n",
> +				profile_names[mode_profile], buf.iob_values[i]);
> +		} else {
> +			pr_debug_prefixed("unmapped performance mode 0x%x will be ignored\n"=
,
> +					  buf.iob_values[i]);
> +		}
> +	}
> +
> +	/* if no performance modes were mapped (err is still -ENODEV) then sto=
p and fail here */
> +	if (err)
> +		return err;
> +
> +	err =3D platform_profile_register(&galaxybook->profile_handler);
> +	if (err)
> +		return err;
> +
> +	/* now check currently set performance mode; if not supported then set=
 default profile */
> +	err =3D performance_mode_acpi_get(galaxybook, &current_performance_mod=
e);
> +	if (err)
> +		pr_warn("failed with code %d when fetching initial performance mode\n=
", err);
> +	if (profile_performance_mode(galaxybook, current_performance_mode) =3D=
=3D -1) {
> +		pr_debug_prefixed("initial performance mode value is not supported by=
 device; "
> +				  "setting to default\n");
> +		err =3D galaxybook_platform_profile_set(&galaxybook->profile_handler,
> +						      DEFAULT_PLATFORM_PROFILE);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void galaxybook_profile_exit(struct samsung_galaxybook *galaxybo=
ok)
> +{
> +	platform_profile_remove();
> +}
> +
> +/*
> + * Hotkey work and filters
> + */
> +
> +static void galaxybook_performance_mode_hotkey_work(struct work_struct =
*work)
> +{
> +	platform_profile_cycle();
> +}
> +
> +static void galaxybook_kbd_backlight_hotkey_work(struct work_struct *wo=
rk)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(work, struct samsung_galaxybook, kbd_backlight_hotkey_wo=
rk);
> +
> +	if (galaxybook->kbd_backlight.brightness < galaxybook->kbd_backlight.m=
ax_brightness)
> +		kbd_backlight_acpi_set(galaxybook, galaxybook->kbd_backlight.brightne=
ss + 1);
> +	else
> +		kbd_backlight_acpi_set(galaxybook, 0);
> +
> +	led_classdev_notify_brightness_hw_changed(
> +		&galaxybook->kbd_backlight,
> +		galaxybook->kbd_backlight.brightness);

Use the KEY_KBDILLUMDOWN/KEY_KBDILLUMUP key codes to let userspace do this=
 for you. This also allows
userspace applications to ignore those requests when necessary.

> +}
> +
> +static void galaxybook_allow_recording_hotkey_work(struct work_struct *=
work)
> +{
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(work, struct samsung_galaxybook, allow_recording_hotkey_=
work);
> +	bool value;
> +
> +	allow_recording_acpi_get(galaxybook, &value);
> +	allow_recording_acpi_set(galaxybook, !value);

I am pretty sure a suitable keycode(s) exists for that so userspace can sh=
ow a OSD icon.
Also you might need some locking here.

> +}
> +
> +static bool galaxybook_i8042_filter(unsigned char data, unsigned char s=
tr, struct serio *port)
> +{
> +	static bool extended;
> +
> +	if (str & I8042_STR_AUXDATA)
> +		return false;
> +
> +	if (unlikely(data =3D=3D 0xe0)) {
> +		extended =3D true;
> +		return true;
> +	} else if (unlikely(extended)) {
> +		extended =3D false;
> +		switch (data) {
> +
> +		case GB_KEY_KBD_BACKLIGHT_KEYDOWN:
> +			return true;
> +		case GB_KEY_KBD_BACKLIGHT_KEYUP:
> +			if (kbd_backlight)
> +				schedule_work(&galaxybook_ptr->kbd_backlight_hotkey_work);
> +			return true;
> +
> +		case GB_KEY_ALLOW_RECORDING_KEYDOWN:
> +			return true;
> +		case GB_KEY_ALLOW_RECORDING_KEYUP:
> +			if (allow_recording)
> +				schedule_work(&galaxybook_ptr->allow_recording_hotkey_work);

You should forward the keyup/keydown presses to a real input device so use=
rspace can act on them accordingly.
Still i think you can keep the special handling of GB_KEY_ALLOW_RECORDING_=
KEYUP.

> +			return true;
> +
> +		default:
> +			/*
> +			 * Report the previously filtered e0 before continuing
> +			 * with the next non-filtered byte.
> +			 */
> +			serio_interrupt(port, 0xe0, 0);
> +			return false;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * Input device (hotkeys and notifications)
> + */
> +
> +static void galaxybook_input_notify(struct samsung_galaxybook *galaxybo=
ok, int event)
> +{
> +	if (!galaxybook->input)
> +		return;
> +	pr_debug_prefixed("input notification event: 0x%x\n", event);
> +	if (!sparse_keymap_report_event(galaxybook->input, event, 1, true))
> +		pr_warn("unknown input notification event: 0x%x\n", event);

Please also call acpi_bus_generate_netlink_event() so users can use acpid =
to listen to
those events. Also you need to use a mutex when calling the sparse keymap =
since multiple
ACPI notifications might happen concurrently.

> +}
> +
> +static int galaxybook_input_init(struct samsung_galaxybook *galaxybook)
> +{
> +	struct input_dev *input;
> +	int error;
> +
> +	input =3D input_allocate_device();
> +	if (!input)
> +		return -ENOMEM;
> +
> +	input->name =3D "Samsung Galaxy Book Extra Buttons";
> +	input->phys =3D SAMSUNG_GALAXYBOOK_CLASS "/input0";
> +	input->id.bustype =3D BUS_HOST;
> +	input->dev.parent =3D &galaxybook->platform->dev;
> +
> +	error =3D sparse_keymap_setup(input, galaxybook_acpi_keymap, NULL);
> +	if (error) {
> +		pr_err("Unable to setup input device keymap\n");
> +		goto err_free_dev;
> +	}
> +	error =3D input_register_device(input);
> +	if (error) {
> +		pr_err("Unable to register input device\n");
> +		goto err_free_dev;
> +	}
> +

Please remove the print statements and just return the error code. Also co=
nsider
using devm_input_allocate_device() to simplify the error handling.

> +	galaxybook->input =3D input;
> +	return 0;
> +
> +err_free_dev:
> +	input_free_device(input);
> +	return error;
> +}
> +
> +static void galaxybook_input_exit(struct samsung_galaxybook *galaxybook=
)
> +{
> +	if (galaxybook->input)
> +		input_unregister_device(galaxybook->input);
> +	galaxybook->input =3D NULL;
> +}
> +
> +/*
> + * Platform device attributes
> + */
> +
> +/* galaxybook_attrs can include start_on_lid_open, usb_charge, and/or a=
llow_recording */
> +#define MAX_NUM_DEVICE_ATTRIBUTES 3
> +
> +static struct attribute *galaxybook_attrs[MAX_NUM_DEVICE_ATTRIBUTES + 1=
] =3D { NULL };
> +static const struct attribute_group galaxybook_attrs_group =3D {
> +	.attrs =3D galaxybook_attrs,
> +};
> +
> +static int galaxybook_device_attrs_init(struct samsung_galaxybook *gala=
xybook)
> +{
> +	bool value;
> +	int err;
> +	int i =3D 0;
> +
> +	/* attempt to get each attribute's value and add them if the get does =
not fail */
> +
> +	err =3D start_on_lid_open_acpi_get(galaxybook, &value);
> +	if (err)
> +		pr_debug_prefixed("failed to get start_on_lid_open value; "
> +				  "this feature will not be enabled\n");
> +	else
> +		galaxybook_attrs[i++] =3D &dev_attr_start_on_lid_open.attr;
> +
> +	err =3D usb_charge_acpi_get(galaxybook, &value);
> +	if (err)
> +		pr_debug_prefixed("failed to get usb_charge value; "
> +				  "this feature will not be enabled\n");
> +	else
> +		galaxybook_attrs[i++] =3D &dev_attr_usb_charge.attr;
> +
> +	if (allow_recording) {
> +		pr_debug_prefixed("initializing ACPI allow_recording feature\n");
> +		err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_ALLOW_RECORDI=
NG);
> +		if (err) {
> +			pr_debug_prefixed("failed to initialize ACPI allow_recording feature=
\n");
> +			allow_recording =3D false;
> +			return 0;
> +		}
> +
> +		err =3D allow_recording_acpi_get(galaxybook, &value);
> +		if (err) {
> +			pr_debug_prefixed("failed to get allow_recording value; "
> +					  "this feature will not be enabled\n");
> +			allow_recording =3D false;
> +		} else {
> +			galaxybook_attrs[i++] =3D &dev_attr_allow_recording.attr;
> +		}
> +	}
> +
> +	return device_add_group(&galaxybook->platform->dev, &galaxybook_attrs_=
group);
> +};

Use the .is_visible callback for that please.

> +
> +static void galaxybook_device_attrs_exit(struct samsung_galaxybook *gal=
axybook)
> +{
> +	device_remove_group(&galaxybook->platform->dev, &galaxybook_attrs_grou=
p);
> +}

You can attach this group to your driver by using .dev_groups. Those will =
then be handled
automatically by the driver core.

> +
> +/*
> + * ACPI device setup
> + */
> +
> +static void galaxybook_acpi_notify(acpi_handle handle, u32 event, void =
*data)
> +{
> +	struct samsung_galaxybook *galaxybook =3D data;
> +
> +	if (event =3D=3D ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE) {
> +		pr_debug_prefixed("hotkey: performance_mode keydown\n");
> +		if (performance_mode) {
> +			schedule_work(&galaxybook->performance_mode_hotkey_work);
> +			return;
> +		}
> +	}

You do not need to use schedule_work() inside a ACPI notify handler, it al=
ready runs inside
a workqueue.

> +
> +	galaxybook_input_notify(galaxybook, event);
> +}
> +
> +static int galaxybook_enable_acpi_notify(struct samsung_galaxybook *gal=
axybook)
> +{
> +	struct sawb buf =3D { 0 };
> +	int err;
> +
> +	err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_NOTIFICATIONS)=
;
> +	if (err)
> +		return err;
> +
> +	buf.safn =3D SAFN;
> +	buf.sasb =3D SASB_NOTIFICATIONS;
> +	buf.gunm =3D GUNM_ACPI_NOTIFY_ENABLE;
> +	buf.guds[0] =3D GUDS_ACPI_NOTIFY_ENABLE;
> +
> +	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, =
SAWB_LEN_SETTINGS,
> +				      "activate ACPI notifications", &buf);
> +}
> +
> +static int galaxybook_acpi_init(struct samsung_galaxybook *galaxybook)
> +{
> +	return acpi_execute_simple_method(galaxybook->acpi->handle,
> +					  ACPI_METHOD_ENABLE, ACPI_METHOD_ENABLE_ON);
> +}
> +
> +static void galaxybook_acpi_exit(struct samsung_galaxybook *galaxybook)
> +{
> +	acpi_execute_simple_method(galaxybook->acpi->handle,
> +				   ACPI_METHOD_ENABLE, ACPI_METHOD_ENABLE_OFF);

Consider using devm_add_action_or_reset() to call this method at removal t=
ime or in
case of an probe error.

> +}
> +
> +/*
> + * Platform driver
> + */
> +
> +static int galaxybook_probe(struct platform_device *pdev)
> +{
> +	struct acpi_device *adev =3D ACPI_COMPANION(&pdev->dev);
> +	struct samsung_galaxybook *galaxybook;
> +	acpi_status status;
> +	int err;
> +
> +	dmi_check_system(galaxybook_dmi_ids);
> +
> +	pr_info("found matched device %s; loading driver\n", dev_name(&adev->d=
ev));

Working drivers should be silent by default. Also please check adev for NU=
LL first.

> +
> +	galaxybook =3D kzalloc(sizeof(struct samsung_galaxybook), GFP_KERNEL);

Please use sizeof(*galaxybook) here. Also consider using devm_kzalloc() to=
 simplify the error handling.

> +	if (!galaxybook)
> +		return -ENOMEM;
> +	/* set static pointer here so it can be used in various methods for ho=
tkeys, hwmon, etc */
> +	galaxybook_ptr =3D galaxybook;
> +
> +	galaxybook->platform =3D pdev;
> +	galaxybook->acpi =3D adev;
> +
> +	dev_set_drvdata(&galaxybook->platform->dev, galaxybook);
> +
> +	pr_debug_prefixed("initializing ACPI device\n");

Please remove.

> +	err =3D galaxybook_acpi_init(galaxybook);
> +	if (err) {
> +		pr_err("failed to initialize the ACPI device\n");
> +		goto err_free;
> +	}
> +
> +	pr_debug_prefixed("initializing ACPI power management features\n");

...

> +	err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_POWER_MANAGEME=
NT);
> +	if (err) {
> +		pr_warn("failed to initialize ACPI power management features; "
> +			"many features of this driver will not be available\n");
> +		performance_mode =3D false;
> +		battery_threshold =3D false;
> +	}
> +
> +	if (performance_mode) {
> +		pr_debug_prefixed("initializing performance mode and platform profile=
\n");
> +		err =3D galaxybook_profile_init(galaxybook);
> +		if (err) {
> +			pr_debug_prefixed(
> +				"failed to initialize performance mode and platform profile\n");
> +			performance_mode =3D false;
> +		}
> +	} else {
> +		pr_debug_prefixed("performance_mode is disabled\n");
> +	}
> +
> +	if (battery_threshold) {
> +		pr_debug_prefixed("initializing battery charge threshold control\n");
> +		err =3D galaxybook_battery_threshold_init(galaxybook);
> +		if (err) {
> +			pr_debug_prefixed(
> +				"failed to initialize battery charge threshold control\n");
> +			battery_threshold =3D false;
> +		}
> +	} else {
> +		pr_debug_prefixed("battery_threshold is disabled\n");
> +	}
> +
> +	pr_debug_prefixed("adding platform device attributes\n");
> +	err =3D galaxybook_device_attrs_init(galaxybook);
> +	if (err)
> +		pr_err("failed to add platform device attributes\n");
> +
> +	if (kbd_backlight) {
> +		pr_debug_prefixed("initializing kbd_backlight\n");
> +		err =3D galaxybook_kbd_backlight_init(galaxybook);
> +		if (err) {
> +			pr_debug_prefixed("failed to initialize kbd_backlight\n");
> +			kbd_backlight =3D false;
> +		}
> +	} else {
> +		pr_debug_prefixed("kbd_backlight is disabled\n");
> +	}
> +
> +	if (fan_speed) {
> +		pr_debug_prefixed("initializing fan speed\n");
> +		err =3D galaxybook_fan_speed_init(galaxybook);
> +		if (err) {
> +			pr_debug_prefixed("failed to initialize fan speed\n");
> +			fan_speed =3D false;
> +		} else {
> +#if IS_ENABLED(CONFIG_HWMON)
> +			pr_debug_prefixed("initializing hwmon device\n");
> +			err =3D galaxybook_hwmon_init(galaxybook);
> +			if (err)
> +				pr_warn("failed to initialize hwmon device\n");
> +#endif
> +		}
> +	} else {
> +		pr_debug_prefixed("fan_speed is disabled\n");
> +	}
> +
> +	/* i8042_filter should be disabled if kbd_backlight and allow_recordin=
g are disabled */
> +	if (!kbd_backlight && !allow_recording)
> +		i8042_filter =3D false;
> +
> +	if (i8042_filter) {
> +		pr_debug_prefixed("installing i8402 key filter to capture hotkey inpu=
t\n");
> +
> +		/* initialize hotkey work queues */
> +		if (kbd_backlight)
> +			INIT_WORK(&galaxybook->kbd_backlight_hotkey_work,
> +				  galaxybook_kbd_backlight_hotkey_work);
> +		if (allow_recording)
> +			INIT_WORK(&galaxybook->allow_recording_hotkey_work,
> +				  galaxybook_allow_recording_hotkey_work);
> +
> +		err =3D i8042_install_filter(galaxybook_i8042_filter);
> +		if (err) {
> +			pr_err("failed to install i8402 key filter\n");
> +			cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
> +			cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
> +			i8042_filter =3D false;
> +		}
> +	} else {
> +		pr_debug_prefixed("i8042_filter is disabled\n");
> +	}
> +
> +	pr_debug_prefixed("installing ACPI notify handler\n");
> +	status =3D acpi_install_notify_handler(galaxybook->acpi->handle, ACPI_=
ALL_NOTIFY,
> +					     galaxybook_acpi_notify, galaxybook);
> +	if (ACPI_SUCCESS(status)) {
> +		pr_debug_prefixed("enabling ACPI notifications\n");
> +		err =3D galaxybook_enable_acpi_notify(galaxybook);
> +		if (err) {
> +			pr_warn("failed to enable ACPI notifications; "
> +				"some hotkeys will not be supported\n");
> +		} else {
> +			/* initialize ACPI hotkey work queues */
> +			INIT_WORK(&galaxybook->performance_mode_hotkey_work,
> +				  galaxybook_performance_mode_hotkey_work);
> +
> +			pr_debug_prefixed("initializing input device\n");
> +			err =3D galaxybook_input_init(galaxybook);
> +			if (err) {
> +				pr_err("failed to initialize input device\n");
> +				cancel_work_sync(&galaxybook->performance_mode_hotkey_work);
> +				galaxybook_input_exit(galaxybook);
> +			}
> +		}

The input device provides open() and close() callbacks, maybe you can do t=
he event enabling there?
Also you should call INIT_WORK() earlier in case the ACPI firmware gives y=
ou an early notification
my mistake.

> +	} else {
> +		pr_debug_prefixed("failed to install ACPI notify handler\n");

This should result in a probe error.

> +	}
> +
> +	pr_info("driver successfully loaded\n");
> +
> +	return 0;
> +
> +err_free:
> +	kfree(galaxybook);
> +	return err;
> +}
> +
> +static void galaxybook_remove(struct platform_device *pdev)
> +{
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(&pdev->dev);
> +
> +	pr_info("removing driver\n");
> +
> +	galaxybook_device_attrs_exit(galaxybook);
> +
> +	galaxybook_input_exit(galaxybook);
> +	cancel_work_sync(&galaxybook->performance_mode_hotkey_work);
> +
> +	if (i8042_filter) {
> +		i8042_remove_filter(galaxybook_i8042_filter);
> +		cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
> +		cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
> +	}
> +
> +	acpi_remove_notify_handler(galaxybook->acpi->handle, ACPI_ALL_NOTIFY,
> +				   galaxybook_acpi_notify);

Maybe you should remove the ACPI notify handler first to avoid submitting =
a input request
on a unregistered input device.

> +
> +	if (fan_speed) {
> +		galaxybook_fan_speed_exit(galaxybook);
> +#if IS_ENABLED(CONFIG_HWMON)
> +		galaxybook_hwmon_exit(galaxybook);
> +#endif
> +	}
> +
> +	if (kbd_backlight)
> +		galaxybook_kbd_backlight_exit(galaxybook);
> +
> +	if (battery_threshold)
> +		galaxybook_battery_threshold_exit(galaxybook);
> +
> +	if (performance_mode)
> +		galaxybook_profile_exit(galaxybook);
> +
> +	galaxybook_acpi_exit(galaxybook);
> +
> +	if (galaxybook_ptr)
> +		galaxybook_ptr =3D NULL;
> +
> +	kfree(galaxybook);
> +
> +	pr_info("driver successfully removed\n");
> +}
> +
> +static struct platform_driver galaxybook_platform_driver =3D {
> +	.driver =3D {
> +		.name =3D SAMSUNG_GALAXYBOOK_CLASS,
> +		.acpi_match_table =3D galaxybook_device_ids,
> +	},
> +	.probe =3D galaxybook_probe,
> +	.remove =3D galaxybook_remove,
> +};
> +
> +static int __init samsung_galaxybook_init(void)
> +{
> +	return platform_driver_register(&galaxybook_platform_driver);
> +}
> +
> +static void __exit samsung_galaxybook_exit(void)
> +{
> +	platform_driver_unregister(&galaxybook_platform_driver);
> +}

Please use module_platform_driver() here.

In general i am ok with the general design of this driver. The things whic=
h need a bit more work are:

- the fan handling code should be inside the ACPI fan driver
- most debug messages should be replaced by tracepoints, etc or just remov=
ed
- replacing galaxybook_ptr with the state container pattern
- using devres (devm_* functions) would simplify error handling
- some events should trigger a input device event with an appropriate keyc=
ode

Thanks,
Armin Wolf

> +
> +module_init(samsung_galaxybook_init);
> +module_exit(samsung_galaxybook_exit);
> +
> +MODULE_AUTHOR("Joshua Grisham <josh@joshuagrisham.com>");
> +MODULE_DESCRIPTION(SAMSUNG_GALAXYBOOK_NAME);
> +MODULE_LICENSE("GPL");

