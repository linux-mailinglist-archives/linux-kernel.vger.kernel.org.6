Return-Path: <linux-kernel+bounces-568611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED50A69863
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B187D3B494B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D1420B808;
	Wed, 19 Mar 2025 18:50:07 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C347207A20
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410206; cv=none; b=uIPN0i8sDK+LsCv0SvW/0bXkJu1Flf+nPT75Q8GLdryrQHm6EFL5O9t1+swvFr3GWmArfuy/kjKs+2qIaUqfJEHeLTTjityG0N/HbdO+c/Dcf7MA2JXRqx3e81wEHUyuENNZZoEngvUYHmMtv7RSKyVRU7dTHEylOamwhEvouQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410206; c=relaxed/simple;
	bh=y8rbiKDn4iGnGBnglLaSqETgN/SwE1bpBX5g/Xbo26g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4HZfY6rwsmxGTObku2ca+IcnxCSw0OBf3n8ntJweW6WOldbcgq4p61emQI0gUaAXnXDNVdXC3qrB6jln2lGakgClbgsbuFNAdYN4qkAgnKPkmggfNeXZAOLhbzzv38a0wk+HHeMssCZwpavw1h7NLemFIdYfqtSKZQqmKnKalM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZHyKr1CTQz9sRr;
	Wed, 19 Mar 2025 19:44:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Sp1VH9wXf1L; Wed, 19 Mar 2025 19:44:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZHyKr0Kl3z9sPd;
	Wed, 19 Mar 2025 19:44:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D40008B796;
	Wed, 19 Mar 2025 19:44:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id gTNqAfmOhYdH; Wed, 19 Mar 2025 19:44:15 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 72B5E8B763;
	Wed, 19 Mar 2025 19:44:15 +0100 (CET)
Message-ID: <1ad38545-77a4-4236-8ff1-d799330b7111@csgroup.eu>
Date: Wed, 19 Mar 2025 19:44:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: add the linuppc-dev list to the fsl-mc
 bus entry
To: Ioana Ciornei <ioana.ciornei@nxp.com>, Stuart Yoder <stuyoder@gmail.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250319094311.2966519-1-ioana.ciornei@nxp.com>
 <20250319094311.2966519-4-ioana.ciornei@nxp.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250319094311.2966519-4-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 19/03/2025 à 10:43, Ioana Ciornei a écrit :
> [Vous ne recevez pas souvent de courriers de ioana.ciornei@nxp.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> As discussed in the thread linked below, the fsl-mc bus lacked a clear
> maintenance path. Since Christophe accepted to take the fsl-mc bus
> patches through his soc fsl subtree, add the linuxppc-dev mailing list
> in the MAINTAINERS entry.
> 
> Link: https://lore.kernel.org/r/1d822960-85a7-42b3-88cf-9d3dbc75a831@csgroup.eu

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e6aac2962dd..cfa6db4b6ce2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19634,6 +19634,7 @@ F:      include/linux/qnx6_fs.h
>   QORIQ DPAA2 FSL-MC BUS DRIVER
>   M:     Stuart Yoder <stuyoder@gmail.com>
>   M:     Ioana Ciornei <ioana.ciornei@nxp.com>
> +L:     linuxppc-dev@lists.ozlabs.org
>   L:     linux-kernel@vger.kernel.org
>   S:     Maintained
>   F:     Documentation/ABI/stable/sysfs-bus-fsl-mc
> --
> 2.34.1
> 


