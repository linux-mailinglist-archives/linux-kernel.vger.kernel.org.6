Return-Path: <linux-kernel+bounces-298458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7CE95C793
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE324B267E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09BC143C50;
	Fri, 23 Aug 2024 08:10:31 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C646213FD99;
	Fri, 23 Aug 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400631; cv=none; b=uZyzjkSaES1XMMtQkQyA5/JkiiCIAAG855xKJ2lua7AlT2bfjsQ1F+U5lGEGyLitwOEc0FchQax2KSsJmPOjsbZV2ydEk/KVt85MRWzGj+ij4/8iF0zGdvajtlsJ5beGabIra0uEZv2+R6KIBckT0O5/2YErs83DnJqeVdI6ZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400631; c=relaxed/simple;
	bh=4qRV8LjaXlxs8iK8DO4QVzv6Tqvxltp922psqJqgA6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3tEBhZkjodTiksoS+hnWKENzf0MJztHx7OYI0Wj5eIayuAU7mfRq8ZBVxdyFd83aKaDNN3FGMNgA8pOfGlhzYtzaN0oei5F2fnvw+tbhAcPDCh9aoFjvoVp7Bho5JcurEdamV0gAnutsFQe7kmuNTPjcFHIdJbWIgWrcZbwX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt6X0kbKz9sRr;
	Fri, 23 Aug 2024 10:10:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6fEcinwE3CeY; Fri, 23 Aug 2024 10:10:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt6W73mYz9rvV;
	Fri, 23 Aug 2024 10:10:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E0BCE8B77D;
	Fri, 23 Aug 2024 10:10:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id aOnz-ziVcxln; Fri, 23 Aug 2024 10:10:27 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 611238B763;
	Fri, 23 Aug 2024 10:10:27 +0200 (CEST)
Message-ID: <5721db08-5139-49a3-8614-0fcd674a762c@csgroup.eu>
Date: Fri, 23 Aug 2024 10:10:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/36] soc: fsl: cpm1: qmc: Fix 'transmiter' typo
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-22-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-22-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> checkpatch.pl raises the following issue
>    CHECK: 'transmiter' may be misspelled - perhaps 'transmitter'?
> 
> Indeed, fix it.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/qmc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index 04466e735302..2d54d7400d2d 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -1715,7 +1715,7 @@ static int qmc_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		goto err_disable_intr;
>   
> -	/* Enable transmiter and receiver */
> +	/* Enable transmitter and receiver */
>   	qmc_setbits32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
>   
>   	platform_set_drvdata(pdev, qmc);
> @@ -1742,7 +1742,7 @@ static void qmc_remove(struct platform_device *pdev)
>   {
>   	struct qmc *qmc = platform_get_drvdata(pdev);
>   
> -	/* Disable transmiter and receiver */
> +	/* Disable transmitter and receiver */
>   	qmc_setbits32(qmc->scc_regs + SCC_GSMRL, 0);
>   
>   	/* Disable interrupts */

