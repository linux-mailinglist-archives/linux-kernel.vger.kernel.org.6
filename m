Return-Path: <linux-kernel+bounces-556771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91741A5CE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1553A7016
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE51263C8B;
	Tue, 11 Mar 2025 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="jwHht7pv"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67A26158C;
	Tue, 11 Mar 2025 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719334; cv=none; b=cdfU8tGpU3dnh8ZBiRcyWHp59cEiD94HALER3s3Lqq2/sUad2CLAYIkdoaNGUmD2zwTE2a5+/v/5W7Q5patjWOq0dttwGBTuvBIdtKLTSRdaRt0KK2ChTHRlr5ga1G9pe7NZtjmpidfHRHW00Te17iCc19VUrv8D/XUAHIdwaeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719334; c=relaxed/simple;
	bh=HPMnxprR9RslEETD0rXoL+Yko1bhFLmcyo0NSKyb0D0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GG/AfHT+ctu4oLbUuAsr1nqZH4fYZBOltUl328yFXS3/lxA4hqTEZlGwEHEosMrjaoUy173s/TuM227Y5qtkLqjUFCE4pabFH7OCD1qxlrGUHjP2alI/tIqQCGKbwag1ETAkmDMTKDt0qMXSdH7gWYpYnr5z8TD3e7bbUpuEpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=jwHht7pv; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741719327; x=1742324127; i=w_armin@gmx.de;
	bh=Zj6JMiJiRMuvYCV/BhWUcIecLjazW3Ujydsf1WdONjA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jwHht7pvSEaX1ho5XNtgdEi36ApKR1NXcKgYdckqn7CgIi1S9MEqYcse9VmqZPxw
	 +3xBbVoPtzlM0a46qFtvrQDnfdayUG67OowZyH+xPROhHyjXo9vZbuj5lPLMaeLto
	 1cWxWUAiAeKumQ+Hlbi4RB9GVbigJ4QjEzASAq0NcUGwBgzk6N3AQGBve0TtDwmrD
	 LXsMG0YIpe2R4Fz9uotpYiIQw7/8tNvhACCbeQQhzDPcvRgRDKoY5AjVJIDygOVvg
	 Y2ScgVsSAgLpv1XTjykJhsOQmvt/yEXft81pv74YwrsHP/9LM2t2Y2CgifTBczuyb
	 txlMGD3u3ecn/VQnvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbkM-1tdql90J48-00Niez; Tue, 11
 Mar 2025 19:55:27 +0100
Message-ID: <f48154cb-c282-4783-94b9-b5378b146f4a@gmx.de>
Date: Tue, 11 Mar 2025 19:55:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] platform/x86: alienware-wmi-wmax: Add HWMON
 support
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 linux-hwmon@vger.kernel.org
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
 <20250308-hwm-v4-7-afa1342828f5@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250308-hwm-v4-7-afa1342828f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:83HJm8I0RJQGX6A5U8xWOHbSCHjcOQRYd84U3qbt7z4iQ2ofABp
 5qU/8XL/pWZZLa/dMPg5Zx9cdmdppsJBkvSTHL6FoAozFFIOr6Wg5V9jtsLAnZrBUVJQpji
 8qy0OkWxd74MmXvGM29NO+O1JLPzTqJCc21ibH5aEm4mLkH4FnUkbUBhne99WLH+6Rlu0df
 quHLxTCXiXJdOqawTN3gQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uI7hAAyDabU=;YjZZ/OWGX6GSG9d5ZUoq16tRsxH
 HAihsO2u+fCSMbjMsss6bheBTihlRjR8Cbd+llw9Bn8REmTefhDVxhl8U11qySg+a/RlHFJi6
 oE9u8H8e5nrRWzFIhIk7hEN3Bqu2i64uSp1kl9EodZ7UZK093qo1PkO2rjA9dH0DCng1zatJB
 xH0MKpTXrrKY+YvXm3KM5hKPIZEvYHJDfjntSo8cYRsyDDfS6V73z1Q3IJN8MsW6pX43Euoqx
 epq7WLOaHkjAKb5lFvVsl+batIuaG44CBU0IEyxaJjZKPleq+L/G7jpi73dz+06bS5T5f0YO/
 CqkGgH8OekR8lkSs6iKkB4OlP5k1MP8qE4D5tp3jri+gOYponMZwRq4BCbHS04WfWUX42iVMv
 RO0yLFA+JZsrfqYRjW2BdeNUKDlj1YsyLUtTmy7/Kscj//KoMYtBJVL3Ov5sbmmsLLjUJ0ZIj
 1mJ3X1nJlflpIUz/ydAy9ykl7MI6wKiczfqbYj6IuGL/Mjx9MH/g6XxdGm38W2IHdBdr/oHFZ
 zVq69NJ1Jdv/A1emv2Tx+0Xb0XHnBWlp9W1y503/XU9pIodRiZc6cMURuwFvjF1ByZQQ7Eqd+
 o9QaKwazpUw8v7oO9O+CVQGYpMNYokB3RbXSAZvp+d+IbCbKNSAqSH8eMbg5xaGOod6JH4KmH
 emO+AAxHtpncwDUUtDWc3pWIgQfPbBZIqb4ozGiL6osF34/h1WL5n20h1QfDfTuwBE6bS/UhW
 mejibMo9ABzb873sWVWSKBUb9sCHm6rAYG116nmh8DeHmQEdC1HWs+9pnfYgfm12Yd8G9uegq
 Cly27udnWKtrtdNgtqnf4b7j3kDbT0zjHpgrUuq7tXHbFVKu1/K939ONAq+Ew5UIHz7m0z86O
 jDiOsVeNYJfH8xdhqBQi1iW3iU6sy2g7g6fgmfOG5wiA1V/wPUGrI7hhD8IqdUnoOuvx3BQZj
 FeluTijrA4BygTfj7ruLnapNj/elTRiGiWbLDl04ejO6bgDAav6kWm59VBbpRtqcGpqr/czI9
 lgW6gVyoKVT03RAbyHAog1L8Zv1UTv7x29QTSabT6S1ho/Z8KRe2hERKFEsEYXb7839HwXkg9
 1asnjwfF4ZlrlY9/+co7JtaFcIT9F+W1t6Gce5LXWKuRMVAX4SWBinGma06UaVsa0NdoguwAA
 yEXRKWAfJj66l+VFgfK+BSK2LE1VMaf1p1nxw5IWRBKDpQA9ci4uhYpbKTBNRIVST8nM02zVk
 DiHjmrtd9eeFvpGF+3Z9yWL+6j5eKNKwE9AGYNVfSxf3hQUsIitnnW3OZc9Ih+l1zmlADIHub
 qyfmQpxOMnZFZ0RoD5zzcuQYxN5RZrG3OZY4Dy59Y9/6co23MduYr4quAnMhfCk4OkGZda5mq
 PigsraKcLh3jxw3tN9Ywu/Cz6GvklknB2MsoVf3yTxxn3NXq7vb72lRsGd

Am 08.03.25 um 21:23 schrieb Kurt Borja:

> All models with the "AWCC" WMAX device support monitoring fan speed and
> temperature sensors. Expose this feature through the HWMON interface.
>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/Kconfig              |   1 +
>   drivers/platform/x86/dell/alienware-wmi-wmax.c | 396 +++++++++++++++++=
++++++++
>   2 files changed, 397 insertions(+)
>
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/de=
ll/Kconfig
> index f8a0dffcaab7c3b423472c5b9093011334a698c8..85a57c01aaada5d899cd8252=
e77ed6043da5cbdf 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -43,6 +43,7 @@ config ALIENWARE_WMI_WMAX
>   	bool "Alienware WMAX WMI device driver"
>   	default y
>   	depends on ALIENWARE_WMI
> +	depends on HWMON
>   	select ACPI_PLATFORM_PROFILE
>   	help
>   	 Alienware WMI driver with AlienFX LED, HDMI, amplifier, deep sleep a=
nd
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
> index 3b37e4456482bc284b8e867c1c5b6255fc6c8ef2..f1f20db206d47f644e8cd58a=
6d169c850606e75b 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -9,10 +9,13 @@
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>   #include <linux/bitfield.h>
> +#include <linux/bitmap.h>
>   #include <linux/bits.h>
>   #include <linux/dmi.h>
> +#include <linux/hwmon.h>
>   #include <linux/moduleparam.h>
>   #include <linux/platform_profile.h>
> +#include <linux/units.h>
>   #include <linux/wmi.h>
>   #include "alienware-wmi.h"
>
> @@ -25,6 +28,7 @@
>   #define WMAX_METHOD_BRIGHTNESS			0x3
>   #define WMAX_METHOD_ZONE_CONTROL		0x4
>
> +#define AWCC_METHOD_GET_FAN_SENSORS		0x13
>   #define AWCC_METHOD_THERMAL_INFORMATION		0x14
>   #define AWCC_METHOD_THERMAL_CONTROL		0x15
>   #define AWCC_METHOD_GAME_SHIFT_STATUS		0x25
> @@ -38,6 +42,12 @@
>
>   /* Arbitrary limit based on supported models */
>   #define AWCC_MAX_RES_COUNT			16
> +#define AWCC_ID_BITMAP_SIZE			(U8_MAX + 1)
> +#define AWCC_ID_BITMAP_LONGS			BITS_TO_LONGS(AWCC_ID_BITMAP_SIZE)
> +
> +static bool force_hwmon;
> +module_param_unsafe(force_hwmon, bool, 0);
> +MODULE_PARM_DESC(force_hwmon, "Force probing for HWMON support without =
checking if the WMI backend is available");
>
>   static bool force_platform_profile;
>   module_param_unsafe(force_platform_profile, bool, 0);
> @@ -48,16 +58,19 @@ module_param_unsafe(force_gmode, bool, 0);
>   MODULE_PARM_DESC(force_gmode, "Forces G-Mode when performance profile =
is selected");
>
>   struct awcc_quirks {
> +	bool hwmon;
>   	bool pprof;
>   	bool gmode;
>   };
>
>   static struct awcc_quirks g_series_quirks =3D {
> +	.hwmon =3D true,
>   	.pprof =3D true,
>   	.gmode =3D true,
>   };
>
>   static struct awcc_quirks generic_quirks =3D {
> +	.hwmon =3D true,
>   	.pprof =3D true,
>   	.gmode =3D false,
>   };
> @@ -155,9 +168,18 @@ static const struct dmi_system_id awcc_dmi_table[] =
__initconst =3D {
>   	},
>   };
>
> +enum AWCC_GET_FAN_SENSORS_OPERATIONS {
> +	AWCC_OP_GET_TOTAL_FAN_TEMPS		=3D 0x01,
> +	AWCC_OP_GET_FAN_TEMP_ID			=3D 0x02,
> +};
> +
>   enum AWCC_THERMAL_INFORMATION_OPERATIONS {
>   	AWCC_OP_GET_SYSTEM_DESCRIPTION		=3D 0x02,
>   	AWCC_OP_GET_RESOURCE_ID			=3D 0x03,
> +	AWCC_OP_GET_TEMPERATURE			=3D 0x04,
> +	AWCC_OP_GET_FAN_RPM			=3D 0x05,
> +	AWCC_OP_GET_FAN_MIN_RPM			=3D 0x08,
> +	AWCC_OP_GET_FAN_MAX_RPM			=3D 0x09,
>   	AWCC_OP_GET_CURRENT_PROFILE		=3D 0x0B,
>   };
>
> @@ -180,6 +202,11 @@ enum AWCC_SPECIAL_THERMAL_CODES {
>   	AWCC_SPECIAL_PROFILE_GMODE		=3D 0xAB,
>   };
>
> +enum AWCC_TEMP_SENSOR_TYPES {
> +	AWCC_TEMP_SENSOR_CPU			=3D 0x01,
> +	AWCC_TEMP_SENSOR_GPU			=3D 0x06,
> +};
> +
>   enum awcc_thermal_profile {
>   	AWCC_PROFILE_USTT_BALANCED,
>   	AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
> @@ -216,6 +243,14 @@ struct wmax_u32_args {
>   	u8 arg3;
>   };
>
> +struct awcc_fan_data {
> +	unsigned long auto_channels_temp;
> +	const char *label;
> +	u32 min_rpm;
> +	u32 max_rpm;
> +	u8 id;
> +};
> +
>   struct awcc_priv {
>   	struct wmi_device *wdev;
>   	union {
> @@ -231,6 +266,10 @@ struct awcc_priv {
>
>   	struct device *ppdev;
>   	u8 supported_profiles[PLATFORM_PROFILE_LAST];
> +
> +	struct device *hwdev;
> +	struct awcc_fan_data **fan_data;
> +	unsigned long temp_sensors[AWCC_ID_BITMAP_LONGS];
>   };
>
>   static const enum platform_profile_option awcc_mode_to_platform_profil=
e[AWCC_PROFILE_LAST] =3D {
> @@ -495,6 +534,19 @@ static int __awcc_wmi_command(struct wmi_device *wd=
ev, u32 method_id,
>   	return 0;
>   }
>
> +static inline int awcc_get_fan_sensors(struct wmi_device *wdev, u8 oper=
ation,
> +				       u8 fan_id, u8 index, u32 *out)
> +{
> +	struct wmax_u32_args args =3D {
> +		.operation =3D operation,
> +		.arg1 =3D fan_id,
> +		.arg2 =3D index,
> +		.arg3 =3D 0,
> +	};
> +
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_GET_FAN_SENSORS, &args, ou=
t);
> +}
> +
>   static inline int awcc_thermal_information(struct wmi_device *wdev, u8=
 operation,
>   					   u8 arg, u32 *out)
>   {
> @@ -552,6 +604,30 @@ static inline int awcc_op_get_resource_id(struct wm=
i_device *wdev, u8 index, u32
>   	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &arg=
s, out);
>   }
>
> +static inline int awcc_op_get_fan_rpm(struct wmi_device *wdev, u8 fan_i=
d, u32 *out)
> +{
> +	struct wmax_u32_args args =3D {
> +		.operation =3D AWCC_OP_GET_FAN_RPM,
> +		.arg1 =3D fan_id,
> +		.arg2 =3D 0,
> +		.arg3 =3D 0,
> +	};
> +
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args=
, out);
> +}
> +
> +static inline int awcc_op_get_temperature(struct wmi_device *wdev, u8 t=
emp_id, u32 *out)
> +{
> +	struct wmax_u32_args args =3D {
> +		.operation =3D AWCC_OP_GET_TEMPERATURE,
> +		.arg1 =3D temp_id,
> +		.arg2 =3D 0,
> +		.arg3 =3D 0,
> +	};
> +
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args=
, out);
> +}
> +
>   static inline int awcc_op_get_current_profile(struct wmi_device *wdev,=
 u32 *out)
>   {
>   	struct wmax_u32_args args =3D {
> @@ -577,6 +653,313 @@ static inline int awcc_op_activate_profile(struct =
wmi_device *wdev, u8 profile)
>   	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &=
out);
>   }
>
> +/*
> + * HWMON
> + *  - Provides temperature and fan speed monitoring as well as manual f=
an
> + *    control
> + */
> +static umode_t awcc_hwmon_is_visible(const void *drvdata, enum hwmon_se=
nsor_types type,
> +				     u32 attr, int channel)
> +{
> +	const struct awcc_priv *priv =3D drvdata;
> +	unsigned int temp_count;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		temp_count =3D bitmap_weight(priv->temp_sensors, AWCC_ID_BITMAP_SIZE)=
;
> +
> +		return channel < temp_count ? 0444 : 0;
> +	case hwmon_fan:
> +		return channel < priv->fan_count ? 0444 : 0;
> +	case hwmon_pwm:
> +		return channel < priv->fan_count ? 0444 : 0;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int awcc_hwmon_read(struct device *dev, enum hwmon_sensor_types =
type,
> +			   u32 attr, int channel, long *val)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +	const struct awcc_fan_data *fan;
> +	u32 state;
> +	int ret;
> +	u8 temp;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		temp =3D find_nth_bit(priv->temp_sensors, AWCC_ID_BITMAP_SIZE, channe=
l);
> +
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			ret =3D awcc_op_get_temperature(priv->wdev, temp, &state);
> +			if (ret)
> +				return ret;
> +
> +			*val =3D state * MILLIDEGREE_PER_DEGREE;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +		break;
> +	case hwmon_fan:
> +		fan =3D priv->fan_data[channel];
> +
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			ret =3D awcc_op_get_fan_rpm(priv->wdev, fan->id, &state);
> +			if (ret)
> +				return ret;
> +
> +			*val =3D state;
> +			break;
> +		case hwmon_fan_min:
> +			*val =3D fan->min_rpm;
> +			break;
> +		case hwmon_fan_max:
> +			*val =3D fan->max_rpm;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +		break;
> +	case hwmon_pwm:
> +		fan =3D priv->fan_data[channel];
> +
> +		switch (attr) {
> +		case hwmon_pwm_auto_channels_temp:
> +			*val =3D fan->auto_channels_temp;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int awcc_hwmon_read_string(struct device *dev, enum hwmon_sensor=
_types type,
> +				  u32 attr, int channel, const char **str)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +	u8 temp;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		temp =3D find_nth_bit(priv->temp_sensors, AWCC_ID_BITMAP_SIZE, channe=
l);
> +
> +		switch (temp) {
> +		case AWCC_TEMP_SENSOR_CPU:
> +			*str =3D "CPU";
> +			break;
> +		case AWCC_TEMP_SENSOR_GPU:
> +			*str =3D "GPU";
> +			break;
> +		default:
> +			*str =3D "Unknown";
> +			break;
> +		}
> +
> +		break;
> +	case hwmon_fan:
> +		*str =3D priv->fan_data[channel]->label;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops awcc_hwmon_ops =3D {
> +	.is_visible =3D awcc_hwmon_is_visible,
> +	.read =3D awcc_hwmon_read,
> +	.read_string =3D awcc_hwmon_read_string,
> +};
> +
> +static const struct hwmon_channel_info * const awcc_hwmon_info[] =3D {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_LABEL | HWMON_T_INPUT,
> +			   HWMON_T_LABEL | HWMON_T_INPUT,
> +			   HWMON_T_LABEL | HWMON_T_INPUT,
> +			   HWMON_T_LABEL | HWMON_T_INPUT,
> +			   HWMON_T_LABEL | HWMON_T_INPUT,
> +			   HWMON_T_LABEL | HWMON_T_INPUT
> +			   ),
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX
> +			   ),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP
> +			   ),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info awcc_hwmon_chip_info =3D {
> +	.ops =3D &awcc_hwmon_ops,
> +	.info =3D awcc_hwmon_info,
> +};
> +
> +static int awcc_hwmon_temps_init(struct wmi_device *wdev)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(&wdev->dev);
> +	unsigned int i;
> +	int ret;
> +	u32 id;
> +
> +	for (i =3D 0; i < priv->temp_count; i++) {
> +		/*
> +		 * Temperature sensors IDs are listed after the fan IDs at
> +		 * offset `fan_count`
> +		 */
> +		ret =3D awcc_op_get_resource_id(wdev, i + priv->fan_count, &id);
> +		if (ret)
> +			return ret;
> +
> +		__set_bit(FIELD_GET(AWCC_RESOURCE_ID_MASK, id), priv->temp_sensors);
> +	}
> +
> +	return 0;
> +}
> +
> +static char *awcc_alloc_fan_label(struct device *dev, u32 temp_count, u=
8 temp_id)
> +{
> +	char *label;
> +
> +	switch (temp_count) {
> +	case 0:
> +		label =3D devm_kstrdup(dev, "Independent Fan", GFP_KERNEL);
> +		break;
> +	case 1:
> +		switch (temp_id) {
> +		case AWCC_TEMP_SENSOR_CPU:
> +			label =3D devm_kstrdup(dev, "Processor Fan", GFP_KERNEL);
> +			break;
> +		case AWCC_TEMP_SENSOR_GPU:
> +			label =3D devm_kstrdup(dev, "Video Fan", GFP_KERNEL);
> +			break;
> +		default:
> +			label =3D devm_kstrdup(dev, "Unknown Fan", GFP_KERNEL);
> +			break;
> +		}
> +
> +		break;
> +	default:
> +		label =3D devm_kstrdup(dev, "Shared Fan", GFP_KERNEL);

All of those strings are static, please drop the usage of devm_kstrdup() h=
ere.

With those issues being addressed:
Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +		break;
> +	}
> +
> +	return label;
> +}
> +
> +static int awcc_hwmon_fans_init(struct wmi_device *wdev)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(&wdev->dev);
> +	u32 id, min_rpm, max_rpm, temp_count, temp_id;
> +	unsigned long fan_temps[AWCC_ID_BITMAP_LONGS];
> +	unsigned long gather[AWCC_ID_BITMAP_LONGS];
> +	struct awcc_fan_data *fan_data;
> +	unsigned int i, j;
> +	char *label;
> +	int ret;
> +
> +	for (i =3D 0; i < priv->fan_count; i++) {
> +		fan_data =3D devm_kzalloc(&wdev->dev, sizeof(*fan_data), GFP_KERNEL);
> +		if (!fan_data)
> +			return -ENOMEM;
> +
> +		/*
> +		 * Fan IDs are listed first at offset 0
> +		 */
> +		ret =3D awcc_op_get_resource_id(wdev, i, &id);
> +		if (ret)
> +			return ret;
> +		id =3D FIELD_GET(AWCC_RESOURCE_ID_MASK, id);
> +
> +		ret =3D awcc_thermal_information(wdev, AWCC_OP_GET_FAN_MIN_RPM, id,
> +					       &min_rpm);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D awcc_thermal_information(wdev, AWCC_OP_GET_FAN_MAX_RPM, id,
> +					       &max_rpm);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D awcc_get_fan_sensors(wdev, AWCC_OP_GET_TOTAL_FAN_TEMPS, id,
> +					   0, &temp_count);
> +		if (ret)
> +			return ret;
> +
> +		for (j =3D 0; j < temp_count; j++) {
> +			ret =3D awcc_get_fan_sensors(wdev, AWCC_OP_GET_FAN_TEMP_ID,
> +						   id, j, &temp_id);
> +			if (ret)
> +				break;
> +
> +			temp_id =3D FIELD_GET(AWCC_RESOURCE_ID_MASK, temp_id);
> +			__set_bit(temp_id, fan_temps);
> +		}
> +
> +		label =3D awcc_alloc_fan_label(&wdev->dev, temp_count, temp_id);
> +		if (!label)
> +			return -ENOMEM;
> +
> +		fan_data->id =3D id;
> +		fan_data->min_rpm =3D min_rpm;
> +		fan_data->max_rpm =3D max_rpm;
> +		fan_data->label =3D label;
> +		bitmap_gather(gather, fan_temps, priv->temp_sensors, AWCC_ID_BITMAP_S=
IZE);
> +		bitmap_copy(&fan_data->auto_channels_temp, gather, priv->temp_count);

Please check that the bitmap can fit into the long variable before using b=
itmap_copy().

> +		priv->fan_data[i] =3D fan_data;
> +
> +		bitmap_zero(fan_temps, AWCC_ID_BITMAP_SIZE);
> +	}
> +
> +	return 0;
> +}
> +
> +static int awcc_hwmon_init(struct wmi_device *wdev)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(&wdev->dev);
> +	int ret;
> +
> +	priv->fan_data =3D devm_kcalloc(&wdev->dev, priv->fan_count,
> +				      sizeof(*priv->fan_data), GFP_KERNEL);
> +	if (!priv->fan_data)
> +		return -ENOMEM;
> +
> +	ret =3D awcc_hwmon_temps_init(wdev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D awcc_hwmon_fans_init(wdev);
> +	if (ret)
> +		return ret;
> +
> +	priv->hwdev =3D devm_hwmon_device_register_with_info(&wdev->dev, "alie=
nware_wmi", priv,
> +							   &awcc_hwmon_chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(priv->hwdev);
> +}
> +
>   /*
>    * Thermal Profile control
>    *  - Provides thermal profile control through the Platform Profile AP=
I
> @@ -744,6 +1127,12 @@ static int alienware_awcc_setup(struct wmi_device =
*wdev)
>   	priv->wdev =3D wdev;
>   	dev_set_drvdata(&wdev->dev, priv);
>
> +	if (awcc->hwmon) {
> +		ret =3D awcc_hwmon_init(wdev);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	if (awcc->pprof) {
>   		ret =3D awcc_platform_profile_init(wdev);
>   		if (ret)
> @@ -824,6 +1213,13 @@ int __init alienware_wmax_wmi_init(void)
>   	if (id)
>   		awcc =3D id->driver_data;
>
> +	if (force_hwmon) {
> +		if (!awcc)
> +			awcc =3D &empty_quirks;
> +
> +		awcc->hwmon =3D true;
> +	}
> +
>   	if (force_platform_profile) {
>   		if (!awcc)
>   			awcc =3D &empty_quirks;
>

