Return-Path: <linux-kernel+bounces-550012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1E0A559E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91013B1EF7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EA927CB13;
	Thu,  6 Mar 2025 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ZOIweNiA"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767661F4185;
	Thu,  6 Mar 2025 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300569; cv=none; b=I30ojXr11KDdG+9Sz8LiT5rF/dgpvLvfac3pKJaZ7DNZQ0uYviXwURtZM+UcZ5wvvcqwcpwSuB+O4+FXMKnFyd+XTG8kSoJbLgpyi64ojc7T2db5TBb5ln9cr5fjK7I0UBcHVN7uMXI7ZpHyF8ltAQAY8RF9tOZUuIKv9dc6HmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300569; c=relaxed/simple;
	bh=BMYUyATBUXacJRYPd2sAv/PbG8GVt824s28XdcvWz78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sH3stte/E7jlVAsPGqhO72rc/mxUVBgQEgz71dk8PWlBG0LSn+BaO1E5kzkakGvk5GjRqlnFEXNTGV7xb/bp3PyybXmqva8LCKwlsX1A3ZnL1XpvzqnU7LHw39fW55giUWXIvOA+kS3wftib79hvlzGUH39Fpaw9hKREKcevSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ZOIweNiA; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741300542; x=1741905342; i=w_armin@gmx.de;
	bh=tp3wwbn04QBRfdsHIlaUft4QInDaZPMcZACWnCaoHlo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZOIweNiA9jTip2JHNbVRlOHDKuYZB5uBuKO0ol9rfD4ZMy0kAAEdLC/LD8c/rM+O
	 bwgWNmkk8lPDfSxhRngSwWoKAG8v58nSteEgpp+1/6eXSUHXbmf+S6+Kq3tV8vVvD
	 ZVKcHPlHAaYWTue4OFgKGltCi6rfhJSlxAJTzMTkBQglTqDJFLJHhUjoAZk5b8qQY
	 P/1baijZyWi4TcKz+SeSXvRLbWph0bjx+k5Vg2s7tHK0NUdrK5zURJg2wHkbFbrPP
	 d90jeB7D4lT7R8Yxfu803l/8Nrlzj0W9GZWb5HsJVEiCj/n1u9g5vp9QNWsuJtMQM
	 ukIrtsk02GOpTTABvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4zAy-1t9b9G0Vgy-00wNmx; Thu, 06
 Mar 2025 23:35:42 +0100
Message-ID: <e8a44866-602c-47bb-8b11-7ba59c3d346f@gmx.de>
Date: Thu, 6 Mar 2025 23:35:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] platform/x86: alienware-wmi-wmax: Add support
 for manual fan control
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 linux-hwmon@vger.kernel.org
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
 <20250305-hwm-v3-8-395e7a1407e2@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250305-hwm-v3-8-395e7a1407e2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u6FzxdXHcKi5n6zovbYpb29yWMLjzRkGhNZaWXRJaYUFgRr5led
 4z4c6HWSozOtpAD5seUd7z9hUCcg65+T3QyijUJxV7tDLTbp+61wyrtIy0S/Pz4S3z1bAdh
 9ZLpG0Ojj1QV9ba6ssIPW7cKlzVBxz3BIduwQHwOLNVc4YLwUQAuKlGTANk+RYgDFf441VS
 X5gqDIaGOju3ogVblogrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jbwxwCexvn4=;rO+CDoL3AJS4B/22aPQBqIKlPK0
 I4JrFflCJ5OyodqigV3md9X8tdzaVMGWiapOearOihlAYRZmZLjJn3uR3Gh6NfDxG9zPG2pBy
 nzlWCSnpSkUbep22GLsYIPNadwcHs46TGrtzSz5MkRYALUXU2JUFgyJUlkRtHKScG6BcF9m8s
 +DoFJJngVk2e/1Xgm73D70JN6fVEzyxMfsQM8yCKNHsMdDe7WrlyucmnmqNNhhAxFbKXTdGlS
 JpcSmVe0lFTI11jHq4mxs9gxxeuJUNF+pXlLT0msEKmxYujU0U7yRIDM5ZLR+/KOJ5oE7Gn2G
 EIlEb7F6HqYXerGZd8VZkpVduJev+soDZTOsTmShOqxCvL4rq8NETiNduaAYL5uyL/l9B2wg9
 zfICMY9Dur83oU5d9dZaOXwo4ON1QmzgJ4b4zxvwu1Db9NgMhUUas3iMqrDZ9NRhs4TQhWZGM
 oG9t0DbPUyAzsflqsmaSCy6+Kd6bwo3RpiKYej74cZOSH/lmQA6DuAqzRONhPksnPJ2W0y6Eh
 ROwBDsTClfmzPKjwEdIJdjxoiCcx1omZBZ6mzi5pW/T8+l0f12xSFKw4seIgOCRHYxwhh+/Ch
 B4T5Tf39Kq9jjEgT/8hqNefJWnuwIfDkubSrtvZ80rdru1Wb1r1VVadrKK50gphnBnSc+Wtiq
 obssw5mY/BksEM/SQXSFt+MLW/JhG16MiMvPHG6gIc+KdprTbEeHbXYk3M5ZozuL64I5VeAPK
 PENg7C7/7ZuMsp8B6kBpLXoOsk4I3lwZz/mdj/xE/Jyvv9hT/BsSfKdmztuIEtG1yBvEwQ3t7
 LvHxvPd2mZBSDXmYHYkRQZGhhnUYlcjLzE55yU1Qu3Fc3H3YezEZ3Cy3uFKwNhn5eHAUy7+5H
 fdX2M2C1rcJLi8ZqvKstpPMv2zuvkul/OeIMIWLDJuhB6bW6EsBLNgaWWZKV5MSyrLmsybXtm
 N/gBD1Fa68XASp/9giaucRBR89NxFHoXXg2xIToQcOcSKOvqqf3maaei3/SsIntIF6MxNbz0n
 kreqmnQhj4+l7eBrJe0qV+TSva++j9kE84af9jCiAG6REqmiC0CSUL0hshoTu8zlZtQndb87Y
 ViAfMxhgiT0OCeU7Gb9uHqGG5BuU9Gj/7Axtto+7FX10wzjl6NAmhnX2U71mB591lgUHZCpuU
 NDIZauooGLEb8MAweskioyPu6t+b3WDfkoBkaBflxZ5DQfbHARBfFBdW7rS6s7fJLecZhAEq/
 SPKp6HKmlLyLTFGEWvyKz54E/8oi7lgCGgba0924e6BoRPh7nTnQtNJatkKuFGgiXlXedY8a4
 sMVDnztaCmmoiA0m7vhanQohpb1QM1oeIeMVNcGa29JyLGGbe7lShHa7VZ2yRYt1Xn0crku6x
 y7rgb9lyFgX8Fqf9eXJ6Uxp+LKqLc0LI3q1MdZ8n0Lsogm3W+Ozw0DDL1u

Am 06.03.25 um 01:56 schrieb Kurt Borja:

> All models with the "AWCC" WMAX device support a way of manually
> controlling fans.
>
> The PWM duty cycle of a fan can't be controlled directly. Instead the
> AWCC interface let's us tune a PWM `boost` value, which has the
> following empirically discovered, aproximate behavior over the PWM
> value:
>
> 	pwm =3D pwm_base + (pwm_boost / 255) * (pwm_max - pwm_base)
>
> Where the pwm_base is the locked PWM value controlled by the FW and
> pwm_boost is a value between 0 and 255.
>
> Expose this pwm_boost knob as a custom HWMON attribute.
>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/alienware-wmi-wmax.c | 223 +++++++++++++++++=
+++++++-
>   1 file changed, 220 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
> index 20cf3371ee3c0e1ea038b3ca517e831f3b30dc29..de4e8f177aadc9552b05cc73=
2e41ee458b761143 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -13,8 +13,11 @@
>   #include <linux/bits.h>
>   #include <linux/dmi.h>
>   #include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/minmax.h>
>   #include <linux/moduleparam.h>
>   #include <linux/platform_profile.h>
> +#include <linux/pm.h>
>   #include <linux/units.h>
>   #include <linux/wmi.h>
>   #include "alienware-wmi.h"
> @@ -179,10 +182,12 @@ enum AWCC_THERMAL_INFORMATION_OPERATIONS {
>   	AWCC_OP_GET_FAN_MIN_RPM			=3D 0x08,
>   	AWCC_OP_GET_FAN_MAX_RPM			=3D 0x09,
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
> @@ -248,6 +253,7 @@ struct awcc_fan_data {
>   	u32 total_temps;
>   	u32 min_rpm;
>   	u32 max_rpm;
> +	u8 suspend_cache;
>   	u8 id;
>   };
>
> @@ -627,6 +633,17 @@ static inline int awcc_op_get_temperature(struct wm=
i_device *wdev, u8 temp_id, u
>   		.arg3 =3D 0,
>   	};
>
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args=
, out);
> +}
> +
> +static inline int awcc_op_get_fan_boost(struct wmi_device *wdev, u8 fan=
_id, u32 *out)
> +{
> +	struct wmax_u32_args args =3D {
> +		.operation =3D AWCC_OP_GET_FAN_BOOST,
> +		.arg1 =3D fan_id,
> +		.arg2 =3D 0,
> +		.arg3 =3D 0,
> +	};
>
>   	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &arg=
s, out);
>   }
> @@ -656,6 +673,19 @@ static inline int awcc_op_activate_profile(struct w=
mi_device *wdev, u8 profile)
>   	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &=
out);
>   }
>
> +static int awcc_op_set_fan_boost(struct wmi_device *wdev, u8 fan_id, u8=
 boost)
> +{
> +	struct wmax_u32_args args =3D {
> +		.operation =3D AWCC_OP_SET_FAN_BOOST,
> +		.arg1 =3D fan_id,
> +		.arg2 =3D boost,
> +		.arg3 =3D 0,
> +	};
> +	u32 out;
> +
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &o=
ut);
> +}
> +
>   static int awcc_profile_id_to_pprof(u32 id, enum platform_profile_opti=
on *profile)
>   {
>   	switch (id) {
> @@ -717,6 +747,7 @@ static int awcc_hwmon_read(struct device *dev, enum =
hwmon_sensor_types type,
>   			   u32 attr, int channel, long *val)
>   {
>   	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +	enum platform_profile_option profile;
>   	struct awcc_fan_data *fan;
>   	u32 state;
>   	int ret;
> @@ -765,6 +796,28 @@ static int awcc_hwmon_read(struct device *dev, enum=
 hwmon_sensor_types type,
>   		fan =3D priv->fan_data[channel];
>
>   		switch (attr) {
> +		case hwmon_pwm_enable:
> +			ret =3D awcc_op_get_current_profile(priv->wdev, &state);
> +			if (ret)
> +				return ret;
> +
> +			ret =3D awcc_profile_id_to_pprof(state, &profile);
> +			if (ret)
> +				return ret;
> +
> +			switch (profile) {
> +			case PLATFORM_PROFILE_PERFORMANCE:

The hwmon sysfs docs say that 0 means that the fan is spinning at maximum =
speed. Does PLATFORM_PROFILE_PERFORMANCE
guarantee that all fans are always spinning at maximum speed?

If no then i suggest to drop support for 0.

> +				*val =3D 0;
> +				break;
> +			case PLATFORM_PROFILE_CUSTOM:
> +				*val =3D 1;
> +				break;
> +			default:
> +				*val =3D 2;
> +				break;
> +			}
> +
> +			break;
>   		case hwmon_pwm_auto_channels_temp:
>   			bitmap_copy(val, fan->auto_channels_temp, BITS_PER_LONG);
>   			break;
> @@ -840,10 +893,48 @@ static int awcc_hwmon_read_string(struct device *d=
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
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_enable:
> +			/*
> +			 * We don't want to duplicate platform profile logic, so
> +			 * we only allow enabling manual fan control
> +			 */

I do not think that having pwm1_enable brings any benefit, as the pwmX_boo=
st attributes
behave differently than pwmX attributes. I think it would be enough to doc=
ument that
pwmX_boost settings will only reliably work when the custom platform profi=
le is selected.

> +			if (val !=3D 1)
> +				return -EINVAL;
> +
> +			ret =3D awcc_op_activate_profile(priv->wdev, AWCC_SPECIAL_PROFILE_CU=
STOM);
> +			if (ret)
> +				return ret;
> +
> +			if (priv->ppdev)
> +				platform_profile_notify(priv->ppdev);
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
>   static const struct hwmon_ops awcc_hwmon_ops =3D {
>   	.is_visible =3D awcc_hwmon_is_visible,
>   	.read =3D awcc_hwmon_read,
>   	.read_string =3D awcc_hwmon_read_string,
> +	.write =3D awcc_hwmon_write,
>   };
>
>   static const struct hwmon_channel_info * const awcc_hwmon_info[] =3D {
> @@ -864,7 +955,7 @@ static const struct hwmon_channel_info * const awcc_=
hwmon_info[] =3D {
>   			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX
>   			   ),
>   	HWMON_CHANNEL_INFO(pwm,
> -			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP | HWMON_PWM_ENABLE,
>   			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>   			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>   			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> @@ -879,6 +970,75 @@ static const struct hwmon_chip_info awcc_hwmon_chip=
_info =3D {
>   	.info =3D awcc_hwmon_info,
>   };
>
> +static ssize_t pwm_boost_show(struct device *dev, struct device_attribu=
te *attr,
> +			      char *buf)
> +{
> +	int ret, index =3D to_sensor_dev_attr(attr)->index;

Please initialize "index" on a separate line, can remember the reverse xma=
s-tree order for variables.

> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +	struct awcc_fan_data *fan =3D priv->fan_data[index];
> +	u32 boost;
> +
> +	ret =3D awcc_op_get_fan_boost(priv->wdev, fan->id, &boost);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", boost);
> +}
> +
> +static ssize_t pwm_boost_store(struct device *dev, struct device_attrib=
ute *attr,
> +			       const char *buf, size_t count)
> +{
> +	int ret, index =3D to_sensor_dev_attr(attr)->index;
> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +	struct awcc_fan_data *fan =3D priv->fan_data[index];
> +	unsigned long val;
> +
> +	ret =3D kstrtoul(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D awcc_op_set_fan_boost(priv->wdev, fan->id, clamp_val(val, 0, 2=
55));
> +
> +	return ret ? ret : count;
> +}
> +
> +static SENSOR_DEVICE_ATTR_RW(pwm1_boost, pwm_boost, 0);
> +static SENSOR_DEVICE_ATTR_RW(pwm2_boost, pwm_boost, 1);
> +static SENSOR_DEVICE_ATTR_RW(pwm3_boost, pwm_boost, 2);
> +static SENSOR_DEVICE_ATTR_RW(pwm4_boost, pwm_boost, 3);

Since those attributes are working differently than the standard pwm attri=
butes, i suggest to
instead name them fanX_boost.

> +
> +static umode_t pwm_boost_attr_visible(struct kobject *kobj, struct attr=
ibute *attr, int n)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(kobj_to_dev(kobj));
> +
> +	return n < priv->fan_count ? attr->mode : 0;
> +}
> +
> +static bool pwm_boost_group_visible(struct kobject *kobj)
> +{
> +	return true;
> +}
> +
> +DEFINE_SYSFS_GROUP_VISIBLE(pwm_boost);
> +
> +static struct attribute *fan_boost_attrs[] =3D {
> +	&sensor_dev_attr_pwm1_boost.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_boost.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_boost.dev_attr.attr,
> +	&sensor_dev_attr_pwm4_boost.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group pwm_boost_group =3D {
> +	.attrs =3D fan_boost_attrs,
> +	.is_visible =3D SYSFS_GROUP_VISIBLE(pwm_boost),
> +};
> +
> +static const struct attribute_group *awcc_hwmon_groups[] =3D {
> +	&pwm_boost_group,
> +	NULL
> +};
> +
>   static int awcc_hwmon_temps_init(struct wmi_device *wdev)
>   {
>   	struct awcc_priv *priv =3D dev_get_drvdata(&wdev->dev);
> @@ -1011,12 +1171,50 @@ static int awcc_hwmon_init(struct wmi_device *wd=
ev)
>   	if (ret)
>   		return ret;
>
> -	priv->hwdev =3D devm_hwmon_device_register_with_info(&wdev->dev, "alie=
nware_wmi", priv,
> -							   &awcc_hwmon_chip_info, NULL);
> +	priv->hwdev =3D devm_hwmon_device_register_with_info(&wdev->dev, "alie=
nware_wmi",
> +							   priv, &awcc_hwmon_chip_info,
> +							   awcc_hwmon_groups);
>
>   	return PTR_ERR_OR_ZERO(priv->hwdev);
>   }
>
> +static void awcc_hwmon_suspend(struct device *dev)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +	struct awcc_fan_data *fan;
> +	unsigned int i;
> +	u32 boost;
> +	int ret;
> +
> +	for (i =3D 0; i < priv->fan_count; i++) {
> +		fan =3D priv->fan_data[i];
> +
> +		ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_FAN_BOOST,
> +					       fan->id, &boost);
> +		if (ret)
> +			fan->suspend_cache =3D 0;

Please at least log a warning here that the fan boost value can not be res=
tored properly.

> +		else
> +			fan->suspend_cache =3D clamp_val(boost, 0, 255);
> +
> +		awcc_op_set_fan_boost(priv->wdev, fan->id, 0);
> +	}
> +}
> +
> +static void awcc_hwmon_resume(struct device *dev)
> +{
> +
> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +	struct awcc_fan_data *fan;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < priv->fan_count; i++) {
> +		fan =3D priv->fan_data[i];
> +
> +		if (fan->suspend_cache)

How does the driver restore fan boost settings with a value of 0?

Thanks,
Armin Wolf

> +			awcc_op_set_fan_boost(priv->wdev, fan->id, fan->suspend_cache);
> +	}
> +}
> +
>   /*
>    * Thermal Profile control
>    *  - Provides thermal profile control through the Platform Profile AP=
I
> @@ -1233,6 +1431,24 @@ static int wmax_wmi_probe(struct wmi_device *wdev=
, const void *context)
>   	return ret;
>   }
>
> +static int wmax_wmi_suspend(struct device *dev)
> +{
> +	if (awcc->hwmon)
> +		awcc_hwmon_suspend(dev);
> +
> +	return 0;
> +}
> +
> +static int wmax_wmi_resume(struct device *dev)
> +{
> +	if (awcc->hwmon)
> +		awcc_hwmon_resume(dev);
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_DEV_PM_OPS(wmax_wmi_pm_ops, wmax_wmi_suspend, wmax_wmi_re=
sume);
> +
>   static const struct wmi_device_id alienware_wmax_device_id_table[] =3D=
 {
>   	{ WMAX_CONTROL_GUID, NULL },
>   	{ },
> @@ -1243,6 +1459,7 @@ static struct wmi_driver alienware_wmax_wmi_driver=
 =3D {
>   	.driver =3D {
>   		.name =3D "alienware-wmi-wmax",
>   		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +		.pm =3D pm_sleep_ptr(&wmax_wmi_pm_ops),
>   	},
>   	.id_table =3D alienware_wmax_device_id_table,
>   	.probe =3D wmax_wmi_probe,
>

