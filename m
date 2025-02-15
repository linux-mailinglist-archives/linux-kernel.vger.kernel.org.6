Return-Path: <linux-kernel+bounces-516362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11407A37027
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47911893F6D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B31EA7DE;
	Sat, 15 Feb 2025 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="N33VS46v"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC492904;
	Sat, 15 Feb 2025 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739644644; cv=none; b=EErAwArd0zvEo18oAc8LtAsvWwK7JoksAxHg8u7+9BsdsKAtT6lhCnlxUQNbzIq1juKf1aLuDfeWxsNm9TQ1vCpvFbWzIhZUAFUBg3rc2lB+6o38kqk3obtYQ2QFkb9FnjhBxmhBpScpnB9c1Xf9ZG2s6+AfQ3W2teEtIFbitJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739644644; c=relaxed/simple;
	bh=gzLB9mud2C46ZO20xy6jFNBb0tNlfct24OmLEOYrGM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jw+Lj6nv0r7fVYq6krfkjsI5HF5GRi67cR/TNY5XLooxT6VaxdLqA+0IUoGtgQIKVxjFhI2Y/lS3qmJd3GCPv4rwx2IkShcyIJ6bZUPSRDE/w9pVro6WhV8hyeCSXkh3e4qdvUzKhW8VXeDKY68glRrV43nu4OXwbbh3LV6TzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=N33VS46v; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739644633; x=1740249433; i=w_armin@gmx.de;
	bh=1SkU3hK3yyAA8x/LrMSMGbGwQqUCGLI8aqw+QpMCHVo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N33VS46v5AQyH3voj/rYa3cCW+fKXQm0RIm5FhowIt7JXWPAOaxl9q9qR4x2XCib
	 qvKizJKlKBGMx13wfY9qNJUvdjTYSdkaZVsxt1hhponVRb68bKmp+MAoMmhBTUOP2
	 ifqoLCN8zqcJ+bH/hUAH+hnKVj3a2mC5/8ivMsnjjoy0/tgzvqzaZnbd5KeZNgeTJ
	 sXgSoI5p1hRm4PoXdRkiXzfizxBExcchAn6wRdXbbs+xLYUyEMNOw+gU1nZHNsei2
	 /zR2HL4PhdRVTH4aSeJcPzAUo7+v45XbxS62bNrgoDsDRcB0uUnFLCKLpUObAyqLO
	 +SRsvDfiX5vvDbdJpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNcz-1t9jEd34Ax-00aimQ; Sat, 15
 Feb 2025 19:37:12 +0100
Message-ID: <48489ea8-4eb0-4c08-84cf-1183054ac77c@gmx.de>
Date: Sat, 15 Feb 2025 19:37:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] platform/x86: acer-wmi: Fix setting of fan
 behavior
To: Kurt Borja <kuurtb@gmail.com>, jlee@suse.com, basak.sb2006@gmail.com,
 rayanmargham4@gmail.com
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250214221322.47298-1-W_Armin@gmx.de>
 <20250214221322.47298-2-W_Armin@gmx.de>
 <D7SMPVK7KM8E.3VYTBGLEVS109@gmail.com>
 <9170b163-9eeb-4710-add2-6cefaef1eaaf@gmx.de>
 <D7T7XHTX1SS2.NTHM4WBUN8EC@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <D7T7XHTX1SS2.NTHM4WBUN8EC@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yjxNm0JqjlAwHS2hy7J3PENyIfoVUP5AluccLevIgdsQ8U5BnBx
 WhI+2PcuiIskDwpN2UG04vudgOvgCTDxrPL5oKTJu744ewbuxR4/FLmcdcTqs+3FZNIMmIt
 a2Q/Sm+Eof/c+U2kcG8iSbcTlI+6O7yXjxcq1s+6fOhdUJY4VcRHE/SDe94RaDRpuOFQ1WE
 uumxm4MTjkQCOkIGiGiNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NDBRk1P7SE8=;htYkJtjuqFrtWHZPwt4AaEeuTF4
 ojJGsFXhuSc6RaOi9LqZ+wZGegIp0HrJrxxhKb8eYq12mNo3XAKqpK+TNkouDg2bnRhZgve9x
 hR5nWk9hqyF+E5Ix4fdS7oTNhnl6izWn8Z2jDNhEjBGaVxHmF6Mne2VlpV/6n2w7vKh9WsRS4
 UmG5zUx6U4dp5oOMIBXBlbUHHrtQCSAxcW6nGokyRtJOKaGA/xQoM7xbef7nSkzvth4gQ3YWr
 kP1gLGiJ5hqGZpplDsRt1181j9xCWT9j8haSN6HfWJCD+R2CEFs7giQ40YNOCCI7gxWuf5Z+/
 XzXN2s0/RNYAz9ErwNp6Deslg20w4PC/M3FBlE5hCXXW6Zf5YUIeCr1ycH+3/FqScd6Ca5vxP
 YJ+Gid1lGthkCZK0s3NIaUwKawQQ6z4LqOoENkOx63ltLRCEsissMgey/SY8G9ahXA3ILQArD
 hUd9kVGvlMN3JYcJY1G2UvAnJhr/WGWGSW7g95ykzR5OdYIsKqv6e+MvjdvsjkCXqfd5ubuXH
 Rvsi/yst/BCZcXrFaPcuZC4E0r6XwK579Ua8j/GgS6eT3ZFEfViVW6Nrf9q0ivmBzaChD/CWm
 hXFfZpc7g1komfwpOkz9DHLQGXeaAWDHfbQfrnrae+41wg3YDp1uGIZAmygaZpO7IF14TkV5M
 Y1jBh3zehopbL0TtlhwQOoqGPcZM5b9yl4XtjapJO644o2SOh7LPccJAOxJCRKMbR9JcHETqm
 yg5j16vyQikKl0/vyPRei6PWX03mH5MQasHkK1HHbdCHVf2wICrYHta1accbCJskV7zYtD5tK
 YGSGrXAESJuxrWkqp4Fp+LJGLOmJqoUQGQeq96pAbbcpE8X1ePbPXFSsRP3nfTQ7pJZxgMSiY
 He7YTOh0krwdGwnOAYVHESb01Onkg/JNU6V0kP5PjBB+nJOaEEDw0rewX/ck7lOLmxlvhDU19
 keLtvMmRUq4jC6Skh4c1gN5MnChIVRDdNM68Sk+4aZ1VsMevlH0l4bjNsJ+912APdGgPOtNCE
 xpYMwhdk0TgKfr3XhbvkdX/YS32P6a7Veq268ysJT68mlVDSCHxfiZ2/x8rhZiBdrHa0HWG2J
 rziQ0HRQcAE2vHaPu+wadtXOVPcYiYYYTJBz50EYXFA05yred3U9qDbXAw8L+ftwpWNcuxJsx
 HR6W05MVVRq6Mx0VPzOJLKu3dZnqd+hVn5woPJhCGLs3NIBkyz7VqCkOvrznLRzJBqu6HicUV
 q4FVU84lK3E0KAj+a3YdRbkk0qfTJ50+HvyS3BWiQcLNHFfa+NuppnJEdtXZysumGPUGOM9z3
 fIDuBGRO9A9o+tZAqfKEfrV+1NVplEhveop/pdW7LtUvRZs3DZ8gc0Yr6lPD1oTN/vntc2R21
 Bru11OmS3cF1gjKsvl/V01FDu0wegTrIxTIzGAwftaIkOrNy4A6x9pABGUqYl0VlIG8+zF0Ux
 dMuMAg7BIILMmk95F3kgYS3ZTSW8=

Am 15.02.25 um 19:07 schrieb Kurt Borja:

> On Sat Feb 15, 2025 at 12:40 PM -05, Armin Wolf wrote:
>> Am 15.02.25 um 02:30 schrieb Kurt Borja:
>>
>>> Hi Armin,
>>>
>>> On Fri Feb 14, 2025 at 5:13 PM -05, Armin Wolf wrote:
>>>> After studying the linuwu_sense driver
>>>> (https://github.com/0x7375646F/Linuwu-Sense) i was able to understand
>>>> the meaning of the SetGamingFanBehavior() WMI method:
>>>>
>>>> - the first 16-bit are a bitmap of all fans affected by a fan behavior
>>>>     change request.
>>>>
>>>> - the next 8 bits contain four fan mode fields (2-bit), each being
>>>>     associated with a bit inside the fan bitmap.
>>>>
>>>> There are three fan modes: auto, turbo and custom.
>>>>
>>>> Use this newfound knowledge to fix the turbo fan handling by setting
>>>> the correct bits before calling SetGamingFanBehavior(). Also check
>>>> the result of the WMI method call and return an error should the ACPI
>>>> firmware signal failure.
>>>>
>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>> ---
>>>>    drivers/platform/x86/acer-wmi.c | 75 +++++++++++++++++++++++----------
>>>>    1 file changed, 52 insertions(+), 23 deletions(-)
>>>>
>>>> --
>>>> 2.39.5
>>>>
>>>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
>>>> index 69336bd778ee..f20a882e3650 100644
>>>> --- a/drivers/platform/x86/acer-wmi.c
>>>> +++ b/drivers/platform/x86/acer-wmi.c
>>>> @@ -68,10 +68,19 @@ MODULE_LICENSE("GPL");
>>>>    #define ACER_WMID_SET_GAMING_LED_METHODID 2
>>>>    #define ACER_WMID_GET_GAMING_LED_METHODID 4
>>>>    #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
>>>> -#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
>>>> +#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
>>>>    #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
>>>>    #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23
>>>>
>>>> +#define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
>>>> +#define ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK GENMASK_ULL(23, 16)
>>>> +
>>>> +#define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
>>>> +#define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
>>>> +
>>>> +#define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
>>>> +#define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)
>>>> +
>>>>    #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
>>>>    #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
>>>>    #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
>>>> @@ -121,6 +130,12 @@ enum acer_wmi_predator_v4_sensor_id {
>>>>    	ACER_WMID_SENSOR_GPU_TEMPERATURE	= 0x0A,
>>>>    };
>>>>
>>>> +enum acer_wmi_gaming_fan_mode {
>>>> +	ACER_WMID_FAN_MODE_AUTO		= 0x01,
>>>> +	ACER_WMID_FAN_MODE_TURBO	= 0x02,
>>>> +	ACER_WMID_FAN_MODE_CUSTOM	= 0x03,
>>>> +};
>>>> +
>>>>    enum acer_wmi_predator_v4_oc {
>>>>    	ACER_WMID_OC_NORMAL			= 0x0000,
>>>>    	ACER_WMID_OC_TURBO			= 0x0002,
>>>> @@ -1565,9 +1580,6 @@ static acpi_status WMID_gaming_set_u64(u64 value, u32 cap)
>>>>    	case ACER_CAP_TURBO_LED:
>>>>    		method_id = ACER_WMID_SET_GAMING_LED_METHODID;
>>>>    		break;
>>>> -	case ACER_CAP_TURBO_FAN:
>>>> -		method_id = ACER_WMID_SET_GAMING_FAN_BEHAVIOR;
>>>> -		break;
>>>>    	default:
>>>>    		return AE_BAD_PARAMETER;
>>>>    	}
>>>> @@ -1618,25 +1630,42 @@ static int WMID_gaming_get_sys_info(u32 command, u64 *out)
>>>>    	return 0;
>>>>    }
>>>>
>>>> +static int WMID_gaming_set_fan_behavior(u16 fan_bitmap, u8 mode_bitmap)
>>>> +{
>>>> +	acpi_status status;
>>>> +	u64 input = 0;
>>>> +	u64 result;
>>>> +
>>>> +	input |= FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitmap);
>>>> +	input |= FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK, mode_bitmap);
>>>> +
>>>> +	status = WMI_gaming_execute_u64(ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID, input,
>>>> +					&result);
>>>> +	if (ACPI_FAILURE(status))
>>>> +		return -EIO;
>>>> +
>>>> +	/* TODO: Proper error handling */
>>>> +	pr_notice("Fan behavior return status: %llu\n", result);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    static void WMID_gaming_set_fan_mode(u8 fan_mode)
>>>>    {
>>>> -	/* fan_mode = 1 is used for auto, fan_mode = 2 used for turbo*/
>>>> -	u64 gpu_fan_config1 = 0, gpu_fan_config2 = 0;
>>>> -	int i;
>>>> -
>>>> -	if (quirks->cpu_fans > 0)
>>>> -		gpu_fan_config2 |= 1;
>>>> -	for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
>>>> -		gpu_fan_config2 |= 1 << (i + 1);
>>> This was not replicated bellow. Just to be sure, are there no fans at
>>> BIT(1) and BIT(2)?
>> AFAIK the Acer OEM software support the following fans:
>>
>> - CPU (BIT(0))
>> - GPU 1 (BIT(3))
>> - GPU 2 (BIT(4), but untested)
>>
>> The other bits seem to be unused.
> Interesting.
>
> I ask because quirks->cpu_fans + quirks->gpu_fans is currently always 2,
> so the line two `-` lines I referenced make the following equivalent
> operation:
>
> fan_bitmap |= BIT(1);
> mode_bitmap |= FIELD_PREP(GENMASK(3, 2), fan_mode);
>
> fan_bitmap |= BIT(2);
> mode_bitmap |= FIELD_PREP(GENMASK(5, 4), fan_mode);
>
> So if any model has fans at BIT(1), BIT(2) this may cause regressions if
> the behavior is not mimicked.
>
> Am I missing something?
>
> Anyway, your explaination for how this method works makes a lot of
> sense, so it is weird that the original author of this is summing the
> number of fans and setting this bits in the first place.
>
I do not know why the original code assigned BIT(1) and BIT(2), but i know for sure
that no other (out-of-tree) implementation does this.

I suspect that some models just ignore those unused bits, while others return an error.
This might explain why the turbo fan functionality does not work on some machines.

Should we find a model in the future with more fans then we can extend the fan control code
as needed. For now the risk of regressions should be low since all models inside the whitelist
have only a single CPU and GPU fan.

Thanks,
Armin Wolf


