Return-Path: <linux-kernel+bounces-551959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8A9A5736E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813133B6135
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0E2257AD8;
	Fri,  7 Mar 2025 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KxL/A2Ne"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E043618A95A;
	Fri,  7 Mar 2025 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382354; cv=none; b=qla8zUzZWtYcHRUOL9rkwwi+fb+MyJQf6hIpQ85KpbCxPtMWOHxJtatLKfkYT+1uj//xmCSdY3aYuYixekpKAJsFa97baeZKLigLy4YcDS3OINzOz3Vwe3SQTSro/J8K8xsVweUiptFtJrYowGQ+u1CyGE7vzp8j95/+fB3uHGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382354; c=relaxed/simple;
	bh=WVH2q0vF4vzWsXDI97XZyROMPCb1942ZVGmhhUn7YPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcWrUIxVRZjgR22E45Fi74z/pUYmVHyRKg+rxHfjejD0mu8jrCg8c2n7PWp7wIFb7rYJKactrK0FbDoSYNWdWRlEjPJLlpCE3OfhxC+PZA8W4Gzm1zjvlB+h5vsUgEm9nXiXC8bW0MwZG1Y0UAbheuWfBWenBXZCr0qbXXL97as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KxL/A2Ne; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741382325; x=1741987125; i=w_armin@gmx.de;
	bh=CBWSPathHeFs9x8ij6jAqlNIxtclFNuxyTugibH17oQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KxL/A2NeqBgg/wSv2CgbB8rbkcXgYxs6fVf+ME3LE2TOZKUQgIoEX0mmcD3OqM+D
	 bkYWuoHeYBKE6noJYt6QfVXn93n94Yn1r02WDAt9Pj3FCH5gHY4KagsCr+LVeJFYo
	 Uk5PzKnPzpQ1M9oqCzL5pS1cgM8FPZHBjQt4F/4dV0hJ+VcWivOeigOyGTrOO5jAs
	 Y3xqSOcs+SrcS8ra/e96a4WL4MKs84dV6sTJ8mjHpD/wBhAvDyVGeTK6JduAydC4m
	 IoBfcuFKY6p0TGh03f0eCz8xyxmM6QW28DX+8EkcYPHkSmIUCxxu6B8b7YaM/o7oZ
	 U+mqGuPwAcByTsJw0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hV5-1tunx61gUj-0031aD; Fri, 07
 Mar 2025 22:18:45 +0100
Message-ID: <abe60cae-23ef-4d69-81e3-d9a50eedb482@gmx.de>
Date: Fri, 7 Mar 2025 22:18:42 +0100
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
 <e8a44866-602c-47bb-8b11-7ba59c3d346f@gmx.de>
 <D89LODODY167.1VG4P7K7X2BZO@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <D89LODODY167.1VG4P7K7X2BZO@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SdsDRZ5fd4KpKL5ISg3WH+gTEmhQpDpZECpB/RE5XabcZ87onKP
 uro3KGQTC80Eu1UrxGDCX5T4JDNYq7lQGxqJ2g2hp1XhFPX+WEsKnCK9bN964dJ6hKvLDh0
 05rEh3BLtqDjpXxpRrTARFf5WTfoBM5/8aBF3IFudBpjLQ9rUo+Fikb5LiPsrdrUkJNSZtl
 wr/Cwhy1Wr6myE0ErcpPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2+Tq9Uqv+eI=;8g6awvldzkgT76P57WPVNN2nlkC
 vcCQIG6v5JEQ3EVblhX088qGOwY1xPAPm6cQ7IU4ODkyTtpK6DJZJc8DrJ54XR0T3BoPiKwzS
 WRLe8ASYHb3u5jAyLwkqJqbdLJCeV8JVCPZ3ljyuJmsuNKi1ZtMrWcowl8RsfHR9qZeqfb866
 e86BKsfT1mcSowcM6RyRUMsvW91Bv9ljb+LVz33dIdVkcQ8CyMfZabq5TWp6LhOxi5bTy/f4l
 e75dA23pnEz1PWDypuLan8y/vGNQeFDj3dz0YW6KmkRTcgWcAAbBiqMYhcTpoHsprcbQxFhqf
 0Bl1ZhNqh1gE/glLY4fWLnDEGIQYZAW4xFtET9ngbC7VVLVroKvFfTGyaYNZ/NmUhQYRIJt9u
 5T8/6NoEmFq1fc39q+jLhz2vUEj5G1kura0qOdUof6qBJH7bAh/d3Q66UJP05xRtuwjuOt9mJ
 BBG/KQvgrk1zU0gpDS8yRVehpIPlxgDI3SShcsz1W6a1FPoTvX/jPIHq8DlZvSIbHG8FN/CVw
 b1zv/lRIt5NAgnPQSMNu+r36Y4MYWceJgi2Dtej34018rDthsW5oEOzX2OzfoPYO7gYjmcaWG
 FeaHTHTKqwYnwV2D2YAWhcdv+FHupHT7t//DV2fykJ4Q3k541nYnr38MJhDz5N5MvHqVBa+ys
 1S3PM0mSlFl4QAuFQ24dbyZMqPGXqtrEVfHmE/n1+Hohi9hlHRrIsWH9Jq8An+DnFmvrlWaRE
 ztbyE0bsoOF+0fIbOqWKUKmOf2LxKuhVcbnOZBa28MJ/E43e8Y3Ip8XopJqREuYOL//N9kpDk
 xN0Oe/94qNbz74Ovf8YUDsKrbgHLY4/KYmPb/kMDbi7gFBxGtA0tKqFpF+hbaSegeZdFEbZTs
 bitPvLOkRo/XfF9ZlCGsz9xZ4OO8VwpQ2ZDe8JYDoPNIStbYSX4vLxpvJ1LqfZAIm3dsY+P61
 Op71bdT8zs49XokfWwFwyJ7/+b4l2zMngo8Oh04i/7AWfiraZgmQVwKR9Ar8EcQe5DAqvRfAQ
 jvWQpMTQ3VLvnr0Nt7p73IumJw3n3se7nWjkqNzqct80oWkJIWFVRu4GFnd3eJJYE8NpzZT+m
 vQqJeQh1HvIzT/I1ejxYqPIxJ/Uf0o0oGV/xYeO34gGPAF0WlqA3nWqd15+XYiq8xrrceECRS
 E40qYtDpGsOl4Vm6NNX76QzF33mv2J13wGrem90wjElyppb8CpnXvqkqCGyVUzKuT3ezjD3MU
 s1bCxxRwJrxEFt7HLQnWQCqlYBO+z/MFxsMqrsU0CfP2AXBNZCTmwubpRfB94ojJcLPk/BdPR
 g8fEkD8IrvlieJNfQyoh8nd3IUikgfzT6bkFWeB5o7OMkksZYLi59rwJTbG1a4toj/blxifWx
 xz7gcAAsJbmeQ8uLkTfwCJSlZhSBfKxBsxSwOt3giv6aflJVxPwob82wIS

Am 07.03.25 um 01:16 schrieb Kurt Borja:

> Hi Armin,
>
> On Thu Mar 6, 2025 at 5:35 PM -05, Armin Wolf wrote:
>> Am 06.03.25 um 01:56 schrieb Kurt Borja:
>>
>>> All models with the "AWCC" WMAX device support a way of manually
>>> controlling fans.
>>>
>>> The PWM duty cycle of a fan can't be controlled directly. Instead the
>>> AWCC interface let's us tune a PWM `boost` value, which has the
>>> following empirically discovered, aproximate behavior over the PWM
>>> value:
>>>
>>> 	pwm = pwm_base + (pwm_boost / 255) * (pwm_max - pwm_base)
>>>
>>> Where the pwm_base is the locked PWM value controlled by the FW and
>>> pwm_boost is a value between 0 and 255.
>>>
>>> Expose this pwm_boost knob as a custom HWMON attribute.
>>>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: Jean Delvare <jdelvare@suse.com>
>>> Cc: linux-hwmon@vger.kernel.org
>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>> ---
>>>    drivers/platform/x86/dell/alienware-wmi-wmax.c | 223 ++++++++++++++++++++++++-
>>>    1 file changed, 220 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
>>> index 20cf3371ee3c0e1ea038b3ca517e831f3b30dc29..de4e8f177aadc9552b05cc732e41ee458b761143 100644
>>> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
>>> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
>>> @@ -13,8 +13,11 @@
>>>    #include <linux/bits.h>
>>>    #include <linux/dmi.h>
>>>    #include <linux/hwmon.h>
>>> +#include <linux/hwmon-sysfs.h>
>>> +#include <linux/minmax.h>
>>>    #include <linux/moduleparam.h>
>>>    #include <linux/platform_profile.h>
>>> +#include <linux/pm.h>
>>>    #include <linux/units.h>
>>>    #include <linux/wmi.h>
>>>    #include "alienware-wmi.h"
>>> @@ -179,10 +182,12 @@ enum AWCC_THERMAL_INFORMATION_OPERATIONS {
>>>    	AWCC_OP_GET_FAN_MIN_RPM			= 0x08,
>>>    	AWCC_OP_GET_FAN_MAX_RPM			= 0x09,
>>>    	AWCC_OP_GET_CURRENT_PROFILE		= 0x0B,
>>> +	AWCC_OP_GET_FAN_BOOST			= 0x0C,
>>>    };
>>>
>>>    enum AWCC_THERMAL_CONTROL_OPERATIONS {
>>>    	AWCC_OP_ACTIVATE_PROFILE		= 0x01,
>>> +	AWCC_OP_SET_FAN_BOOST			= 0x02,
>>>    };
>>>
>>>    enum AWCC_GAME_SHIFT_STATUS_OPERATIONS {
>>> @@ -248,6 +253,7 @@ struct awcc_fan_data {
>>>    	u32 total_temps;
>>>    	u32 min_rpm;
>>>    	u32 max_rpm;
>>> +	u8 suspend_cache;
>>>    	u8 id;
>>>    };
>>>
>>> @@ -627,6 +633,17 @@ static inline int awcc_op_get_temperature(struct wmi_device *wdev, u8 temp_id, u
>>>    		.arg3 = 0,
>>>    	};
>>>
>>> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
>>> +}
>>> +
>>> +static inline int awcc_op_get_fan_boost(struct wmi_device *wdev, u8 fan_id, u32 *out)
>>> +{
>>> +	struct wmax_u32_args args = {
>>> +		.operation = AWCC_OP_GET_FAN_BOOST,
>>> +		.arg1 = fan_id,
>>> +		.arg2 = 0,
>>> +		.arg3 = 0,
>>> +	};
>>>
>>>    	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
>>>    }
>>> @@ -656,6 +673,19 @@ static inline int awcc_op_activate_profile(struct wmi_device *wdev, u8 profile)
>>>    	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &out);
>>>    }
>>>
>>> +static int awcc_op_set_fan_boost(struct wmi_device *wdev, u8 fan_id, u8 boost)
>>> +{
>>> +	struct wmax_u32_args args = {
>>> +		.operation = AWCC_OP_SET_FAN_BOOST,
>>> +		.arg1 = fan_id,
>>> +		.arg2 = boost,
>>> +		.arg3 = 0,
>>> +	};
>>> +	u32 out;
>>> +
>>> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &out);
>>> +}
>>> +
>>>    static int awcc_profile_id_to_pprof(u32 id, enum platform_profile_option *profile)
>>>    {
>>>    	switch (id) {
>>> @@ -717,6 +747,7 @@ static int awcc_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>>>    			   u32 attr, int channel, long *val)
>>>    {
>>>    	struct awcc_priv *priv = dev_get_drvdata(dev);
>>> +	enum platform_profile_option profile;
>>>    	struct awcc_fan_data *fan;
>>>    	u32 state;
>>>    	int ret;
>>> @@ -765,6 +796,28 @@ static int awcc_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>>>    		fan = priv->fan_data[channel];
>>>
>>>    		switch (attr) {
>>> +		case hwmon_pwm_enable:
>>> +			ret = awcc_op_get_current_profile(priv->wdev, &state);
>>> +			if (ret)
>>> +				return ret;
>>> +
>>> +			ret = awcc_profile_id_to_pprof(state, &profile);
>>> +			if (ret)
>>> +				return ret;
>>> +
>>> +			switch (profile) {
>>> +			case PLATFORM_PROFILE_PERFORMANCE:
>> The hwmon sysfs docs say that 0 means that the fan is spinning at maximum speed. Does PLATFORM_PROFILE_PERFORMANCE
>> guarantee that all fans are always spinning at maximum speed?
> Yes PERFORMANCE is full-speed for all devices I know. Manual fan control
> is completely disabled for that profile too.
>
> In fact I'm thinking about adding a module parameter to suppress this
> behavior. Not everyone may like that. That's outside the scope of these
> series tho.

I see no problem in exposing PLATFORM_PROFILE_PERFORMANCE as a normal platform profile,
if a user does not want to use it then they can simply not select it.

>> If no then i suggest to drop support for 0.
>>
>>> +				*val = 0;
>>> +				break;
>>> +			case PLATFORM_PROFILE_CUSTOM:
>>> +				*val = 1;
>>> +				break;
>>> +			default:
>>> +				*val = 2;
>>> +				break;
>>> +			}
>>> +
>>> +			break;
>>>    		case hwmon_pwm_auto_channels_temp:
>>>    			bitmap_copy(val, fan->auto_channels_temp, BITS_PER_LONG);
>>>    			break;
>>> @@ -840,10 +893,48 @@ static int awcc_hwmon_read_string(struct device *dev, enum hwmon_sensor_types ty
>>>    	return 0;
>>>    }
>>>
>>> +
>>> +static int awcc_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
>>> +			    u32 attr, int channel, long val)
>>> +{
>>> +	struct awcc_priv *priv = dev_get_drvdata(dev);
>>> +	int ret;
>>> +
>>> +	switch (type) {
>>> +	case hwmon_pwm:
>>> +		switch (attr) {
>>> +		case hwmon_pwm_enable:
>>> +			/*
>>> +			 * We don't want to duplicate platform profile logic, so
>>> +			 * we only allow enabling manual fan control
>>> +			 */
>> I do not think that having pwm1_enable brings any benefit, as the pwmX_boost attributes
>> behave differently than pwmX attributes. I think it would be enough to document that
>> pwmX_boost settings will only reliably work when the custom platform profile is selected.
> Now I realise I completely forgot about the admin-guide documentation!
> I'll include it in the next revision. Is this path ok?
>
> 	Documentation/admin-guide/laptops/alienware-wmi.rst
>
> Or should I add driver specific ABI documentation? (or both ofc)
>
> I don't want to name the file alienware-laptop because this driver is
> compatible with Dell G-Series too.

The name "alienware-wmi.rst" is OK. I suggest that you create driver specific ABI documentation for
the boost attributes and reference them inside the laptop documentation.

>>> +			if (val != 1)
>>> +				return -EINVAL;
>>> +
>>> +			ret = awcc_op_activate_profile(priv->wdev, AWCC_SPECIAL_PROFILE_CUSTOM);
>>> +			if (ret)
>>> +				return ret;
>>> +
>>> +			if (priv->ppdev)
>>> +				platform_profile_notify(priv->ppdev);
>>> +			break;
>>> +		default:
>>> +			return -EOPNOTSUPP;
>>> +		}
>>> +
>>> +		break;
>>> +	default:
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static const struct hwmon_ops awcc_hwmon_ops = {
>>>    	.is_visible = awcc_hwmon_is_visible,
>>>    	.read = awcc_hwmon_read,
>>>    	.read_string = awcc_hwmon_read_string,
>>> +	.write = awcc_hwmon_write,
>>>    };
>>>
>>>    static const struct hwmon_channel_info * const awcc_hwmon_info[] = {
>>> @@ -864,7 +955,7 @@ static const struct hwmon_channel_info * const awcc_hwmon_info[] = {
>>>    			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX
>>>    			   ),
>>>    	HWMON_CHANNEL_INFO(pwm,
>>> -			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP | HWMON_PWM_ENABLE,
>>>    			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>>>    			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>>>    			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>>> @@ -879,6 +970,75 @@ static const struct hwmon_chip_info awcc_hwmon_chip_info = {
>>>    	.info = awcc_hwmon_info,
>>>    };
>>>
>>> +static ssize_t pwm_boost_show(struct device *dev, struct device_attribute *attr,
>>> +			      char *buf)
>>> +{
>>> +	int ret, index = to_sensor_dev_attr(attr)->index;
>> Please initialize "index" on a separate line, can remember the reverse xmas-tree order for variables.
> Ack.
>
>>> +	struct awcc_priv *priv = dev_get_drvdata(dev);
>>> +	struct awcc_fan_data *fan = priv->fan_data[index];
>>> +	u32 boost;
>>> +
>>> +	ret = awcc_op_get_fan_boost(priv->wdev, fan->id, &boost);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return sysfs_emit(buf, "%u\n", boost);
>>> +}
>>> +
>>> +static ssize_t pwm_boost_store(struct device *dev, struct device_attribute *attr,
>>> +			       const char *buf, size_t count)
>>> +{
>>> +	int ret, index = to_sensor_dev_attr(attr)->index;
>>> +	struct awcc_priv *priv = dev_get_drvdata(dev);
>>> +	struct awcc_fan_data *fan = priv->fan_data[index];
>>> +	unsigned long val;
>>> +
>>> +	ret = kstrtoul(buf, 0, &val);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = awcc_op_set_fan_boost(priv->wdev, fan->id, clamp_val(val, 0, 255));
>>> +
>>> +	return ret ? ret : count;
>>> +}
>>> +
>>> +static SENSOR_DEVICE_ATTR_RW(pwm1_boost, pwm_boost, 0);
>>> +static SENSOR_DEVICE_ATTR_RW(pwm2_boost, pwm_boost, 1);
>>> +static SENSOR_DEVICE_ATTR_RW(pwm3_boost, pwm_boost, 2);
>>> +static SENSOR_DEVICE_ATTR_RW(pwm4_boost, pwm_boost, 3);
>> Since those attributes are working differently than the standard pwm attributes, i suggest to
>> instead name them fanX_boost.
> I went for pwm*_boost because we also export pwm*_auto_channels_temp,
> but I'm ok with fan*_boost too.
>
Having pwmX_auto_channels_temp as the only pwm attribute is fine, the fsteutates driver does
something similar. Naming the attributes fanX_boost would better fir inside the fan-centric
hwmon API of this driver.

>>> +
>>> +static umode_t pwm_boost_attr_visible(struct kobject *kobj, struct attribute *attr, int n)
>>> +{
>>> +	struct awcc_priv *priv = dev_get_drvdata(kobj_to_dev(kobj));
>>> +
>>> +	return n < priv->fan_count ? attr->mode : 0;
>>> +}
>>> +
>>> +static bool pwm_boost_group_visible(struct kobject *kobj)
>>> +{
>>> +	return true;
>>> +}
>>> +
>>> +DEFINE_SYSFS_GROUP_VISIBLE(pwm_boost);
>>> +
>>> +static struct attribute *fan_boost_attrs[] = {
>>> +	&sensor_dev_attr_pwm1_boost.dev_attr.attr,
>>> +	&sensor_dev_attr_pwm2_boost.dev_attr.attr,
>>> +	&sensor_dev_attr_pwm3_boost.dev_attr.attr,
>>> +	&sensor_dev_attr_pwm4_boost.dev_attr.attr,
>>> +	NULL
>>> +};
>>> +
>>> +static const struct attribute_group pwm_boost_group = {
>>> +	.attrs = fan_boost_attrs,
>>> +	.is_visible = SYSFS_GROUP_VISIBLE(pwm_boost),
>>> +};
>>> +
>>> +static const struct attribute_group *awcc_hwmon_groups[] = {
>>> +	&pwm_boost_group,
>>> +	NULL
>>> +};
>>> +
>>>    static int awcc_hwmon_temps_init(struct wmi_device *wdev)
>>>    {
>>>    	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
>>> @@ -1011,12 +1171,50 @@ static int awcc_hwmon_init(struct wmi_device *wdev)
>>>    	if (ret)
>>>    		return ret;
>>>
>>> -	priv->hwdev = devm_hwmon_device_register_with_info(&wdev->dev, "alienware_wmi", priv,
>>> -							   &awcc_hwmon_chip_info, NULL);
>>> +	priv->hwdev = devm_hwmon_device_register_with_info(&wdev->dev, "alienware_wmi",
>>> +							   priv, &awcc_hwmon_chip_info,
>>> +							   awcc_hwmon_groups);
>>>
>>>    	return PTR_ERR_OR_ZERO(priv->hwdev);
>>>    }
>>>
>>> +static void awcc_hwmon_suspend(struct device *dev)
>>> +{
>>> +	struct awcc_priv *priv = dev_get_drvdata(dev);
>>> +	struct awcc_fan_data *fan;
>>> +	unsigned int i;
>>> +	u32 boost;
>>> +	int ret;
>>> +
>>> +	for (i = 0; i < priv->fan_count; i++) {
>>> +		fan = priv->fan_data[i];
>>> +
>>> +		ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_FAN_BOOST,
>>> +					       fan->id, &boost);
>>> +		if (ret)
>>> +			fan->suspend_cache = 0;
>> Please at least log a warning here that the fan boost value can not be restored properly.
> Ack.
>
> Is not propagating errors a good approach here? My idea was to try to
> turn off fans no matter what.

In this case it should be OK, failing to restore the fan boost value is not critical.

>>> +		else
>>> +			fan->suspend_cache = clamp_val(boost, 0, 255);
>>> +
>>> +		awcc_op_set_fan_boost(priv->wdev, fan->id, 0);
>>> +	}
>>> +}
>>> +
>>> +static void awcc_hwmon_resume(struct device *dev)
>>> +{
>>> +
>>> +	struct awcc_priv *priv = dev_get_drvdata(dev);
>>> +	struct awcc_fan_data *fan;
>>> +	unsigned int i;
>>> +
>>> +	for (i = 0; i < priv->fan_count; i++) {
>>> +		fan = priv->fan_data[i];
>>> +
>>> +		if (fan->suspend_cache)
>> How does the driver restore fan boost settings with a value of 0?
> We set to 0 when suspending so I don't think it's necessary to restore
> to 0 again when resuming.
>
I understand, in this case everything should be fine.

Thanks,
Armin Wolf

>> Thanks,
>> Armin Wolf
>>
>>> +			awcc_op_set_fan_boost(priv->wdev, fan->id, fan->suspend_cache);
>>> +	}
>>> +}
>>> +
>>>    /*
>>>     * Thermal Profile control
>>>     *  - Provides thermal profile control through the Platform Profile API
>>> @@ -1233,6 +1431,24 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
>>>    	return ret;
>>>    }
>>>
>>> +static int wmax_wmi_suspend(struct device *dev)
>>> +{
>>> +	if (awcc->hwmon)
>>> +		awcc_hwmon_suspend(dev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int wmax_wmi_resume(struct device *dev)
>>> +{
>>> +	if (awcc->hwmon)
>>> +		awcc_hwmon_resume(dev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +DEFINE_SIMPLE_DEV_PM_OPS(wmax_wmi_pm_ops, wmax_wmi_suspend, wmax_wmi_resume);
>>> +
>>>    static const struct wmi_device_id alienware_wmax_device_id_table[] = {
>>>    	{ WMAX_CONTROL_GUID, NULL },
>>>    	{ },
>>> @@ -1243,6 +1459,7 @@ static struct wmi_driver alienware_wmax_wmi_driver = {
>>>    	.driver = {
>>>    		.name = "alienware-wmi-wmax",
>>>    		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>>> +		.pm = pm_sleep_ptr(&wmax_wmi_pm_ops),
>>>    	},
>>>    	.id_table = alienware_wmax_device_id_table,
>>>    	.probe = wmax_wmi_probe,
>>>
>

