Return-Path: <linux-kernel+bounces-516354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB3A37003
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73653188E45B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7C01E5B8E;
	Sat, 15 Feb 2025 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uG0Tw2wp"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22614A088;
	Sat, 15 Feb 2025 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641926; cv=none; b=mf42hebYwlbTsK15dA9k0jsvEcZ7cWdW5KgZIoI8UUvjFYXFk09mjtZ69Me7quwaG27+qsn0KCqrBDqYhhU12IxytU6L5LzIi1gZBUfMm1XBq5Fwp3bQvj45te0TU0pKY/lPUybTDt/s094E4SzcZkoCtX+ARxBoe7W9djwpvIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641926; c=relaxed/simple;
	bh=ZdF07qXoJPnojHDz6GKNBWAjjLy5weuq4FbGKn7LmEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZy9RMMbdtCzknAKQBFINJ3ZyWYekChBJkRG+VKc1sLbhy7PKeq2Xk7uWUBzd57JfZgV4aB38MLgk0PdYFrJ7GsFtGO2CpccCjYBXt9XcZ+Vk300QRNdaufBgDddPqrmxjqqi26B1jMdtKJ8WZIiwt7CSwmAoqG1wfC4ulSa9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=uG0Tw2wp; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739641916; x=1740246716; i=w_armin@gmx.de;
	bh=+Udm9OKsM9KLzWhel4Blt94F7jjifjUv4hiX3bMkiuk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uG0Tw2wpgYN/tovYdljm4p5bpvLk1vK2gI7W8tLoEaznMZHyG3ST4q4cNSbFLwAc
	 4SvJh/sahsobRWSG8i1/+K7C1thJmdBZzmfs+XRZJj0v4wbcJDS5EiKE742XRYpq0
	 vkum6Y7dJTnRVFm9VyY+YUEPjjacxjhUc9UQL2QFcN/tSSoiycbI5456JZDhWGFlu
	 I3wHFCkGuKJLF7oZluu3rUx7fBL14obskQ5Ere0+dSBKHMBl+k/g6KHKuQcOZqgdy
	 rsHk0y/fEkmWLifi0VeOIx5wtB0EJIuARMgZpJt/teDj3IuymxB+jQU9+sqnY+4R0
	 15iUQQl60Ywin5lE8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU9Z-1t6R4h1V0V-00b7Ia; Sat, 15
 Feb 2025 18:51:56 +0100
Message-ID: <90ba69f5-7575-4d0c-bfd3-5aa404fa9b32@gmx.de>
Date: Sat, 15 Feb 2025 18:51:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] platform/x86:lenovo-wmi-hotkey-utilities.c: Support
 for mic and audio mute LEDs
To: Jackie Dong <xy-jackie@139.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 kuurtb@gmail.com, dongeg1@lenovo.com,
 Mark Pearson <mpearson-lenovo@squebb.ca>
References: <20250215023525.17233-1-xy-jackie@139.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250215023525.17233-1-xy-jackie@139.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GFE1oDGD16O90FPbqmzx2R2586NL3Y1mVjJgBes8P2z9zyArGPS
 4kXGKpEOeLqZhIaJqmm1NWAaqZ0JqJl5ANyf/iyXe6RIORe4kQm5e1LbOhx7kGjVO0jeAVI
 t4isvhoWDJOYxe5gDZdWVhMmrdAImbTnvkBYD4CoXgdr4EP9/0K946IQ331nvjU0NQ2IO9a
 rEJApE55YoSAkndd00d5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BZ8TbTQTcRs=;ub452Zx3OA23oFQRgz4v6v540xg
 2dlP0mQ8n8lwGxPvZpxSJahlI91acBdT5eK1YxLyAA14XKFA6CfFuZbnuljPYH0PtV7G0VrPg
 qCjucv6wNj+yy1ne3IokGff7JZEtno8cgz+cUBVwBzW2/EoWteoUjSNIWKH/YoVvCpnVIpgjZ
 CitsogL74GHpIjPlspZgkgXXPGpMyM0ZanADE3vZzmJd5z5dyfgMlCS7LThj2UVjyj/hdnhHY
 EquvNjXL0jvmqxCDL2U/Uoda5IrCgjNRmGlQK+LUcs43GYKGxtpMtoKhweWI9JfeNGTSBesbs
 QO7umEewCnqfE1u1sXjOtPvbvoYDnO31s6o5OWImgXbGAH4xepbinVpgEdPhNgIVYhE1Jo4Pp
 KUVAfn84ObUon1yX06rNjvcXPEVhw3w35xDokarbHpEa7OaaPvwWjeukaJm+toznZMOuHe49m
 PVwvuoJAdPnaCIVzsuTJjR3yHCxc0i4JGaPMk7uKMOsnkUsiVS0USkoF72SqpF4xBLR/xFkjD
 HQIFlzDWGiy8JP9eZj1Y2ymn2TA/erxzRcObXr3nCL+ENnmpIWj3z3OwpWEZLLzDE2vctmC7f
 XYVwNsQCc0aYn8Es99E/P+df34BGsd82doMiTmx5OV7OR36TKk2+KWa4KjPoMtSr3AWGXBDl+
 RUHp7L0vu95WydH1Ghi4Zcek7FiHmxkd8Cy2AArM32tRbJpG+EENsgzn1CAdnPWcjUKjuhsWo
 j9tQLVHDk7ibdseZmMIWW6h4zlweBRc0fqotM0DPW+ct8cVa/x835vjT+T009xfaGdAvRYaKO
 AyFBhVGcxL4WT+n+W9s6r/wPlKTjGvKLVsIRi8XmKCi17cTbib2iXLneiAlbwps/pijlMGIEc
 mDFxiSIdm/gnLupV038Ysb7cy9S8eyr2qIlFLDiS4QhEP2GQxCumY7BvzbNQ2Jp84STaY3D8A
 Cju/+Ay/ueeyuOKWQuPsUWJnR81p40bbg8dyoO41vicJG9l5F9zGNbEERwvQiizKRwL8Mz9x8
 QDq0dVkkHg1Lmmh0VIKszLa9RH89lxbDSPdfI0eWqsaNhgO/aePpqF2BA7DEhCxiAoSXc/GpX
 moEiKRMDntHL9RaQGEKraLx7NX3CmGZRnHWQbI9X9w82xJrueWzzmYHNUSq/FdqnbU5Fs1GcP
 C2zGd5tCb9M9epCGpIaXQlbnQLElRo+xJpV25GUdgEAEfwhAFqYegMybUhF/AA4iBp3u8fj91
 I/aP+sBct4Wcv/mr6D/BzUiFbHPN9abKA4FFXb2Lc+1qVsRqtXkx9y3B+mKCYknhADa2Rdptm
 B84piMqr3EyVV6yNW4xdHhIcWpcDUq2Nnns33Y4VEbsfXDW0FlTzdm4rfRTmsq24BcXNCipXS
 bprvYmzU6lfChnbihbrUFy7tp/a+WXZDIXhXyBJ02IIDfMJqvWVSPqkMIC

Am 15.02.25 um 03:33 schrieb Jackie Dong:

> Implement Lenovo utility data WMI calls needed to make LEDs
> work on Ideapads that support this GUID.
> This enables the mic and audio LEDs to be updated correctly.
>
> Tested on below samples.
> ThinkBook 13X Gen4 IMH
> ThinkBook 14 G6 ABP
> ThinkBook 16p Gen4-21J8
> ThinkBook 16 G8 IRL
> ThinkBook 16 G7+ ASP
>
> Signed-off-by: Jackie Dong <xy-jackie@139.com>
> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Kurt Borja <kuurtb@gmail.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>
> ---
> Changes in v8:
>   - Update MAINTAINERS for this driver
>   - Added Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com=
>
>   - Added Reviewed-by: Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>
> Changes in v7:
>   - Replaced spaces by tab for items in enum hotkey_set_feature
>   - Directly return lenovo_super_hotkey_wmi_leds_setup(&wdev->dev)
>   - Added Reviewed-by: Kurt Borja <kuurtb@gmail.com>
>
> Changes in v6:
>   - Rename lenovo-super-hotkey-wmi.c to lenovo-wmi-hotkey-utilities
>   - Update LENOVO_WMI_HOTKEY_UTILITIES item description and add select
>     NEW_LEDS, LEDS_CLASS based on reviewer's suggestion.
>   - Align items in enum hotkey_set_feature
>   - Drop some brances and return error message directly
>   - Check return value of lenovo_super_hotkey_wmi_led_init() in
>     lenovo_super_hotkey_wmi_leds_setup
>
> Changes in v5:
>   - Take out union acpi_object *obj __free(kfree) =3D output.pointer fro=
m
>     if-else block
>   - Remove lsk_wmi_context_lud_keys related source code
>
> Changes in v4:
>   - Add related head files include cleanup.h, dev_printk.h, device.h,
>     module.h
>   - Replaced kfree() by __free()
>   - Remove double free for obj
>   - Remove wpriv->cdev[led_type].dev =3D dev
>   - Remove *wpriv =3D *(const struct lenovo_super_hotkey_wmi_private *)c=
ontext
>   - Remove wpriv->event =3D=3D LSH_WMI_EVENT_LUD_KEYS
>   - Remove lenovo_super_hotkey_wmi_remove() for unnecessary
>
> Changes in v3:
>   - Changed the name of the Kconfig entry to LENOVO_SUPER_HOTKEY_WMI
>   - Renamed everything in this driver which contains the name "ideapad"
>     to instead contain the name of this driver.
>   - Moved struct wmi_device *led_wdev in lenovo_super_hotkey_wmi_private=
,
>     and use container_of() to the led_wdev pointer.
>   - Replaced sizeof(struct wmi_led_args) by sizeof(led_arg)
>   - Added condtions checking for obj && obj->type =3D=3D ACPI_TYPE_INTEG=
ER
>     and free the ACPI object after get the required value.
>   - Removed led_classdev_unregister() after led_reg_failed label, but
>     add lenovo_super_hotkey_wmi_remove(struct wmi_device *wdev) to free
>     resource.
>   - Removed IDEAPAD_WMI_EVENT_FN_KEYS/IDEAPAD_WMI_EVENT_LUD_KEYS related
>     source codes and only keep LUD_WMI_METHOD_GUID.
>
> Changes in v2:
>   - Update code layout and formatting as recommended in review
>   - Improved error handling in ideapad_wmi_led_init
>   - Separated a WMI driver named lenovo-super-hotkey-wmi.c from
>     ideapad-lap.c, it's only for Lenovo Super Hotkey WMI devices.
>
>   MAINTAINERS                                   |   6 +
>   drivers/platform/x86/Kconfig                  |  11 +
>   drivers/platform/x86/Makefile                 |   1 +
>   .../x86/lenovo-wmi-hotkey-utilities.c         | 222 ++++++++++++++++++
>   4 files changed, 240 insertions(+)
>   create mode 100644 drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25c86f47353d..793ffb25ea74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13149,6 +13149,12 @@ S:	Maintained
>   W:	http://legousb.sourceforge.net/
>   F:	drivers/usb/misc/legousbtower.c
>
> +LENOVO WMI HOTKEY UTILITIES DRIVER
> +M:	Jackie Dong <xy-jackie@139.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> +
>   LETSKETCH HID TABLET DRIVER
>   M:	Hans de Goede <hdegoede@redhat.com>
>   L:	linux-input@vger.kernel.org
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64..715bcfbe992f 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -475,6 +475,17 @@ config IDEAPAD_LAPTOP
>   	  This is a driver for Lenovo IdeaPad netbooks contains drivers for
>   	  rfkill switch, hotkey, fan control and backlight control.
>
> +config LENOVO_WMI_HOTKEY_UTILITIES
> +	tristate "Lenovo Hotkey Utility WMI extras driver"
> +	depends on ACPI_WMI
> +	depends on IDEAPAD_LAPTOP
> +	select NEW_LEDS
> +	select LEDS_CLASS
> +	help
> +	  This driver provides WMI support for Lenovo customized hotkeys funct=
ion,
> +	  such as LED control for audio/mic mute event for Ideapad, YOGA, Xiao=
Xin,
> +	  Gaming, ThinkBook and so on.
> +
>   config LENOVO_YMC
>   	tristate "Lenovo Yoga Tablet Mode Control"
>   	depends on ACPI_WMI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index e1b142947067..131fcf974477 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_UV_SYSFS)       +=3D uv_sysfs.o
>   # IBM Thinkpad and Lenovo
>   obj-$(CONFIG_IBM_RTL)		+=3D ibm_rtl.o
>   obj-$(CONFIG_IDEAPAD_LAPTOP)	+=3D ideapad-laptop.o
> +obj-$(CONFIG_LENOVO_WMI_HOTKEY_UTILITIES)	+=3D lenovo-wmi-hotkey-utilit=
ies.o
>   obj-$(CONFIG_LENOVO_YMC)	+=3D lenovo-ymc.o
>   obj-$(CONFIG_SENSORS_HDAPS)	+=3D hdaps.o
>   obj-$(CONFIG_THINKPAD_ACPI)	+=3D thinkpad_acpi.o
> diff --git a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c b/driver=
s/platform/x86/lenovo-wmi-hotkey-utilities.c
> new file mode 100644
> index 000000000000..9df7145620a0
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Lenovo Super Hotkey Utility WMI extras driver for Ideapad laptop
> + *
> + *  Copyright (C) 2025	Lenovo
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +
> +/* Lenovo Super Hotkey WMI GUIDs */
> +#define LUD_WMI_METHOD_GUID	"CE6C0974-0407-4F50-88BA-4FC3B6559AD8"
> +
> +/* Lenovo Utility Data WMI method_id */
> +#define WMI_LUD_GET_SUPPORT 1
> +#define WMI_LUD_SET_FEATURE 2
> +
> +#define WMI_LUD_GET_MICMUTE_LED_VER   20
> +#define WMI_LUD_GET_AUDIOMUTE_LED_VER 26
> +
> +#define WMI_LUD_SUPPORT_MICMUTE_LED_VER   25
> +#define WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER 27
> +
> +/* Input parameters to mute/unmute audio LED and Mic LED */
> +struct wmi_led_args {
> +	u8 id;
> +	u8 subid;
> +	u16 value;
> +};
> +
> +/* Values of input parameters to SetFeature of audio LED and Mic LED */
> +enum hotkey_set_feature {
> +	MIC_MUTE_LED_ON		=3D 1,
> +	MIC_MUTE_LED_OFF	=3D 2,
> +	AUDIO_MUTE_LED_ON	=3D 4,
> +	AUDIO_MUTE_LED_OFF	=3D 5,
> +};
> +
> +#define LSH_ACPI_LED_MAX 2
> +
> +struct lenovo_super_hotkey_wmi_private {
> +	struct led_classdev cdev[LSH_ACPI_LED_MAX];
> +	struct wmi_device *led_wdev;
> +};
> +
> +enum mute_led_type {
> +	MIC_MUTE,
> +	AUDIO_MUTE,
> +};
> +
> +static int lsh_wmi_mute_led_set(enum mute_led_type led_type, struct led=
_classdev *led_cdev,
> +				enum led_brightness brightness)
> +
> +{
> +	struct lenovo_super_hotkey_wmi_private *wpriv =3D container_of(led_cde=
v,
> +			struct lenovo_super_hotkey_wmi_private, cdev[led_type]);
> +	struct wmi_led_args led_arg =3D {0, 0, 0};
> +	struct acpi_buffer input;
> +	acpi_status status;
> +
> +	switch (led_type) {
> +	case MIC_MUTE:
> +		led_arg.id =3D brightness =3D=3D LED_ON ? MIC_MUTE_LED_ON : MIC_MUTE_=
LED_OFF;
> +		break;
> +	case AUDIO_MUTE:
> +		led_arg.id =3D brightness =3D=3D LED_ON ? AUDIO_MUTE_LED_ON : AUDIO_M=
UTE_LED_OFF;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	input.length =3D sizeof(led_arg);
> +	input.pointer =3D &led_arg;
> +	status =3D wmidev_evaluate_method(wpriv->led_wdev, 0, WMI_LUD_SET_FEAT=
URE, &input, NULL);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int lsh_wmi_audiomute_led_set(struct led_classdev *led_cdev,
> +				     enum led_brightness brightness)
> +
> +{
> +	return lsh_wmi_mute_led_set(AUDIO_MUTE, led_cdev, brightness);
> +}
> +
> +static int lsh_wmi_micmute_led_set(struct led_classdev *led_cdev,
> +				   enum led_brightness brightness)
> +{
> +	return lsh_wmi_mute_led_set(MIC_MUTE, led_cdev, brightness);
> +}
> +
> +static int lenovo_super_hotkey_wmi_led_init(enum mute_led_type led_type=
, struct device *dev)
> +{
> +	struct lenovo_super_hotkey_wmi_private *wpriv =3D dev_get_drvdata(dev)=
;
> +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_buffer input;
> +	int led_version, err =3D 0;
> +	unsigned int wmiarg;
> +	acpi_status status;
> +
> +	switch (led_type) {
> +	case MIC_MUTE:
> +		wmiarg =3D WMI_LUD_GET_MICMUTE_LED_VER;
> +		break;
> +	case AUDIO_MUTE:
> +		wmiarg =3D WMI_LUD_GET_AUDIOMUTE_LED_VER;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	input.length =3D sizeof(wmiarg);
> +	input.pointer =3D &wmiarg;
> +	status =3D wmidev_evaluate_method(wpriv->led_wdev, 0, WMI_LUD_GET_SUPP=
ORT, &input, &output);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	union acpi_object *obj __free(kfree) =3D output.pointer;
> +	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)
> +		led_version =3D obj->integer.value;
> +	else
> +		return -EIO;
> +
> +	wpriv->cdev[led_type].max_brightness =3D LED_ON;
> +	wpriv->cdev[led_type].flags =3D LED_CORE_SUSPENDRESUME;
> +
> +	switch (led_type) {
> +	case MIC_MUTE:
> +		if (led_version !=3D WMI_LUD_SUPPORT_MICMUTE_LED_VER)
> +			return -EIO;
> +
> +		wpriv->cdev[led_type].name =3D "platform::micmute";
> +		wpriv->cdev[led_type].brightness_set_blocking =3D &lsh_wmi_micmute_le=
d_set;
> +		wpriv->cdev[led_type].default_trigger =3D "audio-micmute";
> +
> +		err =3D devm_led_classdev_register(dev, &wpriv->cdev[led_type]);
> +		if (err < 0)
> +			goto led_reg_failed;
> +
> +		break;
> +	case AUDIO_MUTE:
> +		if (led_version !=3D WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER)
> +			return -EIO;
> +
> +		wpriv->cdev[led_type].name =3D "platform::mute";
> +		wpriv->cdev[led_type].brightness_set_blocking =3D &lsh_wmi_audiomute_=
led_set;
> +		wpriv->cdev[led_type].default_trigger =3D "audio-mute";
> +
> +		err =3D devm_led_classdev_register(dev, &wpriv->cdev[led_type]);
> +		if (err < 0)
> +			goto led_reg_failed;

Hi,

please deduplicate the LED registration code. You can do that by calling d=
evm_led_classdev_register()
after the switch statement.

> +
> +		break;
> +	default:
> +		dev_err(dev, "Unknown LED type %d\n", led_type);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +
> +led_reg_failed:
> +	dev_err(dev, "Could not register mute LED %d : %d\n", led_type, err);
> +	return err;
> +}
> +
> +static int lenovo_super_hotkey_wmi_leds_setup(struct device *dev)
> +{
> +	int err;
> +
> +	err =3D lenovo_super_hotkey_wmi_led_init(MIC_MUTE, dev);
> +	if (err)
> +		return err;
> +
> +	err =3D lenovo_super_hotkey_wmi_led_init(AUDIO_MUTE, dev);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int lenovo_super_hotkey_wmi_probe(struct wmi_device *wdev, const=
 void *context)
> +{
> +	struct lenovo_super_hotkey_wmi_private *wpriv;
> +
> +	wpriv =3D devm_kzalloc(&wdev->dev, sizeof(*wpriv), GFP_KERNEL);
> +	if (!wpriv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&wdev->dev, wpriv);
> +	wpriv->led_wdev =3D wdev;
> +	return lenovo_super_hotkey_wmi_leds_setup(&wdev->dev);
> +}
> +
> +static const struct wmi_device_id lenovo_super_hotkey_wmi_id_table[] =
=3D {
> +	{ LUD_WMI_METHOD_GUID, NULL }, /* Utility data */
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(wmi, lenovo_super_hotkey_wmi_id_table);
> +
> +static struct wmi_driver lenovo_super_hotkey_wmi_driver =3D {
> +	 .driver =3D {
> +		 .name =3D "lenovo_super_hotkey_wmi",

The name of the driver and the associated data structures still contains "=
super_hotkey"
when the module is being called "lenovo-wmi-hotkey-utilities".

Please rename the driver and the data structures to better match the modul=
e name.

Thanks,
Armin Wolf

> +		 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS
> +	 },
> +	 .id_table =3D lenovo_super_hotkey_wmi_id_table,
> +	 .probe =3D lenovo_super_hotkey_wmi_probe,
> +	 .no_singleton =3D true,
> +};
> +
> +module_wmi_driver(lenovo_super_hotkey_wmi_driver);
> +
> +MODULE_INFO(depends, "wmi,ideapad-laptop");
> +MODULE_AUTHOR("Jackie Dong <dongeg1@lenovo.com>");
> +MODULE_DESCRIPTION("Lenovo Super Hotkey Utility WMI extras driver");
> +MODULE_LICENSE("GPL");

