Return-Path: <linux-kernel+bounces-551955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7327CA5735E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6AC17767E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7FD2571C1;
	Fri,  7 Mar 2025 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qyTweqvx"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A86E187346;
	Fri,  7 Mar 2025 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381815; cv=none; b=IaApYhE0LRlbAphsJbl/ufWeg4iz4vxoIWfJ9j3UkNQrZMJKMkDpRfKwSjMvxx53VB9H0FHfF4iS2xMqmYWhAcrDweIH15QoQK0trszqY96AGUceJfIVj6aqDe2rbxGVRNQqQbTui0DDUddAjvHIu4LWR3L5lIfQQP2jGJhQShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381815; c=relaxed/simple;
	bh=5YsWDsAjTmqLUDN5MmZc5e0Bs4UULrGoSrIMvrGxSLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m87UD1fke1VcFkJFZGFEQcmqBi5L8yqDUsbawFBzIwgq9WBrkkQmEs+WVymeWY+wnGRNDGJYWgU6faqUxiy75cZz9cBhyZ/2Fh6mI53xpRnIHijDwa5riBX9NwU8ve8a0TZ1XIZ2uXywmszm91LdV/U+nVUOEZ1ubYkN41cXMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qyTweqvx; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741381796; x=1741986596; i=w_armin@gmx.de;
	bh=1st1NqSYZkfkdR/VlZZKmx/9nhbI7EASyfwI9dFYv9c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qyTweqvxL3joqdqbPo64FwA0iSmELT4t0Uyq+FCj8L3u4T9t5jpzk8MuofpOAffQ
	 lHkCJbdzJr6mAW/jB2Yc4HCMrfvYZT8NOlkl9UhIgdyx55UKIBRjGr1tOsybQWv3N
	 TqcGwmYlJehRIDSi0CcMJcCvFqlkchekyKsQxz9/XgQnS1beuJ2Tu2b3YxjEs3TXw
	 vcIAiihiJ2ALcvJ6BEtg7fwxVNT5VypB3gG69K4mIwNibSoJp7CAPH74cp0FvrSRx
	 CNvU/duxgQk7vzHKyUOwzStljFaN2vwzQjWRSvEWTz8+m/D+ScVy+vexgtfQCo2zT
	 DgtWI8o9JKEkl/ZOOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRMs-1tgfbr3HgK-00NK9X; Fri, 07
 Mar 2025 22:09:56 +0100
Message-ID: <7fbf0553-e6b3-4964-9210-8cd720ae9c9e@gmx.de>
Date: Fri, 7 Mar 2025 22:09:52 +0100
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
 <a375d474-5349-4662-8ce8-4f8f55349901@gmx.de>
 <D89M2ZQJEH45.1HKFFX5ESXRSJ@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <D89M2ZQJEH45.1HKFFX5ESXRSJ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KjRBCkbngy7hKLB+T1rt+pWimHFaI1f7TPTut/AffzoS9Vp4Jqp
 lSCtrrf15YjQomXOWwPBNaRJbSRY96bjyh5haIoMoYqPNJXy1IGhFnciO9CdTbaF8SN0KG+
 qfAkPJbLy+S4uiBdD4nr0BKTYeIiwhWkGksV0xpPFnPj5Qedykw+JnvECjblIXQ18oIlLhz
 zO1dkCRZiCymEr9XQQHpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X9fEFTYavKo=;dcMqc0euV8Ryahknfb//nKvmihQ
 J/mNK1E8dEg7JpuzA+u+GGnEA26Is0DfcuV2BNWAHgttCKRIoItj8vLAuCq3ySZ30QAqRzVRd
 4FheyzAIk1RicTPSHFDKx0Eau0K7tC/j49FjaraIY66xXw5SmNUK1SFsu2+68Nrk9e7u2MlHD
 tnkgoNSkQvl21zrfKpff8gM0OF93xtpxtARwfeugA1LvxBWYnAD2sZAE3vp2tUDPetIesktJX
 npjnjwDm2BvbresPo/PTsLMu20sjyugDgwYasUPDnxv7iCwJmPHdZlR0PTS2pPo6U0SmI+YJK
 PhIji5kc3hvLZXW6Rf2ufLnpX48SIGZZu5j2/3I6r3SLajwMsx3R0jzgCI6QtRgKJkxNJhOLa
 06f77h2a63M10v4vlAQKKjVPlzVHj7jjgmyiTqlvUmV19mlc5IE78kivrhQ/0TXMy+FDBRZY3
 gc77EkH+Z5ZZ6hfkrD+Y2cmTDrYdsqYG2cZB9ywv3h7Gd3GUWNQdpJP8LYqPNX00sTH6D1HUc
 XKJnkAYs/NzJferst2/cCDpcOZRS6xD+rmvlUUSmLSEZ/mCPM9MbzqPRMIPupcFA+Y8/7xLXB
 BVOp5zPyrOHgDqX/NW8774z08aCR7XgzriINrdP5xduSPtXUgCcNqy4eiCkjUdO11KsOsZRBh
 wwUqcazdi5S9D+RbWCnlIMJ3HUBP3c7qlB/JKkqsqKO6UNg1iC3tazWJLAUfDYP/NZE7/ilmX
 wR+dlzqdbfWe6Iwhh3hrPUiDa4htmBMCsV0+Dd6QidibB7fRmLthtW7xypZ3yV2lOv5AII4Kv
 +S5tYQS5wsBWx5O1kZLY9tjYh2Va4TCOF69oRMq+u2Y5YQu0ieeE8ojc+GsaP4jpp+xZDCR/S
 0bv/cl/dfRPhmLSqOtmrMzlrFWaakyel9wjgRmOvLY4xQNw6jmiHQrQmIUnQqFyOLlDbnXudF
 fIP6RQpU141HMfzIeYKt1C2eIq6V8RCfyuZnHohOC+qm+k0/nSfZjfRg44fa2hnylfD4JJZTc
 iL7VgGDMhn22t20vlpb3saI7TzXFDqvo4LJlPylQTRRT1wMJJwuDFKfdU8am45fwYQQCQS35K
 NOegqAZ/oKM335F801oUWkkPPSpFzZhbaOShWT8ZYfpX1ARGoZgySz36mL7FrNp7PaApFPFLd
 GKJ8nyXI3NGp4hUBjKlkAfgNwA4y6wTvXwTtsIvBT4UxbXdjMSXaNVJyKCkEMsrM0uH0fNGrE
 JlFDh3cNEf3NKWjlHYUuUVFf4flAZWt0KbwJ8R5Mxuw2FCuFfOcySEtyVJQ0f+ozP6nZIGhPY
 wPNG3O8MDTbJ7k20vH2SRf2tgjBEC1CBg9TiNCaV3tC2PgEoZ5OYC79XPH1S3uhzsF3Glrc6e
 iOky8Mcv71LdJ+QjchY8D8OEXo/ZMua2TfA5MLG6zoxajui3bALF8/De/e

Am 07.03.25 um 01:35 schrieb Kurt Borja:

> On Thu Mar 6, 2025 at 5:19 PM -05, Armin Wolf wrote:
>> Am 06.03.25 um 01:56 schrieb Kurt Borja:
>>
>>> All models with the "AWCC" WMAX device support monitoring fan speed and
>>> temperature sensors. Expose this feature through the HWMON interface.
>>>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: Jean Delvare <jdelvare@suse.com>
>>> Cc: linux-hwmon@vger.kernel.org
>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>> ---
>>>    drivers/platform/x86/dell/Kconfig              |   1 +
>>>    drivers/platform/x86/dell/alienware-wmi-wmax.c | 431 +++++++++++++++++++++++++
>>>    2 files changed, 432 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
>>> index f8a0dffcaab7c3b423472c5b9093011334a698c8..85a57c01aaada5d899cd8252e77ed6043da5cbdf 100644
>>> --- a/drivers/platform/x86/dell/Kconfig
>>> +++ b/drivers/platform/x86/dell/Kconfig
>>> @@ -43,6 +43,7 @@ config ALIENWARE_WMI_WMAX
>>>    	bool "Alienware WMAX WMI device driver"
>>>    	default y
>>>    	depends on ALIENWARE_WMI
>>> +	depends on HWMON
>>>    	select ACPI_PLATFORM_PROFILE
>>>    	help
>>>    	 Alienware WMI driver with AlienFX LED, HDMI, amplifier, deep sleep and
>>> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
>>> index 71fc17e8d103146b8edf53a552ae5ba64414e873..20cf3371ee3c0e1ea038b3ca517e831f3b30dc29 100644
>>> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
>>> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
>>> @@ -9,10 +9,13 @@
>>>    #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>>
>>>    #include <linux/bitfield.h>
>>> +#include <linux/bitmap.h>
>>>    #include <linux/bits.h>
>>>    #include <linux/dmi.h>
>>> +#include <linux/hwmon.h>
>>>    #include <linux/moduleparam.h>
>>>    #include <linux/platform_profile.h>
>>> +#include <linux/units.h>
>>>    #include <linux/wmi.h>
>>>    #include "alienware-wmi.h"
>>>
>>> @@ -25,6 +28,7 @@
>>>    #define WMAX_METHOD_BRIGHTNESS			0x3
>>>    #define WMAX_METHOD_ZONE_CONTROL		0x4
>>>
>>> +#define AWCC_METHOD_GET_FAN_SENSORS		0x13
>>>    #define AWCC_METHOD_THERMAL_INFORMATION		0x14
>>>    #define AWCC_METHOD_THERMAL_CONTROL		0x15
>>>    #define AWCC_METHOD_GAME_SHIFT_STATUS		0x25
>>> @@ -39,6 +43,10 @@
>>>    /* Arbitrary limit based on supported models */
>>>    #define AWCC_MAX_RES_COUNT			16
>>>
>>> +static bool force_hwmon;
>>> +module_param_unsafe(force_hwmon, bool, 0);
>>> +MODULE_PARM_DESC(force_hwmon, "Force probing for HWMON support without checking if the WMI backend is available");
>>> +
>>>    static bool force_platform_profile;
>>>    module_param_unsafe(force_platform_profile, bool, 0);
>>>    MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting thermal profiles without checking if WMI thermal backend is available");
>>> @@ -48,16 +56,19 @@ module_param_unsafe(force_gmode, bool, 0);
>>>    MODULE_PARM_DESC(force_gmode, "Forces G-Mode when performance profile is selected");
>>>
>>>    struct awcc_quirks {
>>> +	bool hwmon;
>>>    	bool pprof;
>>>    	bool gmode;
>>>    };
>>>
>>>    static struct awcc_quirks g_series_quirks = {
>>> +	.hwmon = true,
>>>    	.pprof = true,
>>>    	.gmode = true,
>>>    };
>>>
>>>    static struct awcc_quirks generic_quirks = {
>>> +	.hwmon = true,
>>>    	.pprof = true,
>>>    	.gmode = false,
>>>    };
>>> @@ -155,9 +166,18 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
>>>    	},
>>>    };
>>>
>>> +enum AWCC_GET_FAN_SENSORS_OPERATIONS {
>>> +	AWCC_OP_GET_TOTAL_FAN_TEMPS		= 0x01,
>>> +	AWCC_OP_GET_FAN_TEMP_ID			= 0x02,
>>> +};
>>> +
>>>    enum AWCC_THERMAL_INFORMATION_OPERATIONS {
>>>    	AWCC_OP_GET_SYSTEM_DESCRIPTION		= 0x02,
>>>    	AWCC_OP_GET_RESOURCE_ID			= 0x03,
>>> +	AWCC_OP_GET_TEMPERATURE			= 0x04,
>>> +	AWCC_OP_GET_FAN_RPM			= 0x05,
>>> +	AWCC_OP_GET_FAN_MIN_RPM			= 0x08,
>>> +	AWCC_OP_GET_FAN_MAX_RPM			= 0x09,
>>>    	AWCC_OP_GET_CURRENT_PROFILE		= 0x0B,
>>>    };
>>>
>>> @@ -180,6 +200,12 @@ enum AWCC_SPECIAL_THERMAL_CODES {
>>>    	AWCC_SPECIAL_PROFILE_GMODE		= 0xAB,
>>>    };
>>>
>>> +enum AWCC_TEMP_SENSOR_TYPES {
>>> +	AWCC_TEMP_SENSOR_CPU			= 0x01,
>>> +	AWCC_TEMP_SENSOR_GPU			= 0x06,
>>> +	AWCC_TEMP_SENSOR_LAST
>>> +};
>>> +
>>>    enum awcc_thermal_profile {
>>>    	AWCC_PROFILE_USTT_BALANCED,
>>>    	AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
>>> @@ -216,6 +242,15 @@ struct wmax_u32_args {
>>>    	u8 arg3;
>>>    };
>>>
>>> +struct awcc_fan_data {
>>> +	unsigned long *related_temps;
>>> +	unsigned long *auto_channels_temp;
>>> +	u32 total_temps;
>>> +	u32 min_rpm;
>>> +	u32 max_rpm;
>>> +	u8 id;
>>> +};
>>> +
>>>    struct awcc_priv {
>>>    	struct wmi_device *wdev;
>>>    	union {
>>> @@ -231,6 +266,11 @@ struct awcc_priv {
>>>
>>>    	struct device *ppdev;
>>>    	u8 supported_profiles[PLATFORM_PROFILE_LAST];
>>> +
>>> +	struct device *hwdev;
>>> +	struct awcc_fan_data **fan_data;
>>> +	unsigned int temp_sensors_size;
>>> +	unsigned long *temp_sensors;
>>>    };
>>>
>>>    static const enum platform_profile_option awcc_mode_to_platform_profile[AWCC_PROFILE_LAST] = {
>>> @@ -495,6 +535,19 @@ static int __awcc_wmi_command(struct wmi_device *wdev, u32 method_id,
>>>    	return 0;
>>>    }
>>>
>>> +static inline int awcc_get_fan_sensors(struct wmi_device *wdev, u8 operation,
>>> +				       u8 fan_id, u8 index, u32 *out)
>>> +{
>>> +	struct wmax_u32_args args = {
>>> +		.operation = operation,
>>> +		.arg1 = fan_id,
>>> +		.arg2 = index,
>>> +		.arg3 = 0,
>>> +	};
>>> +
>>> +	return __awcc_wmi_command(wdev, AWCC_METHOD_GET_FAN_SENSORS, &args, out);
>>> +}
>>> +
>>>    static inline int awcc_thermal_information(struct wmi_device *wdev, u8 operation,
>>>    					   u8 arg, u32 *out)
>>>    {
>>> @@ -552,6 +605,32 @@ static inline int awcc_op_get_resource_id(struct wmi_device *wdev, u8 index, u32
>>>    	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
>>>    }
>>>
>>> +static inline int awcc_op_get_fan_rpm(struct wmi_device *wdev, u8 fan_id, u32 *out)
>>> +{
>>> +	struct wmax_u32_args args = {
>>> +		.operation = AWCC_OP_GET_FAN_RPM,
>>> +		.arg1 = fan_id,
>>> +		.arg2 = 0,
>>> +		.arg3 = 0,
>>> +	};
>>> +
>>> +
>>> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
>>> +}
>>> +
>>> +static inline int awcc_op_get_temperature(struct wmi_device *wdev, u8 temp_id, u32 *out)
>>> +{
>>> +	struct wmax_u32_args args = {
>>> +		.operation = AWCC_OP_GET_TEMPERATURE,
>>> +		.arg1 = temp_id,
>>> +		.arg2 = 0,
>>> +		.arg3 = 0,
>>> +	};
>>> +
>>> +
>>> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
>>> +}
>>> +
>>>    static inline int awcc_op_get_current_profile(struct wmi_device *wdev, u32 *out)
>>>    {
>>>    	struct wmax_u32_args args = {
>>> @@ -599,6 +678,345 @@ static int awcc_profile_id_to_pprof(u32 id, enum platform_profile_option *profil
>>>    	return 0;
>>>    }
>>>
>>> +/*
>>> + * HWMON
>>> + *  - Provides temperature and fan speed monitoring as well as manual fan
>>> + *    control
>>> + */
>>> +static umode_t awcc_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_types type,
>>> +				     u32 attr, int channel)
>>> +{
>>> +	const struct awcc_priv *priv = drvdata;
>>> +	unsigned int temp_count;
>>> +
>>> +	switch (type) {
>>> +	case hwmon_temp:
>>> +		temp_count = bitmap_weight(priv->temp_sensors, priv->temp_sensors_size);
>>> +
>>> +		return channel < temp_count ? 0444 : 0;
>>> +	case hwmon_fan:
>>> +		return channel < priv->fan_count ? 0444 : 0;
>>> +	case hwmon_pwm:
>>> +		if (channel >= priv->fan_count)
>>> +			return 0;
>>> +
>>> +		switch (attr) {
>>> +		case hwmon_pwm_enable:
>> Please drop pwm_enable here and only introduce it inside the proper patch.
> Thanks, mb.
>
>>> +			return 0644;
>>> +		case hwmon_pwm_auto_channels_temp:
>>> +			return 0444;
>>> +		default:
>>> +			return 0;
>>> +		}
>>> +	default:
>>> +		return 0;
>>> +	}
>>> +}
>>> +
>>> +static int awcc_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>>> +			   u32 attr, int channel, long *val)
>>> +{
>>> +	struct awcc_priv *priv = dev_get_drvdata(dev);
>>> +	struct awcc_fan_data *fan;
>>> +	u32 state;
>>> +	int ret;
>>> +	u8 temp;
>>> +
>>> +	switch (type) {
>>> +	case hwmon_temp:
>>> +		temp = find_nth_bit(priv->temp_sensors, priv->temp_sensors_size, channel);
>>> +
>>> +		switch (attr) {
>>> +		case hwmon_temp_input:
>>> +			ret = awcc_op_get_temperature(priv->wdev, temp, &state);
>>> +			if (ret)
>>> +				return ret;
>>> +
>>> +			*val = state * MILLIDEGREE_PER_DEGREE;
>>> +			break;
>>> +		default:
>>> +			return -EOPNOTSUPP;
>>> +		}
>>> +
>>> +		break;
>>> +	case hwmon_fan:
>>> +		fan = priv->fan_data[channel];
>>> +
>>> +		switch (attr) {
>>> +		case hwmon_fan_input:
>>> +			ret = awcc_op_get_fan_rpm(priv->wdev, fan->id, &state);
>>> +			if (ret)
>>> +				return ret;
>>> +
>>> +			*val = state;
>>> +			break;
>>> +		case hwmon_fan_min:
>>> +			*val = fan->min_rpm;
>>> +			break;
>>> +		case hwmon_fan_max:
>>> +			*val = fan->max_rpm;
>>> +			break;
>>> +		default:
>>> +			return -EOPNOTSUPP;
>>> +		}
>>> +
>>> +		break;
>>> +	case hwmon_pwm:
>>> +		fan = priv->fan_data[channel];
>>> +
>>> +		switch (attr) {
>>> +		case hwmon_pwm_auto_channels_temp:
>>> +			bitmap_copy(val, fan->auto_channels_temp, BITS_PER_LONG);
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
>>> +static int awcc_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
>>> +				  u32 attr, int channel, const char **str)
>>> +{
>>> +	struct awcc_priv *priv = dev_get_drvdata(dev);
>>> +	struct awcc_fan_data *fan;
>>> +	u8 temp;
>>> +
>>> +	switch (type) {
>>> +	case hwmon_temp:
>>> +		temp = find_nth_bit(priv->temp_sensors, priv->temp_sensors_size, channel);
>>> +
>>> +		switch (temp) {
>>> +		case AWCC_TEMP_SENSOR_CPU:
>>> +			*str = "CPU";
>>> +			break;
>>> +		case AWCC_TEMP_SENSOR_GPU:
>>> +			*str = "GPU";
>>> +			break;
>>> +		default:
>>> +			*str = "Unknown";
>>> +			break;
>>> +		}
>>> +
>>> +		break;
>>> +	case hwmon_fan:
>>> +		fan = priv->fan_data[channel];
>>> +
>>> +		switch (fan->total_temps) {
>>> +		case 0:
>>> +			*str = "Independent Fan";
>>> +			break;
>>> +		case 1:
>>> +			temp = find_first_bit(fan->related_temps, priv->temp_sensors_size);
>>> +
>>> +			switch (temp) {
>>> +			case AWCC_TEMP_SENSOR_CPU:
>>> +				*str = "Processor Fan";
>>> +				break;
>>> +			case AWCC_TEMP_SENSOR_GPU:
>>> +				*str = "Video Fan";
>>> +				break;
>>> +			default:
>>> +				*str = "Unknown Fan";
>>> +				break;
>>> +			}
>>> +
>>> +			break;
>>> +		default:
>>> +			*str = "Shared Fan";
>>> +			break;
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
>>> +static const struct hwmon_ops awcc_hwmon_ops = {
>>> +	.is_visible = awcc_hwmon_is_visible,
>>> +	.read = awcc_hwmon_read,
>>> +	.read_string = awcc_hwmon_read_string,
>>> +};
>>> +
>>> +static const struct hwmon_channel_info * const awcc_hwmon_info[] = {
>>> +	HWMON_CHANNEL_INFO(temp,
>>> +			   HWMON_T_LABEL | HWMON_T_INPUT,
>>> +			   HWMON_T_LABEL | HWMON_T_INPUT,
>>> +			   HWMON_T_LABEL | HWMON_T_INPUT,
>>> +			   HWMON_T_LABEL | HWMON_T_INPUT,
>>> +			   HWMON_T_LABEL | HWMON_T_INPUT,
>>> +			   HWMON_T_LABEL | HWMON_T_INPUT
>>> +			   ),
>>> +	HWMON_CHANNEL_INFO(fan,
>>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX
>>> +			   ),
>>> +	HWMON_CHANNEL_INFO(pwm,
>>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP
>>> +			   ),
>> Since the number of fans and temperature sensors is only known at runtime creating awcc_hwmon_info
>> would make sense.
> IIRC Guenter asked another dev to add more CHANNEL_INFO entries instead
> of doing that? I might be wrong tho.
>
> I'm fine either way.
>
If Guenter is fine with your current approach then you can keep it.

>>> +	NULL
>>> +};
>>> +
>>> +static const struct hwmon_chip_info awcc_hwmon_chip_info = {
>>> +	.ops = &awcc_hwmon_ops,
>>> +	.info = awcc_hwmon_info,
>>> +};
>>> +
>>> +static int awcc_hwmon_temps_init(struct wmi_device *wdev)
>>> +{
>>> +	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
>>> +	unsigned long temp_sensors[BITS_TO_LONGS(U8_MAX)];
>>> +	unsigned int i, max_sensor_id = 0;
>>> +	int ret;
>>> +	u32 id;
>>> +
>>> +	for (i = 0; i < priv->temp_count; i++) {
>>> +		/*
>>> +		 * Temperature sensors IDs are listed after the fan IDs at
>>> +		 * offset `fan_count`
>>> +		 */
>>> +		ret = awcc_op_get_resource_id(wdev, i + priv->fan_count, &id);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		id = FIELD_GET(AWCC_RESOURCE_ID_MASK, id);
>>> +		if (id > max_sensor_id)
>>> +			max_sensor_id = id;
>>> +
>>> +		__set_bit(id, temp_sensors);
>>> +	}
>>> +
>>> +	/*
>>> +	 * We prefer to allocate the bitmap dynamically because usually temp IDs
>>> +	 * are small (< 0x30) and only one UL is needed to store it, but there
>>> +	 * may be unknown devices that break this rule
>>> +	 */
>> Hi,
>>
>> as far as i know the memory allocator inside the kernel at least allocates 32 bytes, so you are
> bytes? bits maybe?

I am sure it is bytes.

>> not saving any memory with this. I suggest you allocate the bitmaps statically.
> The thing is - We don't know before hand how big an ID can be.
>
> Technically the upper limit is U8_MAX which would require 4 ULs to
> store, which is a lot. However I haven't seen temp IDs bigger than 0x6,
> so this way only one UL is allocated for most devices.
>
> I would be very grateful if Dell could help us on this one :')
>
I think wasting 3 * 8 = 24 bytes is OK, especially if you allocate at least 32 bytes
for a dynamic bitmap either way.

Thanks,
Armin Wolf

>>> +	priv->temp_sensors_size = max_sensor_id + 1;
>>> +	priv->temp_sensors = devm_bitmap_zalloc(&wdev->dev, priv->temp_sensors_size,
>>> +						GFP_KERNEL);
>>> +	if (!priv->temp_sensors)
>>> +		return -ENOMEM;
>>> +
>>> +	bitmap_copy(priv->temp_sensors, temp_sensors, priv->temp_sensors_size);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int awcc_hwmon_fans_init(struct wmi_device *wdev)
>>> +{
>>> +	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
>>> +	u32 id, min_rpm, max_rpm, temp_count, temp_id;
>>> +	unsigned long gather[BITS_TO_LONGS(U8_MAX)];
>>> +	struct awcc_fan_data *fan_data;
>>> +	unsigned int i, j;
>>> +	int ret;
>>> +
>>> +	for (i = 0; i < priv->fan_count; i++) {
>>> +		fan_data = devm_kzalloc(&wdev->dev, sizeof(*fan_data), GFP_KERNEL);
>>> +		if (!fan_data)
>>> +			return -ENOMEM;
>>> +
>>> +		fan_data->related_temps = devm_bitmap_zalloc(&wdev->dev,
>>> +							     priv->temp_sensors_size,
>>> +							     GFP_KERNEL);
>> Same as above
>>
>>> +		if (!priv->temp_sensors)
>>> +			return -ENOMEM;
>>> +
>>> +		fan_data->auto_channels_temp = devm_bitmap_zalloc(&wdev->dev,
>>> +								  priv->temp_count,
>>> +								  GFP_KERNEL);
>> We already know that we only ever use the first sizeof(long) bytes from this bitmap,
>> please do a static allocation here.
> Right, ofc! I forgot about the limit I imposed.
>
>>> +		if (!priv->temp_sensors)
>>> +			return -ENOMEM;
>>> +
>>> +		/*
>>> +		 * Fan IDs are listed first at offset 0
>>> +		 */
>>> +		ret = awcc_op_get_resource_id(wdev, i, &id);
>>> +		if (ret)
>>> +			return ret;
>>> +		id = FIELD_GET(AWCC_RESOURCE_ID_MASK, id);
>>> +
>>> +		ret = awcc_thermal_information(wdev, AWCC_OP_GET_FAN_MIN_RPM, id,
>>> +					       &min_rpm);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		ret = awcc_thermal_information(wdev, AWCC_OP_GET_FAN_MAX_RPM, id,
>>> +					       &max_rpm);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		ret = awcc_get_fan_sensors(wdev, AWCC_OP_GET_TOTAL_FAN_TEMPS, id,
>>> +					   0, &temp_count);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		for (j = 0; j < temp_count; j++) {
>>> +			ret = awcc_get_fan_sensors(wdev, AWCC_OP_GET_FAN_TEMP_ID,
>>> +						   id, j, &temp_id);
>>> +			if (ret)
>>> +				break;
>>> +
>>> +			temp_id = FIELD_GET(AWCC_RESOURCE_ID_MASK, temp_id);
>>> +			if (temp_id < priv->temp_sensors_size)
>>> +				__set_bit(temp_id, fan_data->related_temps);
>>> +		}
>>> +
>>> +		fan_data->id = id;
>>> +		fan_data->min_rpm = min_rpm;
>>> +		fan_data->max_rpm = max_rpm;
>>> +		fan_data->total_temps = bitmap_weight(fan_data->related_temps,
>>> +						      priv->temp_sensors_size);
>>> +		bitmap_gather(gather, fan_data->related_temps, priv->temp_sensors,
>>> +			      priv->temp_sensors_size);
>> Since fan_data->related_temps is only used for determining the fan label after this it would
>> make sense to determine the fan label here and turn fan_data->related_temps into a local
>> variable on the stack.
> Ack.
>
>> Thanks,
>> Armin Wolf
> Thank you very much! Very helpful feedback :)
>
>>> +		bitmap_copy(fan_data->auto_channels_temp, gather, priv->temp_count);
>>> +		priv->fan_data[i] = fan_data;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int awcc_hwmon_init(struct wmi_device *wdev)
>>> +{
>>> +	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
>>> +	int ret;
>>> +
>>> +	priv->fan_data = devm_kcalloc(&wdev->dev, priv->fan_count,
>>> +				      sizeof(*priv->fan_data), GFP_KERNEL);
>>> +	if (!priv->fan_data)
>>> +		return -ENOMEM;
>>> +
>>> +	ret = awcc_hwmon_temps_init(wdev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = awcc_hwmon_fans_init(wdev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	priv->hwdev = devm_hwmon_device_register_with_info(&wdev->dev, "alienware_wmi", priv,
>>> +							   &awcc_hwmon_chip_info, NULL);
>>> +
>>> +	return PTR_ERR_OR_ZERO(priv->hwdev);
>>> +}
>>> +
>>>    /*
>>>     * Thermal Profile control
>>>     *  - Provides thermal profile control through the Platform Profile API
>>> @@ -753,6 +1171,12 @@ static int alienware_awcc_setup(struct wmi_device *wdev)
>>>    	priv->wdev = wdev;
>>>    	dev_set_drvdata(&wdev->dev, priv);
>>>
>>> +	if (awcc->hwmon) {
>>> +		ret = awcc_hwmon_init(wdev);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>>    	if (awcc->pprof) {
>>>    		ret = awcc_platform_profile_init(wdev);
>>>    		if (ret)
>>> @@ -833,6 +1257,13 @@ int __init alienware_wmax_wmi_init(void)
>>>    	if (id)
>>>    		awcc = id->driver_data;
>>>
>>> +	if (force_hwmon) {
>>> +		if (!awcc)
>>> +			awcc = &empty_quirks;
>>> +
>>> +		awcc->hwmon = true;
>>> +	}
>>> +
>>>    	if (force_platform_profile) {
>>>    		if (!awcc)
>>>    			awcc = &empty_quirks;
>>>
>

