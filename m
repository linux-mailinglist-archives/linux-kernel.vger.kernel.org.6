Return-Path: <linux-kernel+bounces-524638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321D4A3E556
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929CC188A2D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E63264618;
	Thu, 20 Feb 2025 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="UxhyEwRw"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2E1E5B6C;
	Thu, 20 Feb 2025 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080918; cv=none; b=QJQcah5MLnPMF+CeMNqebAju616xgFyvwvxUtZsSq+wRbvM90jOIuyCW2neigux8mT5TrXFVxQk6G7rwsQUSUPQY8ynO5AmKmatzjN+lARNrbTBY603cITPE/QQgNPbt7pmDNRyeQ7VEsaVx8A8FanHhXoQqA09GBOrmy2DuSTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080918; c=relaxed/simple;
	bh=5Sk/I+2qLQC6Z1OArVOVUS4UqeXccMOE/VjgNvWTCe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9LbEdcq1V41lygIOqjqHu9hv2dZrb+qxwSWNLNyYaHc5UF7h4bOAYiXUXH0uv4N29Dys+AIf6GGqBwGMJ0s8guwvycwNNYTSY5okKvaZ3EsMV0kgbCAAuw7bshQOfuShX4I/HuB1zUhcYh1miLe9mw/Bf/P8sVtCkVtIEYC/As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=UxhyEwRw; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740080914; x=1740685714; i=w_armin@gmx.de;
	bh=JLLNfEUs4kWZ1tyv72UOmTAWrC7gaWn4saYrQ5W1ryY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UxhyEwRwgbZ+Fn7QP48jlmUXmp469BWOLWLOraBDQ42tu2/VtMJmRfAF41NbBj4W
	 8jlgEQbLxCZVvCec54yH5d0e9CwSkxY+nUxboG6/sz56aUXz0eaVsbvs1dhf1Xvep
	 Umw5YoR7z6Ei6AyS9PTvgknkNew6HJ7xjdGKme4jEGLQBX8VkCIntXX4EXkfCP2cX
	 DSqJZZ/xfRLEjmR8S6tI/a569Fady5gSrU/8to7zw8T7WGmgC+sw+wCNQXkuycOVt
	 bQDkyoExDDb7ay+p2C1w6HJ+mprro0UFZKe+GIltGJIf3OdQpX8OeqGxmyNhLvFks
	 F40Q5HN2WnvNqcqFeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUYu-1szp6L3dHQ-00cVdP; Thu, 20
 Feb 2025 20:48:33 +0100
Message-ID: <eab4001e-78f1-419e-b5ce-2d8f46784046@gmx.de>
Date: Thu, 20 Feb 2025 20:48:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] platform/x86:lenovo-wmi-hotkey-utilities.c: Support
 for mic and audio mute LEDs
To: Jackie Dong <xy-jackie@139.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 kuurtb@gmail.com, dongeg1@lenovo.com,
 Mark Pearson <mpearson-lenovo@squebb.ca>
References: <20250217035744.4116-1-xy-jackie@139.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250217035744.4116-1-xy-jackie@139.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MZsfoxv90eBwLzceip/8E+4n/LTgLqO72YFQe0IBvWlljaxH0+I
 XIRyUsMHE+oJDazATidQMx6v5htiCwMpOR6LAHIinNz+ik7Ok04J/Z0O9m8j8ihH5gK7XY+
 ZtE7ROS3hUB7IhrJPE+xfVxeXsYurDuRuZyNTEU0DrM3mKsPRzJlgpLK4/wcK0SSdjxoyV9
 oNL1vvhUX23T5TKE7JRSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vd7VJgzcrMw=;yXvqB7WEJJ92+GdmWfCXfW0VbJT
 f+8ybJSt8eSZWxGJt/t9j0zFLZ+f4b3a+KF4o0ui5e7fH27vlhwTREk/ZGAfhWDLb2ON3e76M
 Fc3vNlWkVAO+N0/Kp15huZh/e5df8Vpcw+xWn+gQdFQSw9y3zh8g6HjQQlJT2tBED0d5i72Nw
 zrKev6x7tx8EEL6syJDskdVoqntMwiYIuPIsRYRPhFOrFVy9ZEooKDXo6/5VpGecGMygOmTO/
 Pdwu++EGyGqOL0x7u0+j5LKcOegMaGGkz33zBO/ZytiH7Twde4re7LrWwWHHsJfjw0xVSXpzL
 YjTOBJZJFWJ4vz20BGkcNRFiXpj839L1pJuDM+uH3XU+kkQTE1FdHYK3JF+s++qSB4nChSARg
 KihR/B6m1b0DEtI/k0HQKd5W5PJJpNCq3BV7tMrLWX7jlsIiTJIu0kaDSzIUW4b1vze3tmf6b
 PYl/tazkbOKdPMVsC+thA+IhJ4Bt9IQP0xlGTmV4gFHQZTE08bQD+O+snr1YAYVgJq2D3pikR
 mTRnuk2RUM8yiLBt6xWHO2totXwxGYq4uXFKqjYPzLcjMGOB6V/uwWmB2DE/Myk4VoJ0KCB95
 SBAyacLHOUA88pR/wSVFkmQYVBI6bqjauqqX75TL5WhYgcjxxZuv0kRhbKG3T4P4w9yaZORcr
 HB+cvedNXneewwFX5jVuyrmitAtz3y2XVb7hNLBPT+tNsOb8E5OENsdC/tXZVCqVjP2aOj/27
 UEt4qVbX7oz5oFPHUbUOLxC46kz7MhymSHB72CmngR/mXsgq15uLggOYTL0gUb1cK8xmfLZ4z
 o2CyWVfcvwnx5GX/jGEGoxk6JuFVDuREpXYYSJx2AqAdQGw3YW3IICUNGi6wFh42tFgY21sf8
 QZNoCKq8YfE5P638R3ojVvay+z5BYTekMp11CfFIII8hHqlE2+kczR+KhkH66SF6XuyMu659+
 D1C8raPuuNRIkWOtaa6uzFQyHmSic9Ttzz3VXlNI4d1pFi8m3wNp01X0dbOqAk14IhRh/DKpQ
 b8uM9DJmaiggK10Y0AJcyIjoYlQpJbCFgHsyyWJzAmT851fhr/Y316KgyJcIx3xEzve3xw1sk
 7B83xVW7IJ6gRd+A5SgV3DaZzD8UIueOKeDMNCGpg1eTS+cauihnTPqzA6oSVsL0c18FQ9dTK
 hLHyNLTOQtUQ/0LA/21XC625Ki8eSduD6sAIbR6bMiiT9Y2ErUyaLL3hUFBmaIwKoMkSLbEGg
 bIbnsgpLFTgEkvqSz6HusEKzZcnFCPw1vZINL7C33+0RmoGUSCz4ei7tmMlGGX/hYPqipl9X8
 P1HPJcocFOXxKIdE9RyVQjwUmmBiHIvGD3p8/LWhEqCnXD3rdJwbGvUJDQ48cEhP6kxmYFOcb
 bVpwuOaZrH6dqieFoX4OFoc+HgJbKhdyK1aZnGhWDplVIkrEq18Y/5NMIi

Am 17.02.25 um 04:57 schrieb Jackie Dong:

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
> Changes in v9:
>   - Call devm_led_classdev_register() after the switch statement.
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
>   .../x86/lenovo-wmi-hotkey-utilities.c         | 216 ++++++++++++++++++
>   4 files changed, 234 insertions(+)
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

Why not using "implies" instead of "depends on" for CONFIG_IDEAPAD_LAPTOP?

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
> index 000000000000..a8fedc8ed7a6
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> @@ -0,0 +1,216 @@
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
> +	if (err < 0)
> +		goto led_reg_failed;

Please drop led_reg_failed and call dev_err() directly.

Otherwise, the driver looks good:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

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
> +MODULE_AUTHOR("Jackie Dong <dongeg1@lenovo.com>");
> +MODULE_DESCRIPTION("Lenovo Super Hotkey Utility WMI extras driver");
> +MODULE_LICENSE("GPL");

