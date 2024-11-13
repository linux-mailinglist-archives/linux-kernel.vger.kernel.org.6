Return-Path: <linux-kernel+bounces-407383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED499C6CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D864E28BF92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF291FBC91;
	Wed, 13 Nov 2024 10:20:44 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE41FBC82
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493244; cv=none; b=gmHwin1gucFlfGg28+jqlqmQ30km1rOryV8BTG0MYDPzO0DGd+2CsInNdf53FQwzdbq0MGoliXeh2mb9+4wJ7L5HtsJ45wNvO0jiIlkF5P3I8b2qOaNDLqya0mu3GG5V0LP+EnZt2dSnGQHmkY5HvUZqw0ZnRTsRnvE5wRrXOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493244; c=relaxed/simple;
	bh=+guABV/ldCPRDgJyD2HO2GPHVEx0sgy1hR3Gi8cv7mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ev/lMvlga9fjl02/g9Mpktg1ppZ9P140l1KIhal3VZLCsNXuK9oLxSZnbp+BC1bu+nYlLkYUnm6G86t7krG8gFb4uEqQb8TO/d+H5TzTHFip6nlVH/NywLhFtoGGqfVOxKOit7Mh6dLlOUAeHxDPCaPWjVWTieDo99GweFqIbAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XpK6w47Zvz9sSX;
	Wed, 13 Nov 2024 11:20:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YNBYsjjOOxZq; Wed, 13 Nov 2024 11:20:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XpK6w3MQmz9sSV;
	Wed, 13 Nov 2024 11:20:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 618348B79F;
	Wed, 13 Nov 2024 11:20:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4OzcVFT7nyHT; Wed, 13 Nov 2024 11:20:40 +0100 (CET)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A15F8B763;
	Wed, 13 Nov 2024 11:20:40 +0100 (CET)
Message-ID: <b4d3084c-aa26-4d35-a330-8ba55589b89e@csgroup.eu>
Date: Wed, 13 Nov 2024 11:20:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/vdso: Remove unused clockmode asm offsets
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20241113-vdso-powerpc-asm-offsets-v1-1-3f7e589f090d@linutronix.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241113-vdso-powerpc-asm-offsets-v1-1-3f7e589f090d@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/11/2024 à 09:06, Thomas Weißschuh a écrit :
> These offsets are not used anymore, delete them.
> 
> Fixes: c39b1dcf055d ("powerpc/vdso: Add a page for non-time data")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
> This is based on powerpc/topic/vdso.
> Feel free to fold this change into the original commit.
> ---
>   arch/powerpc/kernel/asm-offsets.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 7b3feb6bc2103bc89ea14fbaac6937f1c97d4ff8..23733282de4d9f975aa9450b26c1049688e6663e 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -346,8 +346,6 @@ int main(void)
>   #else
>   	OFFSET(CFG_SYSCALL_MAP32, vdso_arch_data, syscall_map);
>   #endif
> -	OFFSET(VDSO_CLOCKMODE_OFFSET, vdso_arch_data, data[0].clock_mode);
> -	DEFINE(VDSO_CLOCKMODE_TIMENS, VDSO_CLOCKMODE_TIMENS);
>   
>   #ifdef CONFIG_BUG
>   	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
> 
> ---
> base-commit: 0161bd38c24312853ed5ae9a425a1c41c4ac674a
> change-id: 20241113-vdso-powerpc-asm-offsets-056016f80174
> 
> Best regards,

