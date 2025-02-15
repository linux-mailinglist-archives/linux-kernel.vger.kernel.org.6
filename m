Return-Path: <linux-kernel+bounces-516384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E5FA37072
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 20:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FF5188E588
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBBE1EDA3F;
	Sat, 15 Feb 2025 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="UFEq0suH"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D11578F4B;
	Sat, 15 Feb 2025 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739648163; cv=none; b=FsGjlw2Z+AEs7WZ7x9vamoylFuooeprlJMmBsvqyo95mLUNje14t5XBq/W2lebVBjniEVTdOZA5S63lTHgc4ge4jZ7WYTlZiRMUpgDnOzchLs9P5lneuBN48+XtsHZ5QLss0fuRyYV73m5KXjUHmJbZA5HgpUljdqIt18igkcPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739648163; c=relaxed/simple;
	bh=c+77P+CeCwpPbzD2Z3RL5T2OxM7qMYXw+vkgE9vWEuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiDkaSFcEWVm3Rq0uH6XkvqmxxzijkTEOm5TVEvLCo20DkOeggkxdsGHhASecNghCJpsHx+1m14IErrMtVmr50/APhxCjn7VT19p4XHSpDB54BXoN976rSotGp/XN56i67mRDt/fftqB/2xqnFpB2dRbJcqxrBhxPzXgXNrBmgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=UFEq0suH; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739648155; x=1740252955; i=w_armin@gmx.de;
	bh=fd3DQucLmbpCHhWlBe3NSl+CD9pYPIDbqFnHpaPD6vk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UFEq0suH5HzK3YKcBur0GbPEEU7xj9hkdIyQCY8nor4v1q+832cXMpzDHbeIX3mk
	 DjFeWF584xZQN8z9XozmSo1M3OZ/gUPG/4F5jj7fkRPMmxfY2RbbZLrdWLJSJKFNm
	 A+5EXuoI7JXVlA36YalQN9YNP1jPMkHfx/Nv9iMRTPHhy79yES+XTf0/3nCFJBl8q
	 aV2HqHjdgeD4sud0NrlXFNH9KlW5/MauZQEEanCNG0KH8qu0XwFtILCe549oACLqO
	 ilwUBQ+irBpN+lth2OuFztII0ARsZmhULvj+OhbMVzeiagt3jFI1y4BPAAMKRk6Ts
	 ONV5WztQerEGL2/YsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XU1-1tEdj81twH-00xMpV; Sat, 15
 Feb 2025 20:35:55 +0100
Message-ID: <d53c7f66-8efb-4df5-a372-5598aa1f3e01@gmx.de>
Date: Sat, 15 Feb 2025 20:35:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/3] platform/x86: acer-wmi: Fix setting of fan
 behavior
To: Kurt Borja <kuurtb@gmail.com>, jlee@suse.com, basak.sb2006@gmail.com,
 rayanmargham4@gmail.com
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250215174544.8790-1-W_Armin@gmx.de>
 <20250215174544.8790-2-W_Armin@gmx.de> <D7T8UQ8PJ7BH.3DGKE2REW8025@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <D7T8UQ8PJ7BH.3DGKE2REW8025@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:MwxIggLEqNcEqPPL3Q5TLFAMFKXjUWlFujEiLFlebJU5GsJLOfi
 ngxyoYHqhkhoYu8M+NesMiiRkans+MXJR4NETZZQ/Jk26JyOmhhHkZpxuALPBOAHbVJx97i
 zbhGppvWdXcj2H4QOGtLA5CLWKY6xQyC5Wlz46LJsWEfUBCclC1JjiDbsDXMPlkM5VIxb2i
 sv3YT8PnCeqjL9b4gdONw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J2Gx4zBtoxE=;qia41CE4fgzpYhsOjrJbTCB5GIq
 O0RPKVPebBiWFFqiUl1ckj4QrMfV4Zf+DJYakRvBQTS9xy2xsbk0reog+0hYDATxaVOWR3+av
 OauE9uHn9NTcA/2fexQEunlLVxicJgW/PtNR97UPuVgURRyq6s34el9TAcMsmUr454fNNMotf
 YPbgTjjTFWWLC+SrbsPWt7eprqrzOTZXNqjlly9HtF2tFI95+WogSHbM/XyAeyG/IL5I6vg24
 Gz9gnCmQeKKsyUrYbfiK8hvh07ZUwK8r5PcIJF7XYOaKjwPeicDtO9skJ2ME8tNX8eLRqdbEm
 n/mraPMILZfg2htm+eTjqrTYqAIwEF22M3o6xXY9g8COsDocWMwrnZtRUkcy3m3JVUvXnvyDp
 xiRn049jGPgS/l9HMTt0PI3uqfi7Q9V73USgA7yuUXo+wyDS0ECBiPNcKr/LWzLqg0CqMPPD5
 WT3LQ12awXnm6jmf3j3Mn4BtP202umph2QaWACb1229rOkcQcOORzOBR2sqN4I+qHdGMHJrLs
 ehchv1oS2NGqpXdOLDicOU/4HI+ym9p/AxTzRfC3mrIG5+gRNiZBaFSCErxuMb+ReYXd2P9ev
 KMTS+DyqatjwbJGLOIwEAraIGfszSQoAUHnYOUCAKjOuJTt0x58Blxf6WdOf2ixb9fMf9CZga
 +HesuO/Bcqij80T/Ma37RCEA3jpn4ahe1ybWiOQuPR/QRkBH/Ok6YZjzsLC7Vj+9J8Lob2SH0
 dsSmttURCVdb+ZZUi80SFM5rQ4/uVzD/q48In8J0tjxaIXvD8JvD7/QBJN2vipy8YXMVCzgdD
 x3ipDlefM29nZyQnixyN41347529pCEVjES3ybwyUwgbUFhVpAYoneLekM+Quq9SoZU9vvRTb
 C9FGtMU4/fhp6ONfSUv8cY/pfORygm/Fe16lqQXsXBrZJzonGT4DA+/0nZfJDLH7TSW63yeM4
 BVY8hmOHW0KY2oO9XnkIyfLT6hLqVEmYDeX8/d5XTb0HlMNXJKU/6w2jUZ9GpDiwAz+RQa9aQ
 CoOimZAdYtObItQ/ya3nXOLYPi6J8bxAy7L/xUJRVkDYuwPp2GSxGA5hWAH2lJ+FgP5Rxymc+
 UMA93v9zQaetCmgiHG9P1oJ5QWDA9x6LxHix0xdkJX8GeXnCHkxA9xxqMcTVB8azCvrLJR7sO
 tIieenoWGHj0gNH/ubx3ELB+8ZBUIwz7ejyQZfOUn7s+ZA4F1/+8//lbBV9393NX7GC4NxBII
 KahRDl0kTMoAijSdLbISlc9z1VwF94i7In8RMLQ3xCRFdAOoRzqQ7lwtLVWOnVb8ZC454LwW1
 KMf/JaS4B4jYsq4pJhenjJs2vkwAeMXWcjfLM7m0D/CZLsL6docLadIox0PMVt+c3z5psnmL7
 ZkH5GeBr8/nuiY0RIuYKxlWLbxDvLdCOeBaqE35huadIqgVu/LXHWvSV6MkYNZylkUuUKaZHw
 /EvJa0I24UYUGxw8JqVYGntM1/2w=

Am 15.02.25 um 19:51 schrieb Kurt Borja:

> On Sat Feb 15, 2025 at 12:45 PM -05, Armin Wolf wrote:
>> After studying the linuwu_sense driver
>> (https://github.com/0x7375646F/Linuwu-Sense) i was able to understand
>> the meaning of the SetGamingFanBehavior() WMI method:
>>
>> - the first 16-bit are a bitmap of all fans affected by a fan behavior
>>    change request.
>>
>> - the next 8 bits contain four fan mode fields (2-bit), each being
>>    associated with a bit inside the fan bitmap.
>>
>> There are three fan modes: auto, turbo and custom.
>>
>> Use this newfound knowledge to fix the turbo fan handling by setting
>> the correct bits before calling SetGamingFanBehavior(). Also check
>> the result of the WMI method call and return an error should the ACPI
>> firmware signal failure.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/acer-wmi.c | 75 +++++++++++++++++++++++----------
>>   1 file changed, 52 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
>> index 69336bd778ee..f20a882e3650 100644
>> --- a/drivers/platform/x86/acer-wmi.c
>> +++ b/drivers/platform/x86/acer-wmi.c
>> @@ -68,10 +68,19 @@ MODULE_LICENSE("GPL");
>>   #define ACER_WMID_SET_GAMING_LED_METHODID 2
>>   #define ACER_WMID_GET_GAMING_LED_METHODID 4
>>   #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
>> -#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
>> +#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
>>   #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
>>   #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23
>>
>> +#define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
>> +#define ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK GENMASK_ULL(23, 16)
>> +
>> +#define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
>> +#define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
>> +
>> +#define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
>> +#define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)
>> +
>>   #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
>>   #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
>>   #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
>> @@ -121,6 +130,12 @@ enum acer_wmi_predator_v4_sensor_id {
>>   	ACER_WMID_SENSOR_GPU_TEMPERATURE	= 0x0A,
>>   };
>>
>> +enum acer_wmi_gaming_fan_mode {
>> +	ACER_WMID_FAN_MODE_AUTO		= 0x01,
>> +	ACER_WMID_FAN_MODE_TURBO	= 0x02,
>> +	ACER_WMID_FAN_MODE_CUSTOM	= 0x03,
>> +};
>> +
>>   enum acer_wmi_predator_v4_oc {
>>   	ACER_WMID_OC_NORMAL			= 0x0000,
>>   	ACER_WMID_OC_TURBO			= 0x0002,
>> @@ -1565,9 +1580,6 @@ static acpi_status WMID_gaming_set_u64(u64 value, u32 cap)
>>   	case ACER_CAP_TURBO_LED:
>>   		method_id = ACER_WMID_SET_GAMING_LED_METHODID;
>>   		break;
>> -	case ACER_CAP_TURBO_FAN:
>> -		method_id = ACER_WMID_SET_GAMING_FAN_BEHAVIOR;
>> -		break;
>>   	default:
>>   		return AE_BAD_PARAMETER;
>>   	}
>> @@ -1618,25 +1630,42 @@ static int WMID_gaming_get_sys_info(u32 command, u64 *out)
>>   	return 0;
>>   }
>>
>> +static int WMID_gaming_set_fan_behavior(u16 fan_bitmap, u8 mode_bitmap)
>> +{
>> +	acpi_status status;
>> +	u64 input = 0;
>> +	u64 result;
>> +
>> +	input |= FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitmap);
>> +	input |= FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK, mode_bitmap);
>> +
>> +	status = WMI_gaming_execute_u64(ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID, input,
>> +					&result);
>> +	if (ACPI_FAILURE(status))
>> +		return -EIO;
>> +
>> +	/* TODO: Proper error handling */
>> +	pr_notice("Fan behavior return status: %llu\n", result);
> I guess this is missing some ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK
> handling right? This shouldn't mess with testing tho.

Yes, i need to wait for the hardware testers to give feedback before i can implement this.

>> +
>> +	return 0;
>> +}
>> +
>>   static void WMID_gaming_set_fan_mode(u8 fan_mode)
>>   {
>> -	/* fan_mode = 1 is used for auto, fan_mode = 2 used for turbo*/
>> -	u64 gpu_fan_config1 = 0, gpu_fan_config2 = 0;
>> -	int i;
>> -
>> -	if (quirks->cpu_fans > 0)
>> -		gpu_fan_config2 |= 1;
>> -	for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
>> -		gpu_fan_config2 |= 1 << (i + 1);
> I agree on with your explaination in the previous thread, so after the
> TODO is addressed:
>
> Reviewed-by: Kurt Borja <kuurtb@gmail.com>
>
> I do wonder tho, isn't there a WMI operation to get the bitmap of
> available fans? Like in the case of available thermal profiles and
> sensors.

I do not know. There are a couple of other fan-related WMI methods available but they seem
to do something else.

For now i use the hwmon interface for detecting the presence of the CPU and GPU fan. I suspect
that the second GPU fan can also be detected using the hwmon interface.

Thanks,
Armin Wolf


