Return-Path: <linux-kernel+bounces-176968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA268C37E4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 20:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AF51F211A1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 18:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A0E4F217;
	Sun, 12 May 2024 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="iXPko/+U"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124B825634;
	Sun, 12 May 2024 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715537190; cv=none; b=irdIE3iX7xQp1MuA9pTrWdVW5//p0rAH2874ZjbKr7Q7Ttpdgs9dL3uyjG5ZxCOe69dhi3b0Zc/o5V+TYRx/AOoZM/X43qnPyKkSa8tkDt4TTGenN5lLDCLoRX+Hhzbe/cll3SWFUAICRYpUdfWCjoLSF2RloXTrD3z4spQlPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715537190; c=relaxed/simple;
	bh=BfBg8wgewlAxwp506CTOAf/grQaZWzRhFJ+64vBcR0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iciHWythNr96flIC2Yw+ySIPS8RG0zR6N3sMKfV3OiCDBDZe14bysRCXnuFfHnNPVradyMrh+f/lnYE7o9SLlOaHD6X2IdQMIJ9O4QBmwobumi6TGdU2zxPVr9/M7qsw2v16UEel6gD8fpMsxP0ZoNS8/amYO5t3NQxbcJd9Vig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=iXPko/+U; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715537120; x=1716141920; i=w_armin@gmx.de;
	bh=Zyj0C+md8Eq5PSNbbaw9fSYsl1pnf4fC4Xvg7b8BeqE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iXPko/+UaOhaJk7ymQk7AZeuyn5kkdK738kTVYjVjS58sOTYtCGM+45oa3vRY03G
	 LKen0xu8rkMqg9kmk2lZ2jTn9D/YyaMBqmXaDV2LG++ij1zKEwQyKa6ZjneaZXQSI
	 QOHkOFokGiqu96VWXurL9so/eF79YHfZPhNzFULdeKZPz+fgocYJk8NfYjV1XYH2M
	 G6tWMZu3/gMbCAu6NYCWm6pobC/KbLNiyDbOaQNrNsMBsvefZnizipTaPr7Yyufqq
	 5wvGaFN4eAi3TwwqszYdv7KKZdNoKTD6XbrHvBVsr56xv9FI4ae/joVbZEHxQMD7z
	 mxzJtS4mhLb+5HPrrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1sN3Dc3DXb-00E7vb; Sun, 12
 May 2024 20:05:19 +0200
Message-ID: <c927c490-bc22-45d9-87e4-4156746547f9@gmx.de>
Date: Sun, 12 May 2024 20:05:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] platform/x86: dell-laptop: Implement
 platform_profile
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: mario.limonciello@amd.com, pali@kernel.org,
 srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 lkp@intel.com, hdegoede@redhat.com, Yijun.Shen@dell.com,
 Matthew Garrett <mjg59@srcf.ucam.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>, Vegard Nossum <vegard.nossum@oracle.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240511023726.7408-4-lsanche@lyndeno.ca>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240511023726.7408-4-lsanche@lyndeno.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mcZpi5ghIDqfjv96Z29bP5CqJu8FgBe2BUFvpL88vE0+ThkKuJw
 1rNoDERsVoU/tUxofU5J9wSIPi0gHFYo0KtctGXhGns90JEYtbY6z2R/Vc4Puo12iPKchPz
 zNwn3Xo2SFSDuWabliJQB7anMh9JOdFdX9eiwVv/U/aSJHFaeqHlmQFVKBh9OxtP0IRN0Qo
 poRJVtF2Qs9ujpWuQagig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:746OVGxSbZE=;g/4WeSEtzDvPOuHnUO9biBaaI8d
 WniFzk7wbOao8qb2TWYoUXAUCqCaHIf9v/MX/HM9gxLoIjkRkxhzbYG6Oeq1kYlDqp6XuwiiL
 ycudMwPipaqt8uq0fjveFMfg9y7MzDkut+g0iTODyqGZH8xugaUnDni7kA8fXPyW71QcoFTHX
 m9/CkiKhspTaoM7/23oWhPVcTO9iJ9iP62dwp02Cyd4nzPrAx88lRayHtUHfIagH+FVqeZz1V
 GjJRA7g1h7A8fxqWF/wR5J+JCBMkXTAJhuDhPzMSUOBIgEJX3eR1gyqa1czLY4hiTAawkcshE
 Yw3UIoEuyXRrnT08L4Rgo2q8Xfc2ZP2M14nZAerZ0YtRGnGvMFS5OdS2+Oy3JYrKIYi+XSm6n
 zIVUGtSfCjc0ZN2inHL25oSBOL8tirlkos+2zTX2zvrtAMlOf9rrz1V2b47ojRvXFp8EPtzIo
 dDT5yHjmYVj4w9pH4ezqlVJ6xHKC8cXR6P4ztxf6E0vvExquX8xUfJ8iMbpHOwTwICi4e9Ywt
 flA5Mopc1Pj41gJhsjDCaZOhP/UaNl8NrPvZXUwbsMIQZINa6So7foTK2CuPCQKAn6/JzKCBV
 /RCM7qDQWWquLTgOD9YEDvp3Ftn+78A+BE3m6gV/y7jpeuUF1CkZPpTT5fCra2J3SEN8ZOX56
 GBEhTfVLkvrwIXIH9i1i+Hykjkndtzei3rcEUfdw9rm6EJX61k2e8Dcp7rTkx+1e3zH7X1p+N
 wh1+X337/MmuXBbFUuaJ1kwpBcuZa/RBg4QV8QLBO8figsXIiMc/qLBDc4EXs70D4FjwnRAB/
 xKpQrQG4xORDBtdpW4l/ib2ABtsCgMY6IBU2CI23b1Das=

Am 11.05.24 um 04:36 schrieb Lyndon Sanche:

> Some Dell laptops support configuration of preset fan modes through
> smbios tables.
>
> If the platform supports these fan modes, set up platform_profile to
> change these modes. If not supported, skip enabling platform_profile.
>
> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
> ---
>   drivers/platform/x86/dell/Kconfig            |   2 +
>   drivers/platform/x86/dell/dell-laptop.c      | 242 +++++++++++++++++++
>   drivers/platform/x86/dell/dell-smbios-base.c |   1 +
>   drivers/platform/x86/dell/dell-smbios.h      |   1 +
>   4 files changed, 246 insertions(+)
>
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/de=
ll/Kconfig
> index bd9f445974cc..26679f22733c 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -47,6 +47,7 @@ config DCDBAS
>   config DELL_LAPTOP
>   	tristate "Dell Laptop Extras"
>   	default m
> +	depends on ACPI
>   	depends on DMI
>   	depends on BACKLIGHT_CLASS_DEVICE
>   	depends on ACPI_VIDEO || ACPI_VIDEO =3D n
> @@ -57,6 +58,7 @@ config DELL_LAPTOP
>   	select POWER_SUPPLY
>   	select LEDS_CLASS
>   	select NEW_LEDS
> +	select ACPI_PLATFORM_PROFILE
>   	help
>   	This driver adds support for rfkill and backlight control to Dell
>   	laptops (except for some models covered by the Compal driver).
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/=
x86/dell/dell-laptop.c
> index 42f7de2b4522..07f54f1cbac5 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -27,6 +27,9 @@
>   #include <linux/i8042.h>
>   #include <linux/debugfs.h>
>   #include <linux/seq_file.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/platform_profile.h>
>   #include <acpi/video.h>
>   #include "dell-rbtn.h"
>   #include "dell-smbios.h"
> @@ -95,6 +98,7 @@ static struct backlight_device *dell_backlight_device;
>   static struct rfkill *wifi_rfkill;
>   static struct rfkill *bluetooth_rfkill;
>   static struct rfkill *wwan_rfkill;
> +static struct platform_profile_handler *thermal_handler;
>   static bool force_rfkill;
>   static bool micmute_led_registered;
>   static bool mute_led_registered;
> @@ -2199,6 +2203,236 @@ static int mute_led_set(struct led_classdev *led=
_cdev,
>   	return 0;
>   }
>
> +/* Derived from smbios-thermal-ctl
> + *
> + * cbClass 17
> + * cbSelect 19
> + * User Selectable Thermal Tables(USTT)
> + * cbArg1 determines the function to be performed
> + * cbArg1 0x0 =3D Get Thermal Information
> + *  cbRES1         Standard return codes (0, -1, -2)
> + *  cbRES2, byte 0  Bitmap of supported thermal modes. A mode is suppor=
ted if
> + *                  its bit is set to 1
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performance
> + *  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller (AAC)=
 modes.
> + *                 Each mode corresponds to the supported thermal modes=
 in
> + *                  byte 0. A mode is supported if its bit is set to 1.
> + *     Bit 0 AAC (Balanced)
> + *     Bit 1 AAC (Cool Bottom
> + *     Bit 2 AAC (Quiet)
> + *     Bit 3 AAC (Performance)
> + *  cbRes3, byte 0 Current Thermal Mode
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performanc
> + *  cbRes3, byte 1  AAC Configuration type
> + *          0       Global (AAC enable/disable applies to all supported=
 USTT modes)
> + *          1       USTT mode specific
> + *  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
> + *     If AAC Configuration Type is Global,
> + *          0       AAC mode disabled
> + *          1       AAC mode enabled
> + *     If AAC Configuration Type is USTT mode specific (multiple bits m=
ay be set),
> + *          Bit 0 AAC (Balanced)
> + *          Bit 1 AAC (Cool Bottom
> + *          Bit 2 AAC (Quiet)
> + *          Bit 3 AAC (Performance)
> + *  cbRes3, byte 3  Current Fan Failure Mode
> + *     Bit 0 Minimal Fan Failure (at least one fan has failed, one fan =
working)
> + *     Bit 1 Catastrophic Fan Failure (all fans have failed)
> + *
> + * cbArg1 0x1   (Set Thermal Information), both desired thermal mode an=
d
> + *               desired AAC mode shall be applied
> + * cbArg2, byte 0  Desired Thermal Mode to set
> + *                  (only one bit may be set for this parameter)
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performance
> + * cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to set
> + *     If AAC Configuration Type is Global,
> + *         0  AAC mode disabled
> + *         1  AAC mode enabled
> + *     If AAC Configuration Type is USTT mode specific
> + *     (multiple bits may be set for this parameter),
> + *         Bit 0 AAC (Balanced)
> + *         Bit 1 AAC (Cool Bottom
> + *         Bit 2 AAC (Quiet)
> + *         Bit 3 AAC (Performance)
> + */
> +
> +#define DELL_ACC_GET_FIELD		GENMASK(19, 16)
> +#define DELL_ACC_SET_FIELD		GENMASK(11, 8)
> +#define DELL_THERMAL_SUPPORTED	GENMASK(3, 0)
> +
> +enum thermal_mode_bits {
> +	DELL_BALANCED =3D BIT(0),
> +	DELL_COOL_BOTTOM =3D BIT(1),
> +	DELL_QUIET =3D BIT(2),
> +	DELL_PERFORMANCE =3D BIT(3),
> +};
> +
> +static int thermal_get_mode(void)
> +{
> +	struct calling_interface_buffer buffer;
> +	int state;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEME=
NT);
> +	if (ret)
> +		return ret;
> +	state =3D buffer.output[2];
> +	if (state & DELL_BALANCED)
> +		return DELL_BALANCED;
> +	else if (state & DELL_COOL_BOTTOM)
> +		return DELL_COOL_BOTTOM;
> +	else if (state & DELL_QUIET)
> +		return DELL_QUIET;
> +	else if (state & DELL_PERFORMANCE)
> +		return DELL_PERFORMANCE;
> +	else
> +		return -ENXIO;
> +}
> +
> +static int thermal_get_supported_modes(int *supported_bits)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEME=
NT);
> +	if (ret)
> +		return ret;
> +	*supported_bits =3D FIELD_GET(DELL_THERMAL_SUPPORTED, buffer.output[1]=
);
> +	return 0;
> +}
> +
> +static int thermal_get_acc_mode(int *acc_mode)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEME=
NT);
> +	if (ret)
> +		return ret;
> +	*acc_mode =3D FIELD_GET(DELL_ACC_GET_FIELD, buffer.output[3]);
> +	return 0;
> +}
> +
> +static int thermal_set_mode(enum thermal_mode_bits state)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +	int acc_mode;
> +
> +	ret =3D thermal_get_acc_mode(&acc_mode);
> +	if (ret)
> +		return ret;
> +
> +	dell_fill_request(&buffer, 0x1, FIELD_PREP(DELL_ACC_SET_FIELD, acc_mod=
e) | state, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEME=
NT);
> +	return ret;
> +}
> +
> +static int thermal_platform_profile_set(struct platform_profile_handler=
 *pprof,
> +					enum platform_profile_option profile)
> +{
> +	switch (profile) {
> +	case PLATFORM_PROFILE_BALANCED:
> +		return thermal_set_mode(DELL_BALANCED);
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		return thermal_set_mode(DELL_PERFORMANCE);
> +	case PLATFORM_PROFILE_QUIET:
> +		return thermal_set_mode(DELL_QUIET);
> +	case PLATFORM_PROFILE_COOL:
> +		return thermal_set_mode(DELL_COOL_BOTTOM);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int thermal_platform_profile_get(struct platform_profile_handler=
 *pprof,
> +					enum platform_profile_option *profile)
> +{
> +	int ret;
> +
> +	ret =3D thermal_get_mode();
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (ret) {
> +	case DELL_BALANCED:
> +		*profile =3D PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case DELL_PERFORMANCE:
> +		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case DELL_COOL_BOTTOM:
> +		*profile =3D PLATFORM_PROFILE_COOL;
> +		break;
> +	case DELL_QUIET:
> +		*profile =3D PLATFORM_PROFILE_QUIET;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int thermal_init(void)
> +{
> +	int ret;
> +	int supported_modes;
> +
> +	/* If thermal commands not supported, exit without error */
> +	if (!dell_laptop_check_supported_cmds(CLASS_INFO))
> +		return 0;
> +
> +	/* If thermal modes not supported, exit without error */
> +	ret =3D thermal_get_supported_modes(&supported_modes);
> +	if (ret < 0)
> +		return ret;

Hi,

the function dell_smbios_error() says that when a specific functionality i=
s
not supported, -ENXIO is returned.

Please treat this as "no thermal modes supported", since checking if CLASS=
_INFO
is supported is not enough (CLASS_INFO is also used by other functionality=
 like
rfkill, so machines might support CLASS_INFO but not USTT).

Thanks,
Armin Wolf

> +	if (!supported_modes)
> +		return 0;
> +
> +	thermal_handler =3D kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
> +	if (!thermal_handler)
> +		return -ENOMEM;
> +	thermal_handler->profile_get =3D thermal_platform_profile_get;
> +	thermal_handler->profile_set =3D thermal_platform_profile_set;
> +
> +	if (supported_modes & DELL_QUIET)
> +		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> +	if (supported_modes & DELL_COOL_BOTTOM)
> +		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> +	if (supported_modes & DELL_BALANCED)
> +		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> +	if (supported_modes & DELL_PERFORMANCE)
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> +
> +	/* Clean up if failed */
> +	ret =3D platform_profile_register(thermal_handler);
> +	if (ret)
> +		kfree(thermal_handler);
> +
> +	return ret;
> +}
> +
> +static void thermal_cleanup(void)
> +{
> +	if (thermal_handler) {
> +		platform_profile_remove();
> +		kfree(thermal_handler);
> +	}
> +}
> +
>   static struct led_classdev mute_led_cdev =3D {
>   	.name =3D "platform::mute",
>   	.max_brightness =3D 1,
> @@ -2238,6 +2472,11 @@ static int __init dell_init(void)
>   		goto fail_rfkill;
>   	}
>
> +	/* Do not fail module if thermal modes not supported, just skip */
> +	ret =3D thermal_init();
> +	if (ret)
> +		goto fail_thermal;
> +
>   	if (quirks && quirks->touchpad_led)
>   		touchpad_led_init(&platform_device->dev);
>
> @@ -2317,6 +2556,8 @@ static int __init dell_init(void)
>   		led_classdev_unregister(&mute_led_cdev);
>   fail_led:
>   	dell_cleanup_rfkill();
> +fail_thermal:
> +	thermal_cleanup();
>   fail_rfkill:
>   	platform_device_del(platform_device);
>   fail_platform_device2:
> @@ -2344,6 +2585,7 @@ static void __exit dell_exit(void)
>   		platform_device_unregister(platform_device);
>   		platform_driver_unregister(&platform_driver);
>   	}
> +	thermal_cleanup();
>   }
>
>   /* dell-rbtn.c driver export functions which will not work correctly (=
and could
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/plat=
form/x86/dell/dell-smbios-base.c
> index 6ae09d7f76fb..387fa5618f7a 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -71,6 +71,7 @@ static struct smbios_call call_blacklist[] =3D {
>   	/* handled by kernel: dell-laptop */
>   	{0x0000, CLASS_INFO, SELECT_RFKILL},
>   	{0x0000, CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT},
> +	{0x0000, CLASS_INFO, SELECT_THERMAL_MANAGEMENT},
>   };
>
>   struct token_range {
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/=
x86/dell/dell-smbios.h
> index 63116671eada..5d7178df80c6 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -19,6 +19,7 @@
>   /* Classes and selects used only in kernel drivers */
>   #define CLASS_KBD_BACKLIGHT 4
>   #define SELECT_KBD_BACKLIGHT 11
> +#define SELECT_THERMAL_MANAGEMENT 19
>
>   /* Tokens used in kernel drivers, any of these
>    * should be filtered from userspace access

