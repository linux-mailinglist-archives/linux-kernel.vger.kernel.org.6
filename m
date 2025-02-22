Return-Path: <linux-kernel+bounces-527094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7CBA40736
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB4C3BEF33
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8E8207A3D;
	Sat, 22 Feb 2025 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZcMj+FE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF1B2EB10;
	Sat, 22 Feb 2025 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740218357; cv=none; b=HJHrMMfVTd0i2xlNNonpqvO6eAVxPHiSaBFUDQObZXqUEpYv1HF1onh1p4VARJ0ff9cPAZlWzL+VxTLj0q5sYH9M7C95ERNrPaZffzWaJLx3B1XGu9+XurJ3AuHhhvFcPTyPrrPfBOEhA3ztL8euAdRbJVXTLTyNjZLgP+3oMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740218357; c=relaxed/simple;
	bh=i/2WsCyRG4dxpn1+NTTIXKQ2K2x0SJWwCMNSlTX1Ams=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8PRP4PWSXN4JoMZAcgd5zt+TQrpeqHZB0apig5nbDyyekapZeUzC1I0VlU3PkfKbS2fZu1Epoiaw2TVlfk3TnV2CJ7u+SfXjlefbs2+KvOg//ymAcf9HucUtjDcAV1LK10uY4Cd3qyz0tPU6UZy5oEaf7axremDVfYl/VUe9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZcMj+FE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0122AC4CED1;
	Sat, 22 Feb 2025 09:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740218355;
	bh=i/2WsCyRG4dxpn1+NTTIXKQ2K2x0SJWwCMNSlTX1Ams=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fZcMj+FE/6JrZxveDqc3ogrm1LKoaEYmyrJAhYRJlqRWFqJ5qe64qU65bnbpaWKKL
	 wLUEap1fz/xCLJ+jHNWLa21Zs0LcxUjJQdyuPplNuz53J3mlc9MnuevBWhfp7avcQR
	 SyfM/RFZghzhHgAIkMvodNGcc/Azwxl0JuYj3tBzhx2JPmyFt84TFnHb/hrYYEJK0x
	 gLCrI1j8CVDvvtvQWU70GUf/Foa3sV4LRVgLhhqvjUvlYs0AruxSzQ8Q/N3GyJVQzY
	 ANIBjsIQ7IOhasMQ4JqtCBsan84NX8tHu+yfLbEiypwHndt5F9UGneuNaOLkNdhZpy
	 jQAnXeQYJ2Jhw==
Message-ID: <4f7bf109-bf18-42be-971c-5d5edd9595b5@kernel.org>
Date: Sat, 22 Feb 2025 10:59:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: soc: spacemit: Add spacemit,k1-syscon
To: Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <7c697e9a-d6d9-4672-9738-93ce3a71beb6@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2025 00:40, Alex Elder wrote:
> I have a general proposal on how to represent this, but I'd
> like to know whether it makes sense.  It might be what Krzysztof
> is suggesting, but in any case, I hope this representation would
> work, because it could simplify the code, and compartmentalizes
> things.
> 
> Part of what motivates this is that I've been looking at the
> downstream reset code this week.  It contains a large number of
> register offset definitions identical to what's used for the
> clock driver.  The reset driver uses exactly the same registers
> as the clock driver does.  Downstream they are separate drivers,
> but the clock driver exports a shared spinlock for both drivers
> to use.
> 
> These really need to be incorporated into the same driver for
> upstream.

Why? First, it is not related to the topic here at all. You can design
drivers as you wish and still nothing to do with discussion about binding.
Second, different subsystems justify different drivers and Linux handles
this well already. No need for custom spinlock - regmap already does it.


> 
> The clock code defines four distinct "units" (a term I'll use
> from here on; there might be a better name):
>    MPMU  Main Power Management Unit
>    APMU  Application Power Management Unit
>    APBC  APB Clock
>    APBS  APB Spare
> 
> The reset code defines some of those, but doesn't use APBS.
> It also defines three more:
>    APBC2 Another APB Clock
>    RCPU  Real-time CPU?
>    RCPU2 Another Real-time CPU
> 
> Each of these "units" has a distinct I/O memory region that
> contains registers that manage the clocks and reset signals.

So there are children - mpmu, apmu, apbclock, apbspare, apbclock2, rcpu
1+2? But previous statements were saying these are intermixed?

" I'll make APMU/MPMU act as a whole device"

> 
> I suggest a single "k1-clocks" device be created, which has

For four devices? Or for one device?

No, it's again going to wrong direction. I already said:

"You need to define what is the device here. Don't create fake nodes ust
for your drivers. If registers are interleaved and manual says "this is
block APMU/MPMU" then you have one device, so one node with 'reg'."

So what is the device here? Can you people actually answer?



> access to all of the I/O address ranges.  And then within
> the DT node for that device there is a sub-node for the

Uh, confusing. You said there is one device for all the clocks, so if
there is one device so also one device node. No children.

Maybe you have more devices but none of you is explaining the hardware
that way. Mixing talk about drivers is really not helping.

> 


Best regards,
Krzysztof

