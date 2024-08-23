Return-Path: <linux-kernel+bounces-298455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4CA95C78B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76341C24BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FE013FD99;
	Fri, 23 Aug 2024 08:09:38 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01D413D881;
	Fri, 23 Aug 2024 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400578; cv=none; b=jZuz4q/I6H33jp+zINT7t9ctHaFl10oHE/MR7PaOLn1lMuAKxSFGoH4E3mjTeSCMUurX7wq7jK10EtjryDrZEf/kuXB+likQkA1M67lQS7DssutsM0f7fJ6FyT9IxzH6COQ4h/SbME4Kfnq//1ZKNOdcxI9aNbCr5n4PGnyLukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400578; c=relaxed/simple;
	bh=JTasLyLds64PLaIOJrMbZ5tMXKQ5kp18JzVN27pxgcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O016DVmD5zHxoeLiVsk+Hk+zGFLKxjIyXGs76EzChj00Cop6KnWvLvVJGZixQRvb9JGDIGwq2dIz9Sxtok7Q5yPhJPB1AlMp0FpUlRhydOsz7+Zmsaj2PV8XCXnghFsUx3oFnM9xDouPO7V4h8ckLviuefrsjHelCLdmeXze4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt5W2MJZz9sRr;
	Fri, 23 Aug 2024 10:09:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0U4kXzK3M0nj; Fri, 23 Aug 2024 10:09:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt5W1bdvz9rvV;
	Fri, 23 Aug 2024 10:09:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 266F78B77D;
	Fri, 23 Aug 2024 10:09:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id l2fi3h8iZSSd; Fri, 23 Aug 2024 10:09:35 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9511E8B763;
	Fri, 23 Aug 2024 10:09:34 +0200 (CEST)
Message-ID: <72e00507-490d-4df0-ae0e-103c0d76ae47@csgroup.eu>
Date: Fri, 23 Aug 2024 10:09:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/36] soc: fsl: cpm1: qmc: Rename QMC_TSA_MASK
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-18-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-18-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> QMC_TSA_MASK is a bitfield. The value defined is a specific value of
> this bitfield and correspond to the use of 8bit resolution for the
> routing entry.
> 
> Be accurate and rename the defined constant to reflect this point.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/qmc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index 916395745850..721e0770510c 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -77,7 +77,7 @@
>   /* TSA entry (16bit entry in TSATRX and TSATTX) */
>   #define QMC_TSA_VALID		(1 << 15)
>   #define QMC_TSA_WRAP		(1 << 14)
> -#define QMC_TSA_MASK		(0x303F)
> +#define QMC_TSA_MASK_8BIT	(0x303F)
>   #define QMC_TSA_CHANNEL(x)	((x) << 6)
>   
>   /* Tx buffer descriptor base address (16 bits, offset from MCBASE) */
> @@ -641,7 +641,7 @@ static int qmc_chan_setup_tsa_64rxtx(struct qmc_chan *chan, const struct tsa_ser
>   		return -EINVAL;
>   	}
>   
> -	val = QMC_TSA_VALID | QMC_TSA_MASK | QMC_TSA_CHANNEL(chan->id);
> +	val = QMC_TSA_VALID | QMC_TSA_MASK_8BIT | QMC_TSA_CHANNEL(chan->id);
>   
>   	/* Check entries based on Rx stuff*/
>   	for (i = 0; i < info->nb_rx_ts; i++) {
> @@ -677,7 +677,7 @@ static int qmc_chan_setup_tsa_32rx(struct qmc_chan *chan, const struct tsa_seria
>   
>   	/* Use a Rx 32 entries table */
>   
> -	val = QMC_TSA_VALID | QMC_TSA_MASK | QMC_TSA_CHANNEL(chan->id);
> +	val = QMC_TSA_VALID | QMC_TSA_MASK_8BIT | QMC_TSA_CHANNEL(chan->id);
>   
>   	/* Check entries based on Rx stuff */
>   	for (i = 0; i < info->nb_rx_ts; i++) {
> @@ -713,7 +713,7 @@ static int qmc_chan_setup_tsa_32tx(struct qmc_chan *chan, const struct tsa_seria
>   
>   	/* Use a Tx 32 entries table */
>   
> -	val = QMC_TSA_VALID | QMC_TSA_MASK | QMC_TSA_CHANNEL(chan->id);
> +	val = QMC_TSA_VALID | QMC_TSA_MASK_8BIT | QMC_TSA_CHANNEL(chan->id);
>   
>   	/* Check entries based on Tx stuff */
>   	for (i = 0; i < info->nb_tx_ts; i++) {

