Return-Path: <linux-kernel+bounces-297689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F12A95BC85
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE4D1C22FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69E61CDFB6;
	Thu, 22 Aug 2024 16:55:23 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C672C190
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345723; cv=none; b=O+k6ZhMgcSqQLEjfJCAqCPEhDUMBvXSOOovDgyO/8MTVkmhjGw9lyy0MKAUxnNhtsIf1Wl9lQ7OTPbVGPk1ggPfJRLkaXGxJTdiy5GdrmykOT6L5M+uUtj9jkuUJpFNE64C2SVrWAL7bFkg0YJE6GcrDelcFLtLMOTewhq7G6v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345723; c=relaxed/simple;
	bh=i6+v1x+gM1gJ1hPgbf59vltoFnCdz/t/ctYKql5R06k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6IDsh26uDXK9qpHma5unQHPyJhK/HT2HIO+GVYVVWnwFMTNRj01Dzoh7Pcxvyobv1FNlOrt3dRNCkwUKMl1BBPwyAb9UC57Ka7zhnngxg4hVsvA/COdKtutF4kOZ99UnNu1eYs9OiRlNZQ415SO80tKPyNsGIxvjhYtof+7bjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqTpb33Jrz9sSK;
	Thu, 22 Aug 2024 18:55:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tHnpF95fD7qK; Thu, 22 Aug 2024 18:55:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqTpb2JDhz9rvV;
	Thu, 22 Aug 2024 18:55:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 404E78B77D;
	Thu, 22 Aug 2024 18:55:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id DyQRBygMVoHV; Thu, 22 Aug 2024 18:55:19 +0200 (CEST)
Received: from [192.168.232.181] (PO16920.IDSI0.si.c-s.fr [192.168.232.181])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EDCA18B763;
	Thu, 22 Aug 2024 18:55:18 +0200 (CEST)
Message-ID: <3241a692-088d-4316-85c9-f2939a9179b2@csgroup.eu>
Date: Thu, 22 Aug 2024 18:55:18 +0200
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

Hi,

Le 02/08/2024 à 04:16, Xiaolei Wang a écrit :
> [Vous ne recevez pas souvent de courriers de xiaolei.wang@windriver.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> RESERVEDMEM_OF_DECLARE usage has been removed. For
> non-popwerpc platforms, such as ls1043, this warning
> is redundant. ls1043 itself uses shared-dma-mem.

Can you please explain in more details ? I don't understand what it is 
redundant with.

Thanks
Christophe

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

