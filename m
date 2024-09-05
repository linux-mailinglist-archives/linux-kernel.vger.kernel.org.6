Return-Path: <linux-kernel+bounces-316664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF2096D27E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427F01C2277A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA5C194C62;
	Thu,  5 Sep 2024 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PL4wowfT"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB90194A60
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526301; cv=none; b=npbwo8pS53YFQeCEwa9sKtNaJRyfP6w0i1dNlikKtPiJ0N4QbWRj1WHeRAnt0q1VdiBHb2aytitmIKqV8Lkqhodv7raFOrDGbvLQyAI1wffJqusdZe2+Tg18dT2JGUmdRbdciUyHQs3iX6xPN6pOgHoYD4e4VgCAj976a32bmk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526301; c=relaxed/simple;
	bh=twM7WddQqfc+l5fSW0h5VYv6nypnRrYgNwIfYpYw8BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZBEfZYAH/DPPZGGaoYtbwD9/pkgobwdG+rCtorgndVvL01KrZpVCxs9mtrogWNkhZRh5zubveS4h6km4iYiCICtKmqlFn5bYC5WP9dwDlEPivYId+HCyBniBCQ+lEaS34EquFTzc154GdqPy1Y62cof/kNfW4JY5rx5tovN4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PL4wowfT; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <07708265-0c57-4a8d-be2b-b722dd9503e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725526297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXzsr8O7f91QuUqU4vZsbIiIpOuXLyCN04Gn/9BoEHw=;
	b=PL4wowfTkWkScpWzSOZu7RiOgau+n9sK1ZViknZG0bUFhlT3X2cub1filQuvvgk/1DZFQh
	4fNWOcU5WkhYCcFBeEhkzWqVdlvFYcamoJtZCPMpYyvnkSpbqzcOPDHTKoE6cpQIgJ5Vuf
	aeAH77UX7K9W28dfp0Jr1UqFUCildx0=
Date: Thu, 5 Sep 2024 16:51:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] amba: make amba_bustype constant
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, krzk@kernel.org,
 andi.shyti@kernel.org, robh@kernel.org, gregkh@linuxfoundation.org,
 suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
 Kunwu Chan <chentao@kylinos.cn>
References: <20240823064203.119284-1-kunwu.chan@linux.dev>
 <ZsiTPjtnZZIW-K4k@smile.fi.intel.com>
 <56e29159-3ebb-425a-9bd6-cb66484d7738@linux.dev>
 <ZsxbjnMa8teJ5_Pg@smile.fi.intel.com>
 <5b4987e3-af8a-413f-bbbe-d493d6c371f6@linux.dev>
 <Zs3Wt5xkFOiuH-iP@smile.fi.intel.com>
 <6774cd23-47f9-4d15-8954-a9f749998fe2@linux.dev>
 <Zs8jZiN1TvNfHQ9N@smile.fi.intel.com>
 <65c80deb-21e1-44eb-87c9-c7cdd36d77cd@linux.dev>
 <ZthnjPjPB+6cMf9w@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <ZthnjPjPB+6cMf9w@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Thanks for the reply.
On 2024/9/4 21:58, Russell King (Oracle) wrote:
> On Thu, Aug 29, 2024 at 09:31:29AM +0800, Kunwu Chan wrote:
>> Thanks for the reply.
>> On 2024/8/28 21:17, Andy Shevchenko wrote:
>>> On Wed, Aug 28, 2024 at 10:51:54AM +0800, Kunwu Chan wrote:
>>>> On 2024/8/27 21:37, Andy Shevchenko wrote:
>>>>> On Tue, Aug 27, 2024 at 03:45:31PM +0800, Kunwu Chan wrote:
>>>>>> On 2024/8/26 18:40, Andy Shevchenko wrote:
>>>>>>> On Mon, Aug 26, 2024 at 06:08:11PM +0800, Kunwu Chan wrote:
>>> ...
>>>
>>>>>>> Make it patch series:
>>>>>>> 1) patch that introduces exported function called dev_is_amba() (1 patch)
>>>> Done.
>>>>>>> 2) convert user-by-user (N patches)
>>>> I've no idea about how to modify, such as in iommu.c:
>>> Oh, crap. Yes, this need more thinking.
>>> Anyway, Russell is okay with your initial patch, the rest can be done
>>> separately. For now probably we can leave it exported for this only case.
>>>
>> Anyway, thanks for the suggestion, i'll   introduce the dev_is_amba function
>>
>> and  add the Suggested tag for you.
>>
>> If you have a better idea and need me to do it, you can always contact me.
> General policy is not to add stuff that doesn't have any users. From
> what I can see from briefly reading this discussion, and looking at
> the patches submitted to me, the dev_is_amba() patch adds a helper,
> but as yet there are no users - and not even any patches on a mailing
> list to make use of this helper. Therefore, I won't be applying that
> patch.

Actually, here is a user in [1], i'am ready to use it  in [2].

  #ifdef CONFIG_ARM_AMBA
  	else if (dev->bus == &amba_bustype)

[1] 
https://elixir.bootlin.com/linux/v6.10.8/source/drivers/of/platform.c#L631

[2] https://lore.kernel.org/all/20240828150826.GA3803566-robh@kernel.org/

> Good idea, but it needs users...
>
> Please note that I likely won't be reading further discussion (see
> my signature below, and I'm having the same op on the other eye -
> which is the only eye suitable for screen work at the moment -
> this Friday.)

Sure, i've send it to the armlinux.org.uk as:

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9415/1

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9416/1


Good health.

-- 
Thanks,
   Kunwu.Chan


