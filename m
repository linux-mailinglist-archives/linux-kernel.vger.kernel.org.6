Return-Path: <linux-kernel+bounces-312527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563079697C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890A71C22F59
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DC71D0966;
	Tue,  3 Sep 2024 08:45:44 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BBC19F401
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353144; cv=none; b=puPB3z6fL63GmxiYqF4JoPoAFqjY/foZR0odZ83qtX4k4UJ6PMxJ6CBU0zdtwBnpRiMvEfrv9uvJ9hKOo6sWImu7Kg8msKg5nZgjxNnxvOJtdMIpx9OY/t7RtVmz1HmsePWYp7HjgccSaiue4IIIG3viy3p9onuJPuDy/B+xjxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353144; c=relaxed/simple;
	bh=+cwfqMxGbGq8J5ZkuGuVRFFsgvgm9PTGwIh2SwsOlBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qm1Hb8J3w+x1aoQ09eb4r0eGlU2BHGT2gtV6JFEc95o0Sj9wh6/LQiry+j74XL8GRLK387iYmGoJ7v1wKw0ejWENZloIFEKwKlO1Fu+ubTmOzEXH+HJC/4OSjCWeuEakunWW0MVV2CjLyVkvP5OnyWxAA04hnUSfzMSMCwswKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WyfN44H9Kz9sSC;
	Tue,  3 Sep 2024 10:45:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kgnPgwmJvGCa; Tue,  3 Sep 2024 10:45:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WyfN43XSfz9sRy;
	Tue,  3 Sep 2024 10:45:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 684628B76E;
	Tue,  3 Sep 2024 10:45:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id oqf0uNZh5oTP; Tue,  3 Sep 2024 10:45:40 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B3BD8B768;
	Tue,  3 Sep 2024 10:45:40 +0200 (CEST)
Message-ID: <3d0e63da-770d-4317-8c33-023d5ffdd0fa@csgroup.eu>
Date: Tue, 3 Sep 2024 10:45:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: fsl: qbman: Remove redundant warnings
To: Xiaolei Wang <xiaolei.wang@windriver.com>, robh@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240802021651.3854295-1-xiaolei.wang@windriver.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240802021651.3854295-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/08/2024 à 04:16, Xiaolei Wang a écrit :
> [Vous ne recevez pas souvent de courriers de xiaolei.wang@windriver.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> RESERVEDMEM_OF_DECLARE usage has been removed. For
> non-popwerpc platforms, such as ls1043, this warning
> is redundant. ls1043 itself uses shared-dma-mem.
> 
> Fixes: 3e62273ac63a ("soc: fsl: qbman: Remove RESERVEDMEM_OF_DECLARE usage")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>   drivers/soc/fsl/qbman/qman_ccsr.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
> index 392e54f14dbe..aa5348f4902f 100644
> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> @@ -791,8 +791,6 @@ static int fsl_qman_probe(struct platform_device *pdev)
>           * FQD memory MUST be zero'd by software
>           */
>          zero_priv_mem(fqd_a, fqd_sz);
> -#else
> -       WARN(1, "Unexpected architecture using non shared-dma-mem reservations");
>   #endif
>          dev_dbg(dev, "Allocated FQD 0x%llx 0x%zx\n", fqd_a, fqd_sz);
> 
> --
> 2.25.1
> 

Applied for 6.12

Thanks
Christophe

