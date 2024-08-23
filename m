Return-Path: <linux-kernel+bounces-298466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C969595C7A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC551F2685D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28710149002;
	Fri, 23 Aug 2024 08:11:58 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37388142E9D;
	Fri, 23 Aug 2024 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400717; cv=none; b=kkAiPcBMxXzpvze4BDltPbMOdCSwG8iS1RT/OG9F8HxAhcYBAZwUrUz5S/N7gjWJ5gOTSnZbx5jnnSuIC/0PA0I1juG6Az5Tgs0V/5juI3batNYfjhR0J427tUrpP4dUNG7OaDEjeniypxuVtegH8lfk3ptHGXSm5SeNF7S1Xnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400717; c=relaxed/simple;
	bh=xIHYtuC122lOkS0vA/P8HNZVcyMRm84atvv+mtQj9pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbdeXqdls2uYKGXV9jVm1ZjpfQdRmut8I5cueDFyo6PBwc3Ma/WIKP9VuP+kd5uBZfpxS5YYN7cYKfWpUjAEnrLA0r8NCn3hAa3yXWfmquz4dVWTWcCbRxSSpWZci5ZgbDpk0MvvqztdRg7U3mCEVGWJ6suFDz3SDpy+yBj74Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt8B45BYz9sRr;
	Fri, 23 Aug 2024 10:11:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S3mWBa_MIwz6; Fri, 23 Aug 2024 10:11:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt8B2tCXz9rvV;
	Fri, 23 Aug 2024 10:11:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 533918B77D;
	Fri, 23 Aug 2024 10:11:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 47GLv59K21Od; Fri, 23 Aug 2024 10:11:54 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B87CD8B763;
	Fri, 23 Aug 2024 10:11:53 +0200 (CEST)
Message-ID: <475c9db0-26f2-4208-a889-cf5cb3110c74@csgroup.eu>
Date: Fri, 23 Aug 2024 10:11:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/36] soc: fsl: cpm1: qmc: Introduce
 qmc_init_resource() and its CPM1 version
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-27-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-27-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> Current code handles the CPM1 version of QMC. Resources initialisations
> (i.e. retrieving base addresses and offsets of different parts) will
> be slightly different in the QUICC Engine (QE) version. Indeed, in QE
> version, some resources need to be allocated and are no more "staticaly"
> defined.
> 
> In order to prepare the support for QE version, introduce
> qmc_init_resource() to initialize those resources and isolate the CPM1
> specific operations in a specific function.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/qmc.c | 47 ++++++++++++++++++++++++++--------------
>   1 file changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index 8dd0f8fc7b08..eacc7dd2be53 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -1593,11 +1593,38 @@ static irqreturn_t qmc_irq_handler(int irq, void *priv)
>   	return IRQ_HANDLED;
>   }
>   
> +static int qmc_cpm1_init_resources(struct qmc *qmc, struct platform_device *pdev)
> +{
> +	struct resource *res;
> +
> +	qmc->scc_regs = devm_platform_ioremap_resource_byname(pdev, "scc_regs");
> +	if (IS_ERR(qmc->scc_regs))
> +		return PTR_ERR(qmc->scc_regs);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "scc_pram");
> +	if (!res)
> +		return -EINVAL;
> +	qmc->scc_pram_offset = res->start - get_immrbase();
> +	qmc->scc_pram = devm_ioremap_resource(qmc->dev, res);
> +	if (IS_ERR(qmc->scc_pram))
> +		return PTR_ERR(qmc->scc_pram);
> +
> +	qmc->dpram  = devm_platform_ioremap_resource_byname(pdev, "dpram");
> +	if (IS_ERR(qmc->dpram))
> +		return PTR_ERR(qmc->dpram);
> +
> +	return 0;
> +}
> +
> +static int qmc_init_resources(struct qmc *qmc, struct platform_device *pdev)
> +{
> +	return qmc_cpm1_init_resources(qmc, pdev);
> +}
> +
>   static int qmc_probe(struct platform_device *pdev)
>   {
>   	struct device_node *np = pdev->dev.of_node;
>   	unsigned int nb_chans;
> -	struct resource *res;
>   	struct qmc *qmc;
>   	int irq;
>   	int ret;
> @@ -1620,21 +1647,9 @@ static int qmc_probe(struct platform_device *pdev)
>   				     "Failed to get TSA serial\n");
>   	}
>   
> -	qmc->scc_regs = devm_platform_ioremap_resource_byname(pdev, "scc_regs");
> -	if (IS_ERR(qmc->scc_regs))
> -		return PTR_ERR(qmc->scc_regs);
> -
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "scc_pram");
> -	if (!res)
> -		return -EINVAL;
> -	qmc->scc_pram_offset = res->start - get_immrbase();
> -	qmc->scc_pram = devm_ioremap_resource(qmc->dev, res);
> -	if (IS_ERR(qmc->scc_pram))
> -		return PTR_ERR(qmc->scc_pram);
> -
> -	qmc->dpram  = devm_platform_ioremap_resource_byname(pdev, "dpram");
> -	if (IS_ERR(qmc->dpram))
> -		return PTR_ERR(qmc->dpram);
> +	ret = qmc_init_resources(qmc, pdev);
> +	if (ret)
> +		return ret;
>   
>   	/* Parse channels informationss */
>   	ret = qmc_of_parse_chans(qmc, np);

