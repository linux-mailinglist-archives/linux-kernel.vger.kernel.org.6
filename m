Return-Path: <linux-kernel+bounces-560546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4727DA60665
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE8288135E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2449A32;
	Fri, 14 Mar 2025 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nTC4fHFj"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D29A802;
	Fri, 14 Mar 2025 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910711; cv=none; b=HrZgfkw0PRWKLctuXbQ5dgyOg/ulbLtYlHiJoGgKcwmiu92xku19r2kb6t1XubBzoXWEt+hehhs4PtpvVvaZL0zO5oY47kSP1Ln2o1WeyVCgFxO6q8OeBzwvng6YAzYobC32PJHgjsmHKIkBcPb6MHraEt0BO/pTmNWP9v292h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910711; c=relaxed/simple;
	bh=1W8CEFUb9RzbLkyucd9jGuKFCaNamj/pyFF/1tmggBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mV/MhSZs22Y36rmt5dkr8seA7mqre4JJ+DEAXuVnv4HPJeIXoyhVz0XbR2ljXfWXkjD7quiZmksuP9NyzxHZShxS77ejlHFvxMrZd4hzYb5q2uMT9z+Cz7hQltLhU9RhdWDThC4k0WokjtF74CkL9VZPerHto7Piu0RqZYmhW7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nTC4fHFj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=seOIK6F8Ri3Z9b2uMtd13H97RuBbTuOVKW2NN8PKcbE=; b=nTC4fHFjIabjCnWjjCjmk0MIQJ
	f2NNa6pI2kO1Dr/6UnJtfkox9yuU09sGCsA6IpNyEZHSFGau37rI5E8FjtXNBNI2u795pYpNzgS16
	OInbooV2qvy7vGF3ivg243fzGpLvkkIt/ULvTL364/bhyWEt2LxiqKqoYDu1YCmW7CQL0+ZVX01Zz
	t9ypTs5lhFpuRgoOiyWhO3WSsbNWQkl9rxeqDpncc+SIXWkiFGbQrC7WZ95e60roMjk8JxHXMm0wl
	uWOFh6fBFERn/x0IjqXj/E2F/dOZ2YsVFJNUf7SxeGgt/rB5kjzqM2ej59lS2akfwWVPfFYcXUo7I
	jkxB/i2w==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tssXm-00000002oSr-47Yu;
	Fri, 14 Mar 2025 00:04:55 +0000
Message-ID: <60067986-ce08-45da-85ba-a9ea8fedfe06@infradead.org>
Date: Thu, 13 Mar 2025 17:04:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/early_printk: add MMIO-based UARTs
To: dmukhin@ford.com, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250313-earlyprintk-v1-1-8f818d77a8dd@ford.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250313-earlyprintk-v1-1-8f818d77a8dd@ford.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/13/25 4:45 PM, Denis Mukhin via B4 Relay wrote:
> From: Denis Mukhin <dmukhin@ford.com>
> 
> During the bring-up of an x86 board, the kernel was crashing before
> reaching the platform's console driver because of a bug in the firmware,
> leaving no trace of the boot progress.
> 
> It was discovered that the only available method to debug the kernel
> boot process was via the platform's MMIO-based UART, as the board lacked
> an I/O port-based UART, PCI UART, or functional video output.
> 
> Then it turned out that earlyprintk= does not have a knob to configure
> the MMIO-mapped UART.
> 
> Extend the early printk facility to support platform MMIO-based UARTs
> on x86 systems, enabling debugging during the system bring-up phase.
> 
> The command line syntax to enable platform MMIO-based UART is:
>   earlyprintk=mmio,membase[,{nocfg|baudrate}][,keep]
> 
> Note, the change does not integrate MMIO-based UART support to:
>   arch/x86/boot/early_serial_console.c
> 
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 +++
>  arch/x86/kernel/early_printk.c                  | 45 ++++++++++++++++++++++++-
>  2 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb8752b42ec8582b8750d7e014c4d76166fa2fc1..bee9ee18a506d019dc3d330268e3e1c83434ebba 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1414,11 +1414,15 @@
>  			earlyprintk=pciserial[,force],bus:device.function[,baudrate]
>  			earlyprintk=xdbc[xhciController#]
>  			earlyprintk=bios
> +			earlyprintk=mmio,membase[,{nocfg|baudrate}][,keep]
>  
>  			earlyprintk is useful when the kernel crashes before
>  			the normal console is initialized. It is not enabled by
>  			default because it has some cosmetic problems.
>  
> +			Use "nocfg" to skip UART configuration, assume
> +			BIOS/firmware has configured UART correctly.
> +
>  			Append ",keep" to not disable it when the real console
>  			takes over.
>  
> diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
> index 44f937015e1e25bf41532eb7e1031a6be32a6523..19248c73b5b0950e9edf1a60ba67829f1cd3279e 100644
> --- a/arch/x86/kernel/early_printk.c
> +++ b/arch/x86/kernel/early_printk.c
> @@ -191,7 +191,6 @@ static __init void early_serial_init(char *s)
>  	early_serial_hw_init(divisor);
>  }
>  
> -#ifdef CONFIG_PCI
>  static void mem32_serial_out(unsigned long addr, int offset, int value)
>  {
>  	u32 __iomem *vaddr = (u32 __iomem *)addr;
> @@ -206,6 +205,45 @@ static unsigned int mem32_serial_in(unsigned long addr, int offset)
>  	return readl(vaddr + offset);
>  }
>  
> +/*
> + * early_mmio_serial_init() - Initialize MMIO-based early serial console.
> + * @membase: UART base address.
> + * @nocfg: Skip configuration, assume BIOS has configured UART correctly.
> + * @baudrate (int): Baud rate.

Looks like unsigned long to me.

> + * @keep: Keep after the real driver is available.

These 4 "parameters" are not the function arguments.
@s is the function argument.

You could say in a comment that @s is scanned to obtain
these 4 parameters or something like that.

> + */
> +static __init void early_mmio_serial_init(char *s)
> +{
> +	unsigned long baudrate;
> +	unsigned long membase;
> +	char *e;
> +
> +	if (*s == ',')
> +		s++;
> +
> +	if (!strncmp(s, "0x", 2)) {
> +		membase = simple_strtoul(s, &e, 16);
> +		early_serial_base = (unsigned long)early_ioremap(membase, PAGE_SIZE);
> +		serial_in = mem32_serial_in;
> +		serial_out = mem32_serial_out;
> +
> +		s += strcspn(s, ",");
> +		if (*s == ',')
> +			s++;
> +	}
> +
> +	if (!strncmp(s, "nocfg", 5))
> +		baudrate = 0;
> +	else {
> +		baudrate = simple_strtoul(s, &e, 0);
> +		if (baudrate == 0 || s == e)
> +			baudrate = DEFAULT_BAUD;
> +	}
> +	if (baudrate)
> +		early_serial_hw_init(115200 / baudrate);
> +}
> +
> +#ifdef CONFIG_PCI
>  /*
>   * early_pci_serial_init()
>   *
> @@ -352,6 +390,11 @@ static int __init setup_early_printk(char *buf)
>  	keep = (strstr(buf, "keep") != NULL);
>  
>  	while (*buf != '\0') {
> +		if (!strncmp(buf, "mmio", 4)) {
> +			early_mmio_serial_init(buf + 4);
> +			early_console_register(&early_serial_console, keep);
> +			buf += 4;
> +		}
>  		if (!strncmp(buf, "serial", 6)) {
>  			buf += 6;
>  			early_serial_init(buf);
> 
> ---


-- 
~Randy


