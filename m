Return-Path: <linux-kernel+bounces-315507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C4696C376
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF98288016
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25F41DFE09;
	Wed,  4 Sep 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TWgysNHr"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C461DEFE6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466043; cv=none; b=mrZZJoELz9MvAj1EmxGXVtIRIv0j9Is0SRQylhQoLt4qdhmHn9k72IBHpDW4WG0j7+rAMWnT/EUi/TFlsgnfd/dJh9dVPQSCjpT3n2PhvtECX6GwU7Z2wMiLAcm5/w4z4z1Syj4GcO69kHyDaUB7yBSVyjWuqXlUusaJgmfCKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466043; c=relaxed/simple;
	bh=oXoT1pPhQvIPFTehGkFsDwEYb93n265E6U4EKVTenuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJWXlzI0fLg2mHcTGMjqwkCIGf7o1vlClsaLR4bSw59G3FTJg9YOjaFjU+GktplddFxN8cZAg57YInNsZi2LA3kl4Zzp2HSFv8K6qMd/9r5IoeEA6tEChxrqAF718o5Q7BAO08Tiu5RFW6XtWbGLD0zkJhPMUOx8qBB65cC1MG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TWgysNHr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63F1A1BF215;
	Wed,  4 Sep 2024 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725466037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4qo7BsBgewUZZsDUBzms+JlzVFNehNfJl5E2SQ+my8=;
	b=TWgysNHrGn8aAAc7Fe9PztkRv1o56SB1VPvZhIoWa7Rft8DID9O3ZSbe5KWz7WduV78+/Y
	nv5Pw1xdhqaURdkQBdR/JQIuxkH8E9ckuCqMeGKUsZqKYytnKwp5yC9AurHcwn/bJZMjF9
	uuAdq17w6ks728Lg5OhF9zCNRv19VKmri29AZmIL/a/NX1WvC5HgraYXdnWSBHRnHIG941
	AlIbg90UhhtDmV38yMEJZ8FUYdmT+sNmJAAITR6X5H8oVm+STOonLGS2lYPv2Pi6cPp4/G
	R2B07V2yeJ+UwNN/JLu7hZzPhnRxJQHHWS9a4HoxMA4zfjIJ9juZIYivoQDYKg==
Message-ID: <10f29bcc-b627-4bd6-89f9-b8c48fa6fd3a@bootlin.com>
Date: Wed, 4 Sep 2024 18:07:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <6267cf2b-1c05-ec72-9ac8-e715561d5bac@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 9/4/24 14:52, Peter Rosin wrote:
> Hi!
> 
> 2024-09-04 at 13:29, Thomas Richard wrote:
>> On 9/4/24 11:32, Peter Rosin wrote:
>>> Hi!
>>>
>>> 2024-09-04 at 11:18, Thomas Richard wrote:
>>>> On 9/3/24 15:22, Peter Rosin wrote:
>>>>> Hi!
>>>>>
>>>>> Sorry for being unresponsive. And for first writing this in the older v4
>>>>> thread instead of here.
>>>>>
>>>>> 2024-06-13 at 15:07, Thomas Richard wrote:
>>>>>> The mux_chip_resume() function restores a mux_chip using the cached state
>>>>>> of each mux.
>>>>>>
>>>>>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>>>>>> ---
>>>>>>  drivers/mux/core.c         | 29 +++++++++++++++++++++++++++++
>>>>>>  include/linux/mux/driver.h |  1 +
>>>>>>  2 files changed, 30 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>>>>>> index 78c0022697ec..0858cacae845 100644
>>>>>> --- a/drivers/mux/core.c
>>>>>> +++ b/drivers/mux/core.c
>>>>>> @@ -215,6 +215,35 @@ void mux_chip_free(struct mux_chip *mux_chip)
>>>>>>  }
>>>>>>  EXPORT_SYMBOL_GPL(mux_chip_free);
>>>>>>  
>>>>>> +/**
>>>>>> + * mux_chip_resume() - restores the mux-chip state
>>>>>> + * @mux_chip: The mux-chip to resume.
>>>>>> + *
>>>>>> + * Restores the mux-chip state.
>>>>>> + *
>>>>>> + * Return: Zero on success or a negative errno on error.
>>>>>> + */
>>>>>> +int mux_chip_resume(struct mux_chip *mux_chip)
>>>>>> +{
>>>>>> +	int ret, i;
>>>>>> +
>>>>>> +	for (i = 0; i < mux_chip->controllers; ++i) {
>>>>>> +		struct mux_control *mux = &mux_chip->mux[i];
>>>>>> +
>>>>>> +		if (mux->cached_state == MUX_CACHE_UNKNOWN)
>>>>>> +			continue;
>>>>>> +
>>>>>> +		ret = mux_control_set(mux, mux->cached_state);
>>>>>
>>>>> mux_control_set() is an internal helper. It is called from
>>>>> __mux_control_select() and mux_control_deselect() (and on init...)
>>>>>
>>>>> In all those cases, there is no race to reach the mux_control_set()
>>>>> function, by means of the mux->lock semaphore (or the mux not being
>>>>> "published" yet).
>>>>>
>>>>> I fail to see how resume is safe when mux->lock is ignored?
>>>>
>>>> I think I should use mux_control_select() to use the lock.
>>>> If I ignore the lock, I could have a cache coherence issue.
>>>>
>>>> I'll send a new version which use mux_control_select().
>>>> But if I use mux_control_select(), I have to clean the cache before to
>>>> call it, if not nothing happen [1].
>>>>
>>>> [1]
>>>> https://elixir.bootlin.com/linux/v6.11-rc6/source/drivers/mux/core.c#L319
>>>
>>> No, calling mux_control_select() in resume context is not an
>>> option IIUC. That would dead-lock if there is a long-time client
>>> who has locked the mux in some desired state.
>>
>> Yes, I didn't thought about it.
>>
>>>
>>> I see no trivial solution to integrate suspend/resume, and do
>>> not have enough time to think about what a working solutions
>>> would look like. Sorry.
>>>
>>
>> We maybe have a solution.
>> Please let me know if it's relevant or not for you:
>>
>> - Add a get operation in struct mux_control_ops.
>>
>> - Implement mux_chip_suspend() which reads the state of each mux using
>> the get operation, and store it in a hardware_state variable (stored in
>> the mux_control struct).
>>
>> - The mux_chip_resume uses the hardware_state value to restore all muxes
>> using mux_control_set().
>> So if a mux is locked with a long delay, there is no dead-lock.
>>
>> - If the get operation is not defined, mux_chip_suspend() and
>> mux_chip_resume() do nothing (maybe a warning or info message could be
>> useful).
> 
> What if a mux control is used to mux e.g. an SPI bus, and on that bus
> sits some device that needs to be accessed during suspend/resume. What
> part of the system ensures that the mux is supended late and resumed
> early? Other things probably also want to be suspended late and resumed
> early. But everything can be latest/earliest, there has to be some kind
> of order, and I'm not sure that ordering is guaranteed to "fit".

I experimented that it's ordered correctly for each stage, using
dependencies defined in the DT (I guess).
Of course if we suspend at suspend stage and resume at resume stage
whereas an SPI access is done at suspend_late (for example), it doesn't
work.
We could suspend/resume at noirq stages. It's the last suspend stage,
and the first resume stage, so we are sure to save and restore the right
states.

Thomas

