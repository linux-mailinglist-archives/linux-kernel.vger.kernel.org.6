Return-Path: <linux-kernel+bounces-556777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D3DA5CE63
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73EC189DA51
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C116263F5B;
	Tue, 11 Mar 2025 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="AVKcer7N"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B788263C6A;
	Tue, 11 Mar 2025 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719603; cv=none; b=YeDzHG67RLfZgGQSBsVERrFtTBi7vR03gQ9qfnltpJI8NGmZv8TkCdr0gfsC+fo8heOmz0oxidu8ToTLkpKfD9u7I165uzJlXVv0fZzKQDlPLpb1/ldCf1+j9a23SBjECwc+3pwrfXKuyrUa+OnBO3/LoFtFgD1W7jurdeTBEzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719603; c=relaxed/simple;
	bh=5AQr1vCalkaapvWGnJ6H4XAcY/4GB0hOvr4WhI93d8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Esm/nqhFlSUTX9DSIFeY+zWb2jttZ6PbFUtOlkHU/B/1uPHOuILv8Cwo2puq+BXoxd3PtEOM1jhbraBQRTifGNz88CEZ4d/nxzV6IRGoLGFBnunndql/lNZcbgzH7IbNbPeMgWgL4Ww/4wE8YXpaVsMvlyEsBcEloOgqgOwFWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=AVKcer7N; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741719591; x=1742324391; i=w_armin@gmx.de;
	bh=+d+JBF8EifT4PuzOAwZ+7Yq+FV9kDLncu6UI+icpmq8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AVKcer7NgTod8DQ4xrfkxAmd5h9nZbunb/DhWfFG0d49dCJVHu6W/CHuKocYJvB9
	 vjUuECP7iqArbsPX/LhuvTj2XU/+7g/4bPot9dMT16zak4b+xjdfQbcly9hZ1y4I2
	 yaPRQYx/rNcODq6BOBg7BYA5cB1J67PumoquuGddD/5eGC2Pam3MGotxsUCqCwnOH
	 1t04qhuz3GYy/+xVAmt/F0DsUn3HKGYh99r0ZRB089TGabE6Wd4kKmCWQBrYunlUi
	 AFcuIQFLKrZ43yJfHgYYjGFFtW6S0QoRLQLd8di84o7fNifCqP24nochpH6tfxhHm
	 911Wpq7hughYfighsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1tZBTI3DkR-00HbD6; Tue, 11
 Mar 2025 19:59:51 +0100
Message-ID: <973622fe-16f2-4e8f-a21d-f71ad39f8ad6@gmx.de>
Date: Tue, 11 Mar 2025 19:59:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] platform/x86: alienware-wmi-wmax: Add support
 for manual fan control
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 linux-hwmon@vger.kernel.org
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
 <20250308-hwm-v4-8-afa1342828f5@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250308-hwm-v4-8-afa1342828f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3cseTVvl7rwPJiBqlQBW7QPU5drFVWO48sH1LsFWbswYtuVaSJ/
 JnjZgMxRbVPh8Ybc9shENqTs5UN4FK3RXlcu3keRQJe9DwhZYBHd0sCkv4r70dvdfJTR/fU
 OOk50l06S3RjuMpYIfJyxK1++szR44JXKPimia1FyrOzoWkO3HZIYIcPzr4tELhm4Hf/Xln
 9C3YzuR3a3C3c0tWTJ7Rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U+zB8Fy5nHc=;m+6Tm6i7+ECgCwh4AHhDLgf6J5k
 xH4tOpywbY+lmPiMNp5bBlM1E+jR3FQzQ+SFEWxSrmw3rUw4QWn05JEAFMl6iExCfG2rgkj/p
 bsIZF24pUV+pdsyOxplyS/ttN6eTRmFs71yxOKNshzhREvEMpQBxpfrHGhCg37yFe1keyXRos
 GRFNWObVtABMrfQxZFuUf2vOO4xiFHE/IoNlrFFnmW/R+qrr8GiqRC/VLgeyXIeH8OO9GEpOC
 EXO2DUlzIKRdBOOKgBuAdY0t/uan3hsmzYbnygJIvlzkes6trd54ybm+Apcw/n+Tx7zfuGs5z
 GkOVkfhj1KXh33tPEP0obVs6fRBkMy7qGChPx1sY0qLWWrPDOCM5JMJzUyzSwTEH2LCooCzqC
 4JdqSBicA+9l6vj9ZQgc5mM35hlbwj19PH9PAOqItjVmb64Y7rcryYUQePSebGqNJoVm827ZP
 L7UYc48rvjU1/0NHWKlaQ97XHSD3qvb2VpwOvxg2Y5jvxamGhzDIlwhXbXu8YUYVG5m9eL3JG
 J9v6A5hN5Ojy5Oc/INbWMqBj9CSISz0VsGQrDNylaojNkztTpKeMfiNSC5ckFZMSi9jHqenRL
 N04zgubLrGwy1qt/2YJ3+3ehwcrJ/1W01dGRTS805LEGC8kBGSQycfKOu8Neo4Sv0TAXrJOhm
 axnuNYh0hZV8t8AqurRsJ0hRsywTXErjlDU8ZWNyQ99bkr6PgiT2uV68hdhCllIV7wtL06NMA
 l7dzdaPVhQPZar1dbbKb7hEL0fYNpZkDqWPzxuTqf9EW52zs45bZXUHjZaaHDDN6ZZIKuOSFQ
 etOJ2BfMwM4UDm3WGSIEZE+5YRFYcTgWrRmNAFVLGFGytQyXH3RoV808duzRLx72hCBgMOlcy
 3BwzKSW6XgmmpsEZ1oVlMZ0e9Q3RzmWGZDdRMCZgdjWiEBwqRz8ZxrZiNtO7wZ2vUblgqCtwn
 C0akBNosyf1/IB0F5EG80qEzjKVI6OCMEfjPrWthcH3i4dKH/UG0B8DJoZN56Q7aNsppVzSx1
 iR64utqxULLH41nnbTswYYD0niE+5TdIxb1YlrKcdcKb5bIk9ya/7kyaTInDsCQ8Q+3mwKeLg
 MCREMqbWvQcWrPtjckMt+L4UIprz8IlgsBAixl8+QPzCg51ri0D8unaFc2B284rdWdNIk/YFD
 XRH2oH/owKwGhzRbGFPYCeFDYfEg3t2fPiKGwQO4XnKK0jj6/q3EQ4fmsejdWhQzzCZWZREOg
 bMhiqyDofyMtbV70m+CO9l3BvyyTuI+eYah3LheVmxBinmed+M9O1ecfoeJBO3QxVbc6GDztx
 HRTxQOCo1X00MWTgvnwWmwbUx7dePf1sloztTFRnCaRPE2pEyU1XgQkielYuH8dfp97gX5wG3
 gu/Ot1xqz14PvHmqibab1r7EXyXJvB+mAGwm+gUG0NFJQNFOtmPKDP2nASgLSBFWQEujco8uQ
 yh9lCbU0ajMOQO2IA+0orT2J48gc=

Am 08.03.25 um 21:23 schrieb Kurt Borja:

> All models with the "AWCC" WMAX device support a way of manually
> controlling fans.
>
> The PWM duty cycle of a fan can't be controlled directly. Instead the
> AWCC interface let's us tune a fan `boost` value, which has the
> following empirically discovered, aproximate behavior over the PWM
> value:
>
> 	pwm =3D pwm_base + (fan_boost / 255) * (pwm_max - pwm_base)
>
> Where the pwm_base is the locked PWM value controlled by the FW and
> fan_boost is a value between 0 and 255.
>
> Expose this fan_boost knob as a custom HWMON attribute.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/alienware-wmi-wmax.c | 174 +++++++++++++++++=
+++++++-
>   1 file changed, 172 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
> index f1f20db206d47f644e8cd58a6d169c850606e75b..68ff520f016d2d567cddcefe=
41f01bf284b4d979 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -13,8 +13,12 @@
>   #include <linux/bits.h>
>   #include <linux/dmi.h>
>   #include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/kstrtox.h>
> +#include <linux/minmax.h>
>   #include <linux/moduleparam.h>
>   #include <linux/platform_profile.h>
> +#include <linux/pm.h>
>   #include <linux/units.h>
>   #include <linux/wmi.h>
>   #include "alienware-wmi.h"
> @@ -181,10 +185,12 @@ enum AWCC_THERMAL_INFORMATION_OPERATIONS {
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
> @@ -248,6 +254,7 @@ struct awcc_fan_data {
>   	const char *label;
>   	u32 min_rpm;
>   	u32 max_rpm;
> +	u8 suspend_cache;
>   	u8 id;
>   };
>
> @@ -628,6 +635,18 @@ static inline int awcc_op_get_temperature(struct wm=
i_device *wdev, u8 temp_id, u
>   	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &arg=
s, out);
>   }
>
> +static inline int awcc_op_get_fan_boost(struct wmi_device *wdev, u8 fan=
_id, u32 *out)
> +{
> +	struct wmax_u32_args args =3D {
> +		.operation =3D AWCC_OP_GET_FAN_BOOST,
> +		.arg1 =3D fan_id,
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
> @@ -653,6 +672,19 @@ static inline int awcc_op_activate_profile(struct w=
mi_device *wdev, u8 profile)
>   	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &=
out);
>   }
>
> +static inline int awcc_op_set_fan_boost(struct wmi_device *wdev, u8 fan=
_id, u8 boost)
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
>   /*
>    * HWMON
>    *  - Provides temperature and fan speed monitoring as well as manual =
fan
> @@ -817,6 +849,81 @@ static const struct hwmon_chip_info awcc_hwmon_chip=
_info =3D {
>   	.info =3D awcc_hwmon_info,
>   };
>
> +static ssize_t fan_boost_show(struct device *dev, struct device_attribu=
te *attr,
> +			      char *buf)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +	int index =3D to_sensor_dev_attr(attr)->index;
> +	struct awcc_fan_data *fan =3D priv->fan_data[index];
> +	u32 boost;
> +	int ret;
> +
> +	ret =3D awcc_op_get_fan_boost(priv->wdev, fan->id, &boost);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", boost);
> +}
> +
> +static ssize_t fan_boost_store(struct device *dev, struct device_attrib=
ute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +	int index =3D to_sensor_dev_attr(attr)->index;
> +	struct awcc_fan_data *fan =3D priv->fan_data[index];
> +	unsigned long val;
> +	int ret;
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
> +static SENSOR_DEVICE_ATTR_RW(fan1_boost, fan_boost, 0);
> +static SENSOR_DEVICE_ATTR_RW(fan2_boost, fan_boost, 1);
> +static SENSOR_DEVICE_ATTR_RW(fan3_boost, fan_boost, 2);
> +static SENSOR_DEVICE_ATTR_RW(fan4_boost, fan_boost, 3);
> +static SENSOR_DEVICE_ATTR_RW(fan5_boost, fan_boost, 4);
> +static SENSOR_DEVICE_ATTR_RW(fan6_boost, fan_boost, 5);
> +
> +static umode_t fan_boost_attr_visible(struct kobject *kobj, struct attr=
ibute *attr, int n)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(kobj_to_dev(kobj));
> +
> +	return n < priv->fan_count ? attr->mode : 0;
> +}
> +
> +static bool fan_boost_group_visible(struct kobject *kobj)
> +{
> +	return true;
> +}
> +
> +DEFINE_SYSFS_GROUP_VISIBLE(fan_boost);
> +
> +static struct attribute *fan_boost_attrs[] =3D {
> +	&sensor_dev_attr_fan1_boost.dev_attr.attr,
> +	&sensor_dev_attr_fan2_boost.dev_attr.attr,
> +	&sensor_dev_attr_fan3_boost.dev_attr.attr,
> +	&sensor_dev_attr_fan4_boost.dev_attr.attr,
> +	&sensor_dev_attr_fan5_boost.dev_attr.attr,
> +	&sensor_dev_attr_fan6_boost.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group fan_boost_group =3D {
> +	.attrs =3D fan_boost_attrs,
> +	.is_visible =3D SYSFS_GROUP_VISIBLE(fan_boost),
> +};
> +
> +static const struct attribute_group *awcc_hwmon_groups[] =3D {
> +	&fan_boost_group,
> +	NULL
> +};
> +
>   static int awcc_hwmon_temps_init(struct wmi_device *wdev)
>   {
>   	struct awcc_priv *priv =3D dev_get_drvdata(&wdev->dev);
> @@ -954,12 +1061,56 @@ static int awcc_hwmon_init(struct wmi_device *wde=
v)
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
> +			dev_err(dev, "Failed to store Fan %u boost while suspending\n", i);
> +
> +		fan->suspend_cache =3D ret ? 0 : clamp_val(boost, 0, 255);
> +
> +		awcc_op_set_fan_boost(priv->wdev, fan->id, 0);
> +		if (ret)
> +			dev_err(dev, "Failed to set Fan %u boost to 0 while suspending\n", i=
);
> +	}
> +}
> +
> +static void awcc_hwmon_resume(struct device *dev)
> +{
> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> +	struct awcc_fan_data *fan;
> +	unsigned int i;
> +	int ret;
> +
> +	for (i =3D 0; i < priv->fan_count; i++) {
> +		fan =3D priv->fan_data[i];
> +
> +		if (!fan->suspend_cache)
> +			continue;
> +
> +		ret =3D awcc_op_set_fan_boost(priv->wdev, fan->id, fan->suspend_cache=
);
> +		if (ret)
> +			dev_err(dev, "Failed to restore Fan %u boost while resuming\n", i);
> +	}
> +}
> +
>   /*
>    * Thermal Profile control
>    *  - Provides thermal profile control through the Platform Profile AP=
I
> @@ -1189,6 +1340,24 @@ static int wmax_wmi_probe(struct wmi_device *wdev=
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
> @@ -1199,6 +1368,7 @@ static struct wmi_driver alienware_wmax_wmi_driver=
 =3D {
>   	.driver =3D {
>   		.name =3D "alienware-wmi-wmax",
>   		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +		.pm =3D pm_sleep_ptr(&wmax_wmi_pm_ops),
>   	},
>   	.id_table =3D alienware_wmax_device_id_table,
>   	.probe =3D wmax_wmi_probe,
>

