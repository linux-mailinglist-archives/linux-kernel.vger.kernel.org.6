Return-Path: <linux-kernel+bounces-516474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEACA3723C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 07:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E17F3AB21A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 06:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54964149E13;
	Sun, 16 Feb 2025 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="jTRmjJgA"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC2367;
	Sun, 16 Feb 2025 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739686040; cv=none; b=uJbx1naYcCoDx2EByO9GSLuFZuwqeg+1TXrtu6zLUpd60rl22ktjHSCEzj2lLVGKbMaiIug57tOvTHKOZa9zr1tNRrp0+GIgNln2rRvCKapC2b42dmkBXda5nxAZDFIdWBBFV7tTPW9XGMbWEgrYtYX+jXWM9nNZ9zm7dfi01K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739686040; c=relaxed/simple;
	bh=SvfroqpxEdLgT/MAxjl4e2drSM3DeYJ4hj5t0fLt0yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKRDwbCc0KG/5qP4/n/3OB/kdL444DXv6uz12ZPjNi2iJfiQBLWYE9FnQMD6e6CJlSNbNK2weqMhNKlMjAAd3diC0szv0llkQ8TI+UwyGjE7xY8btdd56Adf70qLOBsbO7OhkqKFGaohawjlsiOWGaXZNlzz71qC2bhQyypNB1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=jTRmjJgA; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739686015; x=1740290815; i=w_armin@gmx.de;
	bh=SJ9r+4HvStHJe7jMaw7hV5eAncTpWFpEM56o93dv+a0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jTRmjJgA25aTEkynPig9JKfxT/6/yJB2ReMZBgBjyGZjuC84QdYtbW4brkOY8SiL
	 h6p7L9dBDJSNRvK+cRtEknZLu1OGRzgJbY1UhB61N1oPUvtpNlftECgSjB7HAI3fT
	 hxVm8WLx2Fs4NYYnF3uzKyIehEJSWVABaJNDNXLG7w5GkFU8+UzhC8BeJelPtkxHW
	 fYshHBSKm1o1LTG6gimerRGZcyqKHffSlE7sjZfm7vRuKathMYQWUFqmFAytirkGo
	 B1cc7KY+NyTWj7wUqso4C19cbMMptepCrPCDksA3hniXWl8OWQWyqmNkZBskMfHqX
	 6IyS+fm4e9nk2JFFzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLiCo-1u1DB90Bns-00Opo4; Sun, 16
 Feb 2025 07:06:55 +0100
Message-ID: <c8120567-eb9b-49e1-aedd-cf1aed90e2d7@gmx.de>
Date: Sun, 16 Feb 2025 07:06:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] platform/x86: alienware-wmi-wmax: Add HWMON support
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>
References: <20250208051614.10644-1-kuurtb@gmail.com>
 <20250208051614.10644-8-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250208051614.10644-8-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e9J8S4bNrJCFB6y0CSM98IlfeQSfqgdC2oNdgpyYyIzlHUL5/N7
 rxXmjJVGXdBELYisKhSQ1bjDWz7/QZkBYhjbd5dndAVnEmEXA5b6tIZryGXc/qzdvpubV7G
 SX2WF76tvtUGP3kUTKgZ+BbPvdiEU02PWKb9cWBFmwPtODe7asVVFrusGrZbaHJMVNHBpW9
 rzdzzJ2VNOiAAUMMnkn7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L1AeOLeS7SU=;5hYAkhGv+/0J7RhvJNN6BDzpL15
 SqRvqEyjL64OlcYqx9sb0hr+J2dnkzRZZDRBIFfmpQ7fIB9rbOVmnDFuc6zSYz95TpbaKmKJn
 F1bgT8ZRTmla/i7dFBqAqzsxL4CQRwD+VXN+7yinuWOuBquot86sYXmP2vmWK8IfhPMPj6GAI
 +wb2xIkc3m5eagdYP7XaRRzLZ9HOAo6i6tRTHQ9RRrvwb4W1B9Qa3vnp3tIJEZLMIbnL1Ci32
 7emlfpVnRTo4odD4eF5n5JYjL9WfVpuKHFLmMekP9E2gv6enURl0135sF3CXwKXvEsswiDeDH
 mHsrQqAowGvui5C8v7+1YbwOJIyxsoSHWQ5dpCRQh+IX9bxi5DOb9JABTrYgJn8cchil1qEnK
 ZWuAluHi/nQlNCbiJUEgEdr+9hkZywI8JzGPJiTpPMR7Vh0GE/9WYOtTadiP0AqlU63Ce6BQp
 aGMe0yg5viwp6TmF4zBzXxWk4ylN9Opc6DWHGXnoblkLturNRxDWYZiXsnWhMiG3UMoo9QCs8
 HzPHxfQwORQPGVfqaj51KVemiUaYbL/tiF5bRhQrLNr0VyIyyngehEH3v+1Wu4lbZuw9WK0Rn
 6Io1BZn2xpIQkA5hEQUCqkXtctT9mQtRXRPZ0tQqwVkGVIEN82tm4TjWPRa0rA7W7xJm634FN
 LvyV14f9/PweiC+hDho8X0+y/gVOhixCMP86tviNEx84xcx4LoksR6ZkOn8FfTWtcf+C4l80Q
 i+V2jM7GnzCac6eFYXuwk/cQLsT8suIOX7cWD3JVsWAGZ70irUVLeODTELNP9zNSG13cTdnGm
 8Z1L9lb9iUqH9OOeKNA3aKzx2o2fIolWIv9i7bjs1rmmYr6weGyGSELiodspqoKjgrUg4vZQc
 Bym65b28AKzFXm3ErwJrLv5Lhpq15Tc2qmGHxX5kIKXSlwfFI3I6rHRz00by2sADa3xettc7z
 7+UtdDTOO7EzfIkVvRh2Fc6xgkmlv8f+J2XMUqki8TenYo+xEMl/Y58am8+OZUc927knH3xpJ
 jfN2Y97FuTwecq47hYZdOoiw2rF/auqW730y3iLdAq8PtcY3c6E8/XHdxP0bPacgdae7DOQWR
 GdLTmoHQIz8dCnaeSQii+FcjV3DUohHYgQg0gz0aMJ0H3cD5tuRbz5yS9HZf17AvJNWRC0BT1
 Al8v652Xs4ZR5ikIpH+dyb/VcuK7j2mh0BKBEKazYSS4J0wjNCspf/U6n2UfoZN33qmghEWT4
 QTkppQ7o1FT2YneMXIzosB+y5yWT/mcIYQkAhB3ZHXnTOlz0mHjJF9ImU/EyN2D3aI5Fn76Eh
 vBCTOzECC/denH6JHqWf/wmiHvCHxhZ5j2iTi1GeeSSMbl0LFtLQjr4a9s+U9iEEZAIWJGBxM
 Sc1AFU6Ht/8fnNx5wIK54YmBoF5KAtaZLEdUjy+9BQul2/4HBfscjaPvC8

Am 08.02.25 um 06:16 schrieb Kurt Borja:

> All models with the "AWCC" WMAX device support monitoring fan speed and
> temperature sensors. Expose this feature through the HWMON interface.
>
> Sensor readings are cached for 1 second before refreshing them to
> mitigate the performance cost of calling WMI methods.

Since each fan can be accessed independently, i do not think that the cach=
ing is actually
needed here.

The dell-wmi-ddv driver only uses caching because it can only read all fan=
 sensors
at the same time, which means each call is quite expensive. The AWCC inter=
face however
seems to allow access to each individual fan, so each call should be quite=
 cheap (for
a WMI method call).

Do you know of a device which has such slow WMI calls? If not then i sugge=
st you remove
the caching.

> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/Kconfig             |   1 +
>   .../platform/x86/dell/alienware-wmi-wmax.c    | 341 ++++++++++++++++++
>   2 files changed, 342 insertions(+)
>
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/de=
ll/Kconfig
> index f8a0dffcaab7..85a57c01aaad 100644
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
> index 0d31156f43bb..5f02da7ff25f 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -11,9 +11,13 @@
>   #include <linux/bitfield.h>
>   #include <linux/bits.h>
>   #include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/jiffies.h>
>   #include <linux/moduleparam.h>
> +#include <linux/mutex.h>
>   #include <linux/overflow.h>
>   #include <linux/platform_profile.h>
> +#include <linux/units.h>
>   #include <linux/wmi.h>
>   #include "alienware-wmi.h"
>
> @@ -26,6 +30,7 @@
>   #define WMAX_METHOD_BRIGHTNESS			0x3
>   #define WMAX_METHOD_ZONE_CONTROL		0x4
>
> +#define AWCC_METHOD_GET_FAN_SENSORS		0x13
>   #define AWCC_METHOD_THERMAL_INFORMATION		0x14
>   #define AWCC_METHOD_THERMAL_CONTROL		0x15
>   #define AWCC_METHOD_GAME_SHIFT_STATUS		0x25
> @@ -36,6 +41,10 @@
>   #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
>   #define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
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
> @@ -45,16 +54,19 @@ module_param_unsafe(force_gmode, bool, 0);
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
> @@ -152,9 +164,17 @@ static const struct dmi_system_id awcc_dmi_table[] =
__initconst =3D {
>   	},
>   };
>
> +enum AWCC_GET_FAN_SENSORS_OPERATIONS {
> +	AWCC_OP_GET_TEMP_SENSOR_ID		=3D 0x02,
> +};
> +
>   enum AWCC_THERMAL_INFORMATION_OPERATIONS {
>   	AWCC_OP_GET_SYSTEM_DESCRIPTION		=3D 0x02,
>   	AWCC_OP_GET_RESOURCE_ID			=3D 0x03,
> +	AWCC_OP_GET_TEMPERATURE			=3D 0x04,
> +	AWCC_OP_GET_CURRENT_RPM			=3D 0x05,
> +	AWCC_OP_GET_MIN_RPM			=3D 0x08,
> +	AWCC_OP_GET_MAX_RPM			=3D 0x09,
>   	AWCC_OP_GET_CURRENT_PROFILE		=3D 0x0B,
>   };
>
> @@ -177,6 +197,11 @@ enum AWCC_SPECIAL_THERMAL_CODES {
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
> @@ -213,6 +238,23 @@ struct wmax_u32_args {
>   	u8 arg3;
>   } __packed;
>
> +struct awcc_fan_channel_data {
> +	u8 id;
> +	u32 state;
> +	u32 min_rpm;
> +	u32 max_rpm;
> +	u8 temp_sensor;
> +	u64 timestamp;
> +	struct mutex lock; /* protects state and timestamp */
> +};
> +
> +struct awcc_temp_channel_data {
> +	u8 id;
> +	u32 state;
> +	u64 timestamp;
> +	struct mutex lock; /* protects state and timestamp */
> +};
> +
>   struct awcc_priv {
>   	struct wmi_device *wdev;
>   	union {
> @@ -228,6 +270,10 @@ struct awcc_priv {
>
>   	struct device *ppdev;
>   	u8 supported_profiles[PLATFORM_PROFILE_LAST];
> +
> +	struct device *hwdev;
> +	struct awcc_temp_channel_data *temp_data;
> +	struct awcc_fan_channel_data *fan_data;
>   };
>
>   static const enum platform_profile_option awcc_mode_to_platform_profil=
e[AWCC_PROFILE_LAST] =3D {
> @@ -492,6 +538,18 @@ static int __awcc_wmi_command(struct wmi_device *wd=
ev, u32 method_id,
>   	return 0;
>   }
>
> +static inline int awcc_get_fan_sensors(struct wmi_device *wdev, u8 fan_=
id, u32 *out)
> +{
> +	struct wmax_u32_args args =3D {
> +		.operation =3D AWCC_OP_GET_TEMP_SENSOR_ID,
> +		.arg1 =3D fan_id,
> +		.arg2 =3D 0,
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
> @@ -562,6 +620,276 @@ static inline int awcc_op_get_resource_id(struct w=
mi_device *wdev, u8 index, u32
>   	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &arg=
s, out);
>   }
>
> +/*
> + * HWMON
> + *  - Provides temperature and fan speed monitoring as well as manual f=
an
> + *    control
> + */
> +static int awcc_hwmon_update_temp(struct wmi_device *wdev,
> +				  struct awcc_temp_channel_data *data)
> +{
> +	u32 temp;
> +	int ret;
> +
> +	lockdep_assert_held(data->lock);
> +
> +	if (time_is_after_jiffies64(data->timestamp + secs_to_jiffies(1)))
> +		return 0;
> +
> +	ret =3D awcc_thermal_information(wdev, AWCC_OP_GET_TEMPERATURE, data->=
id,
> +				       &temp);
> +	if (ret)
> +		return ret;
> +
> +	data->state =3D temp * MILLIDEGREE_PER_DEGREE;
> +	data->timestamp =3D get_jiffies_64();
> +
> +	return 0;
> +}
> +
> +static int awcc_hwmon_update_fan(struct wmi_device *wdev,
> +				 struct awcc_fan_channel_data *data)
> +{
> +	u32 rpm;
> +	int ret;
> +
> +	lockdep_assert_held(data->lock);
> +
> +	if (time_is_after_jiffies64(data->timestamp + secs_to_jiffies(1)))
> +		return 0;
> +
> +	ret =3D awcc_thermal_information(wdev, AWCC_OP_GET_CURRENT_RPM, data->=
id,
> +				       &rpm);
> +	if (ret)
> +		return ret;
> +
> +	data->state =3D rpm;
> +	data->timestamp =3D get_jiffies_64();
> +
> +	return 0;
> +}
> +
> +static umode_t awcc_hwmon_is_visible(const void *drvdata, enum hwmon_se=
nsor_types type,
> +				     u32 attr, int channel)
> +{
> +	const struct awcc_priv *priv =3D drvdata;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		if (channel < priv->temp_count)
> +			return 0444;
> +
> +		break;
> +	case hwmon_fan:
> +		if (channel < priv->fan_count)
> +			return 0444;
> +
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int awcc_hwmon_read(struct device *dev, enum hwmon_sensor_types =
type,
> +			   u32 attr, int channel, long *val)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +	struct awcc_temp_channel_data *temp;
> +	struct awcc_fan_channel_data *fan;
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		temp =3D &priv->temp_data[channel];
> +
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			mutex_lock(&temp->lock);
> +			ret =3D awcc_hwmon_update_temp(priv->wdev, temp);
> +			mutex_unlock(&temp->lock);
> +			if (ret)
> +				return ret;
> +
> +			*val =3D temp->state;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +		break;
> +	case hwmon_fan:
> +		fan =3D &priv->fan_data[channel];
> +
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			mutex_lock(&fan->lock);
> +			ret =3D awcc_hwmon_update_fan(priv->wdev, fan);
> +			mutex_unlock(&fan->lock);
> +			if (ret)
> +				return ret;
> +
> +			*val =3D fan->state;
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
> +	u8 temp_id;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		temp_id =3D priv->temp_data[channel].id;
> +
> +		switch (temp_id) {
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
> +		temp_id =3D priv->fan_data[channel].temp_sensor;
> +
> +		switch (temp_id) {
> +		case AWCC_TEMP_SENSOR_CPU:
> +			*str =3D "Processor Fan";
> +			break;
> +		case AWCC_TEMP_SENSOR_GPU:
> +			*str =3D "Video Fan";
> +			break;
> +		default:
> +			*str =3D "Unknown Fan";
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
> +			   HWMON_T_LABEL | HWMON_T_INPUT
> +			   ),
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX
> +			   ),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info awcc_hwmon_chip_info =3D {
> +	.ops =3D &awcc_hwmon_ops,
> +	.info =3D awcc_hwmon_info,
> +};
> +
> +static int awcc_hwmon_init(struct wmi_device *wdev)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(&wdev->dev);
> +	u32 id, temp_sensor, min_rpm, max_rpm;
> +	int ret;
> +
> +	priv->fan_data =3D devm_kcalloc(&wdev->dev, priv->fan_count,
> +				      sizeof(*priv->fan_data), GFP_KERNEL);
> +	if (!priv->fan_data)
> +		return -ENOMEM;
> +
> +	priv->temp_data =3D devm_kcalloc(&wdev->dev, priv->temp_count,
> +				       sizeof(*priv->temp_data), GFP_KERNEL);
> +	if (!priv->temp_data)
> +		return -ENOMEM;
> +
> +	for (u32 i =3D 0; i < priv->fan_count; i++) {
> +		/*
> +		 * Fan IDs are listed first at offset 0
> +		 */
> +		ret =3D awcc_op_get_resource_id(wdev, i, &id);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D awcc_thermal_information(wdev, AWCC_OP_GET_MIN_RPM, id,
> +					       &min_rpm);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D awcc_thermal_information(wdev, AWCC_OP_GET_MAX_RPM, id,
> +					       &max_rpm);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D awcc_get_fan_sensors(wdev, id, &temp_sensor);
> +		if (ret)
> +			return ret;
> +
> +		priv->fan_data[i].id =3D FIELD_GET(AWCC_RESOURCE_ID_MASK, id);
> +		priv->fan_data[i].min_rpm =3D min_rpm;
> +		priv->fan_data[i].max_rpm =3D max_rpm;
> +		priv->fan_data[i].temp_sensor =3D temp_sensor;
> +		ret =3D devm_mutex_init(&wdev->dev, &priv->fan_data[i].lock);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (u32 i =3D 0; i < priv->temp_count; i++) {
> +		/*
> +		 * Temperature sensors IDs are listed after the fan IDs at
> +		 * offset `fan_count`
> +		 */
> +		ret =3D awcc_op_get_resource_id(wdev, i + priv->fan_count, &id);
> +		if (ret)
> +			return ret;
> +
> +		priv->temp_data[i].id =3D FIELD_GET(AWCC_RESOURCE_ID_MASK, id);
> +		ret =3D devm_mutex_init(&wdev->dev, &priv->temp_data[i].lock);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	priv->hwdev =3D devm_hwmon_device_register_with_info(
> +		&wdev->dev, "alienware_wmi", priv, &awcc_hwmon_chip_info, NULL);

checkpatch says "CHECK: Lines should not end with a '('". Please fix this.

Other than that the code looks promising.

Thanks,
Armin Wolf

> +
> +	return PTR_ERR_OR_ZERO(priv->hwdev);
> +}
> +
>   /*
>    * Thermal Profile control
>    *  - Provides thermal profile control through the Platform Profile AP=
I
> @@ -734,6 +1062,12 @@ static int alienware_awcc_setup(struct wmi_device =
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
> @@ -814,6 +1148,13 @@ int __init alienware_wmax_wmi_init(void)
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

