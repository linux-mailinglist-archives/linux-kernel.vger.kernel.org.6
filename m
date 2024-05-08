Return-Path: <linux-kernel+bounces-173898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ECA8C0758
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82E2283183
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABD1133426;
	Wed,  8 May 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d8tD27Us"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953213340E;
	Wed,  8 May 2024 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715207391; cv=none; b=aeo0D32PKS+wy9P8kr6ovH1cJOQlbN4espE71o26+qxWnFIwYLtlUeMuhpykiGRhnnUsJnugBR9VDUqGpeQO0qpEn6FOvCUOMFMuSXMDyB757T489UzsT5AU1huuuTx2+6i7RTipYFZvFe+/LR/Dvyohh4Hx7qwGZr+DJ5FTeUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715207391; c=relaxed/simple;
	bh=FzJBgrQxIdNzOxQOHuhjRfbO74jsiRprQUNagdrkAaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MInjMlLVG9FdGLdkgxQtLQdyKoKzcDSfHV+X16+X0rtoNRf1tdAkHYvnnVmV8QOhfXvbAMt0OyZ9e87mEem7Y2MF5Qmg97927zVLzxgAuQa5KqgBc0k70QULD8ROVhSKJJ8FOayebbEkjCPJXX9EDEC7fScxLc6/X5WGBQuYOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d8tD27Us; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=d6XhmtyByC67AvaiaMru39DJYEvRdT178Mi2caB30As=; b=d8tD27Usvg00XgSFQM+NPLWPb2
	H580GLyvv8UpISBdrNnFqZw8uq7BmCDzdRVb3hTTjAa1zvLLVY3r+theec7SMIORmGqGiPDKoDrrW
	rQ1ggvRwkXJa+jfgVl2OVVIL2I/xWRUsGfrvRFQBn1ZcfdzpdcvaABUKHNtXkikzrgvYk17hjxo72
	cmmaWM0izaQlC6wpy01HAxzXSsMR7jBomGSDC4Mo5bbmRbEWXPBHx2rrQpbUuAPN2Fyk1JGkoNQju
	EETZzYJReBw22RRvI4iuFFkaMBPQ0y8yWU9lbuxxmR0CASGv8oNeGqfC44XFpgejANGjt6nnGisNL
	W1w4EwNg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4pnG-0000000H9uo-43cd;
	Wed, 08 May 2024 22:29:47 +0000
Message-ID: <c1f1b699-71ad-409a-a843-afe42640626a@infradead.org>
Date: Wed, 8 May 2024 15:29:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs: Add advanced extended IRQ model description
To: Tianyang Zhang <zhangtianyang@loongson.cn>, chenhuacai@kernel.org,
 kernel@xen0n.name, corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240507122228.5288-1-zhangtianyang@loongson.cn>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240507122228.5288-1-zhangtianyang@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 5/7/24 5:22 AM, Tianyang Zhang wrote:
> From 3C6000, Loongarch began to support advanced extended
> interrupt mode, in which each CPU has an independent interrupt
> vector number.This will enhance the architecture's ability
> to support modern devices
> 
> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
> ---
>  .../arch/loongarch/irq-chip-model.rst         | 33 +++++++++++++++++
>  .../zh_CN/arch/loongarch/irq-chip-model.rst   | 37 +++++++++++++++++--
>  2 files changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/arch/loongarch/irq-chip-model.rst b/Documentation/arch/loongarch/irq-chip-model.rst
> index 7988f4192363..79228741d1b9 100644
> --- a/Documentation/arch/loongarch/irq-chip-model.rst
> +++ b/Documentation/arch/loongarch/irq-chip-model.rst
> @@ -85,6 +85,39 @@ to CPUINTC directly::
>      | Devices |
>      +---------+
>  
> +Advanced Extended IRQ model
> +=======================

The === underline line needs to be at least as long as the line above it.

> +
> +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt go
> +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, MSI interrupts go to AVEC,
> +and then go to CPUINTC, Other devices interrupts go to PCH-PIC/PCH-LPC and gathered

                  CPUINTC.

> +by EIOINTC, and then go to CPUINTC directly::
> +
> + +-----+     +--------------------------+     +-------+
> + | IPI | --> |           CPUINTC        | <-- | Timer |
> + +-----+     +--------------------------+     +-------+
> +              ^        ^             ^
> +              |        |             |
> +      +--------+  +---------+ +---------+     +-------+
> +      | AVEC   |  | EIOINTC | | LIOINTC | <-- | UARTs |
> +      +--------+  +---------+ +---------+     +-------+
> +           ^            ^
> +           |            |
> +         +---------+  +---------+
> +         |   MSI   |  | PCH-PIC |
> +         +---------+  +---------+
> +            ^          ^       ^
> +            |          |       |
> +    +---------+ +---------+ +---------+
> +    | Devices | | PCH-LPC | | Devices |
> +    +---------+ +---------+ +---------+
> +                     ^
> +                     |
> +                +---------+
> +                | Devices |
> +                +---------+
> +
> +
>  ACPI-related definitions
>  ========================
>  

thanks.
-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

