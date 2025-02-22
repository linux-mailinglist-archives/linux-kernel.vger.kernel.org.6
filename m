Return-Path: <linux-kernel+bounces-527170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD798A4080E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536583BB26C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B033209F25;
	Sat, 22 Feb 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXBs45JI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80F13BC0E;
	Sat, 22 Feb 2025 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740225020; cv=none; b=SKyvMiZInQGTd8PjqKgkbJFcesvXmuiCht+/9hJ6jhU7Z8ZHpEbAs06lTkdvhKs2q09ycH3YZokaUjFiRIRIWfO0tapRCnsQnxZ8h2RSc+3Ar3ZGgzNyBpZ0wjQENZsEB1IhPZXw9MYyxtCtPxqc/r34B+wPWAD9cLOiGKqIGco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740225020; c=relaxed/simple;
	bh=WHtr1zZ9a93GA1KijUCd5YYQ9Yepb+ZGhVADmwPbocI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMYDF8/RDYJ/2eqDuA0/d9hqs6XXBO6JHAxfZA2VrHcDz+V2TA1Oa+nXktuW+9ctZdEPOB1/0AQZCwiaTzf+23OPGLaMMp8T06tKOamQhX3BlHRMbYbQ7QDQgwkBlFxPcSSNU2Lt99MgAkbW7acu5++KIGBNSPt/UNBWeIzE0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXBs45JI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23507C4CED1;
	Sat, 22 Feb 2025 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740225019;
	bh=WHtr1zZ9a93GA1KijUCd5YYQ9Yepb+ZGhVADmwPbocI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SXBs45JIAQyCjrBLXFrXylEYrGln2xUNPbeu/mD4vEJFXqrMqWTebBpkRako/hov1
	 KItQno/KnBo6RrMbMozSpT7L8sN+RpMWywtbc+REHb6CMl+1ysNTRHOiY5LEHX1RDS
	 00ntIoyFm3VgYjFqm8Vp04Y2jzPkthHwPrUWX0deZ0uIjFX8Dtjt4kqoMBYuIgKvtU
	 xlEwAzxTCHrii9X/eBnZT/4Co2YKCF/9SUQY8pFG3Kqw9vyTtLp+KcMVNf82X5tFQj
	 4IUkYYaF415Uk7xN5xKitt1Wl2YhDcnm6nq3Wi7nldFfSYXkdhTlRgvesm8RlTFjWT
	 zRRa2L4s4ssxQ==
Message-ID: <6ea8ac17-42c8-46fa-b970-77ba89de66c4@kernel.org>
Date: Sat, 22 Feb 2025 12:50:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: soc: spacemit: Add spacemit,k1-syscon
To: Haylen Chu <heylenay@4d2.org>, Alex Elder <elder@riscstar.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Haylen Chu <heylenay@outlook.com>,
 Yixun Lan <dlan@gentoo.org>, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>,
 Chen Wang <unicornxdotw@foxmail.com>, Jisheng Zhang <jszhang@kernel.org>,
 Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 Guodong Xu <guodong@riscstar.com>
References: <20250103215636.19967-2-heylenay@4d2.org>
 <20250103215636.19967-4-heylenay@4d2.org>
 <aw2vqnz5vcccqqvrrhz5tgawj7fnzzg3tds7nnepuorit37a7r@jcj3wrs7d73h>
 <Z6rdBhQ7s2ReOgBL@ketchup> <19e5129b-8423-4660-8e4f-8b898214d275@kernel.org>
 <Z63T_EDvXiuRQbvb@ketchup> <2ab715bd-e26c-41bb-ac64-baa864d90414@kernel.org>
 <Z7BTVu10EKHMqOnJ@ketchup>
 <7c697e9a-d6d9-4672-9738-93ce3a71beb6@riscstar.com>
 <4f7bf109-bf18-42be-971c-5d5edd9595b5@kernel.org> <Z7mrdrACFp3m-7sy@ketchup>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z7mrdrACFp3m-7sy@ketchup>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2025 11:48, Haylen Chu wrote:
> On Sat, Feb 22, 2025 at 10:59:09AM +0100, Krzysztof Kozlowski wrote:
>> On 22/02/2025 00:40, Alex Elder wrote:
>>> I have a general proposal on how to represent this, but I'd
>>> like to know whether it makes sense.  It might be what Krzysztof
>>> is suggesting, but in any case, I hope this representation would
>>> work, because it could simplify the code, and compartmentalizes
>>> things.
>>>
>>> Part of what motivates this is that I've been looking at the
>>> downstream reset code this week.  It contains a large number of
>>> register offset definitions identical to what's used for the
>>> clock driver.  The reset driver uses exactly the same registers
>>> as the clock driver does.  Downstream they are separate drivers,
>>> but the clock driver exports a shared spinlock for both drivers
>>> to use.
>>>
>>> These really need to be incorporated into the same driver for
>>> upstream.
>>
>> Why? First, it is not related to the topic here at all. You can design
>> drivers as you wish and still nothing to do with discussion about binding.
>> Second, different subsystems justify different drivers and Linux handles
>> this well already. No need for custom spinlock - regmap already does it.
>>
>>
>>>
>>> The clock code defines four distinct "units" (a term I'll use
>>> from here on; there might be a better name):
>>>    MPMU  Main Power Management Unit
>>>    APMU  Application Power Management Unit
>>>    APBC  APB Clock
>>>    APBS  APB Spare
>>>
>>> The reset code defines some of those, but doesn't use APBS.
>>> It also defines three more:
>>>    APBC2 Another APB Clock
>>>    RCPU  Real-time CPU?
>>>    RCPU2 Another Real-time CPU
>>>
>>> Each of these "units" has a distinct I/O memory region that
>>> contains registers that manage the clocks and reset signals.
>>
>> So there are children - mpmu, apmu, apbclock, apbspare, apbclock2, rcpu
>> 1+2? But previous statements were saying these are intermixed?
>>
>> " I'll make APMU/MPMU act as a whole device"
> 
> My reply seems somehow misleading. The statement means I will merge the
> children with the syscon into one devicetree node, which applies for
> both APMU and MPMU. I wasn't going to say that APMU and MPMU are
> intermixed.
> 
> As Alex said, all these units have their own distinct and separate MMIO
> regions.
> 
>>>
>>> I suggest a single "k1-clocks" device be created, which has
>>
>> For four devices? Or for one device?
> 
> By Alex's example, I think he means a device node taking all these
> distinct MMIO regions as resource.


You still do not answer about the hardware: how many devices is there?

> 
> 	clock {
> 		compatible = "spacemit,k1-clocks";
> 
> 		reg = <0x0 0xc0880000 0x0 0x2050>,
> 		      <0x0 0xc0888000 0x0 0x30>,
> 		      <0x0 0xd4015000 0x0 0x1000>,
> 		      <0x0 0xd4050000 0x0 0x209c>,
> 		      <0x0 0xd4090000 0x0 0x1000>,
> 		      <0x0 0xd4282800 0x0 0x400>,
> 		      <0x0 0xf0610000 0x0 0x20>;
> 		reg-names = "rcpu",
> 			    "rcpu2",
> 			    "apbc",
> 			    "mpmu",
> 			    "apbs",
> 			    "apmu",
> 			    "apbc2";
> 
> 		/* ... */
> 	};
> 
>> No, it's again going to wrong direction. I already said:
>>
>> "You need to define what is the device here. Don't create fake nodes ust
>> for your drivers. If registers are interleaved and manual says "this is
>> block APMU/MPMU" then you have one device, so one node with 'reg'."
>>
>> So what is the device here? Can you people actually answer?
>>
> 
> I'm not sure about the apbc2, rcpu and rcpu2 regions; they aren't
> related to the thread, either. For APBC, MPMU, APBS and APMU, I'm pretty
> sure they're standalone blocks with distinct and separate MMIO regions,
> this could be confirmed by the address mapping[1].

They were brought here to discuss for some reason. Long discussions,
long emails, unrelated topics like hardware or different devices - all
this is not making it easier for me to understand.


Best regards,
Krzysztof

