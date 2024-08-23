Return-Path: <linux-kernel+bounces-298450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA61995C77E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F32286A95
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A45145B00;
	Fri, 23 Aug 2024 08:08:19 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45213D524;
	Fri, 23 Aug 2024 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400499; cv=none; b=XlcjI4g1cpnL4CFa4CMV5eQe8wXybJbXfFyAkm62glrwThx41shnHcuqC2sAW49g9rv1KCeMovhZ+ezRtlhkKr4rSpQFvIl6S1/6MFw0FN9NgwuL5oCHtY67xBCk1C/E43OmL7+v9CGZjVGQDogKDkeEeyIjoP7unxvsRULDnkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400499; c=relaxed/simple;
	bh=Ijwm20sCkljIcz7YUi+SEjUVaZcDSLD1N4Idk6aU8ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5F+BXndMUynB2Tg3OA5mHlW5xa8H5JXFDUFt4B8zv8Jv6QfwJ94l+omb1pmX8zC+sGezqsle5CaHi1cmBOgCcV+XYN+2S0vGXFN2yMib59jer9Nz/3wjprbYfzkuEtR+H4EsUc0wPdwt5VYYBsNXD6FQXAQw3PgxRw7aO+xZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt401T38z9sRr;
	Fri, 23 Aug 2024 10:08:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y017WjX17hHf; Fri, 23 Aug 2024 10:08:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt400jPfz9rvV;
	Fri, 23 Aug 2024 10:08:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 081C18B77D;
	Fri, 23 Aug 2024 10:08:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Efcx2knKi_jw; Fri, 23 Aug 2024 10:08:15 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 670E68B763;
	Fri, 23 Aug 2024 10:08:15 +0200 (CEST)
Message-ID: <f8fb1500-1228-4a95-a31a-7259fe39c179@csgroup.eu>
Date: Fri, 23 Aug 2024 10:08:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/36] soc: fsl: cpm1: tsa: Introduce tsa_version
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-14-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-14-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> Current code handles CPM1 version of TSA.
> 
> In order to prepare the support for the QUICC Engine (QE) version of
> TSA, introduce tsa_version to identify versions. This will enable the
> code to make the distinction between several TSA implementations.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>


> ---
>   drivers/soc/fsl/qe/tsa.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
> index 48a176cece86..297721a0d2b6 100644
> --- a/drivers/soc/fsl/qe/tsa.c
> +++ b/drivers/soc/fsl/qe/tsa.c
> @@ -114,12 +114,17 @@ struct tsa_tdm {
>   #define TSA_TDMA	0
>   #define TSA_TDMB	1
>   
> +enum tsa_version {
> +	TSA_CPM1 = 1, /* Avoid 0 value */
> +};
> +
>   struct tsa {
>   	struct device *dev;
>   	void __iomem *si_regs;
>   	void __iomem *si_ram;
>   	resource_size_t si_ram_sz;
>   	spinlock_t	lock; /* Lock for read/modify/write sequence */
> +	enum tsa_version version;
>   	int tdms; /* TSA_TDMx ORed */
>   	struct tsa_tdm tdm[2]; /* TDMa and TDMb */
>   	struct tsa_serial {
> @@ -685,6 +690,15 @@ static int tsa_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	tsa->dev = &pdev->dev;
> +	tsa->version = (enum tsa_version)(uintptr_t)of_device_get_match_data(&pdev->dev);
> +	switch (tsa->version) {
> +	case TSA_CPM1:
> +		dev_info(tsa->dev, "CPM1 version\n");
> +		break;
> +	default:
> +		dev_err(tsa->dev, "Unknown version (%d)\n", tsa->version);
> +		return -EINVAL;
> +	}
>   
>   	for (i = 0; i < ARRAY_SIZE(tsa->serials); i++)
>   		tsa->serials[i].id = i;
> @@ -746,7 +760,7 @@ static void tsa_remove(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id tsa_id_table[] = {
> -	{ .compatible = "fsl,cpm1-tsa" },
> +	{ .compatible = "fsl,cpm1-tsa", .data = (void *)TSA_CPM1 },
>   	{} /* sentinel */
>   };
>   MODULE_DEVICE_TABLE(of, tsa_id_table);

