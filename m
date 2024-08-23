Return-Path: <linux-kernel+bounces-298456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BD895C78E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE083B26518
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E141428E3;
	Fri, 23 Aug 2024 08:10:01 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4BB13959D;
	Fri, 23 Aug 2024 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400600; cv=none; b=dIdZ+z+Ng8UnU69whrelwQL89PyZyOwxpgcBHaP9WPTFgyI2oaRLTYbsZ3HNd/QggYeXUs1+S9mCHApof+X07ySKavA3xu6PyMsDLOmnQhj6/IV6FUcoS51FPQlTn4hkH2j1wzSu3aF6Ge3BIeRDh4cJrOWGtj8odsBO90mrZ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400600; c=relaxed/simple;
	bh=CqhXeth05I90w+NiWTFVafxVnpFNhBLSGhpyudV2OQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6V9qFJTBPEQ4DE78xam23ROL13aQ/UpWHJvSYAOCrJhGFdgOKrQ6cUc8+vWXXq4gdKBYg51TcYsJViSeEdCnfGuuK8tK/KCJNFkvakz/B3Vry6qsTMn8TMAmbjdBiTC87EhZPl+qQ8ioDyok5BYq3qNYXFWMzmLAphwS08gGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt5x5wGXz9sRr;
	Fri, 23 Aug 2024 10:09:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U6rWnzw2F71U; Fri, 23 Aug 2024 10:09:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt5x51wDz9rvV;
	Fri, 23 Aug 2024 10:09:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9ADDF8B77D;
	Fri, 23 Aug 2024 10:09:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id yKYBB4Lb-Wax; Fri, 23 Aug 2024 10:09:57 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1860C8B763;
	Fri, 23 Aug 2024 10:09:57 +0200 (CEST)
Message-ID: <7cc60804-0c93-4d29-8358-31771bdab246@csgroup.eu>
Date: Fri, 23 Aug 2024 10:09:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/36] soc: fsl: cpm1: qmc: Remove unneeded parenthesis
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-21-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-21-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> checkpatch.pl raises the following issue in several places
>    CHECK: Unnecessary parenthesis around ...
> 
> Remove them.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/qmc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index 44bd9b949770..04466e735302 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -359,8 +359,8 @@ int qmc_chan_set_param(struct qmc_chan *chan, const struct qmc_chan_param *param
>   
>   	switch (param->mode) {
>   	case QMC_HDLC:
> -		if ((param->hdlc.max_rx_buf_size % 4) ||
> -		    (param->hdlc.max_rx_buf_size < 8))
> +		if (param->hdlc.max_rx_buf_size % 4 ||
> +		    param->hdlc.max_rx_buf_size < 8)
>   			return -EINVAL;
>   
>   		qmc_write16(chan->qmc->scc_pram + QMC_GBL_MRBLR,
> @@ -1152,7 +1152,7 @@ static int qmc_check_chans(struct qmc *qmc)
>   	if (ret)
>   		return ret;
>   
> -	if ((info.nb_tx_ts > 64) || (info.nb_rx_ts > 64)) {
> +	if (info.nb_tx_ts > 64 || info.nb_rx_ts > 64) {
>   		dev_err(qmc->dev, "Number of TSA Tx/Rx TS assigned not supported\n");
>   		return -EINVAL;
>   	}
> @@ -1161,7 +1161,7 @@ static int qmc_check_chans(struct qmc *qmc)
>   	 * If more than 32 TS are assigned to this serial, one common table is
>   	 * used for Tx and Rx and so masks must be equal for all channels.
>   	 */
> -	if ((info.nb_tx_ts > 32) || (info.nb_rx_ts > 32)) {
> +	if (info.nb_tx_ts > 32 || info.nb_rx_ts > 32) {
>   		if (info.nb_tx_ts != info.nb_rx_ts) {
>   			dev_err(qmc->dev, "Number of TSA Tx/Rx TS assigned are not equal\n");
>   			return -EINVAL;

