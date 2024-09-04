Return-Path: <linux-kernel+bounces-314892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D33B596BAA7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11AD61C22ADA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B16A1D0DCF;
	Wed,  4 Sep 2024 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LpLfIYGx"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8221D04AA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449353; cv=none; b=IwqKGOGpkP9mQ9rTw/itCkhAIBcFNJXqvxWEky7xX6qwHxwdeIuqy0HTEiMfscXbNLn/EYh0JyFzb01YVmk4aqnBeQslw93bePqDvLL3oDL9IpXYOHEnrsQRO5Np4dT40eJGGcAyD+vWwWUwIqmSXYT5QDUL6CTS5djnkio0K7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449353; c=relaxed/simple;
	bh=gXsUyKWX4eqG122FiUepNnh81SKVQrwhRAm8zyF53+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFbHyj3LhaCobMu4BWbBhq8VRIELJs1EQu1Li6emQY6hrWwbSyPNdscVRrtLOcntWylCzp6+YhxYr6ai8+WTTkzhoY4g50cWQrCF/Wo+ThHZo4NZAUYppNLH+qmK0fIgKcT46NWgJxlBWPaBjTEHgbYxFTltHDS1uEQNTK3cfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LpLfIYGx; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 349C8C000C;
	Wed,  4 Sep 2024 11:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725449348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WydPZP7NPAakT9XUYDlnXK7eOUzTvx6eQKKMASqspTA=;
	b=LpLfIYGx7X/MXTsan9nOxCKtJzrhkPpo3Bpz54ov7ed/Gi1k0j0dQKT9PPQhuA2xfv06Pg
	fpzKjn08WRFgIrM6Picz7zMqr7cIwLTPvyuGpj3hDdPe1GJl+0oTlzJMXxpLrfY6zmI8mF
	a7DSs1TM/p6eZrSguUUNgB5tMxvE+jz/aW9UKg0jvktspEbGRlZX2hOW1mUFVAYqiMi8eh
	4+joFENOO9PJ5Nx/JaPDO64EfjKWHEPo74A1UY5xaea9ncTN0yKcIiRcxWL/i1CGeRrAbb
	r2MfxVYGpCaMOP11udloXOfq8UJD5a1qjNqv6DPzyEaejDXUYWPCKhiomfpjlA==
Message-ID: <c8a82583-5570-4286-9f1b-00a2717bae4b@bootlin.com>
Date: Wed, 4 Sep 2024 13:29:07 +0200
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
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <4cf89e3d-7164-67b5-0a3c-9e8e4df274eb@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 9/4/24 11:32, Peter Rosin wrote:
> Hi!
> 
> 2024-09-04 at 11:18, Thomas Richard wrote:
>> On 9/3/24 15:22, Peter Rosin wrote:
>>> Hi!
>>>
>>> Sorry for being unresponsive. And for first writing this in the older v4
>>> thread instead of here.
>>>
>>> 2024-06-13 at 15:07, Thomas Richard wrote:
>>>> The mux_chip_resume() function restores a mux_chip using the cached state
>>>> of each mux.
>>>>
>>>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>>>> ---
>>>>  drivers/mux/core.c         | 29 +++++++++++++++++++++++++++++
>>>>  include/linux/mux/driver.h |  1 +
>>>>  2 files changed, 30 insertions(+)
>>>>
>>>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>>>> index 78c0022697ec..0858cacae845 100644
>>>> --- a/drivers/mux/core.c
>>>> +++ b/drivers/mux/core.c
>>>> @@ -215,6 +215,35 @@ void mux_chip_free(struct mux_chip *mux_chip)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(mux_chip_free);
>>>>  
>>>> +/**
>>>> + * mux_chip_resume() - restores the mux-chip state
>>>> + * @mux_chip: The mux-chip to resume.
>>>> + *
>>>> + * Restores the mux-chip state.
>>>> + *
>>>> + * Return: Zero on success or a negative errno on error.
>>>> + */
>>>> +int mux_chip_resume(struct mux_chip *mux_chip)
>>>> +{
>>>> +	int ret, i;
>>>> +
>>>> +	for (i = 0; i < mux_chip->controllers; ++i) {
>>>> +		struct mux_control *mux = &mux_chip->mux[i];
>>>> +
>>>> +		if (mux->cached_state == MUX_CACHE_UNKNOWN)
>>>> +			continue;
>>>> +
>>>> +		ret = mux_control_set(mux, mux->cached_state);
>>>
>>> mux_control_set() is an internal helper. It is called from
>>> __mux_control_select() and mux_control_deselect() (and on init...)
>>>
>>> In all those cases, there is no race to reach the mux_control_set()
>>> function, by means of the mux->lock semaphore (or the mux not being
>>> "published" yet).
>>>
>>> I fail to see how resume is safe when mux->lock is ignored?
>>
>> I think I should use mux_control_select() to use the lock.
>> If I ignore the lock, I could have a cache coherence issue.
>>
>> I'll send a new version which use mux_control_select().
>> But if I use mux_control_select(), I have to clean the cache before to
>> call it, if not nothing happen [1].
>>
>> [1]
>> https://elixir.bootlin.com/linux/v6.11-rc6/source/drivers/mux/core.c#L319
> 
> No, calling mux_control_select() in resume context is not an
> option IIUC. That would dead-lock if there is a long-time client
> who has locked the mux in some desired state.

Yes, I didn't thought about it.

> 
> I see no trivial solution to integrate suspend/resume, and do
> not have enough time to think about what a working solutions
> would look like. Sorry.
> 

We maybe have a solution.
Please let me know if it's relevant or not for you:

- Add a get operation in struct mux_control_ops.

- Implement mux_chip_suspend() which reads the state of each mux using
the get operation, and store it in a hardware_state variable (stored in
the mux_control struct).

- The mux_chip_resume uses the hardware_state value to restore all muxes
using mux_control_set().
So if a mux is locked with a long delay, there is no dead-lock.

- If the get operation is not defined, mux_chip_suspend() and
mux_chip_resume() do nothing (maybe a warning or info message could be
useful).

Regards,

Thomas





