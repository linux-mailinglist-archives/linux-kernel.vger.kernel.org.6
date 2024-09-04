Return-Path: <linux-kernel+bounces-314646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B0396B64E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1771F21BB2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1919DF50;
	Wed,  4 Sep 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="arUmb9Sb"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D11922FF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441498; cv=none; b=rnPzgNnrXrwuPMyR/aj142tJg7dN5jWA/6WO3t7s/5VAx0BD5iK84pE2r5mumeH4r34M9NG6UNzPDid0FgImJsOz4vzEJ2Mr5jw5LkEUomwv5/yWShf3W6QqpE5eMJDmkX48BJ4pu391rqCxje20zPcTkQ/tZZ6jKVHJu4+Un1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441498; c=relaxed/simple;
	bh=cq4PcRHrTIX2M4nfOXPbtgUysqrm9T7PKbbD1+SU0Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGH6nuTk09d5Gx9EYJ9ixZU+X1NekT2L805HYNZH1jnD/Rq4WuJK+HqDeS4RbOebCnG/lii8g/ls33gswaQL/qi8ml6n45rq+7M0zqj1gdAGDnHZvmPiJ0pDGTNWGu30y9xzkHNW1C8ZODijJKFLzt197hl6tfSJBUJsJf8v+mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=arUmb9Sb; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 99FE3E0002;
	Wed,  4 Sep 2024 09:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725441494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7uvY3mNBK4QyzCpXlUChoz8NyZinDAJS+ioMM0tdII=;
	b=arUmb9SbVuE72qjSiDrjIcChUyNzrQKYwirV0otvCry4BZwLAG0Vxr5InDNEUfbBd8+Xah
	e+jvWXdBau5BMdcTTbfWM0u5gslk3CpEuga/UBEmu7HI0YE/UZ5AP78IBCd55nw8dhD3Tm
	Zfsl5fEsb/+2Pg3V+/83bfq2H1PM6uudFBKLKdEyDnUW/Ww17czqIZu4KcQjUKEUmspQdJ
	G4+++5MHgaThQik6VlOfIV+rb9GX/dvmkLW6pVsVv3JxhCs/wncv7n70mYaCH2USW54tgY
	FNt73fmf+DI0X1o+haHv4k+JbQFTsmK5gNRnYhRdGRI6M0SwPF+uc68TrulVaw==
Message-ID: <f5067055-1470-4386-8839-b4ec2527872e@bootlin.com>
Date: Wed, 4 Sep 2024 11:18:13 +0200
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
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <94069d56-0981-2d69-65c2-901a05758806@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 9/3/24 15:22, Peter Rosin wrote:
> Hi!
> 
> Sorry for being unresponsive. And for first writing this in the older v4
> thread instead of here.
> 
> 2024-06-13 at 15:07, Thomas Richard wrote:
>> The mux_chip_resume() function restores a mux_chip using the cached state
>> of each mux.
>>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> ---
>>  drivers/mux/core.c         | 29 +++++++++++++++++++++++++++++
>>  include/linux/mux/driver.h |  1 +
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>> index 78c0022697ec..0858cacae845 100644
>> --- a/drivers/mux/core.c
>> +++ b/drivers/mux/core.c
>> @@ -215,6 +215,35 @@ void mux_chip_free(struct mux_chip *mux_chip)
>>  }
>>  EXPORT_SYMBOL_GPL(mux_chip_free);
>>  
>> +/**
>> + * mux_chip_resume() - restores the mux-chip state
>> + * @mux_chip: The mux-chip to resume.
>> + *
>> + * Restores the mux-chip state.
>> + *
>> + * Return: Zero on success or a negative errno on error.
>> + */
>> +int mux_chip_resume(struct mux_chip *mux_chip)
>> +{
>> +	int ret, i;
>> +
>> +	for (i = 0; i < mux_chip->controllers; ++i) {
>> +		struct mux_control *mux = &mux_chip->mux[i];
>> +
>> +		if (mux->cached_state == MUX_CACHE_UNKNOWN)
>> +			continue;
>> +
>> +		ret = mux_control_set(mux, mux->cached_state);
> 
> mux_control_set() is an internal helper. It is called from
> __mux_control_select() and mux_control_deselect() (and on init...)
> 
> In all those cases, there is no race to reach the mux_control_set()
> function, by means of the mux->lock semaphore (or the mux not being
> "published" yet).
> 
> I fail to see how resume is safe when mux->lock is ignored?

I think I should use mux_control_select() to use the lock.
If I ignore the lock, I could have a cache coherence issue.

I'll send a new version which use mux_control_select().
But if I use mux_control_select(), I have to clean the cache before to
call it, if not nothing happen [1].

[1]
https://elixir.bootlin.com/linux/v6.11-rc6/source/drivers/mux/core.c#L319

Regards,

Thomas


