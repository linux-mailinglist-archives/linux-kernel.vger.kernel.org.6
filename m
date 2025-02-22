Return-Path: <linux-kernel+bounces-527488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F26A40BC4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 22:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABF018989BC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B3F204594;
	Sat, 22 Feb 2025 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KfLPwQaA"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C373F8828;
	Sat, 22 Feb 2025 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740260000; cv=none; b=Bps7OjQgLeu1IBvbDCS4M4qJ7Cej3eJhfScmMaKb+jnuJGnXDzRynO2F8GePO3ih9FVBuNXmhIN2NYMwraN69vOuc6EbHS5FvXJbE+NuGi44CWUcl9PIxLwGBpATOgsNcUO2gVmXwRGTGS647Qs0eCUki7zw/mGbG2rlS7uHeEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740260000; c=relaxed/simple;
	bh=in0FG3md8QjgZAiYuhVoBURTAlF+7k70zXe2+gDbU3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzCAe+m1uNvrOBUzuyztkN2CiALnQswLFx2MRTPISM11T1mNrEeE/q9sKMwQ2eaxyVdL5+OmO4EtmtzI6DQQDXN+utRwBG9uR0dLxI7awDuVeR7rBFFd8kiDzs8G6TPPVzklXxzH1QFbKrHiZNm6+ndigQ7sbit9lNOWj3YKejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KfLPwQaA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740259992; x=1740864792; i=w_armin@gmx.de;
	bh=ZxlL5kSVmRtVHp7K4eCOnFg/st8j4zm70QsQFKy4k1Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KfLPwQaApb0YLrQci/bXnWM0TKgILIG+2EW7FANPWD4k2uMJkJLeO+DOZYVrFE+H
	 3ylurxdBlPRP1R6A9KKxZmmJmFD5DTFpZ7kKYSyBz4Y93HN+hGSLyDLvsCJ8m5Tvz
	 PpTSiS5Oqdnqqrp61QgeMBbowzuWVUUsPKNMgjsyitZvyC9ySFTuXc4q6Zddkf2HR
	 OVfvaJqDsI8zgqT4rpi9flZ4aETIWnrOKdk2VV+Fy6ebK1jG53Y56EXD4Vhd54KIk
	 qkKwqRP1vDtnsTtYx/ixPthRc1pnAE4D7vHRnZbepbE9j4dvCkU7/KcuHYclC1UBT
	 ffDEUrCUOYyF7J5ekw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzb8-1tuALd3rm6-00IpaS; Sat, 22
 Feb 2025 22:33:12 +0100
Message-ID: <06516281-ae76-4354-a5f6-ce8d319e303c@gmx.de>
Date: Sat, 22 Feb 2025 22:33:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] platform/x86:lenovo-wmi-hotkey-utilities.c: Support
 for mic and audio mute LEDs
To: Jackie Dong <xy-jackie@139.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 kuurtb@gmail.com, dongeg1@lenovo.com,
 Mark Pearson <mpearson-lenovo@squebb.ca>
References: <20250222114532.4105-1-xy-jackie@139.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250222114532.4105-1-xy-jackie@139.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lCvTLN5MlcxFo+S3Tes1CPSSz1WrAkk3VuE4y7JLOygDXx7SDOc
 IG6BSsdMFN1okZP5pV5Kxs4np17D5SCb6htDw4CESGG8oUiZYf0MBuHO2HaCKqla55alSys
 Z0xf10jUwuCxfJ2AJTgwuiALMIpjV1sKlPeIA9lU5VDXxvKCBs4lxSyDunOTWcgcOHlXqbI
 NPMu544LGZg/1VG3O6IvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BQF8FrzZM+c=;7uKmSmZO7Jy423ttqa5ZruY3Yrh
 rIErXIR/Snz4XguJ0x2aH9sw+Z6gSvcjVRqrAWwEkW/Bxp7pDXNXBtrcwxyAuxAIHedw8WICZ
 OUNId+PwhDFJGmn9xdnQXxESkdoXaBUYsjeCp8eW5LDvpmhv0qphuKAu/3ycl75gRSaS/D2RJ
 MyFmA0SY966VZXL8poOs+1g+uNIuUN+NKkHOc8/kWH5YQoLLhSEXruaKxsUEYov8sgpZFChFM
 kg0/9IC9AKZ4Q+8PmStTigrUXgxso5Arym9DTUHp1T11cLuWjW6iUjp8L6kMHbQAm0teb93Ro
 EYH7iNUc1Coci815AdDdy1LKSJBzBLfDnoe9eYA7mGe/hvJTVzLVTy8WQ2MUy0Wj57CpPSUB/
 waKZUSXiXpgy8ogum6savptLnaQumZ8shjrDuu2LSkD1MCpXmN88KO4CosdRcniW5Yrrw2k5u
 uGEp7bs/OG1JiIOPZ98x8TBDA0pOB445m+WXdeHLWyVj8LhlSJe9kA8jSJwM+Z1I6+xNAwsoe
 uOICriBAkCMhx6ER3yVZOQb4OwFNhyLlgeqdOWXuEnfOMYJNJhQCivefJzL3XSYYNPdu7Cfm7
 kGtEWAA30ZNi2CN5Kpxh13NyQTADK04ES3y5MQFcSm0U5pBGeC6Cq2Rfyk4eyrY7zYdl9VZfX
 Y8BK4/G52OI0015/3Sp5uh1UdSOxftAXf/34DzoAuQiMQY7YTu8Yyu4dq8KZ/h1mxWa3nO3kn
 k/RX6oeeAsKDAIUxcgwDzDmMJrTuqtZfzETDOHCgufFbBH8hq7joejU3uC/9iwR8nB5SiZr8T
 /p4ljh4Fhrc2T+2fs8hUZQIgnBIqqaRrrsaHg7hntp9Qhwq5vDnfgNcojeZN2GwCuil3BUDva
 mjtkgrZvEFkx6AfXV/74JFshue4gHj9hs2+tH7cPzkmXPLiXyuyGGwIAX+GkdgvwGOnmM3+SS
 zwIk4yScCXEJlRxCy+5si7OW5p3Fcu1RysxzlHX6BsdzxkW9UvK5Ms3wNetL9IwquWT6snXGp
 aXZ61wBZ4J0fk+6eykJyQTUgOUJ+nLf4mHxz0twuIDjObCHCgh0QmmYPqT2RsK6GhhzLbgCpI
 7dbpxL9aXeOPir6sRZbWysSQj6cshuPbBXl5nNnWHq69JzTIRzGjYZp26/6jl7fSgNJ0ZXs3f
 sUFK3FxAr+2Ig2yKCzwr6ZLU7qH6K2SEqZK5qkOtt8eBvkB0fCCUZgpk30f9/FqsLC4Jnjxro
 kJFc/t+019dglnz6Wj/NnmxaYQQIg1ylFjR62O/zlCgtfYT127Fkm6qzHp5D7T7hZWyNcMqq8
 wOXRhm9WuRiQzc9t6HBacgB1EZj7NBL45yzYhYmqJCLDKEILMDlnawDvMgxLa3eJKd0n2tCCR
 U7Crc8l2TUGDDVmUnLEQnUF5nyiYa/fYOAYJDOIzoKgW51sqxIixCOY0LG

Am 22.02.25 um 12:45 schrieb Jackie Dong:

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

Hi,

the whole patch looks good to me now.

Thanks,
Armin Wolf

> Signed-off-by: Jackie Dong <xy-jackie@139.com>
> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Kurt Borja <kuurtb@gmail.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>
> ---
> Changes in v11:
>   - Removed MODULE_INFO(depends, "wmi,ideapad-laptop")
>
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
>   .../x86/lenovo-wmi-hotkey-utilities.c         | 212 ++++++++++++++++++
>   4 files changed, 230 insertions(+)
>   create mode 100644 drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3864d473f52f..8588baacf137 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13142,6 +13142,12 @@ S:	Maintained
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
> index 000000000000..89153afd7015
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> @@ -0,0 +1,212 @@
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
> +MODULE_AUTHOR("Jackie Dong <dongeg1@lenovo.com>");
> +MODULE_DESCRIPTION("Lenovo Super Hotkey Utility WMI extras driver");
> +MODULE_LICENSE("GPL");

