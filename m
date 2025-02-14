Return-Path: <linux-kernel+bounces-515338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504C6A3635E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B8F3A5768
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2466C26770D;
	Fri, 14 Feb 2025 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="OvwjQ6ed"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793526738A;
	Fri, 14 Feb 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551469; cv=none; b=GurIZ+kFhOIp/NteFCceoWzORtXynCIwEuPQPsaphbXmaxN48DVeLxVuur1AAmS+VR+y+TsgNC7kqcstIQHsYS0M62xNuknO3pEWJxQpi6Yjj1zKuGtRdNRW7elbBIypXDrdb1g59o5SnVyt58pYLToAGsxE8TJSvtcwGN/aaGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551469; c=relaxed/simple;
	bh=k9bEKjYSAJbDRHrkmJzawgplW6zMWmxht/+7rXGONaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZIhL9OXalQxLyl5iaw/UvD+Z+qm8JAv7jOIF74mg/l2SBbJPc/bhHdYajXTKionZFqSSOXnA9qtKRJ8YeTyeYMvfcuW6IG6YZ+95LrbZqdZ/2HBciS767hRZqv3HV9VXduaE7MYbUVa8XBnPBA7RxMrik4P33OGmI/ghAg9RRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=OvwjQ6ed; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739551464; x=1740156264; i=w_armin@gmx.de;
	bh=9dQRTjzmfye0YLMwS//LyRqOJ1dH3w/+koP9zeDAl+8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OvwjQ6ed1JNrfoxB4GRgKuuNVBrEGSTinT+eKx9bTNEG2W++OriAbw+ghFcSOxe2
	 5cIXZzvGcoGtFZzXlDEyTF+aUBdawAA6VXs971CkjR/K7g01rbTpqN6CwAZnJGIZv
	 oFmKFt6tQ6kj+Fighi3hbv0jv+AyfhwvDpA7ups32U0/yw4hlKkKXwBeuAlymfppd
	 82iaPiuUI1zZJWGkpm9Vwz4CMhnR5K3XzqlTHpPh036zEgda9+6QEwf6pj+sMqc+g
	 YHP1VhhHJieGOxqgM6S9RQA8+5LBLPlDifc0wNyq4nwMQon5icKrm3shdCiO1qO8y
	 CMv65Zf0jL+/N0WH7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2DxE-1tEm9x49za-017AD0; Fri, 14
 Feb 2025 17:44:24 +0100
Message-ID: <153b3473-e6a2-4105-9398-94bc2004e59c@gmx.de>
Date: Fri, 14 Feb 2025 17:44:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] platform/x86:lenovo-wmi-hotkey-utilities
To: Jackie Dong <xy-jackie@139.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 kuurtb@gmail.com, dongeg1@lenovo.com,
 Mark Pearson <mpearson-lenovo@squebb.ca>
References: <20250214154033.5483-1-xy-jackie@139.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250214154033.5483-1-xy-jackie@139.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tk/CBovi77TygzmHCcq9YL86tlU7ep03ON8kw+Gmnt6j3EeRNDV
 S/35Uxh03bUdOQJMn9B1mrwmeqZBF8JKSmC6G/8U6aLlUoAS/ySZcuZmVvy5mz6rptVgPdK
 a4qYD5Aw6KCSZ92/aLB4Tel3YZ7wgOEw3/WUS7fxJzDd0wfgyPi/iwDVE3tzA8bhL4XJteC
 mOr3p9O4YmXGBUoYlupMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cv7F2K8NxHk=;Qw8xv26ecoSLN4KpX6Bv782lonR
 LyZki2Hza3TCiRnUQEIWmGTZHDH55Q6IO8wPubs0MpQo/Kqw1v+alpj40rk2Fl5DpUvIH09WP
 Vogvde4OjMHkvqs8YlpbWljUvh5LTfrM6LRzK2BjVQZDK9PvUqc3tMxVMZqWH/7OBnxJGIGOj
 pfR0ORJvYqt+FquzHB205N13Qj6DErp8oXFHjYY5gy22NnZeA/9SG9o+FOu8OGyLez9IvPRTK
 DqnyM9SzJWYRea2g8yvrF8EBNBQUX3qH8zQNgt5rQZMr0/GwCzOtNTeIG3QTuDmy6A5Q/mZYm
 CNKWyqJB+oTq0Ltjpfsn8InXe33PKPZjc8rV2iLo8Sf+qhgbtBJxhF0JgmSBih0YLn4bzSOS6
 3rmDq3c49IVy6Dqx4PZjXYvXDr8IDIvVz8zurvnXRrp4EA5H6I0npy+pG480SNmOB6h53Dz1F
 +m8jCNxnytUIV3TP6Jy4OJpOGFmTXAnm7FvtJ6aqJpOe5zMpdV7QJtSwHSvuWZiQdDByS2YaB
 V2D7ZhlPlWDhnEUGdGYmeoy3u4drmPQVta0z2arn+8XDXySq4OKzx8KdInPpGxs8DaMPIvOXv
 h9qGkK7YmIs8yeSEnWk75KNqNkzK+IeVYj1gAGIX93vaPPrcg7v4DFPXmNmcoGroEG1wHu9Cr
 m6PuMmQ8Gmxi9jrwEWpzNlAZCLE71m7c5HtH8pX9JQVaSPD/H6vZ+DyDyVljYKAFT4T86zeCF
 bHBZjvjM6gGVY4RSm0LyY1/JI7Iqt2GnoR3c7WBOLaKagpRXDPw5RLPQWOn4uUpsH3i/56p5v
 /Y7mBbcYYpimURunfEpystCDTnLQAWXesQS0WtSrkBzJ2m6RpDvn1dh8hSXjuLo5BZe37MIwV
 VXTD3ZRcm0skWgMiJRZleTvgUFUCyumvBglaBWzxuIMjek6meCvCfIECJgWHLZ2mhNVx+wa3z
 5twfsOspbOaffDQTv1UHlmFAmENizDpYqgkPBWx3m5/Bd2j5OVfDxnC+2iAjPStYgAnpXEydP
 5tTmIvk00kaygbntWSCU+4Z6f+oj6sGwx6rkf89aEOGUmusIqk7Fck+hraTZJ4IIlJTVkkIJR
 fJyJXxVPN1zMrDowX1O0wKB4xjhFJblm/5vY59V/6B6qFJaW9OiF0/fIxbQc5tzOQ+mdZA51N
 rjN7LG3yB6PKyf5XoyTf1ostxL1dnNMVsRnc/f1CeF+ghseJkdtsQuLC0qxta0D2emKmv0Jt/
 GEL4i/vzcaY8UTSqq+7EkMv70pOww3R76oZAryYw1xKGfPCdxRv+0W8nJnaznF75I2CwgRaVM
 scvBz8aJHzfdAabtHxmjF0ILnxys4D5Ku6k6rSp9OiQTr4g1CruBw+ELDaAPB91OaiweV/Alb
 VccNlOBj+w1lQQgFvFum6PWNMtV/Jrg94zTBeRIIzMKbjGAFXpT10A37jH

Am 14.02.25 um 16:40 schrieb Jackie Dong:

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
> ---
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
>   drivers/platform/x86/Kconfig                  |  11 +
>   drivers/platform/x86/Makefile                 |   1 +
>   .../x86/lenovo-wmi-hotkey-utilities.c         | 222 ++++++++++++++++++
>   3 files changed, 234 insertions(+)
>   create mode 100644 drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
>
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

Since the driver does not directly depend on the IDEAPAD_LAPTOP driver, i =
suggest you use "implies IDEAPAD_LAPTOP".

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

This part seems to be common for both types of LEDs. Please de-duplicate t=
he LED registration code
by placing it after the switch.

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

Please make sure that the name of the driver matches the module name ("len=
ovo-wmi-hotkey-utilities").

With this being fixed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

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

