Return-Path: <linux-kernel+bounces-276175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCF5948F7B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73BEAB20E44
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A951C461D;
	Tue,  6 Aug 2024 12:50:05 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1821C3F21
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948605; cv=none; b=SlRyumTztBdRY6f0s1FLdYM139XMnxymEJWW04JFPy0FyqFAqQAjHGVzfl45ceYsnA0pPbzlfvwFUKWDsGdp2L5s0dpE8VsrcmyaXix3HknghzU1yYM38NxtF6kcfoSHQ+jNUW6qqF+1vwNXNPlVH7Z1dYYU+54af9LGNG0wu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948605; c=relaxed/simple;
	bh=DNhFjV9fPyxAwFaOsUvXuFhJOdvdvP8hNXhpNzPNqJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q+HGVa6Pzp66nxL/RvYMG4Lfz6PVFWMRM6+Nwo/OmAEIm2TsMCtqGBWCpYCjKd6908fGvxIF54pj8y9QiprTzQf0IiocmxupD/v8uTtpdmAyfFuqHAgMMAWSt82Dko64BTFyuUMgKCajShpeIiyauD4EwrW3Ir9kmansnrRw3qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WdY6x2Z41z9sRr;
	Tue,  6 Aug 2024 14:50:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HkUBW5cEupxE; Tue,  6 Aug 2024 14:50:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WdY6x1lgbz9sRk;
	Tue,  6 Aug 2024 14:50:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 28F8C8B76C;
	Tue,  6 Aug 2024 14:50:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Ha8emGShSbFq; Tue,  6 Aug 2024 14:50:01 +0200 (CEST)
Received: from [192.168.234.84] (unknown [192.168.234.84])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A6C258B763;
	Tue,  6 Aug 2024 14:50:00 +0200 (CEST)
Message-ID: <135289c2-78bc-4a14-ad43-6d45750af293@csgroup.eu>
Date: Tue, 6 Aug 2024 14:50:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] powerpc: Fix a config comment typo in asm/percpu.h
To: Jinjie Ruan <ruanjinjie@huawei.com>, dennis@kernel.org, tj@kernel.org,
 cl@linux.com, mpe@ellerman.id.au, npiggin@gmail.com, naveen@kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240806112345.2387969-1-ruanjinjie@huawei.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240806112345.2387969-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/08/2024 à 13:23, Jinjie Ruan a écrit :
> [Vous ne recevez pas souvent de courriers de ruanjinjie@huawei.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> commit 0db880fc865f ("powerpc: Avoid nmi_enter/nmi_exit in real mode
> interrupt.") has a config comment typo, fix it.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   arch/powerpc/include/asm/percpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
> index 634970ce13c6..c836b16ce30d 100644
> --- a/arch/powerpc/include/asm/percpu.h
> +++ b/arch/powerpc/include/asm/percpu.h
> @@ -23,7 +23,7 @@ DECLARE_STATIC_KEY_FALSE(__percpu_first_chunk_is_paged);
>                  (static_key_enabled(&__percpu_first_chunk_is_paged.key))
>   #else
>   #define percpu_first_chunk_is_paged    false
> -#endif /* CONFIG_PPC64 && CONFIG_SMP */
> +#endif /* CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK && CONFIG_SMP */

The #if/#else/#endif section is small and doesn't nest additional 
#ifdefs so the comment is useless and should be removed completely.

Christophe

