Return-Path: <linux-kernel+bounces-561866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDA7A617A1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD82885452
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE5A204C1D;
	Fri, 14 Mar 2025 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="egqEOekc"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA6204863;
	Fri, 14 Mar 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973303; cv=none; b=NC1odMtpmCRqdSVb6n986s598TDBZbWQ5Y/Nxct3xnKAXILU8E/vkWBuXKuS/046wwmfRjHIWzbPxxJO3+s9KracDNiHHg0Kz1f/gA5cMRzSgvvLOLuenp0tJQGlal/D78zWEyaTBiou6pjYrK88jnq+ssznFfnw6tyDxZJHBbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973303; c=relaxed/simple;
	bh=KHgcPjnVOoijG9c/+h5zNbYKSPXH2dyw501fzPENB8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keKdelxgm8m+iL8DTNMSu6i20RYihwto+lb7BL8QcU/rAK5bzSotcq7dUbugPRek0fKQlYSJLotO88BIuwAilOXHPEyQcw8g6ECQBu8xhaoIrzABP/zYmOo+01ol7B9/M6qtuFM2LemJcGhyIZdw5sx7M5unBGN24GjdDayAdZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=egqEOekc; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5b164989.dip0.t-ipconnect.de [91.22.73.137])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 738322FC0186;
	Fri, 14 Mar 2025 18:28:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1741973296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9f8SrtAYLDdPkvh4yYPQ0CsmuisQdBIm3f9X5+S3QdE=;
	b=egqEOekcf+kkiZHOmxGCkGYXbv9H6dMxnWRpdNvY7BreBwUcMgeby14SwsWDMQs0wDSt+1
	E4jiHtq7DQSkDMCF1XTSVsCC405BHdEQE9Jt7v054/cTJfZTs2DXK1BgoCA/9ARisynnQl
	btYRBbx9/PTYFzlGqsDpGtcO3joFeEY=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <c6c5aceb-e329-464e-82ca-b70c5310ca89@tuxedocomputers.com>
Date: Fri, 14 Mar 2025 18:28:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86/tuxedo: Implement TUXEDO TUXI ACPI TFAN
 via hwmon
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20250306132639.642369-1-wse@tuxedocomputers.com>
 <70633701-31d2-c2ab-f4f4-043dd186f485@linux.intel.com>
 <75556900-5fe3-4083-b81b-240994e4f8e0@tuxedocomputers.com>
 <4344644a-582b-aee6-7eef-8afd3c0ee16f@linux.intel.com>
 <49ceb1f4-93b1-47ed-a87b-b936fee1b371@tuxedocomputers.com>
 <ad2e303d-1b13-d575-d58c-f4785e71d6e7@linux.intel.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ad2e303d-1b13-d575-d58c-f4785e71d6e7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ilpo,

Am 14.03.25 um 14:59 schrieb Ilpo Järvinen:
> On Fri, 14 Mar 2025, Werner Sembach wrote:
>
>> Sorry, resend, mail client did html message by accident
> Np.
>
>> Am 14.03.25 um 11:05 schrieb Ilpo Järvinen:
>>>>>> +			S32_MAX : (retval - TUXI_FW_TEMP_OFFSET) *
>>>>>> 100;
>>>>> Is the math wrong, as you do retval - TUXI_FW_TEMP_OFFSET before
>>>>> multiplying?
>>>> No, retval is in 10th of °K (but the last number is always 0) so is
>>>> TUXI_FW_TEMP_OFFSET which is there to convert it to 10th of °C, the * 100
>>>> is
>>>> then to bring it in line with hwmon wanting to output milli degrees
>>> So is result of S32_MAX correct when retval is 21474837?
>>>
>>> (21474837-2730)*100
>>> 2147210700
>>> 2^31-1
>>> 2147483647
>>>
>>> 2147210700 would have been representable but the upper bound is
>>> still applied (the value might be large enough to not have practical
>>> significance but to me the code looks still illogical why it applies the
>>> bound prematurely).
>> Yeah my though was: this check is only here to catch the firmware doing some
>> crazy stuff and sending highly unrealistic values, so gifting a small bit of
>> the available range away doesn't matter
> But it does matter as you could note. I stumbled on the logic which didn't
> look right while reviewing. You even claimed afterwards is not wrong when
> I raised this. :-/
>
> Please just correct the logic so it makes sense to the code reader, there
> seems to be no well justified reason to keep the illogical code even if
> the practical impact is very low. It's probably done the way it is only
> because the variable types are what they are so you couldn't do the
> subtraction like I proposed ;-). At minimum you'd need to add a comment to
> warn about the inconsistency at which point rewriting to correct logic is
> already way simpler.
ok
>
>>> I see you already sent another version, it would have been prudent to wait
>>> a bit longer as you contested some of the comments so you could have seen
>>> my replies before sending the next version.
>> I'm sorry. I just wanted to show that I'm iterating as I wait for the reply if
>> the design with the periodic safeguard is acceptable. If that's gets rejected
>> this driver must be rewritten anyway.
> Kernel development is not a sprint. It's better to avoid sending versions
> unnecessarily, a day or two isn't worth it when compared with ending up
> into people's low priority bin which will inevitably happen when the
> version counter starts to grow beyond v5-6.
>
> I (and likely others too) appreciate if they don't have to waste review
> cycles on something that is not "complete" because we have to look at the
> completed one later too. Maintainers work in good faith that developers
> are simply improving their patches (or working on some other great
> improvements to the kernel :-)) while nothing seemingly happens for a
> while. There's no need to prove that something is going on just for the
> sake of proving.
>
> Obviously RFC patches are still fine to ask specific questions about
> something, but that's not about proving progress (in fact, RFC patches are
> more about being "stuck" than about making progress).
Sorry, didn't know though it will eventually just get skipped.
>
>>>>> Shouldn't it be like this:
>>>>>
>>>>> 		retval -= TUXI_FW_TEMP_OFFSET;
>>>>> 		*val = min(retval * 100, (unsigned long long)S32_MAX);
>>>> As retval is unsigned this would not work with (theoretical) negative °C.
>>> So your code relies on implicit type conversion in this: (retval -
>>> TUXI_FW_TEMP_OFFSET) ?
>> I can add an explicit cast, np.
>>
>> [snip]
>>
>>>>>> +	}
>>>>>> +	if (temp >= temp_high)
>>>>>> +		ret = i;
>>> Now that I reread things, is this also incorrect, as "i" is at the
>>> terminator entry at this point?
>> Yes that's intentional, the 3 entries in the array open up 4 ranges:
>>
>> lower then 1st entry i=0, between 1st and 2nd entry i=1, 2nd and 3rd i=2,
>> higher then 3rd i=3 (the value that terminates the for loop)
> I didn't realize that. To me { } looks just an terminating entry. So
> what's the min_speed going to be for that last entry since it's
> initialized to 0?
>
> Oh, I see you're taking .min_speed from temp_levels[temp_level - 1] which
> I don't like either. You have a "state" and then store min_speed for the
> state into other index inside the array?!?

Because state 0 is the implicit low temperature -> no min speed is required

And then high states have higher min speeds. So to sync this up I would need to 
add a dummy entry in the first position of the array.

>
>>>>>> +
>>>>>> +		temp = retval > S32_MAX / 100 ?
>>>>>> +			S32_MAX : (retval - TUXI_FW_TEMP_OFFSET) *
>>>>>> 100;
>>>>> Same math issue comment as above.
>>>>>
>>>>> Why is the read+conversion code duplicated into two places?
>>>> because here it is with special error handling and didn't thought about an
>>>> own
>>>> function for a defacto 2 liner
>>> A function that does read+conversion would be 6-8 lines with the error
>>> handling.
>> I can add it.
>>
>> [snip]
>>
>> Thanks for the code review again.
>>
>>
>> Last but not least: As already mentioned, I still wonder if the design with
>> the periodic safeguard is ok or not or?
> I'm not sure if fully understand Daniel's suggestion [1] as it
> doesn't specify who/what is sending that notification to the thermal
> engine.
>
> [1] https://lore.kernel.org/all/286f5efc-cd15-4e0b-bec2-2e9bbb93dd37@linaro.org/#t

Me too, also at one point he was talking about device trees, but isn't that only 
an ARM thing? Or can you define one for x86 devices too?

I put him in the cc again

>
>
> When it comes to your own concerns, I'm not exactly buying the argument
> that userspace can do dangerous things. Yeah, it can shoot one's own
> foot, no doubt, such as unloading this driver and there goes your periodic
> safeguards. If the argument would be that userspace fails to respond (in
> time), I would have less trouble in accepting that argument.
>
Unloading the driver will activate the auto mode again with firmware handling 
the complete fancurve.

Userspace not responding in time, or not responding at all, or intentionally 
always requesting fan speed 0 kinda all result in the conclusion -> don't trust 
userspace.

Having this in driver is the only surefire way to communicate to the 
User(-space) that this device must not be run under full load with the fans 
turned off.

Best regards,

Werner


