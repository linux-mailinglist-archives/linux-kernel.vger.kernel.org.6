Return-Path: <linux-kernel+bounces-352476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3EF991FC9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 18:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8301F215C0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6792189BB5;
	Sun,  6 Oct 2024 16:58:34 +0000 (UTC)
Received: from dsmtpq3-prd-nl1-vfz.edge.unified.services (dsmtpq3-prd-nl1-vfz.edge.unified.services [84.116.6.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0589136E3F
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.116.6.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728233914; cv=none; b=VMvdAlQ23Ije+7eQV1ObJy0Jj07whUxWwFztABYlQHnVQ4QAASrAEYzdHa4gVv++r+0L02PjfrzAMFJ+V7ipygTTbF7Tqn8U1treF6h7uvWiyt/imxjB7WOtbPcEC1bm78X31LRSzbz4rioNwIKu7F+Kgn+lQUqlLoigIM4Y8Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728233914; c=relaxed/simple;
	bh=fYF1jODItvn4rlyGfZQacksuZCTrAG3CDA2RYOwpYL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EP9E7AHdzlLQ1lR7qWqVfdw6qq4E6wrndTMG+e7BGR5zd2pVpJZoX6HHfoxzlaxOtqg0zr3FUVck1dopcTGZg+epzN0iYIhMHQ5PYOR6+Xp/8lqM+ZfPK/WUkPpaTWIFVX3QwbClFEao09lM0oqUZ6Lt1fV4nuurDb1qBM32yRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=zonnet.nl; spf=fail smtp.mailfrom=zonnet.nl; arc=none smtp.client-ip=84.116.6.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=zonnet.nl
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=zonnet.nl
Received: from csmtpq2-prd-nl1-vfz.edge.unified.services ([84.116.50.17])
	by dsmtpq3-prd-nl1-vfz.edge.unified.services with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <rn.mast@zonnet.nl>)
	id 1sxUWI-007Lye-JZ
	for linux-kernel@vger.kernel.org; Sun, 06 Oct 2024 18:54:10 +0200
Received: from csmtp3-prd-nl1-vfz.nl1.unified.services ([100.107.80.136] helo=csmtp3-prd-nl1-vfz.edge.unified.services)
	by csmtpq2-prd-nl1-vfz.edge.unified.services with esmtp (Exim 4.93)
	(envelope-from <rn.mast@zonnet.nl>)
	id 1sxUWA-001ZI8-W7
	for linux-kernel@vger.kernel.org; Sun, 06 Oct 2024 18:54:03 +0200
Received: from [192.168.178.171] ([217.62.228.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by csmtp3-prd-nl1-vfz.edge.unified.services with ESMTPSA
	id xUWAslz8q5TFixUWAs7YI4; Sun, 06 Oct 2024 18:54:02 +0200
X-Env-Mailfrom: rn.mast@zonnet.nl
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 217.62.228.60
X-CNFS-Analysis: v=2.4 cv=WIEtXWsR c=1 sm=1 tr=0 ts=6702c0aa cx=a_exe
 a=OXinquTQ3LwltNd+b0x1bg==:117 a=OXinquTQ3LwltNd+b0x1bg==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=a3QoFbTJfDPCQh3_qdQA:9 a=QEXdDO2ut3YA:10
X-Authenticated-Sender: r.mast73@upcmail.nl
Message-ID: <e0c8c98f-64ec-4297-bbc8-de489414515c@zonnet.nl>
Date: Sun, 6 Oct 2024 18:54:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/20] platform/x86: intel_atomisp2: Move to intel
 sub-directory
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Kate Hsuan <hpa@redhat.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com, mchehab@redhat.com,
 laurent.pinchart@ideasonboard.com, kitakar@gmail.com
Cc: Mark Gross <mgross@linux.intel.com>, Alex Hung <alex.hung@canonical.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>, Zha Qipeng <qipeng.zha@intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 AceLan Kao <acelan.kao@canonical.com>, Jithu Joseph
 <jithu.joseph@intel.com>, Maurice Ma <maurice.ma@intel.com>
References: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
 <20210820110458.73018-15-andriy.shevchenko@linux.intel.com>
Content-Language: nl
From: Robert Mast <rn.mast@zonnet.nl>
In-Reply-To: <20210820110458.73018-15-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBQ9casefpNeMkjjJ/QMnQbHZp4fmgRBWRhtmdub6u0exkbTHQW8msAtwcpGGaHvVX7q4cER6JznMtgnecdubZf7ejLskUDKK8g3RJwbdXxnvNpMa+Xe
 VkFoeklSo6Ni9oKfBgTBaOYVlgMirYimZ91CFzIf5oKbRWwhKtbI72S5sXVQ5OnuaAZdF2NQF0BEPlz8VroAh0Vb4Z+AM0zaEcH+dNV7rh3tN2recRCoFBAA
 aJVmUpp5u/euZinugteiOQQIx5zMhl/m8ptoVhpWAqhK6005o22veh537xh8nxBOy5vVkwogiIbxU9HnzkVt68fpQ87sQP3yDrQyI8d8ME2f2kq886ByOKoI
 e5QyZ7LmKFrs9z82vlnfLlTz9Qq70Eb6iZtHY0xtj+4vWZUXvPnDE+KacSQRsigSg7XP0y1N1SVTQdu0NripLTRm2EI6yjQEzEYn6MUObGa3/kmFlA24rTrQ
 NWYE8iJV5UJjNyiHEwpIjkJNxp/7SSnQK31aCA+4r93VylmfjLZzfGY7nzgJY2yriJkzntfHyPJONVFNinP+NUlKzLG3Pz9ohHIYzemDXWQAiR4ucJ+K/4N6
 NOF5LgROeNH6Hbcw9SlxM2aR2cYoKnphL/tlmXd/Z/wZw8ybivAscMhDsC4yJHpn0cym8DdX9SPzfOlHdNUMKGEUKq1dX5N5otpRalsOto9P9aBV2g6vfu/s
 VHzqqCMOUjyv32/h6eMsnCFVp/Wc3PPZu8BWL3zgdW1Bzsyi8S4AvYuAaWEDry6nFnot31B4GRJDuao27Ab+wEnVCFYKRBVlKhNYkq/x0KqXF90xFwZEvbbP
 dmV6J7eTPk7Cwr0tepRCciiDS7/OspJjSeI9n9mYKmECnfKbuKCJ7ypI33ZOXA==

Hi,

In an attempt to put the camera led on the T100ta (baytrail) back on to 
repeat the success of Mauro on the ov2680 on cherry trail for the 
MT9M114 I compiled this led-driver in the media-atomisp branch of hgoede 
to try to put the camera back on by writing 1 to 
/sys/class/leds/atomisp::camera/brightness

However nothing happened. At boot the camera led is on, but with my 
Debian 12.7 install of bootia32.efi and the like the camera is already 
off at the boot menu, so there is another trick used to shut it off even 
before the kernel has been boot. Does any of you have any clue how to 
get that camera back on for use in v4l? Mauro did so on the 20th of may 
2020 for the ov2680 on Cherry Trail with a little help of Intel.

Or am I just too short sighted for trying to get light in /dev/video0 
because of the lack of libcamera support?

Should v4l2-ctl have an answer about /dev/video0 as long as there is no 
userspace-driver, or should I test differently?

Here a blog of my progress: 
https://github.com/jfwells/linux-asus-t100ta/issues/4 with some dmesg 
and config dumps.

Op 20-8-2021 om 13:04 schreef Andy Shevchenko:
> From: Kate Hsuan <hpa@redhat.com>
> 
> Move Intel AtomISP v2 drivers to intel sub-directory
> to improve readability.
> 
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   MAINTAINERS                                   |  4 +-
>   drivers/platform/x86/Kconfig                  | 34 ---------------
>   drivers/platform/x86/Makefile                 |  2 -
>   drivers/platform/x86/intel/Kconfig            |  1 +
>   drivers/platform/x86/intel/Makefile           |  1 +
>   drivers/platform/x86/intel/atomisp2/Kconfig   | 43 +++++++++++++++++++
>   drivers/platform/x86/intel/atomisp2/Makefile  |  9 ++++
>   .../atomisp2/led.c}                           |  0
>   .../atomisp2/pm.c}                            |  0
>   9 files changed, 56 insertions(+), 38 deletions(-)
>   create mode 100644 drivers/platform/x86/intel/atomisp2/Kconfig
>   create mode 100644 drivers/platform/x86/intel/atomisp2/Makefile
>   rename drivers/platform/x86/{intel_atomisp2_led.c => intel/atomisp2/led.c} (100%)
>   rename drivers/platform/x86/{intel_atomisp2_pm.c => intel/atomisp2/pm.c} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf29f7154889..429b8b5c5283 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9212,13 +9212,13 @@ INTEL ATOMISP2 DUMMY / POWER-MANAGEMENT DRIVER
>   M:	Hans de Goede <hdegoede@redhat.com>
>   L:	platform-driver-x86@vger.kernel.org
>   S:	Maintained
> -F:	drivers/platform/x86/intel_atomisp2_pm.c
> +F:	drivers/platform/x86/intel/atomisp2/pm.c
>   
>   INTEL ATOMISP2 LED DRIVER
>   M:	Hans de Goede <hdegoede@redhat.com>
>   L:	platform-driver-x86@vger.kernel.org
>   S:	Maintained
> -F:	drivers/platform/x86/intel_atomisp2_led.c
> +F:	drivers/platform/x86/intel/atomisp2/led.c
>   
>   INTEL BIOS SAR INT1092 DRIVER
>   M:	Shravan S <s.shravan@intel.com>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 55820fc60a63..81eaa00983bd 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -668,40 +668,6 @@ config THINKPAD_LMI
>   
>   source "drivers/platform/x86/intel/Kconfig"
>   
> -config INTEL_ATOMISP2_LED
> -	tristate "Intel AtomISP2 camera LED driver"
> -	depends on GPIOLIB && LEDS_GPIO
> -	help
> -	  Many Bay Trail and Cherry Trail devices come with a camera attached
> -	  to Intel's Image Signal Processor. Linux currently does not have a
> -	  driver for these, so they do not work as a camera. Some of these
> -	  camera's have a LED which is controlled through a GPIO.
> -
> -	  Some of these devices have a firmware issue where the LED gets turned
> -	  on at boot. This driver will turn the LED off at boot and also allows
> -	  controlling the LED (repurposing it) through the sysfs LED interface.
> -
> -	  Which GPIO is attached to the LED is usually not described in the
> -	  ACPI tables, so this driver contains per-system info about the GPIO
> -	  inside the driver, this means that this driver only works on systems
> -	  the driver knows about.
> -
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called intel_atomisp2_led.
> -
> -config INTEL_ATOMISP2_PM
> -	tristate "Intel AtomISP2 dummy / power-management driver"
> -	depends on PCI && IOSF_MBI && PM
> -	depends on !INTEL_ATOMISP
> -	help
> -	  Power-management driver for Intel's Image Signal Processor found on
> -	  Bay Trail and Cherry Trail devices. This dummy driver's sole purpose
> -	  is to turn the ISP off (put it in D3) to save power and to allow
> -	  entering of S0ix modes.
> -
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called intel_atomisp2_pm.
> -
>   config INTEL_HID_EVENT
>   	tristate "INTEL HID Event"
>   	depends on ACPI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 1b1f4337a77f..6c682114e4fe 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -71,8 +71,6 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>   # Intel
>   obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
>   
> -obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= intel_atomisp2_led.o
> -obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= intel_atomisp2_pm.o
>   obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
>   obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
>   obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
> diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
> index 0c044b31e822..e8e1bad38113 100644
> --- a/drivers/platform/x86/intel/Kconfig
> +++ b/drivers/platform/x86/intel/Kconfig
> @@ -16,6 +16,7 @@ menuconfig X86_PLATFORM_DRIVERS_INTEL
>   
>   if X86_PLATFORM_DRIVERS_INTEL
>   
> +source "drivers/platform/x86/intel/atomisp2/Kconfig"
>   source "drivers/platform/x86/intel/int1092/Kconfig"
>   source "drivers/platform/x86/intel/int33fe/Kconfig"
>   source "drivers/platform/x86/intel/int3472/Kconfig"
> diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
> index 9858657f3f39..8ce9894e5efe 100644
> --- a/drivers/platform/x86/intel/Makefile
> +++ b/drivers/platform/x86/intel/Makefile
> @@ -4,6 +4,7 @@
>   # Intel x86 Platform-Specific Drivers
>   #
>   
> +obj-$(CONFIG_INTEL_ATOMISP2_PDX86)	+= atomisp2/
>   obj-$(CONFIG_INTEL_SAR_INT1092)		+= int1092/
>   obj-$(CONFIG_INTEL_CHT_INT33FE)		+= int33fe/
>   obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
> diff --git a/drivers/platform/x86/intel/atomisp2/Kconfig b/drivers/platform/x86/intel/atomisp2/Kconfig
> new file mode 100644
> index 000000000000..35dd2be9d2a1
> --- /dev/null
> +++ b/drivers/platform/x86/intel/atomisp2/Kconfig
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Intel x86 Platform Specific Drivers
> +#
> +
> +config INTEL_ATOMISP2_PDX86
> +	bool
> +
> +config INTEL_ATOMISP2_LED
> +	tristate "Intel AtomISP v2 camera LED driver"
> +	depends on GPIOLIB && LEDS_GPIO
> +	select INTEL_ATOMISP2_PDX86
> +	help
> +	  Many Bay Trail and Cherry Trail devices come with a camera attached
> +	  to Intel's Image Signal Processor. Linux currently does not have a
> +	  driver for these, so they do not work as a camera. Some of these
> +	  camera's have a LED which is controlled through a GPIO.
> +
> +	  Some of these devices have a firmware issue where the LED gets turned
> +	  on at boot. This driver will turn the LED off at boot and also allows
> +	  controlling the LED (repurposing it) through the sysfs LED interface.
> +
> +	  Which GPIO is attached to the LED is usually not described in the
> +	  ACPI tables, so this driver contains per-system info about the GPIO
> +	  inside the driver, this means that this driver only works on systems
> +	  the driver knows about.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called intel_atomisp2_led.
> +
> +config INTEL_ATOMISP2_PM
> +	tristate "Intel AtomISP v2 dummy / power-management driver"
> +	depends on PCI && IOSF_MBI && PM
> +	depends on !INTEL_ATOMISP
> +	select INTEL_ATOMISP2_PDX86
> +	help
> +	  Power-management driver for Intel's Image Signal Processor found on
> +	  Bay Trail and Cherry Trail devices. This dummy driver's sole purpose
> +	  is to turn the ISP off (put it in D3) to save power and to allow
> +	  entering of S0ix modes.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called intel_atomisp2_pm.
> diff --git a/drivers/platform/x86/intel/atomisp2/Makefile b/drivers/platform/x86/intel/atomisp2/Makefile
> new file mode 100644
> index 000000000000..96b1e877d1f1
> --- /dev/null
> +++ b/drivers/platform/x86/intel/atomisp2/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Intel x86 Platform Specific Drivers
> +#
> +
> +intel_atomisp2_led-y			:= led.o
> +obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= intel_atomisp2_led.o
> +intel_atomisp2_pm-y			+= pm.o
> +obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= intel_atomisp2_pm.o
> diff --git a/drivers/platform/x86/intel_atomisp2_led.c b/drivers/platform/x86/intel/atomisp2/led.c
> similarity index 100%
> rename from drivers/platform/x86/intel_atomisp2_led.c
> rename to drivers/platform/x86/intel/atomisp2/led.c
> diff --git a/drivers/platform/x86/intel_atomisp2_pm.c b/drivers/platform/x86/intel/atomisp2/pm.c
> similarity index 100%
> rename from drivers/platform/x86/intel_atomisp2_pm.c
> rename to drivers/platform/x86/intel/atomisp2/pm.c


