Return-Path: <linux-kernel+bounces-298470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 437B095C7B8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F313E286CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE06214387B;
	Fri, 23 Aug 2024 08:13:33 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F313959D;
	Fri, 23 Aug 2024 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400813; cv=none; b=I+guuJ9ApnFgsDoDFJsU8V8p+JKtYSZ8jARX3G2Y44WYRuA/P8H51WHbPvkiugEv/LmaykBNosLXXaBksfY2qm2EzldOdX7eBnb2DV0c2qbo1eRgtB+1rh54CxDkcFxx696jxHUwnsD56AHuWvCF5FKOaWnmkifI8xtIEcKExQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400813; c=relaxed/simple;
	bh=yo1PCAAFldFiGJCst3UDhy8HLFc/5v/DOjYVvnBln1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDCLeLyURDw/4vo3tuRSlsCqRvo6d1Yr/YSPR4Rwh2oYMsDgjlvG2fi01T/0NQ/NdV/a534qBheMp0HLrmvwHJPnSDq/Qzhx08xh+I5EPQgT3W+nPZ+xDJ+29f+d/CpnY7SfLLdUBMtn9Qgpp2CuAgjLt1PaRlT2QdsqVC869fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqtB14Lf7z9sRr;
	Fri, 23 Aug 2024 10:13:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9hmcQWiwSfRN; Fri, 23 Aug 2024 10:13:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqtB13XhNz9rvV;
	Fri, 23 Aug 2024 10:13:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 67F5E8B77D;
	Fri, 23 Aug 2024 10:13:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id OEB9s8w2hMYk; Fri, 23 Aug 2024 10:13:29 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D921B8B763;
	Fri, 23 Aug 2024 10:13:28 +0200 (CEST)
Message-ID: <50bb8062-757a-4838-8497-55ce7555bf96@csgroup.eu>
Date: Fri, 23 Aug 2024 10:13:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/36] soc: fsl: cpm1: qmc: Rename SCC_GSMRL_MODE_QMC
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-31-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-31-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> Current code handles CPM1 version of QMC. Even if GSMRL is specific to
> the CPM1 version, the exact same purpose and format register (GUMRL) is
> present in the QUICC Engine (QE) version of QMC. Compared to the QE
> version, the values defined for the mode bitfield are different and the
> 0x0A value defined for the QMC mode is CPM1 specific.
> 
> In order to prepare the support for the QE version, rename this bitfield
> value to clearly identify it as CPM1 specific.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/qmc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index 63af2608c3cd..062477b7426e 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -27,7 +27,7 @@
>   #define SCC_GSMRL_ENR		BIT(5)
>   #define SCC_GSMRL_ENT		BIT(4)
>   #define SCC_GSMRL_MODE_MASK	GENMASK(3, 0)
> -#define SCC_GSMRL_MODE_QMC	FIELD_PREP_CONST(SCC_GSMRL_MODE_MASK, 0x0A)
> +#define SCC_CPM1_GSMRL_MODE_QMC	FIELD_PREP_CONST(SCC_GSMRL_MODE_MASK, 0x0A)
>   
>   /* SCC general mode register low (32 bits) */
>   #define SCC_GSMRH	0x04
> @@ -1642,7 +1642,7 @@ static int qmc_cpm1_init_scc(struct qmc *qmc)
>   	qmc_write32(qmc->scc_regs + SCC_GSMRH, val);
>   
>   	/* enable QMC mode */
> -	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_MODE_QMC);
> +	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_CPM1_GSMRL_MODE_QMC);
>   
>   	/* Disable and clear interrupts */
>   	qmc_write16(qmc->scc_regs + SCC_SCCM, 0x0000);

