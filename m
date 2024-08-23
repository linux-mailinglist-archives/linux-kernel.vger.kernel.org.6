Return-Path: <linux-kernel+bounces-298442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC34395C766
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21A41C244B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AE7142904;
	Fri, 23 Aug 2024 08:07:07 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FBE142651;
	Fri, 23 Aug 2024 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400427; cv=none; b=K5ORp4KXvAJEbjiRgWLRUolVseZpAwm7ZEiOeMsXNnqx37o2znPHVZIKFVTckd/3VHPpFtNN98ZPA3n58r4HOh2pCJDn9BzX88iIcV+nqwqfgbMSyvichzSmyGzkt9OlzZtQvF/jnFF5rIRqdu1QbeckFeuCTF4gmIG1iP7Pn3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400427; c=relaxed/simple;
	bh=g0Qjw77z7lKj0N2DmWs7T8e+mlx0cVSPU09pD9OMHxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0eUnsVPllANXr2QVQPe5LORq43SId/uApFYQykXe+ZX0rvy6/giGt94zG/b7o84Nl9GCvorXTU/mqxH77MpMA0yI8aWRbRYp1GRYmAAZYzjrg1dfSghbYD621rp8EFEX9sVVY7Bx9uFIHRSlqbx/kzK/qD8lVS9bhh3Q7chrJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt2b5rL8z9sSK;
	Fri, 23 Aug 2024 10:07:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qDA-1aHvJd3r; Fri, 23 Aug 2024 10:07:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt2M3DSvz9sRs;
	Fri, 23 Aug 2024 10:06:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 407C28B780;
	Fri, 23 Aug 2024 10:06:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4ynYaQNVgcoa; Fri, 23 Aug 2024 10:06:51 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C6158B763;
	Fri, 23 Aug 2024 10:06:50 +0200 (CEST)
Message-ID: <280789e0-a018-432f-b208-e907add713ae@csgroup.eu>
Date: Fri, 23 Aug 2024 10:06:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/36] soc: fsl: cpm1: tsa: Introduce tsa_setup() and
 its CPM1 compatible version
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-12-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-12-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> Current code handles the CPM1 version of TSA. Setting up TSA consists in
> handling SIMODE and SIGMR registers. These registers are CPM1 specific.
> 
> Setting up the QUICC Engine (QE) version of TSA is slightly different.
> 
> In order to prepare the support for QE version, clearly identify these
> registers as CPM1 compatible and isolate their handling in a CPM1
> specific function.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>


> ---
>   drivers/soc/fsl/qe/tsa.c | 93 +++++++++++++++++++++++-----------------
>   1 file changed, 54 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
> index bf7354ebaca4..239b71187e07 100644
> --- a/drivers/soc/fsl/qe/tsa.c
> +++ b/drivers/soc/fsl/qe/tsa.c
> @@ -32,14 +32,14 @@
>   #define TSA_CPM1_SIRAM_ENTRY_CSEL_SMC2	FIELD_PREP_CONST(TSA_CPM1_SIRAM_ENTRY_CSEL_MASK, 0x6)
>   
>   /* SI mode register (32 bits) */
> -#define TSA_SIMODE	0x00
> -#define   TSA_SIMODE_SMC2			BIT(31)
> -#define   TSA_SIMODE_SMC1			BIT(15)
> -#define   TSA_SIMODE_TDMA_MASK			GENMASK(11, 0)
> -#define   TSA_SIMODE_TDMA(x)			FIELD_PREP(TSA_SIMODE_TDMA_MASK, x)
> -#define   TSA_SIMODE_TDMB_MASK			GENMASK(27, 16)
> -#define   TSA_SIMODE_TDMB(x)			FIELD_PREP(TSA_SIMODE_TDMB_MASK, x)
> -#define     TSA_SIMODE_TDM_MASK			GENMASK(11, 0)
> +#define TSA_CPM1_SIMODE		0x00
> +#define   TSA_CPM1_SIMODE_SMC2			BIT(31)
> +#define   TSA_CPM1_SIMODE_SMC1			BIT(15)
> +#define   TSA_CPM1_SIMODE_TDMA_MASK		GENMASK(11, 0)
> +#define   TSA_CPM1_SIMODE_TDMA(x)		FIELD_PREP(TSA_CPM1_SIMODE_TDMA_MASK, x)
> +#define   TSA_CPM1_SIMODE_TDMB_MASK		GENMASK(27, 16)
> +#define   TSA_CPM1_SIMODE_TDMB(x)		FIELD_PREP(TSA_CPM1_SIMODE_TDMB_MASK, x)
> +#define     TSA_CPM1_SIMODE_TDM_MASK		GENMASK(11, 0)
>   #define     TSA_SIMODE_TDM_SDM_MASK		GENMASK(11, 10)
>   #define       TSA_SIMODE_TDM_SDM_NORM		FIELD_PREP_CONST(TSA_SIMODE_TDM_SDM_MASK, 0x0)
>   #define       TSA_SIMODE_TDM_SDM_ECHO		FIELD_PREP_CONST(TSA_SIMODE_TDM_SDM_MASK, 0x1)
> @@ -49,22 +49,22 @@
>   #define     TSA_SIMODE_TDM_RFSD(x)		FIELD_PREP(TSA_SIMODE_TDM_RFSD_MASK, x)
>   #define     TSA_SIMODE_TDM_DSC			BIT(7)
>   #define     TSA_SIMODE_TDM_CRT			BIT(6)
> -#define     TSA_SIMODE_TDM_STZ			BIT(5)
> +#define     TSA_CPM1_SIMODE_TDM_STZ		BIT(5)
>   #define     TSA_SIMODE_TDM_CE			BIT(4)
>   #define     TSA_SIMODE_TDM_FE			BIT(3)
>   #define     TSA_SIMODE_TDM_GM			BIT(2)
>   #define     TSA_SIMODE_TDM_TFSD_MASK		GENMASK(1, 0)
>   #define     TSA_SIMODE_TDM_TFSD(x)		FIELD_PREP(TSA_SIMODE_TDM_TFSD_MASK, x)
>   
> -/* SI global mode register (8 bits) */
> -#define TSA_SIGMR	0x04
> -#define TSA_SIGMR_ENB			BIT(3)
> -#define TSA_SIGMR_ENA			BIT(2)
> -#define TSA_SIGMR_RDM_MASK		GENMASK(1, 0)
> -#define   TSA_SIGMR_RDM_STATIC_TDMA	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x0)
> -#define   TSA_SIGMR_RDM_DYN_TDMA	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x1)
> -#define   TSA_SIGMR_RDM_STATIC_TDMAB	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x2)
> -#define   TSA_SIGMR_RDM_DYN_TDMAB	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x3)
> +/* CPM SI global mode register (8 bits) */
> +#define TSA_CPM1_SIGMR	0x04
> +#define TSA_CPM1_SIGMR_ENB			BIT(3)
> +#define TSA_CPM1_SIGMR_ENA			BIT(2)
> +#define TSA_CPM1_SIGMR_RDM_MASK			GENMASK(1, 0)
> +#define   TSA_CPM1_SIGMR_RDM_STATIC_TDMA	FIELD_PREP_CONST(TSA_CPM1_SIGMR_RDM_MASK, 0x0)
> +#define   TSA_CPM1_SIGMR_RDM_DYN_TDMA		FIELD_PREP_CONST(TSA_CPM1_SIGMR_RDM_MASK, 0x1)
> +#define   TSA_CPM1_SIGMR_RDM_STATIC_TDMAB	FIELD_PREP_CONST(TSA_CPM1_SIGMR_RDM_MASK, 0x2)
> +#define   TSA_CPM1_SIGMR_RDM_DYN_TDMAB		FIELD_PREP_CONST(TSA_CPM1_SIGMR_RDM_MASK, 0x3)
>   
>   /* SI clock route register (32 bits) */
>   #define TSA_SICR	0x0C
> @@ -656,13 +656,45 @@ static void tsa_init_si_ram(struct tsa *tsa)
>   		tsa_write32(tsa->si_ram + i, TSA_CPM1_SIRAM_ENTRY_LAST);
>   }
>   
> +static int tsa_cpm1_setup(struct tsa *tsa)
> +{
> +	u32 val;
> +
> +	/* Set SIMODE */
> +	val = 0;
> +	if (tsa->tdm[0].is_enable)
> +		val |= TSA_CPM1_SIMODE_TDMA(tsa->tdm[0].simode_tdm);
> +	if (tsa->tdm[1].is_enable)
> +		val |= TSA_CPM1_SIMODE_TDMB(tsa->tdm[1].simode_tdm);
> +
> +	tsa_clrsetbits32(tsa->si_regs + TSA_CPM1_SIMODE,
> +			 TSA_CPM1_SIMODE_TDMA(TSA_CPM1_SIMODE_TDM_MASK) |
> +			 TSA_CPM1_SIMODE_TDMB(TSA_CPM1_SIMODE_TDM_MASK),
> +			 val);
> +
> +	/* Set SIGMR */
> +	val = (tsa->tdms == BIT(TSA_TDMA)) ?
> +		TSA_CPM1_SIGMR_RDM_STATIC_TDMA : TSA_CPM1_SIGMR_RDM_STATIC_TDMAB;
> +	if (tsa->tdms & BIT(TSA_TDMA))
> +		val |= TSA_CPM1_SIGMR_ENA;
> +	if (tsa->tdms & BIT(TSA_TDMB))
> +		val |= TSA_CPM1_SIGMR_ENB;
> +	tsa_write8(tsa->si_regs + TSA_CPM1_SIGMR, val);
> +
> +	return 0;
> +}
> +
> +static int tsa_setup(struct tsa *tsa)
> +{
> +	return tsa_cpm1_setup(tsa);
> +}
> +
>   static int tsa_probe(struct platform_device *pdev)
>   {
>   	struct device_node *np = pdev->dev.of_node;
>   	struct resource *res;
>   	struct tsa *tsa;
>   	unsigned int i;
> -	u32 val;
>   	int ret;
>   
>   	tsa = devm_kzalloc(&pdev->dev, sizeof(*tsa), GFP_KERNEL);
> @@ -696,26 +728,9 @@ static int tsa_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	/* Set SIMODE */
> -	val = 0;
> -	if (tsa->tdm[0].is_enable)
> -		val |= TSA_SIMODE_TDMA(tsa->tdm[0].simode_tdm);
> -	if (tsa->tdm[1].is_enable)
> -		val |= TSA_SIMODE_TDMB(tsa->tdm[1].simode_tdm);
> -
> -	tsa_clrsetbits32(tsa->si_regs + TSA_SIMODE,
> -			 TSA_SIMODE_TDMA(TSA_SIMODE_TDM_MASK) |
> -			 TSA_SIMODE_TDMB(TSA_SIMODE_TDM_MASK),
> -			 val);
> -
> -	/* Set SIGMR */
> -	val = (tsa->tdms == BIT(TSA_TDMA)) ?
> -		TSA_SIGMR_RDM_STATIC_TDMA : TSA_SIGMR_RDM_STATIC_TDMAB;
> -	if (tsa->tdms & BIT(TSA_TDMA))
> -		val |= TSA_SIGMR_ENA;
> -	if (tsa->tdms & BIT(TSA_TDMB))
> -		val |= TSA_SIGMR_ENB;
> -	tsa_write8(tsa->si_regs + TSA_SIGMR, val);
> +	ret = tsa_setup(tsa);
> +	if (ret)
> +		return ret;
>   
>   	platform_set_drvdata(pdev, tsa);
>   

