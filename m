Return-Path: <linux-kernel+bounces-319195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF1D96F926
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F3D286282
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371741D2F5A;
	Fri,  6 Sep 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jhSm8J1O"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED62179BC
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639452; cv=none; b=Q+hwj2S6tZBv2iNyX2izaWfwp+bHIXAUQFGUHd51ffsKUJxVfmxQUY7MjYVhYywwE/mc2PaF0ik8iYUNXr9DCBEZZvKT9b9LXDjf2CpE8J7ckVgff/tYLq6Xfri8NSbsgnqmKo2vcNjWd/uZ6QSIyz6qn6+YgtXcKiGwnkexmog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639452; c=relaxed/simple;
	bh=00jXbhruCujMOCFmX9PFofCJw4l/RjJ/bhFD5+daNW4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GPKGmmcUcDZx8XP7Wj0i6+IJCMNvZgShDIkAhbKbS+kFUQWVKO2AulSLL3NNj4CRFE1zG2KTwhuwozbzqtYo3hPVRhWV2fjAcEabzBJP7I9XYioLja1VpHhQ4061xcwZ2ILbmxtRVz5QzLGHGx7598sG6LcclUYsvooGGfYtPOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jhSm8J1O; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC0EA60004;
	Fri,  6 Sep 2024 16:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725639448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2276qXFzGBViPVB+vH4vyDFpAnoDGrhrrdDCftYlMFs=;
	b=jhSm8J1OALLkv5OQTVmv/MpVvFAKWnyK1sG0+DwKeApmnujclCb9NIJLSg/d9XhfHaT4NH
	MSh8WykoC/Vptz010a6dusOV6ot1M2kUZ0kkPU8uLLbTrHO4d0o24mvqfbc6SjBcYmIvXb
	0TgMj0UpyX/vSDXWjGxxgMzPV6tZVL/sPtR/cMdu0nuNIL+CGelNNoCu2FjLgys6oMrZpR
	TtVQysyNsYIWEeC+cLaWnvkBl4YL8CrWqRSBW01Tmx+0PNhNHMN1BBaLkL/9tmYr2aGm9h
	LaDVDWewF3f7dwxtYr5t3laokCDxUIIPDXRrCHAVv1+qTchovcKFQJX8ma5AVw==
Message-ID: <4d5ea9a9-df92-47b2-bd60-15e4a2e6f8e1@bootlin.com>
Date: Fri, 6 Sep 2024 18:17:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: Re: [PATCH 1/2] mux: add mux_chip_resume() function
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
 <20240613-mux-mmio-resume-support-v1-1-4525bf56024a@bootlin.com>
 <94069d56-0981-2d69-65c2-901a05758806@axentia.se>
 <f5067055-1470-4386-8839-b4ec2527872e@bootlin.com>
 <4cf89e3d-7164-67b5-0a3c-9e8e4df274eb@axentia.se>
 <c8a82583-5570-4286-9f1b-00a2717bae4b@bootlin.com>
 <6267cf2b-1c05-ec72-9ac8-e715561d5bac@axentia.se>
 <10f29bcc-b627-4bd6-89f9-b8c48fa6fd3a@bootlin.com>
 <df9c448b-5f74-c0be-3a06-198e46a5de62@axentia.se>
Content-Language: en-US
In-Reply-To: <df9c448b-5f74-c0be-3a06-198e46a5de62@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 9/5/24 10:28, Peter Rosin wrote:
> Hi!
> 
> 2024-09-04 at 18:07, Thomas Richard wrote:
>> On 9/4/24 14:52, Peter Rosin wrote:
>>> Hi!
>>>
>>> 2024-09-04 at 13:29, Thomas Richard wrote:
>>>> On 9/4/24 11:32, Peter Rosin wrote:
>>>>> Hi!
>>>>>
>>>>> 2024-09-04 at 11:18, Thomas Richard wrote:
>>>>>> On 9/3/24 15:22, Peter Rosin wrote:
>>>>>>> Hi!
>>>>>>>
>>>>>>> Sorry for being unresponsive. And for first writing this in the older v4
>>>>>>> thread instead of here.
>>>>>>>
>>>>>>> 2024-06-13 at 15:07, Thomas Richard wrote:
>>>>>>>> The mux_chip_resume() function restores a mux_chip using the cached state
>>>>>>>> of each mux.
>>>>>>>>
>>>>>>>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>>>>>>>> ---
>>>>>>>>  drivers/mux/core.c         | 29 +++++++++++++++++++++++++++++
>>>>>>>>  include/linux/mux/driver.h |  1 +
>>>>>>>>  2 files changed, 30 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>>>>>>>> index 78c0022697ec..0858cacae845 100644
>>>>>>>> --- a/drivers/mux/core.c
>>>>>>>> +++ b/drivers/mux/core.c
>>>>>>>> @@ -215,6 +215,35 @@ void mux_chip_free(struct mux_chip *mux_chip)
>>>>>>>>  }
>>>>>>>>  EXPORT_SYMBOL_GPL(mux_chip_free);
>>>>>>>>  
>>>>>>>> +/**
>>>>>>>> + * mux_chip_resume() - restores the mux-chip state
>>>>>>>> + * @mux_chip: The mux-chip to resume.
>>>>>>>> + *
>>>>>>>> + * Restores the mux-chip state.
>>>>>>>> + *
>>>>>>>> + * Return: Zero on success or a negative errno on error.
>>>>>>>> + */
>>>>>>>> +int mux_chip_resume(struct mux_chip *mux_chip)
>>>>>>>> +{
>>>>>>>> +	int ret, i;
>>>>>>>> +
>>>>>>>> +	for (i = 0; i < mux_chip->controllers; ++i) {
>>>>>>>> +		struct mux_control *mux = &mux_chip->mux[i];
>>>>>>>> +
>>>>>>>> +		if (mux->cached_state == MUX_CACHE_UNKNOWN)
>>>>>>>> +			continue;
>>>>>>>> +
>>>>>>>> +		ret = mux_control_set(mux, mux->cached_state);
>>>>>>>
>>>>>>> mux_control_set() is an internal helper. It is called from
>>>>>>> __mux_control_select() and mux_control_deselect() (and on init...)
>>>>>>>
>>>>>>> In all those cases, there is no race to reach the mux_control_set()
>>>>>>> function, by means of the mux->lock semaphore (or the mux not being
>>>>>>> "published" yet).
>>>>>>>
>>>>>>> I fail to see how resume is safe when mux->lock is ignored?
>>>>>>
>>>>>> I think I should use mux_control_select() to use the lock.
>>>>>> If I ignore the lock, I could have a cache coherence issue.
>>>>>>
>>>>>> I'll send a new version which use mux_control_select().
>>>>>> But if I use mux_control_select(), I have to clean the cache before to
>>>>>> call it, if not nothing happen [1].
>>>>>>
>>>>>> [1]
>>>>>> https://elixir.bootlin.com/linux/v6.11-rc6/source/drivers/mux/core.c#L319
>>>>>
>>>>> No, calling mux_control_select() in resume context is not an
>>>>> option IIUC. That would dead-lock if there is a long-time client
>>>>> who has locked the mux in some desired state.
>>>>
>>>> Yes, I didn't thought about it.
>>>>
>>>>>
>>>>> I see no trivial solution to integrate suspend/resume, and do
>>>>> not have enough time to think about what a working solutions
>>>>> would look like. Sorry.
>>>>>
>>>>
>>>> We maybe have a solution.
>>>> Please let me know if it's relevant or not for you:
>>>>
>>>> - Add a get operation in struct mux_control_ops.
>>>>
>>>> - Implement mux_chip_suspend() which reads the state of each mux using
>>>> the get operation, and store it in a hardware_state variable (stored in
>>>> the mux_control struct).
>>>>
>>>> - The mux_chip_resume uses the hardware_state value to restore all muxes
>>>> using mux_control_set().
>>>> So if a mux is locked with a long delay, there is no dead-lock.
>>>>
>>>> - If the get operation is not defined, mux_chip_suspend() and
>>>> mux_chip_resume() do nothing (maybe a warning or info message could be
>>>> useful).
>>>
>>> What if a mux control is used to mux e.g. an SPI bus, and on that bus
>>> sits some device that needs to be accessed during suspend/resume. What
>>> part of the system ensures that the mux is supended late and resumed
>>> early? Other things probably also want to be suspended late and resumed
>>> early. But everything can be latest/earliest, there has to be some kind
>>> of order, and I'm not sure that ordering is guaranteed to "fit".
>>
>> I experimented that it's ordered correctly for each stage, using
>> dependencies defined in the DT (I guess).
>> Of course if we suspend at suspend stage and resume at resume stage
>> whereas an SPI access is done at suspend_late (for example), it doesn't
>> work.
>> We could suspend/resume at noirq stages. It's the last suspend stage,
>> and the first resume stage, so we are sure to save and restore the right
>> states.
> 
> And what if the mux in turn sits on I2C? Is the ordering still guaranteed
> to be correct? I.e. I'm not really intrested in just one case, but in the
> general problem. I am resisting the attempt to add generic support for
> something that, AFAICT, has no clear general solution.
> 
> Maybe you should simply implement resume locally in the driver itself and
> have it reprogram the register, perhaps still based on mux->cached_state,
> but "behind the back" of the mux core?

Ok, it's seems to be the best solution for now.
I'll send a patch.

Just a small comment, I think I should not use the cached_state.
I should implement a mux_mmio_get(), which is called during suspend, to
get the "real" state. Then use it during resume.
Because the cache is not coherent during is a very small period [1].

What do you think ?

[1]
https://elixir.bootlin.com/linux/v6.11-rc6/source/drivers/mux/core.c#L144

Thomas

