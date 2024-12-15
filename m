Return-Path: <linux-kernel+bounces-446547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0582D9F25F8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 21:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC1D188564B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 20:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB81BC08B;
	Sun, 15 Dec 2024 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Mizba+w3"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B2175BF;
	Sun, 15 Dec 2024 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734292984; cv=none; b=SCnoLEHIoZgOPLcnaoxD25I9FsMgXK21MRW/vAlwLr/gLL3ptAMGTdShnXnwHZ/uEjjSIYyjVWl5uK7SEXvFN5xdoe2QQWBNBwYI2cV+WKX3M19FfKiZFC8c3XjxAaKffUpvFqhkscnREq5QqY6MxNo2bQq9xHaW1IA6rspM8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734292984; c=relaxed/simple;
	bh=SGghSm/KwDKp8N9jaf1On8eSVZ7D93ZYLY8w+/qRxOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i+wQou3/mmwW/G3q7Aw1Do2Fll3hzdrXJ55VCCfD3Vk7kPHF9dSGhU6x3EjF8daCpqcDlfkb94uPirxzG28TDjxu51OqWImA16O6BbP6zlbT3yVvh2GZxMphDgp3bVK4V/dAgv/nM4vOOPRRVwGqAbedgiEPGHkf92oaz5c7Xbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Mizba+w3; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734292942; x=1734897742; i=w_armin@gmx.de;
	bh=r+S6E9YVuUkX9AN0NYqDXTgsKE+mvKMAE1sb4Oq3Cgc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Mizba+w3ZBmr5A1h6moNmlSSoS/RiyDclY0eWAs//xVLvDVVjT9a+4AOZzgXuSvq
	 O9RtWUwiPC7Kd4LFopCNO/nw3dB3VAin4UlNm4y9Mxoqqlafuf4FYZP0h0gjG5gsf
	 1WpnRri0Od5WwyvJL46gvi2qC1f2VR3Hkz0KDX2ScBoFE/miM3Yqz57DFkz+wWCyW
	 TuX6oSBePe61dXoCsuNyAtJv1xvQNdLCVQEUA0wFeQYzRN3TH+bLL+Qn1DzDAbgBK
	 f4Hsz+dt3Z6gsu/+rYOENncVu0TbveI5qI/cF/QwIOq2/MzmAxgGZ4DjVpdzE0I5O
	 OrD5FBwJEXnojcDg+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnaof-1u3dQx0pO9-00c1Za; Sun, 15
 Dec 2024 21:02:22 +0100
Message-ID: <ad96404e-60c4-40cf-b287-f81fa85d85b7@gmx.de>
Date: Sun, 15 Dec 2024 21:02:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: samsung-galaxybook: Add
 samsung-galaxybook driver
To: Joshua Grisham <josh@joshuagrisham.com>, corbet@lwn.net,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20241209163720.17597-1-josh@joshuagrisham.com>
 <20241215141352.58244-1-josh@joshuagrisham.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241215141352.58244-1-josh@joshuagrisham.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CVyZvcKXGuOdkkibP9rSj3YMY6252cBSs6OioODIoeytOn0Oul9
 GgASmbreXsS31G4PCIZyAHNmmlR4D10ZkCIhHqKm7PZClH8HOMWgdLFHNwxyxJJvoB65DSJ
 +Unh6uX9Qw7N9y8Asa0xAYGBA1Sg7EfKlmRjeiFKFhHy9LWe7/3xmApCkCJhABRyP4S20N/
 cpb4AA7iKwGUrLT38A/BQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i36DCUJs6Pg=;tbiRy4eIO3Pzd5/3LsGjvKYyknW
 k4uAJnNb8mGnZkMwGmqr/sCwpPsw0sgsnHv/BHZso2SkhDjxBvihnawfIyCZtUmW2hYqBhzW/
 qu96X3dKiPHWPDZNrrrF1+Dk/DM9rfDILCWfUVt1K15mzLGZlavBlZ/UwDTxc+PVpOuJg2Q5D
 WAfXRyGhCKhlOK3Y43pleICYAiIt2FKIWMEcfsBwHvz+PKY53GhFwR/wkcTGbEKU8zxhrcPSd
 I4OPcDbdSx5CbhAX4XoWEo/2Ke0VHczeezs91yDWWLioSkapRdcGaUJ9GCcYLdDIYUWmR/w8f
 E0se5pzmWnXbZm0gDSUXxiG77D3CHmFlpcnzK/JDe8yNH1vgn/rr2KHdPQdsRaoFoCDkR+DQt
 BRuRaNeNeiJfGDUkRvLqSsefAjTmxxFXtUPjQi0QRQqZ9ogTXZJSoyj9D0G5MUDox2VthmAJ/
 jwx7ndLUCNhy+u+f87mwCQRehc+X+rdHvGniAaMsnUBtkP9HeyRrXSgo0R7WcLO5FNSqLkh1S
 SDZseLp6hcclqvGyUWv4fRnQtWE50JpRao0UnOBCDufQ8gDdJFHxUGGbfTbwPBfalV+eqBv0F
 Ifz9tRSq/LfmvVEM55RIrIaFGHIyRWh/VgDsAIHJntj9+4V5QMgh1OsCqQmFpzyzvzJg6/ha0
 NJeoul3GE/5J+gbZCC1OlB1gEp140flhhMTaYK3CQ3S4rI/LxjkG6HiOppXkIVxPeNWbvs9tt
 D7TErUngCwkXdsbOfb5JVvzJroistKo6yQxcHZSZTQhWXS+6TEymd1G3jAhwzb3XIyK1CnBfs
 iaB3BXKebL7vyHTd3WTiQAOl4TXaOTKhmqajr21PLtl3DyMPbaKT9vqYSF1sVHcoT2sXgR1Wf
 UtjnhnzhGSehqJlwCJOp4X6spph9epQNUw1rR4dZLhk5xLpuRu+ERVtMWPb9AZLidG0e3/GeN
 Qh5/sDxR4s939RNVIzWBhs3mG1mKAhNGaW1zyrwjEOAfqL5XM5hnmJi6ajiS51FYjrLjZf/w3
 ZssgdfLHFebYqTV2v2ZLq3czMZ/dMS/qOBBcnyhLR8luki3JuBXDIYkxozegEY+P3vlaVmCyo
 GYA2zhdX71u5mAFJ8vqXVsnb0IMjtu

Am 15.12.24 um 15:13 schrieb Joshua Grisham:

> Thank you all very much for the wealth of information provided in the
> response to the first version of this patch. As there was quite a lot of
> information to look into, I took a few days as I had the time and tried =
to
> resolve everything that I could; the result is the attached updates to t=
he
> first patch.
>
> I will aim to reply a bit more in detail to the thread and try to addres=
s
> each review comment one-by-one, but within this v2 of the patch itself I
> just wanted to mention some highlights of what has been changed with thi=
s
> attached update:
>
> 1. Completely removed support for fan speed monitoring (including the
> associated hwmon device) -- I agree, it does make a lot more sense if
> support for fan devices with only _FST method is built in to the ACPI co=
re
> (as my guess is there are MANY devices in the wild like this). This
> actually removes many of the review comments/issues as well which is a b=
it
> of a win-win!
>
> 2. Took a step back to regroup regarding what the logging within the dri=
ver
> should be like if it is "production ready". In pursuit of this, I did th=
e
> following:
>    - Removed almost all of the existing print messages
>    - Those which remained I have changed to use a relevant dev_* functio=
n
>    (instead of pr_*) and have moved everything to either warn, error, or
>    debug (for messages which myself as a likely initial maintainer of th=
is
>    driver would get a lot of help from), as seemed appropriate to me.
>    - I removed the built-in hex printing of the ACPI buffers and as
>    suggested by @Armin I have created a new tracepoint which can be enab=
led
>    and will provide full debug of all buffers that are being sent and
>    received from the ACPI device itself via this driver. Note: As the
>    payloads for these devices can be quite large (up to 256 bytes), plus
>    that different models behave slightly differently and have different
>    features, I have found it very necessary to have the availabily for u=
sers
>    to send this information to me, whether it is in the form of a tracep=
oint
>    as I have added now, or otherwise.
>
> 3. Everywhere possible, I have tried to implement the devres version of
> various registration functions, and when there was not a devres function
> available then I have tried to make use of devm_add_action_or_reset() to
> add a hook to handle the exits to try and achieve a similar result.
>
> 4. Tried to remove usage of the global pointer galaxybook_ptr, but with
> mixed success.
>    - Again, as the hwmon device has been removed, its usage of
>    galaxybook_ptr was also removed!
>    - From what I can see, I don't think there are actually any existing =
x86
>    platform drivers that do NOT currently use a global pointer variable =
for
>    the battery extension sysfs attributes (even the Dell driver is
>    eventually using a static struct of "interface tokens" when you drill

The dell-wmi-ddv driver does manage his battery extension without any glob=
al variables.
Could it be that you confused it with another Dell driver?

>    all the way down to the bottom) BUT I was able to take some inspirati=
on
>    from the Chrome OS battery driver and do think I have managed it quit=
e
>    well now in this driver by using a dev_ext_attribute where I have add=
ed a
>    reference to the needed private data on the attribute itself.
>    - For the i8042 filter, again I could not find any instance of any dr=
iver
>    that seems to NOT be using a global pointer variable to execute any
>    actions, and on top of that I was not really able to easily figure ou=
t a
>    good way to rig up a struct member that would work using container_of=
. I
>    tried several things including trying to use a double pointer to the
>    function itself to then fetch the private data struct, but it did not
>    really work super well and the logic felt very "heavy" for an IO filt=
er
>    in the end. I think a better design for this would be if i8042 filter=
s
>    could be installed with extended data so that we can actually provide=
 a
>    pointer and then just use it directly in the filter hook function its=
elf.
>    So, for now, I have left the galaxybook_ptr in, but it is only used i=
n
>    the i8042 filter.

Good point, i think this is an issue within the i8042 driver itself, so us=
ing
galaxybook_ptr here is OK for now.

Please submit this v2 patch as its own separate patch as described in
https://docs.kernel.org/process/submitting-patches.html ("The canonical pa=
tch format").

If you use "git send-email", you can use the -v2 option to automatically a=
djust the patch
header.

You can describe the changes you made like this:

     <commit message>
     ...
     Signed-off-by: Author <author@mail>
     ---
     V1 -> V2:
     - <description of changes>
     - ...

     path/to/file | 5+++--
     ...

Thanks,
Armin Wolf

>
> Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
> ---
>   .../laptops/samsung-galaxybook.rst            |   65 +-
>   MAINTAINERS                                   |    2 +
>   drivers/platform/x86/Kconfig                  |    1 -
>   .../platform/x86/samsung-galaxybook-trace.h   |   51 +
>   drivers/platform/x86/samsung-galaxybook.c     | 1329 +++++------------
>   5 files changed, 446 insertions(+), 1002 deletions(-)
>   create mode 100644 drivers/platform/x86/samsung-galaxybook-trace.h
>
> diff --git a/Documentation/admin-guide/laptops/samsung-galaxybook.rst b/=
Documentation/admin-guide/laptops/samsung-galaxybook.rst
> index ab12f0001..c174cb255 100644
> --- a/Documentation/admin-guide/laptops/samsung-galaxybook.rst
> +++ b/Documentation/admin-guide/laptops/samsung-galaxybook.rst
> @@ -33,11 +33,10 @@ The following features are currently supported:
>   - :ref:`Battery charge control end threshold
>     <battery-charge-control-end-threshold>` (stop charging battery at gi=
ven
>     percentage value) implemented as a battery device extension
> -- :ref:`Fan speed <fan-speed>` monitoring via ``fan_speed_rpm`` sysfs a=
ttribute
> -  plus a new hwmon device
>   - :ref:`Settings Attributes <settings-attributes>` to allow control of=
 various
>     device settings
>   - :ref:`Handling of Fn hotkeys <keyboard-hotkey-actions>` for various =
actions
> +- :ref:`Tracepoint <tracepoint>` event for debugging ACPI device commun=
ication
>
>   Because different models of these devices can vary in their features, =
there is
>   logic built within the driver which attempts to test each implemented =
feature
> @@ -62,7 +61,6 @@ enabling or disabling various features:
>   - ``kbd_backlight``: Enable Keyboard Backlight control (default on)
>   - ``performance_mode``: Enable Performance Mode control (default on)
>   - ``battery_threshold``: Enable battery charge threshold control (defa=
ult on)
> -- ``fan_speed``: Enable fan speed (default on)
>   - ``allow_recording``: Enable control to allow or block access to came=
ra and
>     microphone (default on)
>   - ``i8042_filter``: Enable capture and execution of keyboard-based hot=
key events
> @@ -154,46 +152,6 @@ services as "on" or "off". Otherwise, the device wi=
ll accept any value between 0
>     will set the attribute value to 0 (i.e. 100% will "remove" the end t=
hreshold).
>
>
> -.. _fan-speed:
> -
> -Fan speed
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Controlled by parameter: ``fan_speed``
> -
> -The number and type of fans on these devices can vary, and different me=
thods
> -must be used in order to be able to successfully read their status.
> -
> -In cases where Samsung has implemented the standard ACPI method ``_FST`=
` for a
> -fan device, the other methods in the ACPI specification which would cau=
se
> -the kernel to automatically add the ``fan_speed_rpm`` attribute are not=
 always
> -present. On top of this, it seems that there are some bugs in the firmw=
are that
> -throw an exception when the ``_FST`` method is executed.
> -
> -This platform driver attempts to resolve all PNP fans that are present =
in the
> -ACPI of supported devices, and add support for reading their speed usin=
g the
> -following decision tree:
> -
> -1. Do all 4 required methods exist so that the fan speed should be repo=
rted
> -   out-of-the-box by ACPI? If yes, then assume this fan is already set =
up and
> -   available.
> -
> -2. Does the method ``_FST`` exist and appears to be working (returns a =
speed
> -   value greater than 0)? If yes, add an attribute ``fan_speed_rpm`` to=
 this fan
> -   device and add a fan input channel for it to the hwmon device. The r=
eturned
> -   value will be directly read from the ``_FST`` method.
> -
> -3. Does the field ``FANS`` (fan speed level) exist on the embedded cont=
roller,
> -   and the table ``FANT`` (fan speed level table) exist on the fan devi=
ce? If
> -   yes, add the ``fan_speed_rpm`` attribute to this fan device and add =
a fan
> -   input channel for it to the hwmon device. The returned value will be=
 based
> -   on a match of the current value of ``FANS`` compared to a list of le=
vel
> -   speeds from the ``FANT`` table.
> -
> -The fan speed for all supported fans can be monitored using hwmon senso=
rs or by
> -reading the ``fan_speed_rpm`` sysfs attribute of each fan device.
> -
> -
>   .. _settings-attributes:
>
>   Settings Attributes
> @@ -299,3 +257,24 @@ The Fn+F11 Performance mode hotkey is received as a=
n ACPI notification. It will
>   be handled in a similar way as the Fn+F9 and Fn+F10 hotkeys; namely, t=
hat the
>   keypress will be swallowed by the driver and each press will cycle to =
the next
>   available platform profile.
> +
> +
> +.. _tracepoint:
> +
> +Tracepoint for debugging ACPI communication
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A new tracepoint event ``samsung_galaxybook:samsung_galaxybook_acpi`` w=
ill
> +provide a trace of the buffers sent to, and received from, the ACPI dev=
ice
> +methods.
> +
> +Here is an example of how to use it: ::
> +
> +  # Enable tracepoint events
> +  echo 1 | sudo tee /sys/kernel/tracing/events/samsung_galaxybook/enabl=
e
> +
> +  # Perform some actions using the driver and then read the result
> +  sudo cat /sys/kernel/tracing/trace
> +
> +  # Disable tracepoint events when you are finished
> +  echo 0 | sudo tee /sys/kernel/tracing/events/samsung_galaxybook/enabl=
e
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 21b4fc504..9e3b45cf7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20737,6 +20737,8 @@ SAMSUNG GALAXY BOOK EXTRAS DRIVER
>   M:	Joshua Grisham <josh@joshuagrisham.com>
>   L:	platform-driver-x86@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/admin-guide/laptops/samsung-galaxybook.rst
> +F:	drivers/platform/x86/samsung-galaxybook-trace.h
>   F:	drivers/platform/x86/samsung-galaxybook.c
>
>   SAMSUNG INTERCONNECT DRIVERS
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index b6d28b6a4..03f4fb0e9 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -784,7 +784,6 @@ config SAMSUNG_GALAXYBOOK
>   	depends on ACPI_BATTERY
>   	depends on INPUT
>   	depends on SERIO_I8042
> -	depends on HWMON || HWMON =3D n
>   	select ACPI_PLATFORM_PROFILE
>   	select INPUT_SPARSEKMAP
>   	select NEW_LEDS
> diff --git a/drivers/platform/x86/samsung-galaxybook-trace.h b/drivers/p=
latform/x86/samsung-galaxybook-trace.h
> new file mode 100644
> index 000000000..09ab6dbe6
> --- /dev/null
> +++ b/drivers/platform/x86/samsung-galaxybook-trace.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Samsung Galaxy Book series extras driver tracepoint events
> + *
> + * Copyright (c) 2024 Joshua Grisham <josh@joshuagrisham.com>
> + */
> +
> +#if !defined(_TRACE_SAMSUNG_GALAXYBOOK_H_) || defined(TRACE_HEADER_MULT=
I_READ)
> +#define _TRACE_SAMSUNG_GALAXYBOOK_H_
> +
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM samsung_galaxybook
> +
> +#define GALAXYBOOK_TRACE_MAX_ACPI_BUF_LENGTH 0x100
> +
> +TRACE_EVENT(samsung_galaxybook_acpi,
> +	TP_PROTO(const char *devname, const char *method, const char *label, u=
8 *buf, size_t len),
> +	TP_ARGS(devname, method, label, buf, len),
> +	TP_STRUCT__entry(
> +		__string(devname, devname)
> +		__string(method, method)
> +		__string(label, label)
> +		__array(u8, buf, GALAXYBOOK_TRACE_MAX_ACPI_BUF_LENGTH)
> +		__field(size_t, len)
> +	),
> +	TP_fast_assign(
> +		__assign_str(devname);
> +		__assign_str(method);
> +		__assign_str(label);
> +		memcpy(__entry->buf, buf, len);
> +		__entry->len =3D len;
> +	),
> +	TP_printk("device: %s, method: %s, %s: %s",
> +		  __get_str(devname),
> +		  __get_str(method),
> +		  __get_str(label),
> +		  __print_hex(__entry->buf, __entry->len))
> +);
> +
> +#endif
> +
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE
> +
> +#define TRACE_INCLUDE_PATH ../../drivers/platform/x86
> +#define TRACE_INCLUDE_FILE samsung-galaxybook-trace
> +
> +#include <trace/define_trace.h>
> diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platfor=
m/x86/samsung-galaxybook.c
> index ce8b76d91..4bbd33e83 100644
> --- a/drivers/platform/x86/samsung-galaxybook.c
> +++ b/drivers/platform/x86/samsung-galaxybook.c
> @@ -11,11 +11,8 @@
>    * Thank you to the authors!
>    */
>
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>   #include <linux/acpi.h>
> -#include <linux/dmi.h>
> -#include <linux/hwmon.h>
> +#include <linux/err.h>
>   #include <linux/i8042.h>
>   #include <linux/init.h>
>   #include <linux/input.h>
> @@ -24,15 +21,19 @@
>   #include <linux/leds.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
> -#include <linux/nls.h>
> +#include <linux/mutex.h>
>   #include <linux/platform_device.h>
>   #include <linux/platform_profile.h>
>   #include <linux/serio.h>
> +#include <linux/sysfs.h>
> +#include <linux/uuid.h>
>   #include <linux/workqueue.h>
>   #include <acpi/battery.h>
>
> -#define SAMSUNG_GALAXYBOOK_CLASS  "samsung-galaxybook"
> -#define SAMSUNG_GALAXYBOOK_NAME   "Samsung Galaxy Book Extras"
> +#define CREATE_TRACE_POINTS
> +#include "samsung-galaxybook-trace.h"
> +
> +#define DRIVER_NAME "samsung-galaxybook"
>
>   /*
>    * Module parameters
> @@ -42,21 +43,18 @@ static bool kbd_backlight =3D true;
>   static bool battery_threshold =3D true;
>   static bool performance_mode =3D true;
>   static bool allow_recording =3D true;
> -static bool fan_speed =3D true;
>   static bool i8042_filter =3D true;
>
> -module_param(kbd_backlight, bool, 0644);
> +module_param(kbd_backlight, bool, 0);
>   MODULE_PARM_DESC(kbd_backlight, "Enable Keyboard Backlight control (de=
fault on)");
> -module_param(battery_threshold, bool, 0644);
> +module_param(battery_threshold, bool, 0);
>   MODULE_PARM_DESC(battery_threshold, "Enable battery charge threshold c=
ontrol (default on)");
> -module_param(performance_mode, bool, 0644);
> +module_param(performance_mode, bool, 0);
>   MODULE_PARM_DESC(performance_mode, "Enable Performance Mode control (d=
efault on)");
> -module_param(allow_recording, bool, 0644);
> +module_param(allow_recording, bool, 0);
>   MODULE_PARM_DESC(allow_recording,
>   		 "Enable control to allow or block access to camera and microphone (=
default on)");
> -module_param(fan_speed, bool, 0644);
> -MODULE_PARM_DESC(fan_speed, "Enable fan speed (default on)");
> -module_param(i8042_filter, bool, 0644);
> +module_param(i8042_filter, bool, 0);
>   MODULE_PARM_DESC(i8042_filter, "Enable capturing keyboard hotkey event=
s (default on)");
>
>   /*
> @@ -72,49 +70,25 @@ static const struct acpi_device_id galaxybook_device=
_ids[] =3D {
>   };
>   MODULE_DEVICE_TABLE(acpi, galaxybook_device_ids);
>
> -static const struct dmi_system_id galaxybook_dmi_ids[] =3D {
> -	{
> -		.matches =3D {
> -			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
> -			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
> -		},
> -	},
> -	{}
> -};
> -
> -struct galaxybook_fan {
> -	struct acpi_device fan;
> -	char *description;
> -	bool supports_fst;
> -	unsigned int *fan_speeds;
> -	int fan_speeds_count;
> -	struct dev_ext_attribute fan_speed_rpm_ext_attr;
> -};
> -
> -#define MAX_FAN_COUNT 5
> -
>   struct samsung_galaxybook {
>   	struct platform_device *platform;
>   	struct acpi_device *acpi;
> +	struct mutex acpi_lock;
>
>   	struct led_classdev kbd_backlight;
> -	struct work_struct kbd_backlight_hotkey_work;
>
>   	struct input_dev *input;
> -	struct key_entry *keymap;
> -
> -	u8 *profile_performance_modes;
> -	struct platform_profile_handler profile_handler;
> -	struct work_struct performance_mode_hotkey_work;
> +	struct mutex input_lock;
>
> +	void *i8042_filter_ptr;
> +	struct work_struct kbd_backlight_hotkey_work;
>   	struct work_struct allow_recording_hotkey_work;
>
> -	struct galaxybook_fan fans[MAX_FAN_COUNT];
> -	int fans_count;
> +	struct acpi_battery_hook battery_hook;
> +	struct dev_ext_attribute battery_charge_control_attr;
>
> -#if IS_ENABLED(CONFIG_HWMON)
> -	struct device *hwmon;
> -#endif
> +	u8 *profile_performance_modes;
> +	struct platform_profile_handler profile_handler;
>   };
>   static struct samsung_galaxybook *galaxybook_ptr;
>
> @@ -217,10 +191,6 @@ static const guid_t performance_mode_guid_value =3D
>   #define ACPI_METHOD_SETTINGS         "CSFI"
>   #define ACPI_METHOD_PERFORMANCE_MODE "CSXI"
>
> -#define ACPI_FAN_DEVICE_ID    "PNP0C0B"
> -#define ACPI_FAN_SPEED_LIST   "FANT"
> -#define ACPI_FAN_SPEED_VALUE  "\\_SB.PC00.LPCB.H_EC.FANS"
> -
>   #define KBD_BACKLIGHT_MAX_BRIGHTNESS  3
>
>   #define ACPI_NOTIFY_BATTERY_STATE_CHANGED    0x61
> @@ -245,126 +215,72 @@ static const struct key_entry galaxybook_acpi_key=
map[] =3D {
>    * ACPI method handling
>    */
>
> -#define pr_debug_prefixed(...) pr_debug("[DEBUG] " __VA_ARGS__)
> -
> -#define print_acpi_object_buffer_debug(header_str, buf_ptr, buf_len)	\
> -	do {								\
> -		pr_debug_prefixed("%s\n", header_str);			\
> -		print_hex_dump_debug("samsung_galaxybook: [DEBUG]   ",	\
> -				     DUMP_PREFIX_NONE, 16, 1, buf_ptr,	\
> -				     buf_len, false);			\
> -	} while (0)
> -
> -static char *get_acpi_device_description(struct acpi_device *acpi_dev)
> -{
> -	struct acpi_buffer str_buf =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -	union acpi_object *str_obj;
> -	struct acpi_buffer name_buf =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -	acpi_status status;
> -	int result;
> -
> -	/* first try to get value of _STR (and also convert it to utf8)  */
> -	if (!acpi_has_method(acpi_dev->handle, "_STR"))
> -		goto use_name;
> -	status =3D acpi_evaluate_object_typed(acpi_dev->handle, "_STR", NULL,
> -					   &str_buf, ACPI_TYPE_BUFFER);
> -	if (ACPI_SUCCESS(status) && str_buf.length > 0) {
> -		str_obj =3D str_buf.pointer;
> -		char *buf =3D kzalloc(sizeof(*buf) * str_obj->buffer.length, GFP_KERN=
EL);
> -
> -		result =3D utf16s_to_utf8s((wchar_t *)str_obj->buffer.pointer,
> -					 str_obj->buffer.length,
> -					 UTF16_LITTLE_ENDIAN, buf,
> -					 PAGE_SIZE - 1);
> -		kfree(str_obj);
> -		if (result > 0)
> -			return buf;
> -		/* if no result then free buf */
> -		kfree(buf);
> -	}
> -
> -	kfree(str_buf.pointer);
> -
> -use_name:
> -	/* if _STR is missing then just use the device name */
> -	status =3D acpi_get_name(acpi_dev->handle, ACPI_SINGLE_NAME, &name_buf=
);
> -	if (ACPI_SUCCESS(status) && name_buf.length > 0)
> -		return name_buf.pointer;
> -
> -	kfree(name_buf.pointer);
> -
> -	return NULL;
> -}
> -
>   static int galaxybook_acpi_method(struct samsung_galaxybook *galaxyboo=
k, acpi_string method,
> -				  struct sawb *buf, u32 len, const char *purpose_str,
> -				  struct sawb *ret)
> +				  struct sawb *in_buf, size_t len, const char *purpose_str,
> +				  struct sawb *out_buf)
>   {
> +	struct acpi_buffer output =3D {ACPI_ALLOCATE_BUFFER, NULL};
>   	union acpi_object in_obj, *out_obj;
>   	struct acpi_object_list input;
> -	struct acpi_buffer output =3D {ACPI_ALLOCATE_BUFFER, NULL};
>   	acpi_status status;
> +	int err;
> +
> +	mutex_lock(&galaxybook->acpi_lock);
>
>   	in_obj.type =3D ACPI_TYPE_BUFFER;
>   	in_obj.buffer.length =3D len;
> -	in_obj.buffer.pointer =3D (u8 *)buf;
> +	in_obj.buffer.pointer =3D (u8 *)in_buf;
>
>   	input.count =3D 1;
>   	input.pointer =3D &in_obj;
>
> -	print_acpi_object_buffer_debug(purpose_str, in_obj.buffer.pointer, in_=
obj.buffer.length);
> +	trace_samsung_galaxybook_acpi(dev_name(&galaxybook->acpi->dev), method=
, purpose_str,
> +				      in_obj.buffer.pointer, in_obj.buffer.length);
>
> -	status =3D acpi_evaluate_object(galaxybook->acpi->handle, method, &inp=
ut, &output);
> +	status =3D acpi_evaluate_object_typed(galaxybook->acpi->handle, method=
, &input, &output,
> +					    ACPI_TYPE_BUFFER);
>
>   	if (ACPI_FAILURE(status)) {
> -		pr_err("failed %s with ACPI method %s; got %s\n", purpose_str, method=
,
> -		       acpi_format_exception(status));
> -		return status;
> +		dev_err(&galaxybook->acpi->dev, "failed %s with ACPI method %s; got %=
s\n",
> +			purpose_str, method, acpi_format_exception(status));
> +		err =3D -ENXIO;
> +		goto out_free;
>   	}
>
>   	out_obj =3D output.pointer;
>
> -	if (out_obj->type !=3D ACPI_TYPE_BUFFER) {
> -		pr_err("failed %s with ACPI method %s; response was not a buffer\n",
> -			purpose_str, method);
> -		status =3D -EIO;
> -		goto out_free;
> -	}
> -
> -	print_acpi_object_buffer_debug("response was: ", out_obj->buffer.point=
er,
> -				       out_obj->buffer.length);
> +	trace_samsung_galaxybook_acpi(dev_name(&galaxybook->acpi->dev), method=
, "response",
> +				      out_obj->buffer.pointer, out_obj->buffer.length);
>
> -	if (out_obj->buffer.length !=3D len) {
> -		pr_err("failed %s with ACPI method %s; response length mismatch\n",
> +	if (out_obj->buffer.length !=3D len || out_obj->buffer.length < SAWB_G=
UNM_POS + 1) {
> +		dev_err(&galaxybook->acpi->dev, "failed %s with ACPI method %s; "
> +		       "response length mismatch\n",
>   		       purpose_str, method);
> -		status =3D -EIO;
> -		goto out_free;
> -	}
> -	if (out_obj->buffer.length < SAWB_GUNM_POS + 1) {
> -		pr_err("failed %s with ACPI method %s; response from device was too s=
hort\n",
> -		       purpose_str, method);
> -		status =3D -EIO;
> +		err =3D -ETOOSMALL;
>   		goto out_free;
>   	}
>   	if (out_obj->buffer.pointer[SAWB_RFLG_POS] !=3D RFLG_SUCCESS) {
> -		pr_err("failed %s with ACPI method %s; "
> +		dev_err(&galaxybook->acpi->dev, "failed %s with ACPI method %s; "
>   		       "device did not respond with success code 0x%x\n",
>   		       purpose_str, method, RFLG_SUCCESS);
> -		status =3D -EIO;
> +		err =3D -EIO;
>   		goto out_free;
>   	}
>   	if (out_obj->buffer.pointer[SAWB_GUNM_POS] =3D=3D GUNM_FAIL) {
> -		pr_err("failed %s with ACPI method %s; device responded with failure =
code 0x%x\n",
> +		dev_err(&galaxybook->acpi->dev,
> +			"failed %s with ACPI method %s; device responded with failure code 0=
x%x\n",
>   		       purpose_str, method, GUNM_FAIL);
> -		status =3D -EIO;
> +		err =3D -EIO;
>   		goto out_free;
>   	}
>
> -	memcpy(ret, out_obj->buffer.pointer, len);
> +	memcpy(out_buf, out_obj->buffer.pointer, len);
> +	err =3D 0;
>
>   out_free:
> -	kfree(output.pointer);
> -	return status;
> +	kfree(out_obj);
> +	mutex_unlock(&galaxybook->acpi_lock);
> +	return err;
>   }
>
>   static int galaxybook_enable_acpi_feature(struct samsung_galaxybook *g=
alaxybook, const u16 sasb)
> @@ -411,8 +327,6 @@ static int kbd_backlight_acpi_set(struct samsung_gal=
axybook *galaxybook,
>
>   	galaxybook->kbd_backlight.brightness =3D brightness;
>
> -	pr_debug_prefixed("set kbd_backlight brightness to %d\n", brightness);
> -
>   	return 0;
>   }
>
> @@ -434,8 +348,6 @@ static int kbd_backlight_acpi_get(struct samsung_gal=
axybook *galaxybook,
>   	*brightness =3D buf.gunm;
>   	galaxybook->kbd_backlight.brightness =3D buf.gunm;
>
> -	pr_debug_prefixed("current kbd_backlight brightness is %d\n", buf.gunm=
);
> -
>   	return 0;
>   }
>
> @@ -444,13 +356,8 @@ static int kbd_backlight_store(struct led_classdev =
*led,
>   {
>   	struct samsung_galaxybook *galaxybook =3D
>   		container_of(led, struct samsung_galaxybook, kbd_backlight);
> -	int err;
> -
> -	err =3D kbd_backlight_acpi_set(galaxybook, brightness);
> -	if (err)
> -		return err;
>
> -	return 0;
> +	return kbd_backlight_acpi_set(galaxybook, brightness);
>   }
>
>   static enum led_brightness kbd_backlight_show(struct led_classdev *led=
)
> @@ -469,8 +376,8 @@ static enum led_brightness kbd_backlight_show(struct=
 led_classdev *led)
>
>   static int galaxybook_kbd_backlight_init(struct samsung_galaxybook *ga=
laxybook)
>   {
> -	enum led_brightness brightness;
>   	struct led_init_data init_data =3D {};
> +	enum led_brightness brightness;
>   	int err;
>
>   	err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_KBD_BACKLIGHT=
);
> @@ -482,27 +389,17 @@ static int galaxybook_kbd_backlight_init(struct sa=
msung_galaxybook *galaxybook)
>   	if (err)
>   		return err;
>
> -	init_data.devicename =3D SAMSUNG_GALAXYBOOK_CLASS;
> -	init_data.default_label =3D ":kbd_backlight";
> +	init_data.devicename =3D DRIVER_NAME;
> +	init_data.default_label =3D ":" LED_FUNCTION_KBD_BACKLIGHT;
>   	init_data.devname_mandatory =3D true;
>
> -	galaxybook->kbd_backlight =3D (struct led_classdev){
> -		.brightness_get =3D kbd_backlight_show,
> -		.brightness_set_blocking =3D kbd_backlight_store,
> -		.flags =3D LED_BRIGHT_HW_CHANGED,
> -		.max_brightness =3D KBD_BACKLIGHT_MAX_BRIGHTNESS,
> -	};
> -
> -	pr_info("registering LED class using default name of %s:%s\n",
> -		init_data.devicename, init_data.default_label);
> -
> -	return led_classdev_register_ext(&galaxybook->platform->dev, &galaxybo=
ok->kbd_backlight,
> -					 &init_data);
> -}
> +	galaxybook->kbd_backlight.brightness_get =3D kbd_backlight_show;
> +	galaxybook->kbd_backlight.brightness_set_blocking =3D kbd_backlight_st=
ore;
> +	galaxybook->kbd_backlight.flags =3D LED_BRIGHT_HW_CHANGED;
> +	galaxybook->kbd_backlight.max_brightness =3D KBD_BACKLIGHT_MAX_BRIGHTN=
ESS;
>
> -static void galaxybook_kbd_backlight_exit(struct samsung_galaxybook *ga=
laxybook)
> -{
> -	led_classdev_unregister(&galaxybook->kbd_backlight);
> +	return devm_led_classdev_register_ext(&galaxybook->platform->dev,
> +					      &galaxybook->kbd_backlight, &init_data);
>   }
>
>   /*
> @@ -514,23 +411,16 @@ static void galaxybook_kbd_backlight_exit(struct s=
amsung_galaxybook *galaxybook)
>   static int start_on_lid_open_acpi_set(struct samsung_galaxybook *galax=
ybook, const bool value)
>   {
>   	struct sawb buf =3D { 0 };
> -	int err;
>
>   	buf.safn =3D SAFN;
>   	buf.sasb =3D SASB_POWER_MANAGEMENT;
>   	buf.gunm =3D GUNM_POWER_MANAGEMENT;
>   	buf.guds[0] =3D GUDS_START_ON_LID_OPEN;
>   	buf.guds[1] =3D GUDS_START_ON_LID_OPEN_SET;
> -	buf.guds[2] =3D value;
> +	buf.guds[2] =3D value ? 1 : 0;
>
> -	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> -				     "setting start_on_lid_open", &buf);
> -	if (err)
> -		return err;
> -
> -	pr_debug_prefixed("turned start_on_lid_open %s\n", value ? "on (1)" : =
"off (0)");
> -
> -	return 0;
> +	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, =
SAWB_LEN_SETTINGS,
> +				      "setting start_on_lid_open", &buf);
>   }
>
>   static int start_on_lid_open_acpi_get(struct samsung_galaxybook *galax=
ybook, bool *value)
> @@ -551,9 +441,6 @@ static int start_on_lid_open_acpi_get(struct samsung=
_galaxybook *galaxybook, boo
>
>   	*value =3D buf.guds[1];
>
> -	pr_debug_prefixed("start_on_lid_open is currently %s\n",
> -			  (buf.guds[1] ? "on (1)" : "off (0)"));
> -
>   	return 0;
>   }
>
> @@ -564,9 +451,13 @@ static ssize_t start_on_lid_open_store(struct devic=
e *dev, struct device_attribu
>   	bool value;
>   	int err;
>
> -	if (!count || kstrtobool(buffer, &value))
> +	if (!count)
>   		return -EINVAL;
>
> +	err =3D kstrtobool(buffer, &value);
> +	if (err)
> +		return err;
> +
>   	err =3D start_on_lid_open_acpi_set(galaxybook, value);
>   	if (err)
>   		return err;
> @@ -595,20 +486,13 @@ static DEVICE_ATTR_RW(start_on_lid_open);
>   static int usb_charge_acpi_set(struct samsung_galaxybook *galaxybook, =
const bool value)
>   {
>   	struct sawb buf =3D { 0 };
> -	int err;
>
>   	buf.safn =3D SAFN;
>   	buf.sasb =3D SASB_USB_CHARGE_SET;
>   	buf.gunm =3D value ? GUNM_USB_CHARGE_ON : GUNM_USB_CHARGE_OFF;
>
> -	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> -				     "setting usb_charge", &buf);
> -	if (err)
> -		return err;
> -
> -	pr_debug_prefixed("turned usb_charge %s\n", value ? "on (1)" : "off (0=
)");
> -
> -	return 0;
> +	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, =
SAWB_LEN_SETTINGS,
> +				      "setting usb_charge", &buf);
>   }
>
>   static int usb_charge_acpi_get(struct samsung_galaxybook *galaxybook, =
bool *value)
> @@ -627,8 +511,6 @@ static int usb_charge_acpi_get(struct samsung_galaxy=
book *galaxybook, bool *valu
>
>   	*value =3D buf.gunm;
>
> -	pr_debug_prefixed("usb_charge is currently %s\n", (buf.gunm ? "on (1)"=
 : "off (0)"));
> -
>   	return 0;
>   }
>
> @@ -639,9 +521,13 @@ static ssize_t usb_charge_store(struct device *dev,=
 struct device_attribute *att
>   	bool value;
>   	int err;
>
> -	if (!count || kstrtobool(buffer, &value))
> +	if (!count)
>   		return -EINVAL;
>
> +	err =3D kstrtobool(buffer, &value);
> +	if (err)
> +		return err;
> +
>   	err =3D usb_charge_acpi_set(galaxybook, value);
>   	if (err)
>   		return err;
> @@ -669,21 +555,14 @@ static DEVICE_ATTR_RW(usb_charge);
>   static int allow_recording_acpi_set(struct samsung_galaxybook *galaxyb=
ook, const bool value)
>   {
>   	struct sawb buf =3D { 0 };
> -	int err;
>
>   	buf.safn =3D SAFN;
>   	buf.sasb =3D SASB_ALLOW_RECORDING;
>   	buf.gunm =3D GUNM_SET;
> -	buf.guds[0] =3D value;
> -
> -	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> -				     "setting allow_recording", &buf);
> -	if (err)
> -		return err;
> -
> -	pr_debug_prefixed("turned allow_recording %s\n", value ? "on (1)" : "o=
ff (0)");
> +	buf.guds[0] =3D value ? 1 : 0;
>
> -	return 0;
> +	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, =
SAWB_LEN_SETTINGS,
> +				      "setting allow_recording", &buf);
>   }
>
>   static int allow_recording_acpi_get(struct samsung_galaxybook *galaxyb=
ook, bool *value)
> @@ -700,9 +579,7 @@ static int allow_recording_acpi_get(struct samsung_g=
alaxybook *galaxybook, bool
>   	if (err)
>   		return err;
>
> -	*value =3D buf.gunm;
> -
> -	pr_debug_prefixed("allow_recording is currently %s\n", (buf.gunm ? "on=
 (1)" : "off (0)"));
> +	*value =3D buf.gunm =3D=3D 1;
>
>   	return 0;
>   }
> @@ -714,9 +591,13 @@ static ssize_t allow_recording_store(struct device =
*dev, struct device_attribute
>   	bool value;
>   	int err;
>
> -	if (!count || kstrtobool(buffer, &value))
> +	if (!count)
>   		return -EINVAL;
>
> +	err =3D kstrtobool(buffer, &value);
> +	if (err)
> +		return err;
> +
>   	err =3D allow_recording_acpi_set(galaxybook, value);
>   	if (err)
>   		return err;
> @@ -739,36 +620,78 @@ static ssize_t allow_recording_show(struct device =
*dev, struct device_attribute
>
>   static DEVICE_ATTR_RW(allow_recording);
>
> +static umode_t galaxybook_attr_is_visible(struct kobject *kobj, struct =
attribute *attr, int idx)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	if (attr =3D=3D &dev_attr_start_on_lid_open.attr) {
> +		err =3D start_on_lid_open_acpi_get(galaxybook, &value);
> +		return err ? 0 : attr->mode;
> +	}
> +
> +	if (attr =3D=3D &dev_attr_usb_charge.attr) {
> +		err =3D usb_charge_acpi_get(galaxybook, &value);
> +		return err ? 0 : attr->mode;
> +	}
> +
> +	if (attr =3D=3D &dev_attr_allow_recording.attr) {
> +		if (!allow_recording)
> +			return 0;
> +		err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_ALLOW_RECORDI=
NG);
> +		if (err) {
> +			dev_dbg(&galaxybook->platform->dev,
> +				"failed to initialize ACPI allow_recording feature\n");
> +			allow_recording =3D false;
> +			return 0;
> +		}
> +		err =3D allow_recording_acpi_get(galaxybook, &value);
> +		if (err) {
> +			allow_recording =3D false;
> +			return 0;
> +		}
> +		return attr->mode;
> +	}
> +
> +	return attr->mode;
> +}
> +
> +static struct attribute *galaxybook_attrs[] =3D {
> +	&dev_attr_start_on_lid_open.attr,
> +	&dev_attr_usb_charge.attr,
> +	&dev_attr_allow_recording.attr,
> +};
> +
> +static const struct attribute_group galaxybook_attrs_group =3D {
> +	.attrs =3D galaxybook_attrs,
> +	.is_visible =3D galaxybook_attr_is_visible,
> +};
> +
>   /*
>    * Battery Extension (adds charge_control_end_threshold to the battery=
 device)
>    */
>
> -static int charge_control_end_threshold_acpi_set(struct samsung_galaxyb=
ook *galaxybook,
> -						 const u8 value)
> +static int charge_control_end_threshold_acpi_set(struct samsung_galaxyb=
ook *galaxybook, u8 value)
>   {
>   	struct sawb buf =3D { 0 };
> -	int err;
>
>   	if (value > 100)
>   		return -EINVAL;
> +	/* if setting to 100, should be set to 0 (no threshold) */
> +	if (value =3D=3D 100)
> +		value =3D 0;
>
>   	buf.safn =3D SAFN;
>   	buf.sasb =3D SASB_POWER_MANAGEMENT;
>   	buf.gunm =3D GUNM_POWER_MANAGEMENT;
>   	buf.guds[0] =3D GUDS_BATTERY_CHARGE_CONTROL;
>   	buf.guds[1] =3D GUDS_BATTERY_CHARGE_CONTROL_SET;
> +	buf.guds[2] =3D value;
>
> -	buf.guds[2] =3D (value =3D=3D 100 ? 0 : value); /* if setting to 100, =
should be set to 0 (off) */
> -
> -	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf,=
 SAWB_LEN_SETTINGS,
> -				     "setting battery charge_control_end_threshold", &buf);
> -	if (err)
> -		return err;
> -
> -	pr_debug_prefixed("set battery charge_control_end_threshold to %d\n",
> -			  (value =3D=3D 100 ? 0 : value));
> -
> -	return 0;
> +	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, =
SAWB_LEN_SETTINGS,
> +				      "setting battery charge_control_end_threshold", &buf);
>   }
>
>   static int charge_control_end_threshold_acpi_get(struct samsung_galaxy=
book *galaxybook, u8 *value)
> @@ -789,23 +712,28 @@ static int charge_control_end_threshold_acpi_get(s=
truct samsung_galaxybook *gala
>
>   	*value =3D buf.guds[1];
>
> -	pr_debug_prefixed("battery charge control is currently %s; "
> -			  "battery charge_control_end_threshold is %d\n",
> -			  (buf.guds[1] > 0 ? "on" : "off"), buf.guds[1]);
> -
>   	return 0;
>   }
>
>   static ssize_t charge_control_end_threshold_store(struct device *dev, =
struct device_attribute *attr,
>   						  const char *buffer, size_t count)
>   {
> +	struct dev_ext_attribute *ea =3D container_of(attr, struct dev_ext_att=
ribute, attr);
> +	struct samsung_galaxybook *galaxybook =3D ea->var;
>   	u8 value;
>   	int err;
>
> -	if (!count || kstrtou8(buffer, 0, &value))
> +	if (!galaxybook)
> +		return -ENODEV;
> +
> +	if (!count)
>   		return -EINVAL;
>
> -	err =3D charge_control_end_threshold_acpi_set(galaxybook_ptr, value);
> +	err =3D kstrtou8(buffer, 0, &value);
> +	if (err)
> +		return err;
> +
> +	err =3D charge_control_end_threshold_acpi_set(galaxybook, value);
>   	if (err)
>   		return err;
>
> @@ -815,39 +743,42 @@ static ssize_t charge_control_end_threshold_store(=
struct device *dev, struct dev
>   static ssize_t charge_control_end_threshold_show(struct device *dev, s=
truct device_attribute *attr,
>   						 char *buffer)
>   {
> +	struct dev_ext_attribute *ea =3D container_of(attr, struct dev_ext_att=
ribute, attr);
> +	struct samsung_galaxybook *galaxybook =3D ea->var;
>   	u8 value;
>   	int err;
>
> -	err =3D charge_control_end_threshold_acpi_get(galaxybook_ptr, &value);
> +	if (!galaxybook)
> +		return -ENODEV;
> +
> +	err =3D charge_control_end_threshold_acpi_get(galaxybook, &value);
>   	if (err)
>   		return err;
>
>   	return sysfs_emit(buffer, "%d\n", value);
>   }
>
> -static DEVICE_ATTR_RW(charge_control_end_threshold);
> -
>   static int galaxybook_battery_add(struct power_supply *battery, struct=
 acpi_battery_hook *hook)
>   {
> -	if (device_create_file(&battery->dev, &dev_attr_charge_control_end_thr=
eshold))
> -		return -ENODEV;
> -	return 0;
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(hook, struct samsung_galaxybook, battery_hook);
> +
> +	return device_create_file(&battery->dev, &galaxybook->battery_charge_c=
ontrol_attr.attr);
>   }
>
>   static int galaxybook_battery_remove(struct power_supply *battery, str=
uct acpi_battery_hook *hook)
>   {
> -	device_remove_file(&battery->dev, &dev_attr_charge_control_end_thresho=
ld);
> +	struct samsung_galaxybook *galaxybook =3D
> +		container_of(hook, struct samsung_galaxybook, battery_hook);
> +
> +	device_remove_file(&battery->dev, &galaxybook->battery_charge_control_=
attr.attr);
>   	return 0;
>   }
>
> -static struct acpi_battery_hook galaxybook_battery_hook =3D {
> -	.add_battery =3D galaxybook_battery_add,
> -	.remove_battery =3D galaxybook_battery_remove,
> -	.name =3D "Samsung Galaxy Book Battery Extension",
> -};
> -
>   static int galaxybook_battery_threshold_init(struct samsung_galaxybook=
 *galaxybook)
>   {
> +	struct acpi_battery_hook *hook;
> +	struct device_attribute *attr;
>   	u8 value;
>   	int err;
>
> @@ -855,397 +786,22 @@ static int galaxybook_battery_threshold_init(stru=
ct samsung_galaxybook *galaxybo
>   	if (err)
>   		return err;
>
> -	battery_hook_register(&galaxybook_battery_hook);
> -	return 0;
> -}
> -
> -static void galaxybook_battery_threshold_exit(struct samsung_galaxybook=
 *galaxybook)
> -{
> -	battery_hook_unregister(&galaxybook_battery_hook);
> -}
> -
> -/*
> - * Fan speed
> - */
> -
> -static int fan_speed_get_fst(struct galaxybook_fan *fan, unsigned int *=
speed)
> -{
> -	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -	union acpi_object *response_obj =3D NULL;
> -	acpi_status status;
> -	int ret =3D 0;
> -
> -	status =3D acpi_evaluate_object(fan->fan.handle, "_FST", NULL, &respon=
se);
> -	if (ACPI_FAILURE(status)) {
> -		pr_err("Get fan state failed\n");
> -		return -ENODEV;
> -	}
> -
> -	response_obj =3D response.pointer;
> -	if (!response_obj || response_obj->type !=3D ACPI_TYPE_PACKAGE ||
> -	    response_obj->package.count !=3D 3 ||
> -	    response_obj->package.elements[2].type !=3D ACPI_TYPE_INTEGER) {
> -		pr_err("Invalid _FST data\n");
> -		ret =3D -EINVAL;
> -		goto out_free;
> -	}
> -
> -	*speed =3D response_obj->package.elements[2].integer.value;
> -
> -	pr_debug_prefixed("fan device %s (%s) reporting fan speed of %d\n",
> -			  dev_name(&fan->fan.dev), fan->description, *speed);
> -
> -out_free:
> -	ACPI_FREE(response.pointer);
> -	return ret;
> -}
> -
> -static int fan_speed_get_fans(struct galaxybook_fan *fan, unsigned int =
*speed)
> -{
> -	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -	union acpi_object *response_obj =3D NULL;
> -	acpi_status status;
> -	int ret =3D 0;
> -	int speed_level =3D -1;
> -
> -	status =3D acpi_evaluate_object(NULL, ACPI_FAN_SPEED_VALUE, NULL, &res=
ponse);
> -	if (ACPI_FAILURE(status)) {
> -		pr_err("Get fan state failed\n");
> -		return -ENODEV;
> -	}
> -
> -	response_obj =3D response.pointer;
> -	if (!response_obj || response_obj->type !=3D ACPI_TYPE_INTEGER ||
> -	    response_obj->integer.value > INT_MAX ||
> -	    (int)response_obj->integer.value > fan->fan_speeds_count) {
> -		pr_err("invalid fan speed data\n");
> -		ret =3D -EINVAL;
> -		goto out_free;
> -	}
> -
> -	speed_level =3D (int)response_obj->integer.value;
> -	*speed =3D fan->fan_speeds[speed_level];
> -
> -	pr_debug_prefixed("fan device %s (%s) reporting fan speed of %d (level=
 %d)\n",
> -			  dev_name(&fan->fan.dev), fan->description, *speed, speed_level);
> -
> -out_free:
> -	ACPI_FREE(response.pointer);
> -	return ret;
> -}
> -
> -static int fan_speed_get(struct galaxybook_fan *fan, unsigned int *spee=
d)
> -{
> -	if (!fan)
> -		return -ENODEV;
> -	if (fan->supports_fst)
> -		return fan_speed_get_fst(fan, speed);
> -	else
> -		return fan_speed_get_fans(fan, speed);
> -}
> -
> -static ssize_t fan_speed_rpm_show(struct device *dev, struct device_att=
ribute *attr, char *buffer)
> -{
> -	struct dev_ext_attribute *ea =3D container_of(attr, struct dev_ext_att=
ribute, attr);
> -	struct galaxybook_fan *fan =3D ea->var;
> -	unsigned int speed;
> -	int ret =3D 0;
> -
> -	if (!fan)
> -		return -ENODEV;
> -
> -	ret =3D fan_speed_get(fan, &speed);
> -	if (ret)
> -		return ret;
> -
> -	return sysfs_emit(buffer, "%u\n", speed);
> -}
> -
> -static int __init fan_speed_list_init(acpi_handle handle, struct galaxy=
book_fan *fan)
> -{
> -	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -	union acpi_object *response_obj =3D NULL;
> -	acpi_status status;
> -	unsigned int speed;
> -	int i;
> -
> -	status =3D acpi_evaluate_object(handle, ACPI_FAN_SPEED_LIST, NULL, &re=
sponse);
> -	if (ACPI_FAILURE(status)) {
> -		pr_err("failed to read fan speed list\n");
> -		return -ENODEV;
> -	}
> -
> -	response_obj =3D response.pointer;
> -	if (!response_obj || response_obj->type !=3D ACPI_TYPE_PACKAGE ||
> -	    response_obj->package.count =3D=3D 0) {
> -		pr_err("invalid fan speed list data\n");
> -		status =3D -EINVAL;
> -		goto out_free;
> -	}
> -
> -	/*
> -	 * fan_speeds[] starts with a hard-coded 0 (fan is off), then has some=
 "funny" logic:
> -	 *  - fetch the speed level values read in from FANT and add 0x0a to e=
ach value
> -	 *  - _FST method in the DSDT seems to indicate that level 3 and 4 sho=
uld have same value,
> -	 *    however real-life observation suggests that the speed actually d=
oes change
> -	 *  - _FST says that level 5 should give the 4th value from FANT but i=
t seems significantly
> -	 *    louder -- we will just "guess" it is 1000 RPM faster than the hi=
ghest value from FANT?
> -	 */
> -
> -	fan->fan_speeds =3D kzalloc(sizeof(unsigned int) * (response_obj->pack=
age.count + 2),
> -				  GFP_KERNEL);
> -	if (!fan->fan_speeds)
> -		return -ENOMEM;
> -
> -	/* hard-coded "off" value (0) */
> -	fan->fan_speeds[0] =3D 0;
> -	fan->fan_speeds_count =3D 1;
> -
> -	/* fetch and assign the next values from FANT response */
> -	i =3D 0;
> -	for (i =3D 1; i <=3D response_obj->package.count; i++) {
> -		if (response_obj->package.elements[i - 1].type !=3D ACPI_TYPE_INTEGER=
) {
> -			pr_err("invalid fan speed list value at position %d; "
> -			       "expected type %d, got type %d\n",
> -			       i - 1, ACPI_TYPE_INTEGER,
> -			       response_obj->package.elements[i - 1].type);
> -			status =3D -EINVAL;
> -			goto err_fan_speeds_free;
> -		}
> -		fan->fan_speeds[i] =3D response_obj->package.elements[i - 1].integer.=
value + 0x0a;
> -		fan->fan_speeds_count++;
> -	}
> -
> -	/* add the missing final level where we "guess" 1000 RPM faster than h=
ighest from FANT */
> -	if (fan->fan_speeds_count > 1) {
> -		fan->fan_speeds[i] =3D fan->fan_speeds[i - 1] + 1000;
> -		fan->fan_speeds_count++;
> -	}
> -
> -	/* test that it actually works to read the speed, otherwise the init s=
hould fail */
> -	status =3D fan_speed_get_fans(fan, &speed);
> -	if (ACPI_FAILURE(status)) {
> -		pr_err("failed to read fan speed level from FANS\n");
> -		goto err_fan_speeds_free;
> -	}
> -
> -	pr_info("initialized fan speed reporting for device %s (%s) with the f=
ollowing levels:\n",
> -		dev_name(&fan->fan.dev), fan->description);
> -	for (i =3D 0; i < fan->fan_speeds_count; i++)
> -		pr_info("  %s (%s) fan speed level %d =3D %d\n",
> -			dev_name(&fan->fan.dev), fan->description, i, fan->fan_speeds[i]);
> +	hook =3D &galaxybook->battery_hook;
> +	hook->add_battery =3D galaxybook_battery_add;
> +	hook->remove_battery =3D galaxybook_battery_remove;
> +	hook->name =3D "Samsung Galaxy Book Battery Extension";
>
> -out_free:
> -	ACPI_FREE(response.pointer);
> -	return status;
> +	attr =3D &galaxybook->battery_charge_control_attr.attr;
> +	attr->attr.name =3D "charge_control_end_threshold";
> +	attr->attr.mode =3D 0644;
> +	attr->show =3D charge_control_end_threshold_show;
> +	attr->store =3D charge_control_end_threshold_store;
> +	/* ext attr var points to this galaxybook so it can used in show and s=
tore */
> +	galaxybook->battery_charge_control_attr.var =3D galaxybook;
>
> -err_fan_speeds_free:
> -	kfree(fan->fan_speeds);
> -	goto out_free;
> +	return devm_battery_hook_register(&galaxybook->platform->dev, &galaxyb=
ook->battery_hook);
>   }
>
> -static acpi_status galaxybook_add_fan(acpi_handle handle, u32 level, vo=
id *context,
> -				      void **return_value)
> -{
> -	struct acpi_device *adev =3D acpi_fetch_acpi_dev(handle);
> -	struct samsung_galaxybook *galaxybook =3D context;
> -	struct galaxybook_fan *fan;
> -	int speed =3D -1;
> -
> -	pr_info("found fan device %s\n", dev_name(&adev->dev));
> -
> -	/* if fan meets acpi4 fan device requirements, assume it is added alre=
ady under ACPI */
> -	if (acpi_has_method(handle, "_FIF") &&
> -	    acpi_has_method(handle, "_FPS") &&
> -	    acpi_has_method(handle, "_FSL") &&
> -	    acpi_has_method(handle, "_FST")) {
> -		pr_info("fan device %s should already be available as an ACPI fan; sk=
ipping\n",
> -			dev_name(&adev->dev));
> -		return 0;
> -	}
> -
> -	if (galaxybook->fans_count >=3D MAX_FAN_COUNT) {
> -		pr_err("maximum number of %d fans has already been reached\n", MAX_FA=
N_COUNT);
> -		return 0;
> -	}
> -
> -	fan =3D &galaxybook->fans[galaxybook->fans_count];
> -	fan->fan =3D *adev;
> -	fan->description =3D get_acpi_device_description(&fan->fan);
> -
> -	/* try to get speed from _FST */
> -	if (ACPI_FAILURE(fan_speed_get_fst(fan, &speed))) {
> -		pr_debug_prefixed("_FST is present but failed on fan device %s (%s); =
"
> -				  "will attempt to add fan speed support using FANT and FANS\n",
> -				  dev_name(&fan->fan.dev), fan->description);
> -		fan->supports_fst =3D false;
> -	}
> -	/* if speed was 0 and FANT and FANS exist, they should be used anyway =
due to bugs in ACPI */
> -	else if (speed <=3D 0 &&
> -		 acpi_has_method(handle, ACPI_FAN_SPEED_LIST) &&
> -		 acpi_has_method(NULL, ACPI_FAN_SPEED_VALUE)) {
> -		pr_debug_prefixed("_FST is present on fan device %s (%s) but returned=
 value of 0; "
> -				  "will attempt to add fan speed support using FANT and FANS\n",
> -				  dev_name(&fan->fan.dev), fan->description);
> -		fan->supports_fst =3D false;
> -	} else {
> -		fan->supports_fst =3D true;
> -	}
> -
> -	if (!fan->supports_fst) {
> -		/* since FANS is a field on the EC, it does not make sense to use mor=
e than once */
> -		for (int i =3D 0; i < galaxybook->fans_count; i++) {
> -			if (!galaxybook->fans[i].supports_fst) {
> -				pr_err("more than one fan using FANS is not supported\n");
> -				return 0;
> -			}
> -		}
> -		if (ACPI_FAILURE(fan_speed_list_init(handle, fan))) {
> -			pr_err("unable to initialize fan speeds for fan device %s (%s)\n",
> -			       dev_name(&fan->fan.dev), fan->description);
> -			return 0;
> -		}
> -	} else {
> -		pr_info("initialized fan speed reporting for device %s (%s) using met=
hod _FST\n",
> -			dev_name(&fan->fan.dev), fan->description);
> -	}
> -
> -	/* set up RO dev_ext_attribute */
> -	fan->fan_speed_rpm_ext_attr.attr.attr.name =3D "fan_speed_rpm";
> -	fan->fan_speed_rpm_ext_attr.attr.attr.mode =3D 0444;
> -	fan->fan_speed_rpm_ext_attr.attr.show =3D fan_speed_rpm_show;
> -	/* extended attribute var points to this galaxybook_fan so it can used=
 in the show method */
> -	fan->fan_speed_rpm_ext_attr.var =3D fan;
> -
> -	if (sysfs_create_file(&adev->dev.kobj, &fan->fan_speed_rpm_ext_attr.at=
tr.attr))
> -		pr_err("unable to create fan_speed_rpm attribute for fan device %s (%=
s)\n",
> -		       dev_name(&fan->fan.dev), fan->description);
> -
> -	galaxybook->fans_count++;
> -
> -	return 0;
> -}
> -
> -static int __init galaxybook_fan_speed_init(struct samsung_galaxybook *=
galaxybook)
> -{
> -	acpi_status status;
> -
> -	/* get and set up all fans matching ACPI_FAN_DEVICE_ID */
> -	status =3D acpi_get_devices(ACPI_FAN_DEVICE_ID, galaxybook_add_fan, ga=
laxybook, NULL);
> -
> -	if (galaxybook->fans_count =3D=3D 0)
> -		return -ENODEV;
> -
> -	return status;
> -}
> -
> -static void galaxybook_fan_speed_exit(struct samsung_galaxybook *galaxy=
book)
> -{
> -	for (int i =3D 0; i < galaxybook->fans_count; i++)
> -		sysfs_remove_file(&galaxybook->fans[i].fan.dev.kobj,
> -				  &galaxybook->fans[i].fan_speed_rpm_ext_attr.attr.attr);
> -}
> -
> -/*
> - * Hwmon device
> - */
> -
> -#if IS_ENABLED(CONFIG_HWMON)
> -static umode_t galaxybook_hwmon_is_visible(const void *drvdata, enum hw=
mon_sensor_types type,
> -					   u32 attr, int channel)
> -{
> -	switch (type) {
> -	case hwmon_fan:
> -		if (channel < galaxybook_ptr->fans_count &&
> -		    (attr =3D=3D hwmon_fan_input || attr =3D=3D hwmon_fan_label))
> -			return 0444;
> -		return 0;
> -	default:
> -		return 0;
> -	}
> -}
> -
> -static int galaxybook_hwmon_read(struct device *dev, enum hwmon_sensor_=
types type,
> -				 u32 attr, int channel, long *val)
> -{
> -	unsigned int speed;
> -
> -	switch (type) {
> -	case hwmon_fan:
> -		if (channel < galaxybook_ptr->fans_count && attr =3D=3D hwmon_fan_inp=
ut) {
> -			if (fan_speed_get(&galaxybook_ptr->fans[channel], &speed))
> -				return -EIO;
> -			*val =3D speed;
> -			return 0;
> -		}
> -		return -EOPNOTSUPP;
> -	default:
> -		return -EOPNOTSUPP;
> -	}
> -}
> -
> -static int galaxybook_hwmon_read_string(struct device *dev, enum hwmon_=
sensor_types type,
> -					u32 attr, int channel, const char **str)
> -{
> -	switch (type) {
> -	case hwmon_fan:
> -		if (channel < galaxybook_ptr->fans_count && attr =3D=3D hwmon_fan_lab=
el) {
> -			*str =3D galaxybook_ptr->fans[channel].description;
> -			return 0;
> -		}
> -		return -EOPNOTSUPP;
> -	default:
> -		return -EOPNOTSUPP;
> -	}
> -}
> -
> -static const struct hwmon_ops galaxybook_hwmon_ops =3D {
> -	.is_visible =3D galaxybook_hwmon_is_visible,
> -	.read =3D galaxybook_hwmon_read,
> -	.read_string =3D galaxybook_hwmon_read_string,
> -};
> -
> -static const struct hwmon_channel_info *const galaxybook_hwmon_info[] =
=3D {
> -	/* note: number of max possible fan channel entries here should match =
MAX_FAN_COUNT */
> -	HWMON_CHANNEL_INFO(fan,
> -			   HWMON_F_INPUT | HWMON_F_LABEL,
> -			   HWMON_F_INPUT | HWMON_F_LABEL,
> -			   HWMON_F_INPUT | HWMON_F_LABEL,
> -			   HWMON_F_INPUT | HWMON_F_LABEL,
> -			   HWMON_F_INPUT | HWMON_F_LABEL),
> -	NULL
> -};
> -
> -static const struct hwmon_chip_info galaxybook_hwmon_chip_info =3D {
> -	.ops =3D &galaxybook_hwmon_ops,
> -	.info =3D galaxybook_hwmon_info,
> -};
> -
> -static int galaxybook_hwmon_init(struct samsung_galaxybook *galaxybook)
> -{
> -	int ret =3D 0;
> -
> -	char *hwmon_device_name =3D devm_hwmon_sanitize_name(&galaxybook->plat=
form->dev,
> -							   SAMSUNG_GALAXYBOOK_CLASS);
> -
> -	galaxybook->hwmon =3D devm_hwmon_device_register_with_info(
> -		&galaxybook->platform->dev, hwmon_device_name, NULL,
> -		&galaxybook_hwmon_chip_info, NULL);
> -	if (PTR_ERR_OR_ZERO(galaxybook->hwmon)) {
> -		ret =3D PTR_ERR(galaxybook->hwmon);
> -		galaxybook->hwmon =3D NULL;
> -	}
> -
> -	return ret;
> -}
> -
> -static void galaxybook_hwmon_exit(struct samsung_galaxybook *galaxybook=
)
> -{
> -	if (galaxybook->hwmon)
> -		hwmon_device_unregister(galaxybook->hwmon);
> -}
> -#endif
> -
>   /*
>    * Platform Profile / Performance mode
>    */
> @@ -1254,7 +810,6 @@ static int performance_mode_acpi_set(struct samsung=
_galaxybook *galaxybook,
>   				     const u8 performance_mode)
>   {
>   	struct sawb buf =3D { 0 };
> -	int err;
>
>   	buf.safn =3D SAFN;
>   	buf.sasb =3D SASB_PERFORMANCE_MODE;
> @@ -1263,12 +818,8 @@ static int performance_mode_acpi_set(struct samsun=
g_galaxybook *galaxybook,
>   	buf.subn =3D SUBN_PERFORMANCE_MODE_SET;
>   	buf.iob0 =3D performance_mode;
>
> -	err =3D galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MOD=
E, &buf,
> -				     SAWB_LEN_PERFORMANCE_MODE, "setting performance_mode", &buf);
> -	if (err)
> -		return err;
> -
> -	return 0;
> +	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MODE=
, &buf,
> +				      SAWB_LEN_PERFORMANCE_MODE, "setting performance_mode", &buf);
>   }
>
>   static int performance_mode_acpi_get(struct samsung_galaxybook *galaxy=
book, u8 *performance_mode)
> @@ -1292,40 +843,29 @@ static int performance_mode_acpi_get(struct samsu=
ng_galaxybook *galaxybook, u8 *
>   	return 0;
>   }
>
> -static enum platform_profile_option
> -profile_performance_mode(struct samsung_galaxybook *galaxybook, const u=
8 performance_mode)
> +static int get_performance_mode_profile(struct samsung_galaxybook *gala=
xybook,
> +					const u8 performance_mode,
> +					enum platform_profile_option *profile)
>   {
> -	for (int i =3D 0; i < PLATFORM_PROFILE_LAST; i++)
> -		if (galaxybook->profile_performance_modes[i] =3D=3D performance_mode)
> -			return i;
> -	return -1;
> -}
> +	for (int i =3D 0; i < PLATFORM_PROFILE_LAST; i++) {
> +		if (galaxybook->profile_performance_modes[i] =3D=3D performance_mode)=
 {
> +			if (profile)
> +				*profile =3D i;
> +			return 0;
> +		}
> +	}
>
> -/* copied from platform_profile.c; better if this could be fetched from=
 a public function, maybe? */
> -static const char *const profile_names[] =3D {
> -	[PLATFORM_PROFILE_LOW_POWER] =3D "low-power",
> -	[PLATFORM_PROFILE_COOL] =3D "cool",
> -	[PLATFORM_PROFILE_QUIET] =3D "quiet",
> -	[PLATFORM_PROFILE_BALANCED] =3D "balanced",
> -	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] =3D "balanced-performance",
> -	[PLATFORM_PROFILE_PERFORMANCE] =3D "performance",
> -};
> -static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST);
> +	return -ENODATA;
> +}
>
>   static int galaxybook_platform_profile_set(struct platform_profile_han=
dler *pprof,
>   					   enum platform_profile_option profile)
>   {
>   	struct samsung_galaxybook *galaxybook =3D
>   		container_of(pprof, struct samsung_galaxybook, profile_handler);
> -	int err;
> -
> -	err =3D performance_mode_acpi_set(galaxybook, galaxybook->profile_perf=
ormance_modes[profile]);
> -	if (err)
> -		return err;
>
> -	pr_debug_prefixed("set platform profile to '%s' (performance mode 0x%x=
)\n",
> -			  profile_names[profile], galaxybook->profile_performance_modes[prof=
ile]);
> -	return 0;
> +	return performance_mode_acpi_set(galaxybook,
> +					 galaxybook->profile_performance_modes[profile]);
>   }
>
>   static int galaxybook_platform_profile_get(struct platform_profile_han=
dler *pprof,
> @@ -1340,23 +880,24 @@ static int galaxybook_platform_profile_get(struct=
 platform_profile_handler *ppro
>   	if (err)
>   		return err;
>
> -	*profile =3D profile_performance_mode(galaxybook, performance_mode);
> -	if (*profile =3D=3D -1)
> -		return -EINVAL;
> -
> -	pr_debug_prefixed("platform profile is currently '%s' (performance mod=
e 0x%x)\n",
> -			  profile_names[*profile], performance_mode);
> +	return get_performance_mode_profile(galaxybook, performance_mode, prof=
ile);
> +}
>
> -	return 0;
> +static void galaxybook_profile_exit(void *data)
> +{
> +	platform_profile_remove();
>   }
>
>   #define IGNORE_PERFORMANCE_MODE_MAPPING  -1
>
>   static int galaxybook_profile_init(struct samsung_galaxybook *galaxybo=
ok)
>   {
> -	struct sawb buf =3D { 0 };
> -	int mode_profile, err;
>   	u8 current_performance_mode;
> +	struct sawb buf =3D { 0 };
> +	int mapped_profiles;
> +	int mode_profile;
> +	int err;
> +	int i;
>
>   	galaxybook->profile_handler.profile_get =3D galaxybook_platform_profi=
le_get;
>   	galaxybook->profile_handler.profile_set =3D galaxybook_platform_profi=
le_set;
> @@ -1376,10 +917,10 @@ static int galaxybook_profile_init(struct samsung=
_galaxybook *galaxybook)
>
>   	/* set up profile_performance_modes with "unknown" as init value */
>   	galaxybook->profile_performance_modes =3D
> -		kzalloc(sizeof(u8) * PLATFORM_PROFILE_LAST, GFP_KERNEL);
> +		kcalloc(PLATFORM_PROFILE_LAST, sizeof(u8), GFP_KERNEL);
>   	if (!galaxybook->profile_performance_modes)
>   		return -ENOMEM;
> -	for (int i =3D 0; i < PLATFORM_PROFILE_LAST; i++)
> +	for (i =3D 0; i < PLATFORM_PROFILE_LAST; i++)
>   		galaxybook->profile_performance_modes[i] =3D PERFORMANCE_MODE_UNKNOW=
N;
>
>   	/*
> @@ -1388,8 +929,7 @@ static int galaxybook_profile_init(struct samsung_g=
alaxybook *galaxybook)
>   	 * Loop backwards from last value to first value (to handle fallback =
cases which come with
>   	 * smaller values) and map each supported value to its correct platfo=
rm_profile_option.
>   	 */
> -	err =3D -ENODEV; /* set err to "no device" to signal that we have not =
yet mapped profiles */
> -	for (int i =3D buf.iob0; i > 0; i--) {
> +	for (i =3D buf.iob0; i > 0; i--) {
>   		/*
>   		 * Prefer mapping to at least performance, balanced, and low-power p=
rofiles, as they
>   		 * are the profiles which are typically supported by userspace tools
> @@ -1459,21 +999,22 @@ static int galaxybook_profile_init(struct samsung=
_galaxybook *galaxybook)
>   		}
>
>   		/* if current mode value mapped to a supported platform_profile_opti=
on, set it up */
> -		if (mode_profile > IGNORE_PERFORMANCE_MODE_MAPPING) {
> -			err =3D 0; /* clear err to signal that at least one profile is now m=
apped */
> +		if (mode_profile !=3D IGNORE_PERFORMANCE_MODE_MAPPING) {
> +			mapped_profiles++;
>   			galaxybook->profile_performance_modes[mode_profile] =3D buf.iob_val=
ues[i];
>   			set_bit(mode_profile, galaxybook->profile_handler.choices);
> -			pr_info("will support platform profile '%s' (performance mode 0x%x)\=
n",
> -				profile_names[mode_profile], buf.iob_values[i]);
> +			dev_dbg(&galaxybook->platform->dev,
> +				"will support platform profile %d (performance mode 0x%x)\n",
> +				mode_profile, buf.iob_values[i]);
>   		} else {
> -			pr_debug_prefixed("unmapped performance mode 0x%x will be ignored\n"=
,
> -					  buf.iob_values[i]);
> +			dev_dbg(&galaxybook->platform->dev,
> +				"unmapped performance mode 0x%x will be ignored\n",
> +				buf.iob_values[i]);
>   		}
>   	}
>
> -	/* if no performance modes were mapped (err is still -ENODEV) then sto=
p and fail here */
> -	if (err)
> -		return err;
> +	if (mapped_profiles =3D=3D 0)
> +		return -ENODEV;
>
>   	err =3D platform_profile_register(&galaxybook->profile_handler);
>   	if (err)
> @@ -1482,33 +1023,35 @@ static int galaxybook_profile_init(struct samsun=
g_galaxybook *galaxybook)
>   	/* now check currently set performance mode; if not supported then se=
t default profile */
>   	err =3D performance_mode_acpi_get(galaxybook, &current_performance_mo=
de);
>   	if (err)
> -		pr_warn("failed with code %d when fetching initial performance mode\n=
", err);
> -	if (profile_performance_mode(galaxybook, current_performance_mode) =3D=
=3D -1) {
> -		pr_debug_prefixed("initial performance mode value is not supported by=
 device; "
> -				  "setting to default\n");
> +		goto err_remove_exit;
> +	err =3D get_performance_mode_profile(galaxybook, current_performance_m=
ode, NULL);
> +	if (err) {
> +		dev_dbg(&galaxybook->platform->dev,
> +			"initial performance mode value is not supported by device; "
> +			"setting to default\n");
>   		err =3D galaxybook_platform_profile_set(&galaxybook->profile_handler=
,
>   						      DEFAULT_PLATFORM_PROFILE);
>   		if (err)
> -			return err;
> +			goto err_remove_exit;
>   	}
>
> +	/* if adding dev remove action fails, remove now and return failure */
> +	err =3D devm_add_action_or_reset(&galaxybook->platform->dev,
> +				       galaxybook_profile_exit, NULL);
> +	if (err)
> +		goto err_remove_exit;
> +
>   	return 0;
> -}
>
> -static void galaxybook_profile_exit(struct samsung_galaxybook *galaxybo=
ok)
> -{
> -	platform_profile_remove();
> +err_remove_exit:
> +	galaxybook_profile_exit(NULL);
> +	return err;
>   }
>
>   /*
>    * Hotkey work and filters
>    */
>
> -static void galaxybook_performance_mode_hotkey_work(struct work_struct =
*work)
> -{
> -	platform_profile_cycle();
> -}
> -
>   static void galaxybook_kbd_backlight_hotkey_work(struct work_struct *w=
ork)
>   {
>   	struct samsung_galaxybook *galaxybook =3D
> @@ -1575,118 +1118,77 @@ static bool galaxybook_i8042_filter(unsigned ch=
ar data, unsigned char str, struc
>   	return false;
>   }
>
> -/*
> - * Input device (hotkeys and notifications)
> - */
> -
> -static void galaxybook_input_notify(struct samsung_galaxybook *galaxybo=
ok, int event)
> +static void galaxybook_i8042_filter_remove(void *data)
>   {
> -	if (!galaxybook->input)
> -		return;
> -	pr_debug_prefixed("input notification event: 0x%x\n", event);
> -	if (!sparse_keymap_report_event(galaxybook->input, event, 1, true))
> -		pr_warn("unknown input notification event: 0x%x\n", event);
> +	struct samsung_galaxybook *galaxybook =3D data;
> +
> +	i8042_remove_filter(galaxybook_i8042_filter);
> +	cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
> +	cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
>   }
>
> -static int galaxybook_input_init(struct samsung_galaxybook *galaxybook)
> +static int galaxybook_i8042_filter_install(struct samsung_galaxybook *g=
alaxybook)
>   {
> -	struct input_dev *input;
> -	int error;
> -
> -	input =3D input_allocate_device();
> -	if (!input)
> -		return -ENOMEM;
> +	int err;
>
> -	input->name =3D "Samsung Galaxy Book Extra Buttons";
> -	input->phys =3D SAMSUNG_GALAXYBOOK_CLASS "/input0";
> -	input->id.bustype =3D BUS_HOST;
> -	input->dev.parent =3D &galaxybook->platform->dev;
> +	/* initialize hotkey work queues */
> +	if (kbd_backlight)
> +		INIT_WORK(&galaxybook->kbd_backlight_hotkey_work,
> +			  galaxybook_kbd_backlight_hotkey_work);
> +	if (allow_recording)
> +		INIT_WORK(&galaxybook->allow_recording_hotkey_work,
> +			  galaxybook_allow_recording_hotkey_work);
>
> -	error =3D sparse_keymap_setup(input, galaxybook_acpi_keymap, NULL);
> -	if (error) {
> -		pr_err("Unable to setup input device keymap\n");
> -		goto err_free_dev;
> +	err =3D i8042_install_filter(galaxybook_i8042_filter);
> +	if (err) {
> +		cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
> +		cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
> +		return err;
>   	}
> -	error =3D input_register_device(input);
> -	if (error) {
> -		pr_err("Unable to register input device\n");
> -		goto err_free_dev;
> +
> +	/* if adding dev remove action fails, remove now and return failure */
> +	err =3D devm_add_action_or_reset(&galaxybook->platform->dev,
> +				       galaxybook_i8042_filter_remove, galaxybook);
> +	if (err) {
> +		galaxybook_i8042_filter_remove(galaxybook);
> +		return err;
>   	}
>
> -	galaxybook->input =3D input;
>   	return 0;
> -
> -err_free_dev:
> -	input_free_device(input);
> -	return error;
> -}
> -
> -static void galaxybook_input_exit(struct samsung_galaxybook *galaxybook=
)
> -{
> -	if (galaxybook->input)
> -		input_unregister_device(galaxybook->input);
> -	galaxybook->input =3D NULL;
>   }
>
>   /*
> - * Platform device attributes
> + * Input device (hotkeys and notifications)
>    */
>
> -/* galaxybook_attrs can include start_on_lid_open, usb_charge, and/or a=
llow_recording */
> -#define MAX_NUM_DEVICE_ATTRIBUTES 3
> -
> -static struct attribute *galaxybook_attrs[MAX_NUM_DEVICE_ATTRIBUTES + 1=
] =3D { NULL };
> -static const struct attribute_group galaxybook_attrs_group =3D {
> -	.attrs =3D galaxybook_attrs,
> -};
> +static void galaxybook_input_notify(struct samsung_galaxybook *galaxybo=
ok, int event)
> +{
> +	if (!galaxybook->input)
> +		return;
> +	mutex_lock(&galaxybook->input_lock);
> +	if (!sparse_keymap_report_event(galaxybook->input, event, 1, true))
> +		dev_warn(&galaxybook->acpi->dev, "unknown input notification event: 0=
x%x\n", event);
> +	mutex_unlock(&galaxybook->input_lock);
> +}
>
> -static int galaxybook_device_attrs_init(struct samsung_galaxybook *gala=
xybook)
> +static int galaxybook_input_init(struct samsung_galaxybook *galaxybook)
>   {
> -	bool value;
>   	int err;
> -	int i =3D 0;
>
> -	/* attempt to get each attribute's value and add them if the get does =
not fail */
> +	galaxybook->input =3D devm_input_allocate_device(&galaxybook->platform=
->dev);
> +	if (!galaxybook->input)
> +		return -ENOMEM;
>
> -	err =3D start_on_lid_open_acpi_get(galaxybook, &value);
> -	if (err)
> -		pr_debug_prefixed("failed to get start_on_lid_open value; "
> -				  "this feature will not be enabled\n");
> -	else
> -		galaxybook_attrs[i++] =3D &dev_attr_start_on_lid_open.attr;
> +	galaxybook->input->name =3D "Samsung Galaxy Book Extra Buttons";
> +	galaxybook->input->phys =3D DRIVER_NAME "/input0";
> +	galaxybook->input->id.bustype =3D BUS_HOST;
> +	galaxybook->input->dev.parent =3D &galaxybook->platform->dev;
>
> -	err =3D usb_charge_acpi_get(galaxybook, &value);
> +	err =3D sparse_keymap_setup(galaxybook->input, galaxybook_acpi_keymap,=
 NULL);
>   	if (err)
> -		pr_debug_prefixed("failed to get usb_charge value; "
> -				  "this feature will not be enabled\n");
> -	else
> -		galaxybook_attrs[i++] =3D &dev_attr_usb_charge.attr;
> -
> -	if (allow_recording) {
> -		pr_debug_prefixed("initializing ACPI allow_recording feature\n");
> -		err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_ALLOW_RECORDI=
NG);
> -		if (err) {
> -			pr_debug_prefixed("failed to initialize ACPI allow_recording feature=
\n");
> -			allow_recording =3D false;
> -			return 0;
> -		}
> -
> -		err =3D allow_recording_acpi_get(galaxybook, &value);
> -		if (err) {
> -			pr_debug_prefixed("failed to get allow_recording value; "
> -					  "this feature will not be enabled\n");
> -			allow_recording =3D false;
> -		} else {
> -			galaxybook_attrs[i++] =3D &dev_attr_allow_recording.attr;
> -		}
> -	}
> -
> -	return device_add_group(&galaxybook->platform->dev, &galaxybook_attrs_=
group);
> -};
> +		return err;
>
> -static void galaxybook_device_attrs_exit(struct samsung_galaxybook *gal=
axybook)
> -{
> -	device_remove_group(&galaxybook->platform->dev, &galaxybook_attrs_grou=
p);
> +	return input_register_device(galaxybook->input);
>   }
>
>   /*
> @@ -1698,14 +1200,17 @@ static void galaxybook_acpi_notify(acpi_handle h=
andle, u32 event, void *data)
>   	struct samsung_galaxybook *galaxybook =3D data;
>
>   	if (event =3D=3D ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE) {
> -		pr_debug_prefixed("hotkey: performance_mode keydown\n");
>   		if (performance_mode) {
> -			schedule_work(&galaxybook->performance_mode_hotkey_work);
> -			return;
> +			platform_profile_cycle();
> +			goto exit;
>   		}
>   	}
>
>   	galaxybook_input_notify(galaxybook, event);
> +
> +exit:
> +	acpi_bus_generate_netlink_event(DRIVER_NAME, dev_name(&galaxybook->pla=
tform->dev),
> +					event, 0);
>   }
>
>   static int galaxybook_enable_acpi_notify(struct samsung_galaxybook *ga=
laxybook)
> @@ -1726,247 +1231,155 @@ static int galaxybook_enable_acpi_notify(struc=
t samsung_galaxybook *galaxybook)
>   				      "activate ACPI notifications", &buf);
>   }
>
> -static int galaxybook_acpi_init(struct samsung_galaxybook *galaxybook)
> +static void galaxybook_acpi_remove_notify_handler(void *data)
>   {
> -	return acpi_execute_simple_method(galaxybook->acpi->handle,
> -					  ACPI_METHOD_ENABLE, ACPI_METHOD_ENABLE_ON);
> +	struct samsung_galaxybook *galaxybook =3D data;
> +
> +	acpi_remove_notify_handler(galaxybook->acpi->handle, ACPI_ALL_NOTIFY,
> +				   galaxybook_acpi_notify);
>   }
>
> -static void galaxybook_acpi_exit(struct samsung_galaxybook *galaxybook)
> +static void galaxybook_acpi_disable(void *data)
>   {
> +	struct samsung_galaxybook *galaxybook =3D data;
> +
>   	acpi_execute_simple_method(galaxybook->acpi->handle,
>   				   ACPI_METHOD_ENABLE, ACPI_METHOD_ENABLE_OFF);
>   }
>
> +static int galaxybook_acpi_init(struct samsung_galaxybook *galaxybook)
> +{
> +	acpi_status status;
> +	int err;
> +
> +	status =3D acpi_execute_simple_method(galaxybook->acpi->handle, ACPI_M=
ETHOD_ENABLE,
> +					    ACPI_METHOD_ENABLE_ON);
> +	if (ACPI_FAILURE(status))
> +		return -ENXIO;
> +	err =3D devm_add_action_or_reset(&galaxybook->platform->dev,
> +				       galaxybook_acpi_disable, galaxybook);
> +	if (err)
> +		return err;
> +
> +	status =3D acpi_install_notify_handler(galaxybook->acpi->handle, ACPI_=
ALL_NOTIFY,
> +					     galaxybook_acpi_notify, galaxybook);
> +	if (ACPI_FAILURE(status))
> +		return -ENXIO;
> +	err =3D devm_add_action_or_reset(&galaxybook->platform->dev,
> +				       galaxybook_acpi_remove_notify_handler, galaxybook);
> +	if (err)
> +		return err;
> +
> +	err =3D galaxybook_enable_acpi_notify(galaxybook);
> +	if (err) {
> +		dev_warn(&galaxybook->platform->dev, "failed to enable ACPI notificat=
ions; "
> +			 "some hotkeys will not be supported\n");
> +	} else {
> +		err =3D galaxybook_input_init(galaxybook);
> +		if (err)
> +			dev_warn(&galaxybook->platform->dev,
> +				 "failed to initialize input device\n");
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * Platform driver
>    */
>
> +#define galaxybook_init_feature(module_param, init_func)			\
> +do {										\
> +	if (module_param) {							\
> +		err =3D init_func(galaxybook);					\
> +		if (err) {							\
> +			dev_dbg(&galaxybook->platform->dev,			\
> +				"failed to initialize " #module_param "\n");	\
> +			module_param =3D false;					\
> +		}								\
> +	}									\
> +} while (0)
> +
>   static int galaxybook_probe(struct platform_device *pdev)
>   {
>   	struct acpi_device *adev =3D ACPI_COMPANION(&pdev->dev);
>   	struct samsung_galaxybook *galaxybook;
> -	acpi_status status;
>   	int err;
>
> -	dmi_check_system(galaxybook_dmi_ids);
> +	if (!adev)
> +		return -ENODEV;
>
> -	pr_info("found matched device %s; loading driver\n", dev_name(&adev->d=
ev));
> +	dev_dbg(&pdev->dev, "loading driver\n");
>
> -	galaxybook =3D kzalloc(sizeof(struct samsung_galaxybook), GFP_KERNEL);
> +	galaxybook =3D devm_kzalloc(&pdev->dev, sizeof(*galaxybook), GFP_KERNE=
L);
>   	if (!galaxybook)
>   		return -ENOMEM;
> -	/* set static pointer here so it can be used in various methods for ho=
tkeys, hwmon, etc */
> +	/* set static pointer here so it can be used in i8042 filter */
>   	galaxybook_ptr =3D galaxybook;
>
>   	galaxybook->platform =3D pdev;
>   	galaxybook->acpi =3D adev;
>
>   	dev_set_drvdata(&galaxybook->platform->dev, galaxybook);
> +	devm_mutex_init(&galaxybook->platform->dev, &galaxybook->acpi_lock);
> +	devm_mutex_init(&galaxybook->platform->dev, &galaxybook->input_lock);
>
> -	pr_debug_prefixed("initializing ACPI device\n");
>   	err =3D galaxybook_acpi_init(galaxybook);
>   	if (err) {
> -		pr_err("failed to initialize the ACPI device\n");
> -		goto err_free;
> +		dev_err(&galaxybook->acpi->dev, "failed to initialize the ACPI device=
\n");
> +		return err;
>   	}
>
> -	pr_debug_prefixed("initializing ACPI power management features\n");
>   	err =3D galaxybook_enable_acpi_feature(galaxybook, SASB_POWER_MANAGEM=
ENT);
>   	if (err) {
> -		pr_warn("failed to initialize ACPI power management features; "
> -			"many features of this driver will not be available\n");
> +		dev_warn(&galaxybook->acpi->dev,
> +			 "failed to initialize ACPI power management features; "
> +			 "many features of this driver will not be available\n");
>   		performance_mode =3D false;
>   		battery_threshold =3D false;
>   	}
>
> -	if (performance_mode) {
> -		pr_debug_prefixed("initializing performance mode and platform profile=
\n");
> -		err =3D galaxybook_profile_init(galaxybook);
> -		if (err) {
> -			pr_debug_prefixed(
> -				"failed to initialize performance mode and platform profile\n");
> -			performance_mode =3D false;
> -		}
> -	} else {
> -		pr_debug_prefixed("performance_mode is disabled\n");
> -	}
> -
> -	if (battery_threshold) {
> -		pr_debug_prefixed("initializing battery charge threshold control\n");
> -		err =3D galaxybook_battery_threshold_init(galaxybook);
> -		if (err) {
> -			pr_debug_prefixed(
> -				"failed to initialize battery charge threshold control\n");
> -			battery_threshold =3D false;
> -		}
> -	} else {
> -		pr_debug_prefixed("battery_threshold is disabled\n");
> -	}
> +	galaxybook_init_feature(performance_mode, galaxybook_profile_init);
> +	galaxybook_init_feature(battery_threshold, galaxybook_battery_threshol=
d_init);
>
> -	pr_debug_prefixed("adding platform device attributes\n");
> -	err =3D galaxybook_device_attrs_init(galaxybook);
> +	/* add attrs group here as the is_visible requires above initializatio=
ns */
> +	err =3D devm_device_add_group(&galaxybook->platform->dev, &galaxybook_=
attrs_group);
>   	if (err)
> -		pr_err("failed to add platform device attributes\n");
> +		dev_warn(&galaxybook->platform->dev, "failed to add platform device a=
ttributes\n");
>
> -	if (kbd_backlight) {
> -		pr_debug_prefixed("initializing kbd_backlight\n");
> -		err =3D galaxybook_kbd_backlight_init(galaxybook);
> -		if (err) {
> -			pr_debug_prefixed("failed to initialize kbd_backlight\n");
> -			kbd_backlight =3D false;
> -		}
> -	} else {
> -		pr_debug_prefixed("kbd_backlight is disabled\n");
> -	}
> -
> -	if (fan_speed) {
> -		pr_debug_prefixed("initializing fan speed\n");
> -		err =3D galaxybook_fan_speed_init(galaxybook);
> -		if (err) {
> -			pr_debug_prefixed("failed to initialize fan speed\n");
> -			fan_speed =3D false;
> -		} else {
> -#if IS_ENABLED(CONFIG_HWMON)
> -			pr_debug_prefixed("initializing hwmon device\n");
> -			err =3D galaxybook_hwmon_init(galaxybook);
> -			if (err)
> -				pr_warn("failed to initialize hwmon device\n");
> -#endif
> -		}
> -	} else {
> -		pr_debug_prefixed("fan_speed is disabled\n");
> -	}
> +	galaxybook_init_feature(kbd_backlight, galaxybook_kbd_backlight_init);
>
>   	/* i8042_filter should be disabled if kbd_backlight and allow_recordi=
ng are disabled */
>   	if (!kbd_backlight && !allow_recording)
>   		i8042_filter =3D false;
>
> -	if (i8042_filter) {
> -		pr_debug_prefixed("installing i8402 key filter to capture hotkey inpu=
t\n");
> +	galaxybook_init_feature(i8042_filter, galaxybook_i8042_filter_install)=
;
>
> -		/* initialize hotkey work queues */
> -		if (kbd_backlight)
> -			INIT_WORK(&galaxybook->kbd_backlight_hotkey_work,
> -				  galaxybook_kbd_backlight_hotkey_work);
> -		if (allow_recording)
> -			INIT_WORK(&galaxybook->allow_recording_hotkey_work,
> -				  galaxybook_allow_recording_hotkey_work);
> -
> -		err =3D i8042_install_filter(galaxybook_i8042_filter);
> -		if (err) {
> -			pr_err("failed to install i8402 key filter\n");
> -			cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
> -			cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
> -			i8042_filter =3D false;
> -		}
> -	} else {
> -		pr_debug_prefixed("i8042_filter is disabled\n");
> -	}
> -
> -	pr_debug_prefixed("installing ACPI notify handler\n");
> -	status =3D acpi_install_notify_handler(galaxybook->acpi->handle, ACPI_=
ALL_NOTIFY,
> -					     galaxybook_acpi_notify, galaxybook);
> -	if (ACPI_SUCCESS(status)) {
> -		pr_debug_prefixed("enabling ACPI notifications\n");
> -		err =3D galaxybook_enable_acpi_notify(galaxybook);
> -		if (err) {
> -			pr_warn("failed to enable ACPI notifications; "
> -				"some hotkeys will not be supported\n");
> -		} else {
> -			/* initialize ACPI hotkey work queues */
> -			INIT_WORK(&galaxybook->performance_mode_hotkey_work,
> -				  galaxybook_performance_mode_hotkey_work);
> -
> -			pr_debug_prefixed("initializing input device\n");
> -			err =3D galaxybook_input_init(galaxybook);
> -			if (err) {
> -				pr_err("failed to initialize input device\n");
> -				cancel_work_sync(&galaxybook->performance_mode_hotkey_work);
> -				galaxybook_input_exit(galaxybook);
> -			}
> -		}
> -	} else {
> -		pr_debug_prefixed("failed to install ACPI notify handler\n");
> -	}
> -
> -	pr_info("driver successfully loaded\n");
> +	dev_dbg(&galaxybook->platform->dev, "driver successfully loaded\n");
>
>   	return 0;
> -
> -err_free:
> -	kfree(galaxybook);
> -	return err;
>   }
>
>   static void galaxybook_remove(struct platform_device *pdev)
>   {
>   	struct samsung_galaxybook *galaxybook =3D dev_get_drvdata(&pdev->dev)=
;
>
> -	pr_info("removing driver\n");
> -
> -	galaxybook_device_attrs_exit(galaxybook);
> -
> -	galaxybook_input_exit(galaxybook);
> -	cancel_work_sync(&galaxybook->performance_mode_hotkey_work);
> -
> -	if (i8042_filter) {
> -		i8042_remove_filter(galaxybook_i8042_filter);
> -		cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
> -		cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
> -	}
> -
> -	acpi_remove_notify_handler(galaxybook->acpi->handle, ACPI_ALL_NOTIFY,
> -				   galaxybook_acpi_notify);
> -
> -	if (fan_speed) {
> -		galaxybook_fan_speed_exit(galaxybook);
> -#if IS_ENABLED(CONFIG_HWMON)
> -		galaxybook_hwmon_exit(galaxybook);
> -#endif
> -	}
> -
> -	if (kbd_backlight)
> -		galaxybook_kbd_backlight_exit(galaxybook);
> -
> -	if (battery_threshold)
> -		galaxybook_battery_threshold_exit(galaxybook);
> -
> -	if (performance_mode)
> -		galaxybook_profile_exit(galaxybook);
> -
> -	galaxybook_acpi_exit(galaxybook);
> -
>   	if (galaxybook_ptr)
>   		galaxybook_ptr =3D NULL;
>
> -	kfree(galaxybook);
> -
> -	pr_info("driver successfully removed\n");
> +	dev_dbg(&galaxybook->platform->dev, "driver removed\n");
>   }
>
>   static struct platform_driver galaxybook_platform_driver =3D {
>   	.driver =3D {
> -		.name =3D SAMSUNG_GALAXYBOOK_CLASS,
> +		.name =3D DRIVER_NAME,
>   		.acpi_match_table =3D galaxybook_device_ids,
>   	},
>   	.probe =3D galaxybook_probe,
>   	.remove =3D galaxybook_remove,
>   };
> -
> -static int __init samsung_galaxybook_init(void)
> -{
> -	return platform_driver_register(&galaxybook_platform_driver);
> -}
> -
> -static void __exit samsung_galaxybook_exit(void)
> -{
> -	platform_driver_unregister(&galaxybook_platform_driver);
> -}
> -
> -module_init(samsung_galaxybook_init);
> -module_exit(samsung_galaxybook_exit);
> +module_platform_driver(galaxybook_platform_driver);
>
>   MODULE_AUTHOR("Joshua Grisham <josh@joshuagrisham.com>");
> -MODULE_DESCRIPTION(SAMSUNG_GALAXYBOOK_NAME);
> +MODULE_DESCRIPTION("Samsung Galaxy Book Extras");
>   MODULE_LICENSE("GPL");

