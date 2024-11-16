Return-Path: <linux-kernel+bounces-411808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315589CFFD2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0A6289169
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E5F191F77;
	Sat, 16 Nov 2024 16:15:43 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD018E379
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731773743; cv=none; b=VqtzMO8rMmxTFjecY2VU/G0PjuhfCgw6rRzfbwkjuoZjXBZJ/RVvEfuye70cw9q4Y73nlMCb5xttTFZ0j/0hurq58vDkYOICnTU9WGUCyglitbU/BYqtKqLCR1snWoFeUKbHU2Fk4qiAXtSlxwgaOeY+WI1WRgwpxVT597XfT9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731773743; c=relaxed/simple;
	bh=lMZvYYUoRTyAS55ZblTspUhA2a6Mak886MN0+Dr7gQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMPY/ttyiQH/ly+/AK6gzwAf3C7NrbOw1HNaI8vSOfvJ/dtbX5b5TFNelYKq1Na859BODP8HxjjLDPfAMtnQLYfa6vo+UcP7F2i3x0sRowP6ELwXfW7RAuaPSVZT+3GhTYQJBMeww7sq4TM5WacF8be9c90xps3UCYgbOMbVgfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XrJs670Ghz9sSN;
	Sat, 16 Nov 2024 17:15:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RDniS05mwtFq; Sat, 16 Nov 2024 17:15:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XrJs662Y9z9sSL;
	Sat, 16 Nov 2024 17:15:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BC2638B7A0;
	Sat, 16 Nov 2024 17:15:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 0gGIiKiV87Hr; Sat, 16 Nov 2024 17:15:38 +0100 (CET)
Received: from [192.168.232.159] (POS169858.IDSI0.si.c-s.fr [192.168.232.159])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F5258B763;
	Sat, 16 Nov 2024 17:15:38 +0100 (CET)
Message-ID: <c00a229c-9ced-4a28-9666-b4707f317c90@csgroup.eu>
Date: Sat, 16 Nov 2024 17:15:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/10] powerpc/chrp: Remove various dead code
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, geert@linux-m68k.org, arnd@arndb.de
References: <20241114131114.602234-1-mpe@ellerman.id.au>
 <20241114131114.602234-2-mpe@ellerman.id.au>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241114131114.602234-2-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/11/2024 à 14:11, Michael Ellerman a écrit :
> Remove various bits of code that are dead now that PPC_CHRP has been
> removed.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   arch/powerpc/Kconfig                 |  5 +--
>   arch/powerpc/boot/Makefile           |  1 -
>   arch/powerpc/include/asm/processor.h |  6 ---
>   arch/powerpc/kernel/head_book3s_32.S | 12 ------
>   arch/powerpc/kernel/pci_32.c         |  2 +-
>   arch/powerpc/kernel/prom_init.c      | 56 ----------------------------
>   6 files changed, 3 insertions(+), 79 deletions(-)
> 

> diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
> index cb2bca76be53..c6e297fd36e2 100644
> --- a/arch/powerpc/kernel/head_book3s_32.S
> +++ b/arch/powerpc/kernel/head_book3s_32.S
> @@ -256,20 +256,8 @@ __secondary_hold_acknowledge:
>    */
>   	START_EXCEPTION(INTERRUPT_MACHINE_CHECK, MachineCheck)
>   	EXCEPTION_PROLOG_0
> -#ifdef CONFIG_PPC_CHRP
> -	mtspr	SPRN_SPRG_SCRATCH2,r1
> -	mfspr	r1, SPRN_SPRG_THREAD
> -	lwz	r1, RTAS_SP(r1)
> -	cmpwi	cr1, r1, 0
> -	bne	cr1, 7f
> -	mfspr	r1, SPRN_SPRG_SCRATCH2
> -#endif /* CONFIG_PPC_CHRP */
>   	EXCEPTION_PROLOG_1
>   7:	EXCEPTION_PROLOG_2 0x200 MachineCheck
> -#ifdef CONFIG_PPC_CHRP
> -	beq	cr1, 1f
> -	twi	31, 0, 0
> -#endif
>   1:	prepare_transfer_to_handler
>   	bl	machine_check_exception
>   	b	interrupt_return

Then it becomes a standard exception handler that can be set up with

	EXCEPTION(INTERRUPT_MACHINE_CHECK, MachineCheck, machine_check_exception)

And the comment from paulus voids.


