Return-Path: <linux-kernel+bounces-357382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161669970B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47849B23BB2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0EC1FF7BD;
	Wed,  9 Oct 2024 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="tE7MJDLL"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265241E32B7;
	Wed,  9 Oct 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488997; cv=none; b=YOAi0XY9JfrF+noOpPfz/b2PJPfZRbHV83LRHR0CwYIIK7Bi7325ECRFF1YnveB33FfQfVzwLihZz7D2ErsT1vgD90x3NpQ6WTb79PR/MTOsYXFi9gfsbvzrZHlpsIpPO0e6j2sVsltSSQM/+hpe+podMOy+GyKcp8WebZNPLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488997; c=relaxed/simple;
	bh=rq78IESx5ts2EtUblB0yKMsuQh/dazegeohn+iiQXDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWVfiau+bdXL8qpJpuO8HK50uS63UFh4zSEYtjdoJRrylsUviBUFB6dTeo54HTM0p+hvOouYiIiAki1uagvtH9dqa0eAcU7h1o6+aRwRDFxVLzvmXLNiAPx8xJ/BHH3xo++W5KX+NIKiz8Vt+7TV5ApAV/ba/TRkA2IxPVuHejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=tE7MJDLL; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728488934; x=1729093734; i=w_armin@gmx.de;
	bh=cQ4JfM+zwcTt/gzsqYelbxHyQEzeinnDkVsrlQdRvsY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tE7MJDLLhHWsCKC0qSgTif3pwAo3eA+2RwRgklOvzQiEMUd9DgE5nI3bSD4NDmWx
	 KYgQrKu6TVzRbfiKQ5dzffNLYXNgMD5/CfeAA6pmtplbP0GLo8k7CTxZr6AKLx5Pw
	 vTTR1KVQ74cfWZwAgA2YFfdIJpjTrJ9qFyP2zIvRlvbgxsGRFeYyzYgn0EUVpRWqi
	 OoPxd3TRRyOHmJJIy8Gkjx0uqWgwNjSkuVJDfPkabehQzw8LPE1clNEjQuifarwlt
	 YKsoL5imS9FL67N4vQQKZOPZS6UwImoCnrOu5IZOUIIJHkwEg/lXJDBL2Ry3gwN5d
	 K++ONLGgPtFHwFTiQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.151.191] ([141.76.185.123]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNct-1tcrxy2xqh-00bdDO; Wed, 09
 Oct 2024 17:48:53 +0200
Message-ID: <7eb24067-bef7-416f-b002-3abdcf54b891@gmx.de>
Date: Wed, 9 Oct 2024 17:48:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] alienware-wmi: Dell AWCC platform_profile support
To: Kurt Borja <kuurtb@gmail.com>
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <d7ecb190-285a-4229-a8c8-3105b1f31d5d@gmx.de>
 <20241009144813.7704-1-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241009144813.7704-1-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BiE3rF7H9kfq+tjEFZ2f33tqNadccG9bpTZSgUHXMzAeFEvoR+E
 DNSO9s/2ieV9DsBbwz3hXhHKY+mHhlQ/Nzv2Fkwdc2kBgqBNI8ZzxVmEO+sGHRyQFjhXsLy
 6i1DMtT4RmPOQFGkQnqtL2gzSkcYnHE25nmpqQBNhOuIt3Go0MmWkkNOx6HpJx1vn1nuyKC
 0THb5sP3OTwqyDtONk4GA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mdslWCFULXw=;i2ShwTUylkGKs6rrVN9/+PGDVl2
 28hy2EI2J7Qhbd5QHAh0IHcQsQXRbPg2LvML5X9J47HgiSWdw/YEFhXGr7509/yNnSlA4bnka
 shxr2UuhfsuWu5j6IoX7A4tRuYBox3F0zs8SQFfNRHWwHpCct8pSz/QC5qRrOZ0mnspBTSpyU
 greq0QM26Sjvtp9mVlnbsxh90FsWNb7jc02TTC3INTsf3aK1phMKfHDTSKyCTUl+qvfRgSgaP
 OS2fGpiO/uIK/u53+aCmSIpkGT82QDkry6prqGsbl+5tWXZn1KB6YbdsJTgOYd5ZYg1ULSvuM
 adiMwhp0IvAobGL7tYhY9W4YliDpfE//ayMx2+KhSz46i69DzGt4qG3m8LKtjlGtujXlPyj3b
 wHC4zDerxrfU5XyrsdW0IO2T4abjVR7O3G+bkPJj1BoQFVmP54zhKIUAV0k/yJA51dBOLqO/f
 TAAR+7e455+MMX6izSTsLb1KWFgohFOyKKAwjQ9jw37B1bEOAMX0XA19wbUlmMf1BHAd1dHyL
 d8jDVRUChrHVP3GvsplfDJygnKhKqVB8m2tj0CYQFYOvclhFMkPTzGQOneZVUqvzjBP1xNCMN
 N8Nhke/ZcYjwGlnOhWhRgyQkYtCrBnMqaJptn+u5wWvbz85yA7qgZBh65eZYDdDxaZZ/RU26+
 S/DloKETL2cT1EsyIF98JA6OuhPRY8v05eOZtc7m35CU+f2WAr2KMc3JCfWNhTy3MOzDURSRY
 lzslqORPLxX1M/1uIO21k5AjIXtmGbAIFLiGGSUsW/WLDuiQy1cDi3kjmDgGfRZCGSMYaGjFv
 gl9dVXPhVvwUHKmG7o8FUkAtGvvlp03FOjudjHAEqYl7M=

Am 09.10.24 um 16:48 schrieb Kurt Borja:

> Yes, of course.
>
>>> This driver was heavily inspired on inspur_platform_profile, special
>>> thanks.
>>>
>>> Notes:
>>>    - Performance (FullSpeed) profile is a special profile which has it's own
>>>      entry in the Firmware Settings of the Alienware x15 R1. It also changes
>>>      the color of the F1 key. I suspect this behavior would be replicated in
>>>      other X-Series or M-Series laptops.
>>>    - G-Mode is a profile documented on [1] which mimics the behavior of
>>>      FullSpeed mode but it does not have an entry on the Firmware Settings of
>>>      the Alienware x15 R1, this may correspond to the G-Mode functionality on
>>>      G-Series laptops (activated by a special button) but I cannot test it. I
>>>      did not include this code in the driver as G-Mode causes unexpected
>>>      behavior on X-Series laptops.
>>>
>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>>
>>> ---
>>> v3:
>>>    - Removed extra empty line
>>>    - 0x0B named WMAX_ARG_GET_CURRENT_PROF
>>>    - Removed casts to the same type on functions added in this patch
>>>    - Thermal profile to WMAX argument is now an static function and makes
>>>      use of in-built kernel macros
>>>    - Platform profile is now removed only if it was created first
>>>    - create_platform_profile is now create_thermal_profile to avoid
>>>      confusion
>>>    - profile_get and profile_set functions renamed too to match the above
>>> v2:
>>>    - Moved functionality to alienware-wmi driver
>>>    - Added thermal and gmode quirks to add support based on dmi match
>>>    - Performance profile is now GMODE for devices that support it
>>>    - alienware_wmax_command now is insize agnostic to support new thermal
>>>      methods
>>> ---
>>>    drivers/platform/x86/dell/Kconfig         |   1 +
>>>    drivers/platform/x86/dell/alienware-wmi.c | 238 ++++++++++++++++++++--
>>>    2 files changed, 226 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
>>> index 68a49788a..b06d634cd 100644
>>> --- a/drivers/platform/x86/dell/Kconfig
>>> +++ b/drivers/platform/x86/dell/Kconfig
>>> @@ -21,6 +21,7 @@ config ALIENWARE_WMI
>>>    	depends on LEDS_CLASS
>>>    	depends on NEW_LEDS
>>>    	depends on ACPI_WMI
>>> +	select ACPI_PLATFORM_PROFILE
>>>    	help
>>>    	 This is a driver for controlling Alienware BIOS driven
>>>    	 features.  It exposes an interface for controlling the AlienFX
>>> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
>>> index f5ee62ce1..e3ef4b10b 100644
>>> --- a/drivers/platform/x86/dell/alienware-wmi.c
>>> +++ b/drivers/platform/x86/dell/alienware-wmi.c
>>> @@ -10,6 +10,7 @@
>>>    #include <linux/acpi.h>
>>>    #include <linux/module.h>
>>>    #include <linux/platform_device.h>
>>> +#include <linux/platform_profile.h>
>>>    #include <linux/dmi.h>
>>>    #include <linux/leds.h>
>>>
>>> @@ -25,6 +26,10 @@
>>>    #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
>>>    #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
>>>    #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
>>> +#define WMAX_METHOD_THERMAL_INFORMATION	0x14
>>> +#define WMAX_METHOD_THERMAL_CONTROL	0x15
>>> +
>>> +#define WMAX_ARG_GET_CURRENT_PROF	0x0B
>>>
>>>    MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
>>>    MODULE_DESCRIPTION("Alienware special feature control");
>>> @@ -49,11 +54,22 @@ enum WMAX_CONTROL_STATES {
>>>    	WMAX_SUSPEND = 3,
>>>    };
>>>
>>> +enum WMAX_THERMAL_PROFILE {
>>> +	WMAX_THERMAL_QUIET = 0xA3,
>>> +	WMAX_THERMAL_BALANCED = 0xA0,
>>> +	WMAX_THERMAL_BALANCED_PERFORMANCE = 0xA1,
>>> +	WMAX_THERMAL_PERFORMANCE = 0xA4,
>>> +	WMAX_THERMAL_GMODE = 0xAB,
>>> +	WMAX_THERMAL_LOW_POWER	= 0xA5,
>>> +};
>>> +
>>>    struct quirk_entry {
>>>    	u8 num_zones;
>>>    	u8 hdmi_mux;
>>>    	u8 amplifier;
>>>    	u8 deepslp;
>>> +	u8 thermal;
>>> +	u8 gmode;
>>>    };
>>>
>>>    static struct quirk_entry *quirks;
>>> @@ -64,6 +80,8 @@ static struct quirk_entry quirk_inspiron5675 = {
>>>    	.hdmi_mux = 0,
>>>    	.amplifier = 0,
>>>    	.deepslp = 0,
>>> +	.thermal = 0,
>>> +	.gmode = 0,
>>>    };
>>>
>>>    static struct quirk_entry quirk_unknown = {
>>> @@ -71,6 +89,8 @@ static struct quirk_entry quirk_unknown = {
>>>    	.hdmi_mux = 0,
>>>    	.amplifier = 0,
>>>    	.deepslp = 0,
>>> +	.thermal = 0,
>>> +	.gmode = 0,
>>>    };
>>>
>>>    static struct quirk_entry quirk_x51_r1_r2 = {
>>> @@ -78,6 +98,8 @@ static struct quirk_entry quirk_x51_r1_r2 = {
>>>    	.hdmi_mux = 0,
>>>    	.amplifier = 0,
>>>    	.deepslp = 0,
>>> +	.thermal = 0,
>>> +	.gmode = 0,
>>>    };
>>>
>>>    static struct quirk_entry quirk_x51_r3 = {
>>> @@ -85,6 +107,8 @@ static struct quirk_entry quirk_x51_r3 = {
>>>    	.hdmi_mux = 0,
>>>    	.amplifier = 1,
>>>    	.deepslp = 0,
>>> +	.thermal = 0,
>>> +	.gmode = 0,
>>>    };
>>>
>>>    static struct quirk_entry quirk_asm100 = {
>>> @@ -92,6 +116,8 @@ static struct quirk_entry quirk_asm100 = {
>>>    	.hdmi_mux = 1,
>>>    	.amplifier = 0,
>>>    	.deepslp = 0,
>>> +	.thermal = 0,
>>> +	.gmode = 0,
>>>    };
>>>
>>>    static struct quirk_entry quirk_asm200 = {
>>> @@ -99,6 +125,8 @@ static struct quirk_entry quirk_asm200 = {
>>>    	.hdmi_mux = 1,
>>>    	.amplifier = 0,
>>>    	.deepslp = 1,
>>> +	.thermal = 0,
>>> +	.gmode = 0,
>>>    };
>>>
>>>    static struct quirk_entry quirk_asm201 = {
>>> @@ -106,6 +134,17 @@ static struct quirk_entry quirk_asm201 = {
>>>    	.hdmi_mux = 1,
>>>    	.amplifier = 1,
>>>    	.deepslp = 1,
>>> +	.thermal = 0,
>>> +	.gmode = 0,
>>> +};
>>> +
>>> +static struct quirk_entry quirk_x15_r1 = {
>>> +	.num_zones = 2,
>>> +	.hdmi_mux = 0,
>>> +	.amplifier = 0,
>>> +	.deepslp = 0,
>>> +	.thermal = 1,
>>> +	.gmode = 0,
>>>    };
>>>
>>>    static int __init dmi_matched(const struct dmi_system_id *dmi)
>>> @@ -169,6 +208,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
>>>    		     },
>>>    	 .driver_data = &quirk_asm201,
>>>    	 },
>>> +	 {
>>> +	 .callback = dmi_matched,
>>> +	 .ident = "Alienware x15 R1",
>>> +	 .matches = {
>>> +		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
>>> +		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R1")
>>> +		    },
>>> +	 .driver_data = &quirk_x15_r1,
>>> +	},
>>>    	 {
>>>    	 .callback = dmi_matched,
>>>    	 .ident = "Dell Inc. Inspiron 5675",
>>> @@ -218,6 +266,7 @@ static struct platform_device *platform_device;
>>>    static struct device_attribute *zone_dev_attrs;
>>>    static struct attribute **zone_attrs;
>>>    static struct platform_zone *zone_data;
>>> +static struct platform_profile_handler pp_handler;
>>>
>>>    static struct platform_driver platform_driver = {
>>>    	.driver = {
>>> @@ -500,7 +549,7 @@ static void alienware_zone_exit(struct platform_device *dev)
>>>    	kfree(zone_attrs);
>>>    }
>>>
>>> -static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
>>> +static acpi_status alienware_wmax_command(void *in_args, size_t insize,
>>>    					  u32 command, int *out_data)
>>>    {
>> Can you split this change into a separate patch? This would make review a bit easier.
>>
> Yes, sure. In that case should I mention this patch depends on that one
> in v4?

Yes, but only in the description of the resulting patch series.

Thanks,
Armin Wolf

>>>    	acpi_status status;
>>> @@ -508,7 +557,7 @@ static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
>>>    	struct acpi_buffer input;
>>>    	struct acpi_buffer output;
>>>
>>> -	input.length = (acpi_size) sizeof(*in_args);
>>> +	input.length = (acpi_size) insize;
>> Please drop the cast to acpi_size.
>>
> Ok.
>
>>>    	input.pointer = in_args;
>>>    	if (out_data) {
>>>    		output.length = ACPI_ALLOCATE_BUFFER;
>>> @@ -541,8 +590,8 @@ static ssize_t show_hdmi_cable(struct device *dev,
>>>    		.arg = 0,
>>>    	};
>>>    	status =
>>> -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
>>> -				   (u32 *) &out_data);
>>> +	    alienware_wmax_command(&in_args, sizeof(in_args),
>>> +				   WMAX_METHOD_HDMI_CABLE, (u32 *) &out_data);
>>>    	if (ACPI_SUCCESS(status)) {
>>>    		if (out_data == 0)
>>>    			return sysfs_emit(buf, "[unconnected] connected unknown\n");
>>> @@ -562,8 +611,8 @@ static ssize_t show_hdmi_source(struct device *dev,
>>>    		.arg = 0,
>>>    	};
>>>    	status =
>>> -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
>>> -				   (u32 *) &out_data);
>>> +	    alienware_wmax_command(&in_args, sizeof(in_args),
>>> +				   WMAX_METHOD_HDMI_STATUS, (u32 *) &out_data);
>>>
>>>    	if (ACPI_SUCCESS(status)) {
>>>    		if (out_data == 1)
>>> @@ -589,7 +638,8 @@ static ssize_t toggle_hdmi_source(struct device *dev,
>>>    		args.arg = 3;
>>>    	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
>>>
>>> -	status = alienware_wmax_command(&args, WMAX_METHOD_HDMI_SOURCE, NULL);
>>> +	status = alienware_wmax_command(&args, sizeof(args),
>>> +					WMAX_METHOD_HDMI_SOURCE, NULL);
>>>
>>>    	if (ACPI_FAILURE(status))
>>>    		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
>>> @@ -642,8 +692,8 @@ static ssize_t show_amplifier_status(struct device *dev,
>>>    		.arg = 0,
>>>    	};
>>>    	status =
>>> -	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
>>> -				   (u32 *) &out_data);
>>> +	    alienware_wmax_command(&in_args, sizeof(in_args),
>>> +				   WMAX_METHOD_AMPLIFIER_CABLE, (u32 *) &out_data);
>>>    	if (ACPI_SUCCESS(status)) {
>>>    		if (out_data == 0)
>>>    			return sysfs_emit(buf, "[unconnected] connected unknown\n");
>>> @@ -694,8 +744,8 @@ static ssize_t show_deepsleep_status(struct device *dev,
>>>    	struct wmax_basic_args in_args = {
>>>    		.arg = 0,
>>>    	};
>>> -	status = alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STATUS,
>>> -					(u32 *) &out_data);
>>> +	status = alienware_wmax_command(&in_args, sizeof(in_args),
>>> +					WMAX_METHOD_DEEP_SLEEP_STATUS, (u32 *) &out_data);
>>>    	if (ACPI_SUCCESS(status)) {
>>>    		if (out_data == 0)
>>>    			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
>>> @@ -723,8 +773,8 @@ static ssize_t toggle_deepsleep(struct device *dev,
>>>    		args.arg = 2;
>>>    	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, buf);
>>>
>>> -	status = alienware_wmax_command(&args, WMAX_METHOD_DEEP_SLEEP_CONTROL,
>>> -					NULL);
>>> +	status = alienware_wmax_command(&args, sizeof(args),
>>> +					WMAX_METHOD_DEEP_SLEEP_CONTROL, NULL);
>>>
>>>    	if (ACPI_FAILURE(status))
>>>    		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",
>>> @@ -760,6 +810,160 @@ static int create_deepsleep(struct platform_device *dev)
>>>    	return ret;
>>>    }
>>>
>>> +/*
>>> + * Thermal Profile control
>>> + *  - Provides thermal profile control through the Platform Profile API
>>> + */
>>> +#define PROFILE_MASK		GENMASK(15,8)
>>> +#define PROFILE_ACTIVATE	BIT(0)
>>> +
>>> +static u32 profile_to_wmax_arg(enum WMAX_THERMAL_PROFILE prof)
>>> +{
>>> +	return FIELD_PREP(PROFILE_MASK, prof) | PROFILE_ACTIVATE;
>>> +}
>>> +
>>> +static int thermal_profile_get(struct platform_profile_handler *pprof,
>>> +				enum platform_profile_option *profile)
>>> +{
>>> +	acpi_status status;
>>> +	u32 in_args = WMAX_ARG_GET_CURRENT_PROF;
>>> +	u32 out_data;
>>> +
>>> +	status = alienware_wmax_command(&in_args, sizeof(in_args),
>>> +					WMAX_METHOD_THERMAL_INFORMATION, &out_data);
>>> +
>>> +	if (ACPI_FAILURE(status))
>>> +		return -EOPNOTSUPP;
>> Please return -EIO.
>>
> Ok.
>
>>> +
>>> +	if (out_data == 0xFFFFFFFF)
>>> +		return -EBADRQC;
>>> +
>>> +	switch (out_data) {
>>> +	case WMAX_THERMAL_LOW_POWER:
>>> +		*profile = PLATFORM_PROFILE_LOW_POWER;
>>> +		break;
>>> +	case WMAX_THERMAL_QUIET:
>>> +		*profile = PLATFORM_PROFILE_QUIET;
>>> +		break;
>>> +	case WMAX_THERMAL_BALANCED:
>>> +		*profile = PLATFORM_PROFILE_BALANCED;
>>> +		break;
>>> +	case WMAX_THERMAL_BALANCED_PERFORMANCE:
>>> +		*profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
>>> +		break;
>>> +	case WMAX_THERMAL_PERFORMANCE:
>>> +	case WMAX_THERMAL_GMODE:
>>> +		*profile = PLATFORM_PROFILE_PERFORMANCE;
>>> +		break;
>>> +	default:
>>> +		return -ENODATA;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int thermal_profile_set(struct platform_profile_handler *pprof,
>>> +				enum platform_profile_option profile)
>>> +{
>>> +	acpi_status status;
>>> +	u32 in_args;
>>> +	u32 out_data;
>>> +
>>> +	switch (profile) {
>>> +	case PLATFORM_PROFILE_LOW_POWER:
>>> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_LOW_POWER);
>>> +		break;
>>> +	case PLATFORM_PROFILE_QUIET:
>>> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_QUIET);
>>> +		break;
>>> +	case PLATFORM_PROFILE_BALANCED:
>>> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED);
>>> +		break;
>>> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>>> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED_PERFORMANCE);
>>> +		break;
>>> +	case PLATFORM_PROFILE_PERFORMANCE:
>>> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_PERFORMANCE);
>>> +		break;
>>> +	default:
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +
>>> +	status = alienware_wmax_command(&in_args, sizeof(in_args),
>>> +					WMAX_METHOD_THERMAL_CONTROL, &out_data);
>>> +
>>> +	if (ACPI_FAILURE(status))
>>> +		return -EOPNOTSUPP;
>> Return -EIO.
>>
>>> +
>>> +	if (out_data == 0xFFFFFFFF)
>>> +		return -EBADRQC;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int gmode_thermal_profile_set(struct platform_profile_handler *pprof,
>>> +				     enum platform_profile_option profile)
>>> +{
>>> +	acpi_status status;
>>> +	u32 in_args;
>>> +	u32 out_data;
>>> +
>>> +	switch (profile) {
>>> +	case PLATFORM_PROFILE_LOW_POWER:
>>> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_LOW_POWER);
>>> +		break;
>>> +	case PLATFORM_PROFILE_QUIET:
>>> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_QUIET);
>>> +		break;
>>> +	case PLATFORM_PROFILE_BALANCED:
>>> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED);
>>> +		break;
>>> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>>> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED_PERFORMANCE);
>>> +		break;
>>> +	case PLATFORM_PROFILE_PERFORMANCE:
>>> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_GMODE);
>>> +		break;
>>> +	default:
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +
>>> +	status = alienware_wmax_command(&in_args, sizeof(in_args),
>>> +					WMAX_METHOD_THERMAL_CONTROL, &out_data);
>>> +
>>> +	if (ACPI_FAILURE(status))
>>> +		return -EOPNOTSUPP;
>> Return -EIO.
>>
>> Otherwise the patch looks quite good.
>>
> Thank you! It's my first time working on the kernel.
>
>> Thanks,
>> Armin Wolf
> Your feedback is appreciated.
>
> Kurt
>
>>> +
>>> +	if (out_data == 0xFFFFFFFF)
>>> +		return -EBADRQC;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int create_thermal_profile(void)
>>> +{
>>> +	pp_handler.profile_get = thermal_profile_get;
>>> +
>>> +	if (quirks->gmode > 0)
>>> +		pp_handler.profile_set = gmode_thermal_profile_set;
>>> +	else
>>> +		pp_handler.profile_set = thermal_profile_set;
>>> +
>>> +	set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
>>> +	set_bit(PLATFORM_PROFILE_QUIET, pp_handler.choices);
>>> +	set_bit(PLATFORM_PROFILE_BALANCED, pp_handler.choices);
>>> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pp_handler.choices);
>>> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
>>> +
>>> +	return platform_profile_register(&pp_handler);
>>> +}
>>> +
>>> +static void remove_thermal_profile(void)
>>> +{
>>> +	if (quirks->thermal > 0)
>>> +		platform_profile_remove();
>>> +}
>>> +
>>>    static int __init alienware_wmi_init(void)
>>>    {
>>>    	int ret;
>>> @@ -807,6 +1011,12 @@ static int __init alienware_wmi_init(void)
>>>    			goto fail_prep_deepsleep;
>>>    	}
>>>
>>> +	if (quirks->thermal > 0) {
>>> +		ret = create_thermal_profile();
>>> +		if (ret)
>>> +			goto fail_prep_thermal_profile;
>>> +	}
>>> +
>>>    	ret = alienware_zone_init(platform_device);
>>>    	if (ret)
>>>    		goto fail_prep_zones;
>>> @@ -817,6 +1027,7 @@ static int __init alienware_wmi_init(void)
>>>    	alienware_zone_exit(platform_device);
>>>    fail_prep_deepsleep:
>>>    fail_prep_amplifier:
>>> +fail_prep_thermal_profile:
>>>    fail_prep_hdmi:
>>>    	platform_device_del(platform_device);
>>>    fail_platform_device2:
>>> @@ -834,6 +1045,7 @@ static void __exit alienware_wmi_exit(void)
>>>    	if (platform_device) {
>>>    		alienware_zone_exit(platform_device);
>>>    		remove_hdmi(platform_device);
>>> +		remove_thermal_profile();
>>>    		platform_device_unregister(platform_device);
>>>    		platform_driver_unregister(&platform_driver);
>>>    	}

