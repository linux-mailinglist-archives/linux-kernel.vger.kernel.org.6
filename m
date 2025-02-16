Return-Path: <linux-kernel+bounces-516476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14AAA37241
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 07:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B4127A1F80
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 06:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B99914A4DF;
	Sun, 16 Feb 2025 06:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="akPJbced"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB66C151990;
	Sun, 16 Feb 2025 06:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739686338; cv=none; b=oCawtAAXOBtQlLWEVy7wnlqjShCIoYO5Q9GwG3/+/0rYjjr02jTA5yGpKUxsTibQYNeDVZdzLry6rjm6fVYQTcsc732HSVF3vVSe81GTThhByouh15SWFAMHHXns4OQVR975FVe1N3YI+qXaQKDxcJjK+TgQfn0HsEpRYmt0XEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739686338; c=relaxed/simple;
	bh=/N8YG/jy/wmsmYyKRAEu2kWRya/dLerbeIMcYd9rahQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otiRGBb+7z/+CLqy3BGqjHcrdwvAydkwG2BFa4U0OG//gswCimhCW40ITQ37LzsNE0o253OOfLgc9FZJyGRT/8/hMza4xE7Il6ATLUdNeIAPKlLkOeV0uIKkX4tQ+091JEh9MQqlw9zJ7SY71hvS+JYAiGtm9G0iywHCvg6swDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=akPJbced; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739686334; x=1740291134; i=w_armin@gmx.de;
	bh=9fD0exKNYvwCSbTMLX9oPr/l3I7ISL1YWb+JfxBCxpw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=akPJbcedbmK1759O1DK9SKsP2Pmr2CeiFsrZtPevTlks4dce23070BFJsUtgHTQB
	 DEHlLKb4kF6ev4nEbJvtAnGx2P7/zN6dRgVn5vTi7SoL6rn0Utqo8AD74NVpLfeeT
	 djJ+jWxLO+pIISSkYyvhZcQuey6gBfDhvVx4qqXQN5HjUHEaffhvPf7me/3uA9ids
	 D8eZ1hO5kBBhQGIXeW6dRcc3rBzaQbgTUnfrraSthyYgJKwvmHnlScvEuNpsPvMgN
	 +IMR3yPERJKwRrSQ0pdkFVJ7x0/7JnqACC7i21TJf1+Ck32R344UTE16sVEPecEB8
	 7OR/JVBcBfdUFWF0Mw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Ue3-1th5yG3qYb-003QRu; Sun, 16
 Feb 2025 07:12:14 +0100
Message-ID: <ee2a8428-0c37-408d-9ad2-a8975c1b3c23@gmx.de>
Date: Sun, 16 Feb 2025 07:12:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] platform/x86: alienware-wmi-wmax: Add support for
 manual fan control
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>
References: <20250208051614.10644-1-kuurtb@gmail.com>
 <20250208051614.10644-9-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250208051614.10644-9-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NdQOpXmVcP4xD8jZV+UrfalgiuhGLS4iAtB76uIQnkeNMUUP4hq
 8C5rZbqdsVy2ViZgmDthjr8yLeVExvpuL0BrTaAoJCul5TwOICWJAbI7zzSiaDKKUskrthx
 EAIjxftLYUQ1uluIuoOkdVjHtTMr6BHFR/yn2NlilRQK+VGJ0n5drkv2/yBjlyjbG+P4TZE
 Gq7GQliJN46DVA9O7DtYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ONgkAQcelkw=;/waKdXfm5Zj6YjM4f8SuRaRBiei
 bMVWT/f2sowAo8xI/3ShEm06ZAJxTfYaugcKa2wowbbs1z8BkBGDKVcSDZCekmcveaRUx7tSZ
 gy8y7WnkzjSykaZxcwIUckiyDLwLpf/7ITbcerEZVI5V/1CiAEqL1WaH64mxhMhZAN1W7vxo/
 N6e4pT4TeyRkWdWW0RbtlnpJQL719EAtt6P9VOGtocYcjZS6T+r1Y19n5yUpVt8nDvM0QHaEl
 jmGIlAUd0Se7sZowFSiwtbYV1f9v/+OqSccILFZr4PZymAWOqUvBPci7Y5ts7nGsRBRJTzAyw
 gFhaj9rWsIF4jbtxGfrAJXBcIjlaDeOsk/505abIyta5clL6ZWDhJ7jFP/bp54teIo1SXQnhZ
 TIhiyNd6BmTrcykMPAZoG6zN7PJe7KD00fWLXCG2+rAYqJYjchGgD18LEnG9E2mRtnVkcXssw
 Qt0lfscWSo4HxrSECfL62JATpdCLGgetofKfgAGeAcwBQXhN3k0r4m+JViPoN9PApSEASFixr
 yudMZJxcIVb4SMzzFiO7GEwkcbXTrrSj1A0HCVci7AVY2bRVotB06e5ven244n4uWa6yKgCGl
 6unrbqg4JablV/S4XdnMEM1h8U5lMGhwLyOuTvg0/07iJbH3ZkD9qkQR9ZQCrpXKO2xr5QyyV
 QCsrYPVFex9AN7ExN9duRiX3z/WT0zg650F5MFEmAIeicRlcUk8g11ooiZ6gunMVsMFnP+8Tw
 9NxEsG8jdqr3fvE/3Ax9HHffofEgbxrqOdN+UoNlziT0LChiwlGP5m/i6EZiIAeL8Vry5iRpo
 Iae0H77lYFltTdnOaSUO+v6bzjm9JwKSVrG5siNRSXFqhXucLBmc1R12/+5aL0kMY95KdwUBF
 zzjnKlLer89TPHifPybY7ms36DMwesBrJzAj1ap8B6AZhiM+nJSKlOY+D4G+ouPcCFbdpkjKR
 FWAgduGDuUeDR11Pfy+6Fo4ZaAxCwQ8VJ5IJrvUNtsv6v2ncKnjjhDgHdb8z/i8hmLSZo91N0
 hVHlQyxOeXTaQxBlNVR9jN/DjwmELxGWOhOZHcJtRepZ0k1FfZLGoNXhhl1PMnXMWZeC0lmJ/
 KZa1U9ACJRdB95lG+7xN+X3wv/4y5gaiiFBiePj6q41VH0rjxhfS/lKjxDNkUsDPFeqcfo71v
 nUdVNaqlaPaYQBvG3puMiurKikzkA6apTSshfSlIGNmbqPZ95XPIToBLwWE9Tg+BQzQQDmTpE
 iRJBJuiqbOSB+y0EbSWdtnLfUT/+mzE40u2O8zM4TE0DmR3PeUT3P14S/vaSaq8QOXst2DXrZ
 r8xXIUtVm/Um6ySAoZFH835hsYhz1V4OgJHKEefBBXm48wmDV3CDnEMXu4PKmRVvbeD+XiZTQ
 EyHK8JEA2Iveq31x6rATw/4/h7e735CIEvgYCl7teBqMronibFQq6nVz0U

Am 08.02.25 um 06:16 schrieb Kurt Borja:

> All models with the "AWCC" WMAX device support a way of manually
> controlling fans.
>
> The PWM duty cycle of a fan can't be controlled directly. Instead the
> AWCC interface let's us tune a PWM `boost` value, which has the
> following empirically discovered behavior over the PWM value:
>
> 	pwm =3D pwm_base + (pwm_boost / 255) * (pwm_max - pwm_base)
>
> Where the pwm_base is the locked PWM value controlled by the EC and
> pwm_boost is a value between 0 and 255.
>
> This pwm_boost knob is exposed as a standard `pwm` attribute.

I am not sure if exposing this over the standard "pwm" attribute is correc=
t here,
since userspace applications expect to have full access to the fan when us=
ing the
"pwm" attribute.

Maybe using a custom attribute like "fanX_boost" would make sense here? Ei=
ther way
documenting this special behavior would be nice for future users, maybe yo=
u can write
this down under Documentation/admin-guide/laptops?

Thanks,
Armin Wolf

> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   .../platform/x86/dell/alienware-wmi-wmax.c    | 55 +++++++++++++++++--
>   1 file changed, 49 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
> index 5f02da7ff25f..06d6f88ea54b 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -13,6 +13,7 @@
>   #include <linux/dmi.h>
>   #include <linux/hwmon.h>
>   #include <linux/jiffies.h>
> +#include <linux/minmax.h>
>   #include <linux/moduleparam.h>
>   #include <linux/mutex.h>
>   #include <linux/overflow.h>
> @@ -176,10 +177,12 @@ enum AWCC_THERMAL_INFORMATION_OPERATIONS {
>   	AWCC_OP_GET_MIN_RPM			=3D 0x08,
>   	AWCC_OP_GET_MAX_RPM			=3D 0x09,
>   	AWCC_OP_GET_CURRENT_PROFILE		=3D 0x0B,
> +	AWCC_OP_GET_FAN_BOOST			=3D 0x0C,
>   };
>
>   enum AWCC_THERMAL_CONTROL_OPERATIONS {
>   	AWCC_OP_ACTIVATE_PROFILE		=3D 0x01,
> +	AWCC_OP_SET_FAN_BOOST			=3D 0x02,
>   };
>
>   enum AWCC_GAME_SHIFT_STATUS_OPERATIONS {
> @@ -563,12 +566,13 @@ static inline int awcc_thermal_information(struct =
wmi_device *wdev, u8 operation
>   	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &arg=
s, out);
>   }
>
> -static inline int awcc_thermal_control(struct wmi_device *wdev, u8 prof=
ile)
> +static inline int awcc_thermal_control(struct wmi_device *wdev, u8 oper=
ation,
> +				       u8 arg1, u8 arg2)
>   {
>   	struct wmax_u32_args args =3D {
> -		.operation =3D AWCC_OP_ACTIVATE_PROFILE,
> -		.arg1 =3D profile,
> -		.arg2 =3D 0,
> +		.operation =3D operation,
> +		.arg1 =3D arg1,
> +		.arg2 =3D arg2,
>   		.arg3 =3D 0,
>   	};
>   	u32 out;
> @@ -684,6 +688,11 @@ static umode_t awcc_hwmon_is_visible(const void *dr=
vdata, enum hwmon_sensor_type
>   		if (channel < priv->fan_count)
>   			return 0444;
>
> +		break;
> +	case hwmon_pwm:
> +		if (channel < priv->fan_count)
> +			return 0644;
> +
>   		break;
>   	default:
>   		break;
> @@ -698,6 +707,7 @@ static int awcc_hwmon_read(struct device *dev, enum =
hwmon_sensor_types type,
>   	struct awcc_priv *priv =3D dev_get_drvdata(dev);
>   	struct awcc_temp_channel_data *temp;
>   	struct awcc_fan_channel_data *fan;
> +	u32 fan_boost;
>   	int ret;
>
>   	switch (type) {
> @@ -742,6 +752,16 @@ static int awcc_hwmon_read(struct device *dev, enum=
 hwmon_sensor_types type,
>   			return -EOPNOTSUPP;
>   		}
>
> +		break;
> +	case hwmon_pwm:
> +		fan =3D &priv->fan_data[channel];
> +
> +		ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_FAN_BOOST,
> +					       fan->id, &fan_boost);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D fan_boost;
>   		break;
>   	default:
>   		return -EOPNOTSUPP;
> @@ -796,10 +816,27 @@ static int awcc_hwmon_read_string(struct device *d=
ev, enum hwmon_sensor_types ty
>   	return 0;
>   }
>
> +
> +static int awcc_hwmon_write(struct device *dev, enum hwmon_sensor_types=
 type,
> +			    u32 attr, int channel, long val)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +	u8 fan_id =3D priv->fan_data[channel].id;
> +
> +	switch (type) {
> +	case hwmon_pwm:
> +		return awcc_thermal_control(priv->wdev, AWCC_OP_SET_FAN_BOOST,
> +					    fan_id, (u8)clamp_val(val, 0, 255));
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>   static const struct hwmon_ops awcc_hwmon_ops =3D {
>   	.is_visible =3D awcc_hwmon_is_visible,
>   	.read =3D awcc_hwmon_read,
>   	.read_string =3D awcc_hwmon_read_string,
> +	.write =3D awcc_hwmon_write,
>   };
>
>   static const struct hwmon_channel_info * const awcc_hwmon_info[] =3D {
> @@ -814,6 +851,12 @@ static const struct hwmon_channel_info * const awcc=
_hwmon_info[] =3D {
>   			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>   			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX
>   			   ),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT
> +			   ),
>   	NULL
>   };
>
> @@ -954,8 +997,8 @@ static int awcc_platform_profile_set(struct device *=
dev,
>   		}
>   	}
>
> -	return awcc_thermal_control(priv->wdev,
> -				    priv->supported_profiles[profile]);
> +	return awcc_thermal_control(priv->wdev, AWCC_OP_ACTIVATE_PROFILE,
> +				    priv->supported_profiles[profile], 0);
>   }
>
>   static int awcc_platform_profile_probe(void *drvdata, unsigned long *c=
hoices)

