Return-Path: <linux-kernel+bounces-525818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAAFA3F5D8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59F8188FAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D84288CC;
	Fri, 21 Feb 2025 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="m0yV8nqz"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7901EB3D;
	Fri, 21 Feb 2025 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144048; cv=none; b=TViaiFesZP851v+eKKLMrJe5kgTgvGXD22mMbWFyOYaoBxq+aKydNYh6477GeYz4oi0Gz5rD2BPX606X5XcZyDYlrY9YwYytmP8OIK6SjBFQZwrDfMvhoW/Xj2mfbY6Nj/BaHjcpm+8xnYjm3PiZ8tSA13q5tKWo1bQ1K136M1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144048; c=relaxed/simple;
	bh=ZXUWogyXDoFMhLx9mQwfNl8XHitslYFARNmU63HJQMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZU4gr76baL8cpubFTijBN74yQFGG6vTkf53RnOY2V0Pz9L+tJNnJVNzvrErm0dZzds/PkMDvgZpIp5KT7AkuHmJk9MXF7weXcRslWKYZSsO/ONnC2VeCjUCVxft4NNdu20OSNVFC6298kmr5ovQzgGC5uSwjYMNxdOuswhJiHRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=m0yV8nqz; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740144023; x=1740748823; i=w_armin@gmx.de;
	bh=GykKfGRTP5IrNapSFp0m5wwcf2/EL5MWIrXNwoTJWKY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=m0yV8nqzgs79PLL6C8xgnTE9ZNABH4gYed3bbgybsDNLBkMFmJJkzk68A5duS44i
	 zcU3hsiE3D0NRckyMBFHQQepjqgsStWlReiYX4IUXvoDs8VctwZp0/fh+mc5S0S20
	 6rCfPCUoZhyNN3j1blWuI6fc6SbWR5y14iCqDu1xQHaUuK4jIA/Ch29rI/GhcvsMY
	 1GeWtRB3oKACjxF5xg8ro48WfTCga0bN72Lmtr0UQoS4VsgQKRzKuAkCfNZ7TobZB
	 /OMGUFt4YtRVrAcYG3PXL8N4WulpBotMMWri1nKrs7pEARoxTW9tndDmbgfDtnsb2
	 DG+QLdA2GqXjDH5lqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUjC-1tUUIW3xSc-010vOP; Fri, 21
 Feb 2025 14:20:23 +0100
Message-ID: <58afc79c-4dc0-4811-9cdc-554d5b1b1e1f@gmx.de>
Date: Fri, 21 Feb 2025 14:20:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] platform/x86:lenovo-wmi-hotkey-utilities.c: Support
 for mic and audio mute LEDs
To: Jackie Dong <xy-jackie@139.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 kuurtb@gmail.com, dongeg1@lenovo.com,
 Mark Pearson <mpearson-lenovo@squebb.ca>
References: <20250221090322.3706-1-xy-jackie@139.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250221090322.3706-1-xy-jackie@139.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q/WxAQzIWB18p4AHBXDQxZcXT7vf7yuJOpc+ESwEltJrS8sY3mk
 3zx07Zt4nnNDMikrrwciRtIBjVM1GcNMqhzCqX6t9RE7+wDSSesqABFy+YsCQQEygek7lGS
 ISOv3uYPcYcC2nofhrCbNIthFya6oS/JjxsKR5sA6jdnUYVI3LbgPmQEAYqy5QSODAB/PpD
 Wm+yuIQTVc5UyWdINjowg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HMmR3NZwmoY=;DZmxjEpIWZLbQgMT/w83FvvmqS0
 Kk0ucG+OgdPCy01wjRZOa/D/tszCrKCYgau0m8luzRU1nfvP2RYy0BSwEI2rN/jxRy56d4/S3
 0zNJ0szd9Puu+E5+z9KdXj/LLkXinqptRzvpjjcG91j3EMXPoQv+xcI2VmzTia2Q+WFFZd/5k
 Kz+wfrhMZ744w0MUX22H81r6Y1iUDfTC+RCimysTKtp+eI8oU4cEn5simAFvrN6vhGas5YHzo
 U8qT9CKBPNH7o0d6dGudxV+7UU01SsrBwCGfmXmjdSLSH5/mWOuNjNhVpntGdxCyovYgcCQVq
 GNKEA4ZKWIuYnE+hkOXt+O0FtQZ1FrtTwcBcU7bnk8jIkDTE5AVcjIu2fJK0ns073qqycw/2X
 HZ8NKyipTonsil5zYavqrQFepAALC2h9H7RYa60b/P0rjzrGopqipeqaHglQHXqM5Vse0xWvT
 LUzxkXKMjekcQrfWE5u0frOoeplcnN5ldsAe3lMMH2MMugPS5UnXcJ5pU2id+kBZlGUtxLnqq
 dqOA48CtBa0Py1l318fN2RzlyWDN7YcxncMl95vT0WzUf7vzCScScj+gNhTADi/V/CGUoZCT2
 607sqNma5ZQ0vzdFKmUxNwYFc+dbqpYtVrQBl9bGXx9Mz8SSdXm++nrlJhePQWsFOgY/I6925
 R55QsRXg4KCNQ5U33z2sqyWoJAcUM0/cehwPadT+qWuqtuJCNQw1NnovFbt+QrnvGY9fhUyrl
 7REO244itXJ1LZiifOytFhNbklfLDgEtaGQ/ZHjM97q2UIbEly5QZy9yQoKgcOCDsCUFhdS2a
 aI1Yq3KIykeWNzdHWUfREPnju552F+NtS0tfRjmqA2PtS6ZCu90eEoA/MQYCQXr8f77+pUIew
 sXn8CQfGSUxQWaah22LWWYDKUUU+6VdI9/rWtoCSdDGAG/ucwMMqmCd0ObqOhTBu7jsR/T/xn
 R9QP4Ksup3TLAgPS/Wlnh7JuBIsPUzd0qFdAmrCgjqxEM7Em3KN1W+ZSc7i4PGv4TVld67iJb
 2o/jtce0NeEwm46ghPvzIz3Gc3GX7+IXMC5cPeK7psFdLxkDjZjgKv7AiiP0WsHovfhxYzXkY
 D5WxBjogIV6ZlFOzUqR1jIH7daF6ZSNqook4LRI60KscfBJn0uVsLEi05jLWfxaBd+XGmjac/
 ofN5DzO6YXeTOB4BNiXLvb7a84ITeIt7Q7RGzIFj84O6bO06B/cFByokGXR2Gno2+JqLm9muN
 p6pUr+o0+rofvCGfClPLHr2q7ZRz61ZyYfJg5+aZ2C76TlU/2eFRkHyqRgp/lmJJAeSFxXXQ9
 FWMCF3HeYPr1tsN4YOANCaLO/pzwOicLgW6wrP9WEj0x6058y9oxpCdUg23qh3f3BS34TKMov
 aTHVZ4nNHVEiNuwUZOEbaUmfL/LwsgjrcO64/JVX26BpzV0ZPqZEje67Vp

Am 21.02.25 um 10:03 schrieb Jackie Dong:

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
> Changes in v10:
>   - Using "imply" instead of "depends on" for CONFIG_IDEAPAD_LAPTOP
>   - Drop led_reg_failed and call dev_err() directly
>
> Changes in v9:
>   - Call devm_led_classdev_register() after the switch statement
>   - Update struct wmi_driver with .name =3D "lenovo_wmi_hotkey_utilities=
"
>
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
>   .../x86/lenovo-wmi-hotkey-utilities.c         | 213 ++++++++++++++++++
>   4 files changed, 231 insertions(+)
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
> index 0258dd879d64..b5ac61a0f2fb 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -475,6 +475,17 @@ config IDEAPAD_LAPTOP
>   	  This is a driver for Lenovo IdeaPad netbooks contains drivers for
>   	  rfkill switch, hotkey, fan control and backlight control.
>
> +config LENOVO_WMI_HOTKEY_UTILITIES
> +	tristate "Lenovo Hotkey Utility WMI extras driver"
> +	depends on ACPI_WMI
> +	select NEW_LEDS
> +	select LEDS_CLASS
> +	imply IDEAPAD_LAPTOP
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
> index 000000000000..54c61bfdf13f
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> @@ -0,0 +1,213 @@
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
> +		break;
> +	case AUDIO_MUTE:
> +		if (led_version !=3D WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER)
> +			return -EIO;
> +
> +		wpriv->cdev[led_type].name =3D "platform::mute";
> +		wpriv->cdev[led_type].brightness_set_blocking =3D &lsh_wmi_audiomute_=
led_set;
> +		wpriv->cdev[led_type].default_trigger =3D "audio-mute";
> +		break;
> +	default:
> +		dev_err(dev, "Unknown LED type %d\n", led_type);
> +		return -EINVAL;
> +	}
> +
> +	err =3D devm_led_classdev_register(dev, &wpriv->cdev[led_type]);
> +	if (err < 0) {
> +		dev_err(dev, "Could not register mute LED %d : %d\n", led_type, err);
> +		return err;
> +	}
> +	return 0;
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
> +static struct wmi_driver lenovo_wmi_hotkey_utilities_driver =3D {
> +	 .driver =3D {
> +		 .name =3D "lenovo_wmi_hotkey_utilities",
> +		 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS
> +	 },
> +	 .id_table =3D lenovo_super_hotkey_wmi_id_table,
> +	 .probe =3D lenovo_super_hotkey_wmi_probe,
> +	 .no_singleton =3D true,
> +};
> +
> +module_wmi_driver(lenovo_wmi_hotkey_utilities_driver);
> +
> +MODULE_INFO(depends, "wmi,ideapad-laptop");

Sorry for noticing this only now, but i think this MODULE_INFO() is unnece=
ssary:

- "wmi" will already be loaded since the driver uses symbols exported by i=
t
- "ideapad-laptop" will get loaded automatically on supported hardware

Because of this i think you can safely remove this. Other than that the dr=
iver
seems ready for mainline to me.

Thanks,
Armin Wolf

> +MODULE_AUTHOR("Jackie Dong <dongeg1@lenovo.com>");
> +MODULE_DESCRIPTION("Lenovo Super Hotkey Utility WMI extras driver");
> +MODULE_LICENSE("GPL");

