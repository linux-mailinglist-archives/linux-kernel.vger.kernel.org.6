Return-Path: <linux-kernel+bounces-427248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA279DFE93
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15192162E9E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D31FE44C;
	Mon,  2 Dec 2024 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="eR7L0Bwo"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA751FDE24;
	Mon,  2 Dec 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134477; cv=none; b=GSk38bufZ2tyuCrhmXSZ2xqEecny+23ne42+j7Oxxi6GiQra/RRD61hNdGchJAsMy/HXgWA3qaGQ+r485Xe6bunuyBU5nth1ECjLBQyVVpuhPpsK98o+IIElj4Xi06PUxpS0yZy62OF1d8NfwcNDA3KWlNIxGtIh9ppn2Jb2SrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134477; c=relaxed/simple;
	bh=hzca0Vd/8ffGWVMELyMaSjK5OkJnubC9vL/FhBJgcMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQO8hMQGz+F2oJOjPvZFFw1KBK/CPDidhWgP2WlfSmB9Zq5lLUw29KM+ZaCfOXk2w8wI09Lfa1uLZ0shobQCYNb1kxV0WDt5xKth3Eiie9Gkp70tCHLq6Q47HgzblXriIbXjR+1xYUc2HbNM/D3ougC1m2aYtM6WcZk4j+Eolzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=eR7L0Bwo; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13131240003;
	Mon,  2 Dec 2024 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733134473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=No/NWeHkarpWPPlisVqL/gSD6YvfOp1acQ+zd9+j7Wc=;
	b=eR7L0BwogaZWS7Hk8Zh9PMxYCxlvqynfJIOSBrYqBVx2rb+gPoFtvjQ7PKZi/2+Qy0pBjJ
	6+jB6SP+sUar5PBUuE/8tiKt9HUmR3+CukMrMHKLv4vToN7zzzPsvwIIK+OTyLd2XiLTT/
	GFSUOq7BJvr3/zQ3ltj6EU6zEK1xZqWIJdCCTU/15pPg8cWZsTSWspOLOS/XnE0YgqtQNO
	TBaOgiOy4ALLs7mDrpfUyz4vQsd1JeLWP76XQuXW3Gg19INLREN/ovkBM6AFmBToyULu+H
	bQYfkuCAjSFx0bkqqhyLLtss6hIdLB8+Ulu5DaWkgaQWBPeWxGev5pNjmuPDEA==
Message-ID: <2aefbd79-17c8-4190-bf4b-4e6b7d667065@yoseli.org>
Date: Mon, 2 Dec 2024 11:14:32 +0100
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

On 02/12/2024 10:29, Jean-Michel Hautbois wrote:
> This patch series adds support for DMA timers for the M5441x coldfire
> family. The aim is to provide finer scheduler resolution and support for
> high-resolution timers.
> 
> The first patch fixes the clocks and a typo. The second one is the
> timers support addition. As there is no device tree, I did not use
> TIMER_OF_DECLARE().

I forgot to mention the result on a real M544118 board !
With PIT timer:
bash-5.2# cyclictest -p 80 -m -q -l 10000
WARN: stat /dev/cpu_dma_latency failed: No such file or directory
WARN: High resolution timers not available
T: 0 (  231) P:80 I:1000 C:  10000 Min:    277 Act: 1965 Avg: 1437 Max: 
   2023

With this driver and the following declaration in m5441x.c:
static struct resource mcf_dmatmr2_resource[] = {
	[0] = {
		.start = MCFDMATIMER_BASE2,
		.end   = MCFDMATIMER_BASE2 + 0xf,
		.flags = IORESOURCE_MEM,
	},
	[1] = {
		.start = MCFDMATIMER_IRQ_DTIM2,
		.end   = MCFDMATIMER_IRQ_DTIM2,
		.flags = IORESOURCE_IRQ,
	},
	[2] = {
		.start = MCFDMATIMER_IRQ_PRIO2,
		.end   = MCFDMATIMER_IRQ_PRIO2,
		.flags = IORESOURCE_REG,
		.name = "prio_reg",
	}
};

static struct platform_device mcf_dmatmr2 = {
	.name			= "mcftmr",
	.id			= 2,
	.num_resources = ARRAY_SIZE(mcf_dmatmr2_resource),
	.resource = mcf_dmatmr2_resource,
};

bash-5.2# cyclictest -p 80 -m -q -l 10000 -R
WARN: stat /dev/cpu_dma_latency failed: No such file or directory
WARN: reported clock resolution: 1 nsec
WARN: measured clock resolution approximately: 2376 nsec
T: 0 (  243) P:80 I:1000 C:  10000 Min:    104 Act:  125 Avg:  129 Max: 
    239

I don't know why the reported resolution is 1ns and not 8ns but it is 
not a big issue I suppose :-) ?

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


