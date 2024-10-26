Return-Path: <linux-kernel+bounces-383127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110CD9B1797
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72608B22F88
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863D31D414E;
	Sat, 26 Oct 2024 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="slTIdr3H"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513921D2715;
	Sat, 26 Oct 2024 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943434; cv=none; b=BsKElGobW2u/fWPEDjImrjITLc6qbQiKibLdt7re/BeR7rgs5JXvSJCl4obJz+fYj4ED1M2Yyhy9fdr0zT5tNYdRT4GY5Z+wf2506GWFGpoNZKV8VWI7mY77B0N9gsNNDxHl4DUTIMgrIUOLTePu95lOcU+PcEdsyD3j8aikvoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943434; c=relaxed/simple;
	bh=9dN9PZkHalf4FeRrV1E4OTOJ0M/MPHvpYhts6Jmitj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktSz19GSetK5omzdLw8tFy0D1viuZ2f3OP0vvjlq3cFYl+7QKpPf8MatJoocbLv3E1T5WjwKXe+GQ+PouztZ9P/Rp/9ajdOXqfnz3YWoZvtRvgPuhRiIccgU4INJ8y1VjiqxJ4VttAQE6tQ8yDfiJU4oeT4aLcZlA5bCKLBiExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=slTIdr3H; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729943372; x=1730548172; i=w_armin@gmx.de;
	bh=YPT5k+ovl7Np+MoR1cteSI5A1E3csqjo0n6YJb/zdKU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=slTIdr3HGkftVjcwcnazSOb3jCC+ghr6QadmgsbJDmpv0gGUCqdTcp+tPcqnqTp8
	 rs5wQq3mcKhw71LReuIDjBgzuyKVFSjqegV6P3KoaDZr1MNHIrKAjeMcFxxfLdOKH
	 Fw0cwlDw40bsX7MoeQqhvToB0SMLbpHWL+FNG6bw3QsuFcIqIlaOVd4df3cfrBDmy
	 gMxePvxb/jZ8cuRE2PLEIdX2ZhihnH8uqrWM1RQ6nLbiE9obihPZt+SQ1SjxhtUzI
	 3tahemkDpCWN9oa9moREca8FqyfgURuYmpZKp+vuXRBgTZZY/atsWc3A1d15T6mxO
	 BJnV9wiwUi3HkxDxuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf0U-1tn6je0iva-00Zcx0; Sat, 26
 Oct 2024 13:49:32 +0200
Message-ID: <76f01435-9fb8-4f77-8529-32f7640dce72@gmx.de>
Date: Sat, 26 Oct 2024 13:49:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86: asus-wmi: Fix inconsistent use of
 thermal policies
To: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com,
 luke@ljones.dev, mohamed.ghanmi@supcom.tn
Cc: srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 Michael@phoronix.com, casey.g.bowman@intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241025191514.15032-1-W_Armin@gmx.de>
 <20241025191514.15032-3-W_Armin@gmx.de>
 <42e023e9-3d7c-40c4-b547-829d6ec8d7fc@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <42e023e9-3d7c-40c4-b547-829d6ec8d7fc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Um/VbGXv/9HkkNDfzqy2KXKv72Wvi1g6sRp/H5rjVLJvy2sqULZ
 FBlXFOUNP4mdrnkUXmVy8PePIJtOuYL+feoYC+n/B5vmdmw6LEVnSBc3x3nKaYmkTmB87sR
 F5dYJV2Y+JzWg0EycOezcZwfYDZDSyKR9QW3v8Xvh2hBi7AHHwrMVjM+AumtJvDuG4Cqt+f
 cyB8bpO48DGMZzgeIVxzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gbp9chO5j+I=;+TqNlLgriXJCoJnGybe56RQMKoY
 C4704FmTDnzyeTwaoHqgoUz8C75zRbEZFwmGQz1HyWKpeB2RR936fuiU+wmb3Yc4M5cDpN2WB
 VC3WIkwPWFgXEF+9BGaJ1uiuG1NBBQT5r3BCfBQIdDjS/kUzEsoJ4+5yrylhwtdcIiPvFDsy0
 6ckaHL2k4RgcZJcn5UbDG5L+aCNfgD5lpWuuOCv0P1N8pQsN4qC+kTHKwWgnEG9C5lKD/AdWc
 XN9QGAaOnZDeuAnZ04kwujvL0SPz0RqTj8fGzrkh8pT1snJGm5M6quj+AiAw3aTn20V4WrKKl
 fRUCohW2kcAkYk1HFjnVW8ALyOo5XbaJ3vPyUwkUIIzO/sy7rvbyviMv+XgI20h5w2YPn7RZ5
 pzfTKLxfrbkOkoj3wilQDFfPOh18o9tRvHCw1djVwMqG8Q4UO1zDSbu4n87MZhCwDT0gXdtJD
 aDYk7uEliDPspFxk0YXzV7Yt4GV1nF3ClsVi7g5HhkjxmJHB4UJXo+uMscLW0MCgz97AH0qk6
 KWm8qrcRPLIM2RT4gJSld+Hm7bFdPPapns/hOXLRMdA9j5+nyNXqLpSrOrE7FdgOalT7YHN5Z
 1ojvhrpi1i7jJOFcZyESbjVGki5G10MrcLPB4TEhgnA/1FE6DTUaCjBTS5w1Js9u3RGSiWHpR
 MFF30Z6qh3iF4pKZhOVfLaHIZMhC18ry8BfqSG0/Cj4japyc2rbEtpUxUBH09d7GYXRk8++aL
 DTjMZgm9YkDKGe3T5BOk7MbCy9kbfBvw43zDiq/iCpfA3VdotAHgC63lAvi++vhMFncNt+xL2
 vXRmIDwAZfzE4sDrBhtBOgmQ==

Am 26.10.24 um 11:56 schrieb Hans de Goede:

> Hi Armin,
>
> On 25-Oct-24 9:15 PM, Armin Wolf wrote:
>> When changing the thermal policy using the platform profile API,
>> a Vivobook thermal policy is stored in throttle_thermal_policy_mode.
>>
>> However everywhere else a normal thermal policy is stored inside this
>> variable, potentially confusing the platform profile.
> You say "potentially confusing the platform profile", but did you
> spot any actual issues when reviewing the code ?
>
Yes, for example:

1. User sets thermal policy to "1" (overboost) through the throttle_thermal_policy sysfs attr.

2. "1" gets stored inside throttle_thermal_policy_mode.

3. Platform profile will now think that ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO (1) is set.

4. Platform profile reports current mode as PLATFORM_PROFILE_QUIET.

=> error!

>> Fix this by always storing normal thermal policy values inside
>> throttle_thermal_policy_mode and only do the conversion when writing
>> the thermal policy to hardware.
>>
>> Fixes: bcbfcebda2cb ("platform/x86: asus-wmi: add support for vivobook fan profiles")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> The problem with this approach is that it changes the order in which
> we step through the modes in throttle_thermal_policy_switch_next()
> after this change we have:
>
> Normal Asus: balanced -> performance -> silent -> balanced -> etc.
> Vivobook:    balanced -> silent -> performance -> balanced -> etc.
>
> where if we see "silent" as lower performance then the other 2,
> the vivobook order is a bit weird.
>
> I wonder if this is a big enough issue to really worry about it
> though; and I do like the cleanup / simpler code.

I think users expect the normal Asus switching behavior, but you are right
that this change should be explained inside the commit message.

>
> Note that this also causes a behavior change in
> fan_curve_get_factory_default() as I mentioned in my cover-letter.

Since fan_curve_get_factory_default() was introduced before commit bcbfcebda2cb,
i think this patches actually fixes the behavior of this function.

>
> I think that that behavior change might be a good thing to do actually,
> but at a minimum it needs to be documented in the commit msg.
>
> Regards,
>
> Hans
>
I will wait till the maintainer of asus-wmi can clarify whether or not
fan_curve_get_factory_default() expects normal Asus thermal policy values
or not.

Once we resolved this i will send an updated series.

Thanks,
Armin Wolf

>> ---
>>   drivers/platform/x86/asus-wmi.c | 64 +++++++++++----------------------
>>   1 file changed, 21 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index ab9342a01a48..ce60835d0303 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -3696,10 +3696,28 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
>>   /* Throttle thermal policy ****************************************************/
>>   static int throttle_thermal_policy_write(struct asus_wmi *asus)
>>   {
>> -	u8 value = asus->throttle_thermal_policy_mode;
>>   	u32 retval;
>> +	u8 value;
>>   	int err;
>>
>> +	if (asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO) {
>> +		switch (asus->throttle_thermal_policy_mode) {
>> +		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
>> +			value = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
>> +			break;
>> +		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
>> +			value = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
>> +			break;
>> +		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
>> +			value = ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	} else {
>> +		value = asus->throttle_thermal_policy_mode;
>> +	}
>> +
>>   	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
>>   				    value, &retval);
>>
>> @@ -3804,46 +3822,6 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>>   static DEVICE_ATTR_RW(throttle_thermal_policy);
>>
>>   /* Platform profile ***********************************************************/
>> -static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus, int mode)
>> -{
>> -	bool vivo;
>> -
>> -	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
>> -
>> -	if (vivo) {
>> -		switch (mode) {
>> -		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
>> -			return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
>> -		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
>> -			return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
>> -		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
>> -			return ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
>> -		}
>> -	}
>> -
>> -	return mode;
>> -}
>> -
>> -static int asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus, int mode)
>> -{
>> -	bool vivo;
>> -
>> -	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
>> -
>> -	if (vivo) {
>> -		switch (mode) {
>> -		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO:
>> -			return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>> -		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO:
>> -			return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
>> -		case ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO:
>> -			return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
>> -		}
>> -	}
>> -
>> -	return mode;
>> -}
>> -
>>   static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>>   					enum platform_profile_option *profile)
>>   {
>> @@ -3853,7 +3831,7 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>>   	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
>>   	tp = asus->throttle_thermal_policy_mode;
>>
>> -	switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
>> +	switch (tp) {
>>   	case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
>>   		*profile = PLATFORM_PROFILE_BALANCED;
>>   		break;
>> @@ -3892,7 +3870,7 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
>>   		return -EOPNOTSUPP;
>>   	}
>>
>> -	asus->throttle_thermal_policy_mode = asus_wmi_platform_profile_to_vivo(asus, tp);
>> +	asus->throttle_thermal_policy_mode = tp;
>>   	return throttle_thermal_policy_write(asus);
>>   }
>>
>> --
>> 2.39.5
>>
>

