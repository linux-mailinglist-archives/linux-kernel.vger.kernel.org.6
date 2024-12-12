Return-Path: <linux-kernel+bounces-442940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 846459EE453
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE49188817C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821A211291;
	Thu, 12 Dec 2024 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="MXi/rNhV"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646F1210190;
	Thu, 12 Dec 2024 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999960; cv=none; b=Hj3/i6DNMy84QRqAsa34EhFERWRoL430K/xXSq9zO4by1wNY0Z40WMYtl0xPeCVb6wSPlyC1OT1HS0vy8bVNtvfx/YmsiNxB8oE4Fshl/bKMH3Wx6RE065bauECq2BLQiqR6U50iLpRNLRL9xtF9H2GyGDKk6qsfqqCsmD67UUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999960; c=relaxed/simple;
	bh=EP8PlCbz0QSKg8XArxoMShxg90NERyMwJn9YVjfEVl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUycSfKuY/pLZxntocp7l2X++kYl9u0f5bLQT1vmCFxjgAHZrpGcdffQxlWOTdl6WWInpXn56bTT0Lb4AUBppwDcdFRHaEFFQW+IDUk3442VwzUyd+eQcoFDziYUeSm75AebJPNxhRcPFCV4wdq1eiQrxM5M1KdMdm6hOCeifi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=MXi/rNhV; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id A656C1C0008;
	Thu, 12 Dec 2024 10:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733999951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qE2flIbPdyam8x8lpnGZoOPxbCF9EqnYLhFNl13jOlU=;
	b=MXi/rNhVRgzZRA0qd6zfw3SBKXnMt5UIlim7Tst/grFWKZ4EP4qCwu1+Xc7lbnb2YbC2fI
	0NMi8NzdGWF9N4RB9SUXFYJBOg0ByUpXNO0IefFSGcg6Dn3NOvmjUezGqjP7Z4/a9IX86X
	Tpyuu+vnzAELdoZMziosAkgewnST9d7TJHrVw3JjBcfbYvky43qziozsntJ/B2m27wRoFZ
	WU/OzgQr4td46M/1XuL1UsY7/on8NwAfjVyQJeZY22Q/QLX9d2Iiu8LQYOKqkbo2twG53F
	kx57PhlvM6jv9X3jxE/SpAItsqtRKqwVt9U0hUM+DgS7cf3QIcxn4ux+vxP51Q==
Message-ID: <125431ab-e486-43a7-a903-76c831da4985@yoseli.org>
Date: Thu, 12 Dec 2024 11:39:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] m68k: Add DMA timers support for M5441x
To: Greg Ungerer <gerg@linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-m68k@vger.kernel.org
References: <20241202-m5441x_dma_tmr-v1-0-94087efe4243@yoseli.org>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20241202-m5441x_dma_tmr-v1-0-94087efe4243@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi !

On 02/12/2024 10:29, Jean-Michel Hautbois wrote:
> This patch series adds support for DMA timers for the M5441x coldfire
> family. The aim is to provide finer scheduler resolution and support for
> high-resolution timers.
> 
> The first patch fixes the clocks and a typo. The second one is the
> timers support addition. As there is no device tree, I did not use
> TIMER_OF_DECLARE().
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
> Jean-Michel Hautbois (2):
>        m68k: coldfire: Use proper clock rate for timers
>        m68k: m5441x: Add DMA timer support
> 
>   MAINTAINERS                         |   6 +
>   arch/m68k/coldfire/m5441x.c         |  20 +--
>   arch/m68k/include/asm/m5441xsim.h   |  18 +++
>   drivers/clocksource/Kconfig         |   9 ++
>   drivers/clocksource/Makefile        |   1 +
>   drivers/clocksource/mcf_dma_timer.c | 240 ++++++++++++++++++++++++++++++++++++
>   6 files changed, 284 insertions(+), 10 deletions(-)
> ---
> base-commit: e3f432391d55ec21274bd16a04659b4a24678535
> change-id: 20241202-m5441x_dma_tmr-d969f4cc30a8
> 
> Best regards,

Gentle ping, as I don't know if anyone is interested by this patch :-) ?

I think it makes coldfire really better but it certainly has issues !

On my kernel, m54418, I observed a few things.

First, when launching cyclictest I get sometimes a bad irq handle:
[  720.442175] irq 24, desc: 6b62142b, depth: 1, count: 0, unhandled: 0
[  720.442329] ->handle_irq():  e4232a91, handle_bad_irq+0x0/0x1e6
[  720.442498] ->irq_data.chip(): 66a62b77, 0x4183e868
[  720.442613] ->action(): 00000000
[  720.442667] unexpected IRQ trap at vector 18

These IRQ numbers are a bit weird, I suppose it is a spurious IRQ, but 
not sure ?

Next, cyclictest might experience *very* long delay if the CPU is very 
busy and a ping flood burst comes in:
# cyclictest -m -p 98 --secaligned
WARN: stat /dev/cpu_dma_latency failed: No such file or directory
policy: fifo: loadavg: 2.24 1.94 1.03 1/127 252

T: 0 (  251) P:98 I:1000 C:  53113 Min:    116 Act:  327 Avg:  209 Max: 
  60353

Any review would be appreciated, at least to know if it is totally off 
or not that bad and needs a few fixes ?

Thanks,
JM

