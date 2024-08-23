Return-Path: <linux-kernel+bounces-298475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5464E95C7CB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E894E1F26F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0751428E0;
	Fri, 23 Aug 2024 08:14:56 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ED4142651;
	Fri, 23 Aug 2024 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400895; cv=none; b=CjtQmOLBUhjPc2fkI+a7CIXHxN2D96Tzh2mSbdzRSuuqJOwNWbUzsvyFsbR7LF0kAptbgm2D74HCYuKI8KF0AJDf5L0eUIqTfwTXRBjm7ls7M2EUZiYHjTDS6II1Lc1CEQ1IBdI40EjJ2o7A9WcUO+ifvSyTczGQKWfSMHZo0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400895; c=relaxed/simple;
	bh=ecWROLQSnLWpqxI7nA6r3VNRB1/7r8Hp2sj0ZUUU32Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/qRpZbfqBVul4RdxOf46FKMveQKLw0riFejkk1EksoTjTDGgKl5KX1/HrzCZbKXBNtcCbNqY5Q1hAaI/KdGDgYld4RxFIeQ03jGavO8pNHjPdii2Tmjilwl4AtGHD+enU+B/k6jdpntUl7ZNr60GZVq5wTstx5SSxOyffwY2NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqtCc62WQz9sRr;
	Fri, 23 Aug 2024 10:14:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J4X30XlS6JER; Fri, 23 Aug 2024 10:14:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqtCc5B7kz9rvV;
	Fri, 23 Aug 2024 10:14:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A2F518B77D;
	Fri, 23 Aug 2024 10:14:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id j0NpDRdrK9od; Fri, 23 Aug 2024 10:14:52 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 112898B763;
	Fri, 23 Aug 2024 10:14:52 +0200 (CEST)
Message-ID: <b3323a47-6b57-48ef-ad68-9d457a33a8a3@csgroup.eu>
Date: Fri, 23 Aug 2024 10:14:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 35/36] soc: fsl: cpm1: qmc: Handle QUICC Engine (QE)
 soft-qmc firmware
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-36-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-36-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> The QUICC Engine (QE) QMC can use a firmware to have the QMC working in
> 'soft-qmc' mode.
> 
> Handle this optional 'soft-qmc' firmware.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/qmc.c | 67 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index b3a9534441ee..3dffebb48b0d 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -10,6 +10,7 @@
>   #include <soc/fsl/qe/qmc.h>
>   #include <linux/bitfield.h>
>   #include <linux/dma-mapping.h>
> +#include <linux/firmware.h>
>   #include <linux/hdlc.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
> @@ -1649,6 +1650,66 @@ static irqreturn_t qmc_irq_handler(int irq, void *priv)
>   	return IRQ_HANDLED;
>   }
>   
> +static int qmc_qe_soft_qmc_init(struct qmc *qmc, struct device_node *np)
> +{
> +	struct qe_firmware_info *qe_fw_info;
> +	const struct qe_firmware *qe_fw;
> +	const struct firmware *fw;
> +	const char *filename;
> +	int ret;
> +
> +	ret = of_property_read_string(np, "fsl,soft-qmc", &filename);
> +	switch (ret) {
> +	case 0:
> +		break;
> +	case -EINVAL:
> +		/* fsl,soft-qmc property not set -> Simply do nothing */
> +		return 0;
> +	default:
> +		dev_err(qmc->dev, "%pOF: failed to read fsl,soft-qmc\n",
> +			np);
> +		return ret;
> +	}
> +
> +	qe_fw_info = qe_get_firmware_info();
> +	if (qe_fw_info) {
> +		if (!strstr(qe_fw_info->id, "Soft-QMC")) {
> +			dev_err(qmc->dev, "Another Firmware is already loaded\n");
> +			return -EALREADY;
> +		}
> +		dev_info(qmc->dev, "Firmware already loaded\n");
> +		return 0;
> +	}
> +
> +	dev_info(qmc->dev, "Using firmware %s\n", filename);
> +
> +	ret = request_firmware(&fw, filename, qmc->dev);
> +	if (ret) {
> +		dev_err(qmc->dev, "Failed to request firmware %s\n", filename);
> +		return ret;
> +	}
> +
> +	qe_fw = (const struct qe_firmware *)fw->data;
> +
> +	if (fw->size < sizeof(qe_fw->header) ||
> +	    be32_to_cpu(qe_fw->header.length) != fw->size) {
> +		dev_err(qmc->dev, "Invalid firmware %s\n", filename);
> +		ret = -EINVAL;
> +		goto end;
> +	}
> +
> +	ret = qe_upload_firmware(qe_fw);
> +	if (ret) {
> +		dev_err(qmc->dev, "Failed to load firmware %s\n", filename);
> +		goto end;
> +	}
> +
> +	ret = 0;
> +end:
> +	release_firmware(fw);
> +	return ret;
> +}
> +
>   static int qmc_cpm1_init_resources(struct qmc *qmc, struct platform_device *pdev)
>   {
>   	struct resource *res;
> @@ -1855,6 +1916,12 @@ static int qmc_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	if (qmc_is_qe(qmc)) {
> +		ret = qmc_qe_soft_qmc_init(qmc, np);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	/* Parse channels informationss */
>   	ret = qmc_of_parse_chans(qmc, np);
>   	if (ret)

