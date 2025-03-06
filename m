Return-Path: <linux-kernel+bounces-549989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0966A55990
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190841898F15
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0131927C85D;
	Thu,  6 Mar 2025 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="SrX1NNVH"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A4D205AC0;
	Thu,  6 Mar 2025 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299559; cv=none; b=h8nc5ejhZMwV2DGE3Iaa3lqZOIXP+IgDGVPgrRW1d0naGF6G5AFHTiDi9v9TkEL0e3lCuNH47IudbWNi9ODSJ1GyX4xwJAo+ErnfSbUJ6oFckN/SILc9i3tm3EyO8Wh7S6MrhgOgzHrSgmHOyofnfccIQ8T8aFThmJuSnX16uh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299559; c=relaxed/simple;
	bh=F8I+IHPI9kxbDrAyAiKmd506A2wY3U3h7bDaXxpXQ4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cg1SwwS8eCWHbk1nDmh1vi8jajO+sYbvsVCd7O+MZhnpI2DngJ0SZaYjQVGOq06GL135yx1bgjvSWxG8svTKRK83DLAfrPgud4QdlxWzLB+xQpRQZytpIuWgOwBAgd8m0ap85IS2pbI4qzN08BF7hGQtbCdz9S+sDdMZugx+O0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=SrX1NNVH; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741299555; x=1741904355; i=w_armin@gmx.de;
	bh=okKiy53bmT/JV7LV473DNl8IrAxHziAHqXjYB0yZmSA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SrX1NNVHsaq21dwK5FbRjeZlKAxxpTgL6ODq1RY+JCjZFlG96WLp8kbwDXVm97iB
	 B44D/xy+kvkQ5NCwL+UNf5z0/1xBhW0zad5keWhm4JF9YUOtSBIMFbGY38+B2nifU
	 8JmIhTrNL7STTNiQAPWckF1M1nwL9y3O9Xweky0KpE3blpvXrWx7VWT/rHcOLb+DN
	 Ug3fVSz5ljhuxjewfMvacYLgLYGl1AQuSmLYpE+YrlgBZ4zwPqslk7dDP9kXuZhI8
	 OyuKtxjFXa5DX7Ctr71s+DqicguFLbILc5rYbgvRwKj9UDGXZqvuLSasOpsC9qJSy
	 W6D7fuWCZF78BtHATg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPokN-1tct973F4t-00OYFG; Thu, 06
 Mar 2025 23:19:15 +0100
Message-ID: <a375d474-5349-4662-8ce8-4f8f55349901@gmx.de>
Date: Thu, 6 Mar 2025 23:19:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] platform/x86: alienware-wmi-wmax: Add HWMON
 support
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 linux-hwmon@vger.kernel.org
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
 <20250305-hwm-v3-7-395e7a1407e2@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250305-hwm-v3-7-395e7a1407e2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JrOrZaOdmFzJWkJV/S+z4b2X+mACEXLIpIZQ5YOKVVpBnmjnBDe
 QrYAlBsxpt0CjTTHpjxjLDBqYyw1JgrlV+9ZTubZM8UHCFrkFEX+BpNDmYKuOHrixAp8vLI
 C1jpi2IhXuDWCdQvfjkMOMrYSTyar1OP73zM65dtEsBr0fWKZQCZh6npiosaOWdnap6TBj0
 1FXJOZ6z0kYZITEZOeJOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ot3NKJZ2Sdw=;Ik2p0vKrbzMb/LkoyIcnyCEZWBo
 fDIPpGMGN/fbNZPjw4mUwxrFagnc6/2OwPak4y3Soigw31ahzhjMWv0Ms2mEFXGobrMBbqItk
 m200YRfg4WN+WiF8+Nq24KYUSwHf6g3zClKYZeDjqI8374ebF1kZ6/raCl1H+LxvAVIJhbG2o
 DumOmqRS46TRrVyFadFK0BzdAHYZLQjtMXKF1ro5VHIkuW8VuZokzUg8CoJc0nEk81bGBm7Xv
 Y9M7WQkeEfP8k540apvJ3ltbihVth/kCn26xRNdXRVhoOEkE/amwwsM8YdTXSZ/8ltZMJU6p0
 qWNdLVrFxL+QOinZujGkvDfCP/awUACKj0h65ccxjLUWIvNor/C/VaPTLY+6gesPl0UNbXic6
 yTeUOZqovvVSLBpRgwDr9T/fpPBFZZ39cNBQFll+G0q0wBrjMPx9E/oocOT+yI3b9wDVILGGE
 RfX+F3NA1DlQCN2sl9IGey4rRG0r+NxCwbVnSso1eiZrbaBPBCQYzBLn8u7nkHWEdKb222yq8
 vSLsRP8OrSY6sowXMM5Rzf4hKR5oqbugIdFhJ25Zu6Z8HM6AjCXQxzaMs/sdbDtfFBuJXOVZ1
 NnhAJaEy21ZgxZIN5kbjfxiXGqyUvmW48wN0BTYZMpy6Jtnb1hdI74PZb4yvXspJRv9TCKq4G
 XTY0VAHE/GmyV5E2i4kIigBAHyZyyS7KxvbUldkBtrLfwgfeXLzUBsb13tj6h8lECyXYDn3Wl
 ieBKmXkpUyluOJkJA59NAgPmkXb4PpGbVEuqY7bas5ckxS6qW+y8UNTZd+6S8mYb6LA2O7zeG
 2laQ7tT7KkVtUFBl6LefzNIMHHVd5rRI5W1+p7U3vDV8dosqLqpPSjdNCpo73PwiwNm4BRV2t
 r+hRcsY8dLWXqWJ0A0udaAiB9Wg6TFETspQvDrdOZCKcyOpIqYTEgnJjLe4FFRNJJuebh5MJN
 egeezYoZIQ38C095jlL7IGZq0W9CLj2r/frlC7ja9rWFnROlTl9jVyM80JCLWvknFf6A64Qyv
 ZyGNkCSmscOQoTgXbwijQFa+Y3ySC38Ovfq7gViNylW7XsjnNHsTYUIQivHk1ohWl8z6/Tktf
 zHHbOj4TfwP/4UK0aC38hjRswQCFlGNlL6LKlp4keNetp98pbxPKDbtRP+w0f198nBc0lZiDy
 ESWSwuiLEei68hmpft07k4qTayg26qx/Gi4zKJDYNUduIIDVkWHUC/wv8eQQuKT/DTKvW2BCv
 otMuA6cEfGW2ZkUKzj0HtitGk2T/ubkHsKoQ+PUXWXW5PDawXUm7chlcnfIniiLr6f3S3uVAt
 HIyjs8M8UHYhM0wRMWSaTJUgJC8E2bzlzXwIhUmnyCYxo2wwaaq9H7hXsK9rOIhFuc/7jXuMa
 lgahBZyvqywRS7MrmjTEScq1JH4xOXnJLBbjrbQMdYzM0v0Hg0vikGdk4B

Am 06.03.25 um 01:56 schrieb Kurt Borja:

> All models with the "AWCC" WMAX device support monitoring fan speed and
> temperature sensors. Expose this feature through the HWMON interface.
>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/Kconfig              |   1 +
>   drivers/platform/x86/dell/alienware-wmi-wmax.c | 431 +++++++++++++++++=
++++++++
>   2 files changed, 432 insertions(+)
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
> index 71fc17e8d103146b8edf53a552ae5ba64414e873..20cf3371ee3c0e1ea038b3ca=
517e831f3b30dc29 100644
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
> @@ -39,6 +43,10 @@
>   /* Arbitrary limit based on supported models */
>   #define AWCC_MAX_RES_COUNT			16
>
> +static bool force_hwmon;
> +module_param_unsafe(force_hwmon, bool, 0);
> +MODULE_PARM_DESC(force_hwmon, "Force probing for HWMON support without =
checking if the WMI backend is available");
> +
>   static bool force_platform_profile;
>   module_param_unsafe(force_platform_profile, bool, 0);
>   MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting therma=
l profiles without checking if WMI thermal backend is available");
> @@ -48,16 +56,19 @@ module_param_unsafe(force_gmode, bool, 0);
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
> @@ -155,9 +166,18 @@ static const struct dmi_system_id awcc_dmi_table[] =
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
> @@ -180,6 +200,12 @@ enum AWCC_SPECIAL_THERMAL_CODES {
>   	AWCC_SPECIAL_PROFILE_GMODE		=3D 0xAB,
>   };
>
> +enum AWCC_TEMP_SENSOR_TYPES {
> +	AWCC_TEMP_SENSOR_CPU			=3D 0x01,
> +	AWCC_TEMP_SENSOR_GPU			=3D 0x06,
> +	AWCC_TEMP_SENSOR_LAST
> +};
> +
>   enum awcc_thermal_profile {
>   	AWCC_PROFILE_USTT_BALANCED,
>   	AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
> @@ -216,6 +242,15 @@ struct wmax_u32_args {
>   	u8 arg3;
>   };
>
> +struct awcc_fan_data {
> +	unsigned long *related_temps;
> +	unsigned long *auto_channels_temp;
> +	u32 total_temps;
> +	u32 min_rpm;
> +	u32 max_rpm;
> +	u8 id;
> +};
> +
>   struct awcc_priv {
>   	struct wmi_device *wdev;
>   	union {
> @@ -231,6 +266,11 @@ struct awcc_priv {
>
>   	struct device *ppdev;
>   	u8 supported_profiles[PLATFORM_PROFILE_LAST];
> +
> +	struct device *hwdev;
> +	struct awcc_fan_data **fan_data;
> +	unsigned int temp_sensors_size;
> +	unsigned long *temp_sensors;
>   };
>
>   static const enum platform_profile_option awcc_mode_to_platform_profil=
e[AWCC_PROFILE_LAST] =3D {
> @@ -495,6 +535,19 @@ static int __awcc_wmi_command(struct wmi_device *wd=
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
> @@ -552,6 +605,32 @@ static inline int awcc_op_get_resource_id(struct wm=
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
> +
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args=
, out);
> +}
> +
>   static inline int awcc_op_get_current_profile(struct wmi_device *wdev,=
 u32 *out)
>   {
>   	struct wmax_u32_args args =3D {
> @@ -599,6 +678,345 @@ static int awcc_profile_id_to_pprof(u32 id, enum p=
latform_profile_option *profil
>   	return 0;
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
> +		temp_count =3D bitmap_weight(priv->temp_sensors, priv->temp_sensors_s=
ize);
> +
> +		return channel < temp_count ? 0444 : 0;
> +	case hwmon_fan:
> +		return channel < priv->fan_count ? 0444 : 0;
> +	case hwmon_pwm:
> +		if (channel >=3D priv->fan_count)
> +			return 0;
> +
> +		switch (attr) {
> +		case hwmon_pwm_enable:

Please drop pwm_enable here and only introduce it inside the proper patch.

> +			return 0644;
> +		case hwmon_pwm_auto_channels_temp:
> +			return 0444;
> +		default:
> +			return 0;
> +		}
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
> +	struct awcc_fan_data *fan;
> +	u32 state;
> +	int ret;
> +	u8 temp;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		temp =3D find_nth_bit(priv->temp_sensors, priv->temp_sensors_size, ch=
annel);
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
> +			bitmap_copy(val, fan->auto_channels_temp, BITS_PER_LONG);
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
> +	struct awcc_fan_data *fan;
> +	u8 temp;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		temp =3D find_nth_bit(priv->temp_sensors, priv->temp_sensors_size, ch=
annel);
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
> +		fan =3D priv->fan_data[channel];
> +
> +		switch (fan->total_temps) {
> +		case 0:
> +			*str =3D "Independent Fan";
> +			break;
> +		case 1:
> +			temp =3D find_first_bit(fan->related_temps, priv->temp_sensors_size)=
;
> +
> +			switch (temp) {
> +			case AWCC_TEMP_SENSOR_CPU:
> +				*str =3D "Processor Fan";
> +				break;
> +			case AWCC_TEMP_SENSOR_GPU:
> +				*str =3D "Video Fan";
> +				break;
> +			default:
> +				*str =3D "Unknown Fan";
> +				break;
> +			}
> +
> +			break;
> +		default:
> +			*str =3D "Shared Fan";
> +			break;
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

Since the number of fans and temperature sensors is only known at runtime =
creating awcc_hwmon_info
would make sense.

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
> +	unsigned long temp_sensors[BITS_TO_LONGS(U8_MAX)];
> +	unsigned int i, max_sensor_id =3D 0;
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
> +		id =3D FIELD_GET(AWCC_RESOURCE_ID_MASK, id);
> +		if (id > max_sensor_id)
> +			max_sensor_id =3D id;
> +
> +		__set_bit(id, temp_sensors);
> +	}
> +
> +	/*
> +	 * We prefer to allocate the bitmap dynamically because usually temp I=
Ds
> +	 * are small (< 0x30) and only one UL is needed to store it, but there
> +	 * may be unknown devices that break this rule
> +	 */

Hi,

as far as i know the memory allocator inside the kernel at least allocates=
 32 bytes, so you are
not saving any memory with this. I suggest you allocate the bitmaps static=
ally.

> +	priv->temp_sensors_size =3D max_sensor_id + 1;
> +	priv->temp_sensors =3D devm_bitmap_zalloc(&wdev->dev, priv->temp_senso=
rs_size,
> +						GFP_KERNEL);
> +	if (!priv->temp_sensors)
> +		return -ENOMEM;
> +
> +	bitmap_copy(priv->temp_sensors, temp_sensors, priv->temp_sensors_size)=
;
> +
> +	return 0;
> +}
> +
> +static int awcc_hwmon_fans_init(struct wmi_device *wdev)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(&wdev->dev);
> +	u32 id, min_rpm, max_rpm, temp_count, temp_id;
> +	unsigned long gather[BITS_TO_LONGS(U8_MAX)];
> +	struct awcc_fan_data *fan_data;
> +	unsigned int i, j;
> +	int ret;
> +
> +	for (i =3D 0; i < priv->fan_count; i++) {
> +		fan_data =3D devm_kzalloc(&wdev->dev, sizeof(*fan_data), GFP_KERNEL);
> +		if (!fan_data)
> +			return -ENOMEM;
> +
> +		fan_data->related_temps =3D devm_bitmap_zalloc(&wdev->dev,
> +							     priv->temp_sensors_size,
> +							     GFP_KERNEL);

Same as above

> +		if (!priv->temp_sensors)
> +			return -ENOMEM;
> +
> +		fan_data->auto_channels_temp =3D devm_bitmap_zalloc(&wdev->dev,
> +								  priv->temp_count,
> +								  GFP_KERNEL);

We already know that we only ever use the first sizeof(long) bytes from th=
is bitmap,
please do a static allocation here.

> +		if (!priv->temp_sensors)
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
> +			if (temp_id < priv->temp_sensors_size)
> +				__set_bit(temp_id, fan_data->related_temps);
> +		}
> +
> +		fan_data->id =3D id;
> +		fan_data->min_rpm =3D min_rpm;
> +		fan_data->max_rpm =3D max_rpm;
> +		fan_data->total_temps =3D bitmap_weight(fan_data->related_temps,
> +						      priv->temp_sensors_size);
> +		bitmap_gather(gather, fan_data->related_temps, priv->temp_sensors,
> +			      priv->temp_sensors_size);

Since fan_data->related_temps is only used for determining the fan label a=
fter this it would
make sense to determine the fan label here and turn fan_data->related_temp=
s into a local
variable on the stack.

Thanks,
Armin Wolf

> +		bitmap_copy(fan_data->auto_channels_temp, gather, priv->temp_count);
> +		priv->fan_data[i] =3D fan_data;
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
> @@ -753,6 +1171,12 @@ static int alienware_awcc_setup(struct wmi_device =
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
> @@ -833,6 +1257,13 @@ int __init alienware_wmax_wmi_init(void)
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

