Return-Path: <linux-kernel+bounces-382447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F0F9B0DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F821C20E38
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BCC20D4F2;
	Fri, 25 Oct 2024 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="at4CQgvv"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E994B658;
	Fri, 25 Oct 2024 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729882916; cv=none; b=e9ZTk9YbT7lsyYRqCiidcZS0k8lxBcwP9IGQ3qJ24/RONnC8UFJQkgWRNvb36i9GGkDWmDPegTpLC1Hb5x6BXt7QnMddgQl212eqiIWl/5XFf6QxS908IZSY2X2uMJ2DbmKAFVNKwAipCadvAOHHrUnk77WXbWXD+iZwQu2TSkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729882916; c=relaxed/simple;
	bh=3YpERVRltWuozqD3jKm7DPjsDlT0H/KzwGwPp4GjH1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHdwbIassDnk5atadniD+OxxNgmr2N7FYdSbj4Q9hboRXZhZGEsaeBhKjMgn7ewa7cu8J8b0HuF5TB9HttV4mhrZpFTfj87pnp2kuOIvS6ZOoSFbSfaFLgsOnW0DvzBsux2ICcpKMxGdR/6vR7wrx9DrYYA/UNI1HBIrgw/2kUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=at4CQgvv; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729882904; x=1730487704; i=w_armin@gmx.de;
	bh=R4JJ5zuY0Fu2in4GQayGsOrbBhOLz4wAtwwI0BswQlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=at4CQgvvXfZa80m5JBswQ+fMYHRfN2I83pvuMa+9jyqz51ddNj8WenWXrVYeO4rp
	 0f7GpUCchVrKKswrjw+3tVsEIzJVVU1BNZasm2Zizo+FX+wluS54/p5NJOV3HS1R4
	 Or4RMnS6b2ClnRmhaHJ7etISuLZaWUYstQGT6Uj9Cbs7hldo9jvRExCB4ofdmqEX0
	 g73wTDZFTsN7esqpnhvnXTvvyTg/Fdvr6F3HpnG+I58fYDwfoxTjg9o5EdgfJ3cs/
	 ts3eBJxtahmuFR5H9XvHhV6wxYEIHO+rZSJAOk2XPEGoU2oLwcmp1IZjajVJxawfp
	 L8wEeSy3xqDbAFPmbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5UN-1t94P91UaF-005VDc; Fri, 25
 Oct 2024 21:01:44 +0200
Message-ID: <08590c9b-5446-4a6a-912b-ebe2f45f25d4@gmx.de>
Date: Fri, 25 Oct 2024 21:01:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] alienware-wmi: added platform profile support
To: Kurt Borja <kuurtb@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241025150916.3618-2-kuurtb@gmail.com>
 <20241025151601.4382-3-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241025151601.4382-3-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ncb4rxjo6biwh/kkDdAkFVGbkq1L22JDscRHYE4YuelI3wI1uW4
 za1R5robCz4zHf6JVrVmnj+yv5pTNqfQ+NoN3u1YnNpWrSSLt5oKYCu7fIQsR2+QcPdb14W
 CDOFwECZBabU2yN4omSs7lEGloKHjKQCTJMaeLjdzXclIgZ7WlFYQNfUg+iI3zE61eI8zJU
 IVTn+zaiOGyxYKD4Yghuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XSA1HyU7kqM=;BL7ukwty+OKdIB+sr5QujoMEDuM
 PTLYanT2Qp+9svbZELU5Pgj5Xy+qnxacqmnEv+nFNg309yU/dLn7BWQzjMi9QnqWKMi7vsqD4
 tmB+G0rCMft8SXBNrcHdomHpKSbPshBmXg/m9BunyZBR0SDu+5Rs1DGGTDmC5j/AbufVfRet/
 uqFEZ1p3DBSQN6WRKVIfPGdlZ+QObv0tDxBBqe8boBba8UYmfn9g070r0+DpNq5Xfq3Nx/uH8
 3RHBpAedV90IQIxVzXEBlwNLc2YW/peL04tO3T0LPdauKMGqgzatacsBfP8WiuVgR15EgSbgX
 uZm63xG+lsS5rIAUxYZ8G18pjxPIY+ReOKsTjyD+MebDwAzXQ0HlAV9x5rltdDN1znStGMPqW
 murneCTI+TfYQbisv3rD5BaQMLGqp2rVGrbjreO+68okwEDPMFOMiFid3fDEHOIVR30CcMUaH
 13WpBDYvAMGpMSZO4nciGbOp7+zZBhsUg7rAeSSRSm7hVI1rLppDSwDrnAwCYgQfj2v+N0drl
 whz52aHtGVKvjIcAS5OgSRXHkfgxpz5r7Wwq1wFUZoVaXYQwS6hgmqAJurqwPChqol+zDx+Ig
 R4eNelUS/dYEHnO/v2PZECx33DKWWwZxUwzZmnSNSQSyKPM9BzuGam6VJ3QsN62/+bf1hqH/X
 4DaVdHYRh6wIKXsMk6q7DV3F2IjTetPuNIvV0U/VESNdLr9w8B1ykpWr8RaR5+z4r66hc30rH
 Hdz5lpIh4vZ8i8zvgG3HwzAF3VRpGt507p6uLjcyB1YadwlKYtBGhXTVJz6lnPl4g21Yw47GD
 50XxKmj4loKv+ZIN46G6rGIA==

Am 25.10.24 um 17:16 schrieb Kurt Borja:

> Implements platform profile support for Dell laptops with new WMAX therm=
al
> interface, present on some Alienware X-Series, Alienware M-Series and
> Dell's G-Series laptops. This interface is suspected to be used by
> Alienware Command Center (AWCC), which is not available for linux
> systems, to manage thermal profiles.
>
> This implementation makes use of three WMI methods, namely
> THERMAL_CONTROL, THERMAL_INFORMATION and GAME_SHIFT_STATUS, which take
> u32 as input and output arguments. Each method has a set of supported
> operations specified in their respective enums.
>
> Wrappers written for these methods support multiple operations.
>
> THERMAL_CONTROL switches thermal modes through operation
> ACTIVATE_PROFILE. Available thermal codes are auto-detected at runtime
> and matched against a list of known thermal codes:
>
> Thermal Table "User Selectable Thermal Tables" (USTT):
> 	BALANCED			0xA0
> 	BALANCED_PERFORMANCE		0xA1
> 	COOL				0xA2
> 	QUIET				0xA3
> 	PERFORMANCE			0xA4
> 	LOW_POWER			0xA5
>
> Thermal Table Basic:
> 	QUIET				0x96
> 	BALANCED			0x97
> 	BALANCED_PERFORMANCE		0x98
> 	PERFORMANCE			0x99
>
> Devices are known to implement only one of these tables without mixing
> their thermal codes.
>
> The fact that the least significant digit of every thermal code is
> consecutive of one another is exploited to efficiently match codes
> through arrays.
>
> Autodetection of available codes is done through operation LIST_IDS of
> method THERMAL_INFORMATION. This operation lists fan IDs, CPU sensor ID,
> GPU sensor ID and available thermal profile codes, *in that order*. As
> number of fans and thermal codes is very model dependent, almost every
> ID is scanned and matched based on conditions found on
> is_wmax_thermal_code(). The known upper bound for the number of IDs is
> 13, corresponding to a device that have 4 fans, 2 sensors and 7 thermal
> codes.
>
> Additionally G-Series laptops have a key called G-key, which (with AWCC
> proprietary driver) switches the thermal mode to an special mode named
> GMODE with code 0xAB and changes Game Shift Status to 1. Game Shift is a
> mode the manufacturer claims, increases gaming performance.
>
> GAME_SHIFT_STATUS method is used to mimic this behavior when selecting
> PLATFORM_PROFILE_PERFORMANCE option.
>
> All of these profiles are known to only change fan speed profiles,
> although there are untested claims that some of them also change power
> profiles.
>
> Activating a thermal mode with method THERMAL_CONTROL may cause short
> hangs. This is a known problem present on every platform.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
> v9:
>   - Bool comparisons are now coherent with their type
> v8:
>   - Fixed alignment in wmax_mode_to_platform_profile[]
>   - Quirk thermal and gmode changed from u8 -> bool
>   - Autodetected quirk entries are not initialized
>   - is_wmax_thermal_code refactored to increase readibility
>   - is_wmax_thermal_code now covers all possibilities
>   - Better commit message
> v7:
>   - Method operations are now clearly listed as separate enums
>   - wmax_thermal_modes are now listed without codes in order to support
>     autodetection, as well as getting and setting thermal profiles
>     cleanly through arrays
>   - Added wmax_mode_to_platform_profile[]
>   - Added struct wmax_u32_args to replace bit mask approach of
>     constructing arguments for wmax methods
>   - create_thermal_profile now autodetects available thermal codes
>     through operation 0x03 of THERMAL_INFORMATION method. These are
>     codes are stored in supported_thermal_profiles[]
>   - thermal_profile_get now uses wmax_mode_to_platform_profile[] instead=
 of
>     switch-case approach
>   - thermal_profile_set now uses supported_thermal_profiles[] instead of
>     switch-case approach
>   - When gmode is autodetected, thermal_profile_set also sets Game Shift
>     status accordingly
> v6:
>   - Fixed alignment on some function definitions
>   - Fixed braces on if statment
>   - Removed quirk thermal_ustt
>   - Now quirk thermal can take values defined in enum WMAX_THERMAL_TABLE=
.
>   - Proper removal of thermal_profile
> ---
>   drivers/platform/x86/dell/Kconfig         |   1 +
>   drivers/platform/x86/dell/alienware-wmi.c | 280 ++++++++++++++++++++++
>   2 files changed, 281 insertions(+)
>
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/de=
ll/Kconfig
> index 68a49788a..b06d634cd 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -21,6 +21,7 @@ config ALIENWARE_WMI
>   	depends on LEDS_CLASS
>   	depends on NEW_LEDS
>   	depends on ACPI_WMI
> +	select ACPI_PLATFORM_PROFILE
>   	help
>   	 This is a driver for controlling Alienware BIOS driven
>   	 features.  It exposes an interface for controlling the AlienFX
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platfor=
m/x86/dell/alienware-wmi.c
> index b27f3b64c..da9ba422d 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -8,8 +8,11 @@
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>   #include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
>   #include <linux/dmi.h>
>   #include <linux/leds.h>
>
> @@ -25,6 +28,13 @@
>   #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
>   #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
>   #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
> +#define WMAX_METHOD_THERMAL_INFORMATION	0x14
> +#define WMAX_METHOD_THERMAL_CONTROL	0x15
> +#define WMAX_METHOD_GAME_SHIFT_STATUS	0x25
> +
> +#define WMAX_THERMAL_MODE_GMODE		0xAB
> +
> +#define WMAX_FAILURE_CODE		0xFFFFFFFF
>
>   MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
>   MODULE_DESCRIPTION("Alienware special feature control");
> @@ -49,11 +59,59 @@ enum WMAX_CONTROL_STATES {
>   	WMAX_SUSPEND =3D 3,
>   };
>
> +enum WMAX_THERMAL_INFORMATION_OPERATIONS {
> +	WMAX_OPERATION_LIST_IDS			=3D 0x03,
> +	WMAX_OPERATION_CURRENT_PROFILE		=3D 0x0B,
> +};
> +
> +enum WMAX_THERMAL_CONTROL_OPERATIONS {
> +	WMAX_OPERATION_ACTIVATE_PROFILE		=3D 0x01,
> +};
> +
> +enum WMAX_GAME_SHIFT_STATUS_OPERATIONS {
> +	WMAX_OPERATION_TOGGLE_GAME_SHIFT	=3D 0x01,
> +	WMAX_OPERATION_GET_GAME_SHIFT_STATUS	=3D 0x02,
> +};
> +
> +enum WMAX_THERMAL_TABLES {
> +	WMAX_THERMAL_TABLE_BASIC		=3D 0x90,
> +	WMAX_THERMAL_TABLE_USTT			=3D 0xA0,
> +};
> +
> +enum wmax_thermal_mode {
> +	THERMAL_MODE_USTT_BALANCED,
> +	THERMAL_MODE_USTT_BALANCED_PERFORMANCE,
> +	THERMAL_MODE_USTT_COOL,
> +	THERMAL_MODE_USTT_QUIET,
> +	THERMAL_MODE_USTT_PERFORMANCE,
> +	THERMAL_MODE_USTT_LOW_POWER,
> +	THERMAL_MODE_BASIC_QUIET,
> +	THERMAL_MODE_BASIC_BALANCED,
> +	THERMAL_MODE_BASIC_BALANCED_PERFORMANCE,
> +	THERMAL_MODE_BASIC_PERFORMANCE,
> +	THERMAL_MODE_LAST,
> +};
> +
> +static const enum platform_profile_option wmax_mode_to_platform_profile=
[THERMAL_MODE_LAST] =3D {
> +	[THERMAL_MODE_USTT_BALANCED]			=3D PLATFORM_PROFILE_BALANCED,
> +	[THERMAL_MODE_USTT_BALANCED_PERFORMANCE]	=3D PLATFORM_PROFILE_BALANCED=
_PERFORMANCE,
> +	[THERMAL_MODE_USTT_COOL]			=3D PLATFORM_PROFILE_COOL,
> +	[THERMAL_MODE_USTT_QUIET]			=3D PLATFORM_PROFILE_QUIET,
> +	[THERMAL_MODE_USTT_PERFORMANCE]			=3D PLATFORM_PROFILE_PERFORMANCE,
> +	[THERMAL_MODE_USTT_LOW_POWER]			=3D PLATFORM_PROFILE_LOW_POWER,
> +	[THERMAL_MODE_BASIC_QUIET]			=3D PLATFORM_PROFILE_QUIET,
> +	[THERMAL_MODE_BASIC_BALANCED]			=3D PLATFORM_PROFILE_BALANCED,
> +	[THERMAL_MODE_BASIC_BALANCED_PERFORMANCE]	=3D PLATFORM_PROFILE_BALANCE=
D_PERFORMANCE,
> +	[THERMAL_MODE_BASIC_PERFORMANCE]		=3D PLATFORM_PROFILE_PERFORMANCE,
> +};
> +
>   struct quirk_entry {
>   	u8 num_zones;
>   	u8 hdmi_mux;
>   	u8 amplifier;
>   	u8 deepslp;
> +	bool thermal;	/* Autodetected. Do not initialize explicitly. */
> +	bool gmode;	/* Autodetected. Do not initialize explicitly. */

Hi,

is the WMI method to control the thermal profile available on all Alienwar=
e devices?
If no, then the thermal quirk still needs to be enabled manually.

>   };
>
>   static struct quirk_entry *quirks;
> @@ -214,10 +272,19 @@ struct wmax_led_args {
>   	u8 state;
>   } __packed;
>
> +struct wmax_u32_args {
> +	u8 operation;
> +	u8 arg1;
> +	u8 arg2;
> +	u8 arg3;
> +};
> +
>   static struct platform_device *platform_device;
>   static struct device_attribute *zone_dev_attrs;
>   static struct attribute **zone_attrs;
>   static struct platform_zone *zone_data;
> +static struct platform_profile_handler pp_handler;
> +static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFI=
LE_LAST];
>
>   static struct platform_driver platform_driver =3D {
>   	.driver =3D {
> @@ -761,6 +828,210 @@ static int create_deepsleep(struct platform_device=
 *dev)
>   	return ret;
>   }
>
> +/*
> + * Thermal Profile control
> + *  - Provides thermal profile control through the Platform Profile API
> + */
> +#define WMAX_THERMAL_TABLE_MASK		GENMASK(7, 4)
> +#define WMAX_THERMAL_MODE_MASK		GENMASK(3, 0)
> +#define WMAX_SENSOR_ID_MASK		BIT(8)
> +
> +static bool is_wmax_thermal_code(u32 code)
> +{
> +	if (code & WMAX_SENSOR_ID_MASK)
> +		return false;
> +
> +	if ((code & WMAX_THERMAL_MODE_MASK) >=3D THERMAL_MODE_LAST)
> +		return false;
> +
> +	if ((code & WMAX_THERMAL_TABLE_MASK) =3D=3D WMAX_THERMAL_TABLE_BASIC &=
&
> +	    (code & WMAX_THERMAL_MODE_MASK) >=3D THERMAL_MODE_BASIC_BALANCED)
> +		return true;

Please correct me if i am wrong, but i think THERMAL_MODE_BASIC_BALANCED s=
hould be
THERMAL_MODE_BASIC_QUIET.

> +
> +	if ((code & WMAX_THERMAL_TABLE_MASK) =3D=3D WMAX_THERMAL_TABLE_USTT &&
> +	    (code & WMAX_THERMAL_MODE_MASK) <=3D THERMAL_MODE_USTT_LOW_POWER)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int wmax_thermal_information(u8 operation, u8 arg, u32 *out_data=
)
> +{
> +	acpi_status status;
> +	struct wmax_u32_args in_args =3D {
> +		.operation =3D operation,
> +		.arg1 =3D arg,
> +		.arg2 =3D 0,
> +		.arg3 =3D 0,
> +	};
> +
> +	status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_THERMAL_INFORMATION,
> +					out_data);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	if (*out_data =3D=3D WMAX_FAILURE_CODE)
> +		return -EBADRQC;
> +
> +	return 0;
> +}
> +
> +static int wmax_thermal_control(u8 profile)
> +{
> +	acpi_status status;
> +	struct wmax_u32_args in_args =3D {
> +		.operation =3D WMAX_OPERATION_ACTIVATE_PROFILE,
> +		.arg1 =3D profile,
> +		.arg2 =3D 0,
> +		.arg3 =3D 0,
> +	};
> +	u32 out_data;
> +
> +	status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_THERMAL_CONTROL,
> +					&out_data);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	if (out_data =3D=3D WMAX_FAILURE_CODE)
> +		return -EBADRQC;
> +
> +	return 0;
> +}
> +
> +static int wmax_game_shift_status(u8 operation, u32 *out_data)
> +{
> +	acpi_status status;
> +	struct wmax_u32_args in_args =3D {
> +		.operation =3D operation,
> +		.arg1 =3D 0,
> +		.arg2 =3D 0,
> +		.arg3 =3D 0,
> +	};
> +
> +	status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_GAME_SHIFT_STATUS,
> +					out_data);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	if (*out_data =3D=3D WMAX_FAILURE_CODE)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +static int thermal_profile_get(struct platform_profile_handler *pprof,
> +			       enum platform_profile_option *profile)
> +{
> +	u32 out_data;
> +	int ret;
> +
> +	ret =3D wmax_thermal_information(WMAX_OPERATION_CURRENT_PROFILE,
> +				       0, &out_data);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!is_wmax_thermal_code(out_data))
> +		return -ENODATA;
> +
> +	out_data &=3D WMAX_THERMAL_MODE_MASK;
> +	*profile =3D wmax_mode_to_platform_profile[out_data];

Please check that out_data is smaller than THERMAL_MODE_LAST, otherwise
an out-of-bounds access can occur.

Nice work overall.

Thanks,
Armin Wolf

> +
> +	return 0;
> +}
> +
> +static int thermal_profile_set(struct platform_profile_handler *pprof,
> +			       enum platform_profile_option profile)
> +{
> +	if (quirks->gmode) {
> +		u32 gmode_status;
> +		int ret;
> +
> +		ret =3D wmax_game_shift_status(WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
> +					     &gmode_status);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		if ((profile =3D=3D PLATFORM_PROFILE_PERFORMANCE && !gmode_status) ||
> +		    (profile !=3D PLATFORM_PROFILE_PERFORMANCE && gmode_status)) {
> +			ret =3D wmax_game_shift_status(WMAX_OPERATION_TOGGLE_GAME_SHIFT,
> +						     &gmode_status);
> +
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	return wmax_thermal_control(supported_thermal_profiles[profile]);
> +}
> +
> +static int create_thermal_profile(void)
> +{
> +	u32 out_data;
> +	u32 gmode_status;
> +	enum wmax_thermal_mode mode;
> +	enum platform_profile_option profile;
> +	int ret;
> +
> +	for (u8 i =3D 0x2; i <=3D 0xD; i++) {
> +		ret =3D wmax_thermal_information(WMAX_OPERATION_LIST_IDS,
> +					       i, &out_data);
> +
> +		if (ret =3D=3D -EIO)
> +			return 0;
> +
> +		if (ret =3D=3D -EBADRQC)
> +			break;
> +
> +		if (!is_wmax_thermal_code(out_data))
> +			continue;
> +
> +		mode =3D out_data & WMAX_THERMAL_MODE_MASK;
> +		profile =3D wmax_mode_to_platform_profile[mode];
> +		supported_thermal_profiles[profile] =3D out_data;
> +
> +		set_bit(profile, pp_handler.choices);
> +	}
> +
> +	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
> +		return 0;
> +
> +	ret =3D wmax_game_shift_status(WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
> +				     &gmode_status);
> +
> +	if (!ret) {
> +		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =3D
> +			WMAX_THERMAL_MODE_GMODE;
> +
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> +		quirks->gmode =3D true;
> +	}
> +
> +	pp_handler.profile_get =3D thermal_profile_get;
> +	pp_handler.profile_set =3D thermal_profile_set;
> +
> +	ret =3D platform_profile_register(&pp_handler);
> +	if (ret < 0)
> +		return ret;
> +
> +	quirks->thermal =3D true;
> +
> +	return 0;
> +}
> +
> +static void remove_thermal_profile(void)
> +{
> +	if (quirks->thermal)
> +		platform_profile_remove();
> +}
> +
>   static int __init alienware_wmi_init(void)
>   {
>   	int ret;
> @@ -808,6 +1079,12 @@ static int __init alienware_wmi_init(void)
>   			goto fail_prep_deepsleep;
>   	}
>
> +	if (interface =3D=3D WMAX && quirks =3D=3D &quirk_unknown) {
> +		ret =3D create_thermal_profile();
> +		if (ret)
> +			goto fail_prep_thermal_profile;
> +	}
> +
>   	ret =3D alienware_zone_init(platform_device);
>   	if (ret)
>   		goto fail_prep_zones;
> @@ -816,6 +1093,8 @@ static int __init alienware_wmi_init(void)
>
>   fail_prep_zones:
>   	alienware_zone_exit(platform_device);
> +	remove_thermal_profile();
> +fail_prep_thermal_profile:
>   fail_prep_deepsleep:
>   fail_prep_amplifier:
>   fail_prep_hdmi:
> @@ -835,6 +1114,7 @@ static void __exit alienware_wmi_exit(void)
>   	if (platform_device) {
>   		alienware_zone_exit(platform_device);
>   		remove_hdmi(platform_device);
> +		remove_thermal_profile();
>   		platform_device_unregister(platform_device);
>   		platform_driver_unregister(&platform_driver);
>   	}

