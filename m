Return-Path: <linux-kernel+bounces-298463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3786395C7A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710D3B22940
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FB114264C;
	Fri, 23 Aug 2024 08:11:22 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5713FD99;
	Fri, 23 Aug 2024 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400681; cv=none; b=g2lRM8zvsPltu2O/REunWnl+EvQqrQzNsQj8dyHUZMHbwLVFbkc4iqyDLT33DdoeBCWaFTysSwzWTPgV5ABE1zhX5Lho9djvwREoxj4KxzYq6vpzB+Q+sYJxw8QxjGyxw45HH716i+ztHb1Tn8H1wjxkB3iF0DSxDH6jPScM114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400681; c=relaxed/simple;
	bh=CrZ1OnfQKNqGuq0a8QSQLmFi+nGISXbBa+eD5EEUHBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxbD0D20stcFSC8ylyjcQXVvlomcALchKdHABeH2t46W+6ADcQeOz8kWx3szsaxjGBhLQG5h/v6BUcmzZx5F/yQwnn2mc1/YyLWg3kZDHQP9vmJMd+7VJDPaM6USyfP3RfefLVJojYiVcJz8SVuXxBLOuIlqdWA6im+2JU2c5/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt7V2ySBz9sSH;
	Fri, 23 Aug 2024 10:11:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pm9AhI0XfMR7; Fri, 23 Aug 2024 10:11:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt7V1flZz9sRs;
	Fri, 23 Aug 2024 10:11:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 295778B77D;
	Fri, 23 Aug 2024 10:11:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id VV5EGOk-Gpp9; Fri, 23 Aug 2024 10:11:18 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 866058B763;
	Fri, 23 Aug 2024 10:11:17 +0200 (CEST)
Message-ID: <ea65d6ca-d231-4bb7-a58c-cb2ffc421146@csgroup.eu>
Date: Fri, 23 Aug 2024 10:11:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/36] soc: fsl: cpm1: qmc: Introduce qmc_data
 structure
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-25-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-25-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> Current code handles CPM1 version of QMC. Some hardcoded values are used
> several times to initialize the QMC state machine. In the QUICC Engine
> (QE) version of QMC, these values are different.
> 
> In order to prepare the support for the QE version of QMC and avoid the
> copy of the hardcoded values, introduce the qmc_data structure to define
> these version specific values.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/qmc.c | 69 ++++++++++++++++++++++++++--------------
>   1 file changed, 46 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index 3736a8e4575e..85fc86f91806 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -215,8 +215,17 @@ struct qmc_chan {
>   	bool	is_rx_stopped;
>   };
>   
> +struct qmc_data {
> +	u32 tstate; /* Initial TSTATE value */
> +	u32 rstate; /* Initial RSTATE value */
> +	u32 zistate; /* Initial ZISTATE value */
> +	u32 zdstate_hdlc; /* Initial ZDSTATE value (HDLC mode) */
> +	u32 zdstate_transp; /* Initial ZDSTATE value (Transparent mode) */
> +};
> +
>   struct qmc {
>   	struct device *dev;
> +	const struct qmc_data *data;
>   	struct tsa_serial *tsa_serial;
>   	void __iomem *scc_regs;
>   	void __iomem *scc_pram;
> @@ -543,11 +552,11 @@ int qmc_chan_read_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
>   	/* Restart receiver if needed */
>   	if (chan->is_rx_halted && !chan->is_rx_stopped) {
>   		/* Restart receiver */
> -		if (chan->mode == QMC_TRANSPARENT)
> -			qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x18000080);
> -		else
> -			qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x00000080);
> -		qmc_write32(chan->s_param + QMC_SPE_RSTATE, 0x31000000);
> +		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE,
> +			    chan->mode == QMC_TRANSPARENT ?
> +				chan->qmc->data->zdstate_transp :
> +				chan->qmc->data->zdstate_hdlc);
> +		qmc_write32(chan->s_param + QMC_SPE_RSTATE, chan->qmc->data->rstate);
>   		chan->is_rx_halted = false;
>   	}
>   	chan->rx_pending++;
> @@ -971,11 +980,11 @@ static int qmc_chan_start_rx(struct qmc_chan *chan)
>   	}
>   
>   	/* Restart the receiver */
> -	if (chan->mode == QMC_TRANSPARENT)
> -		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x18000080);
> -	else
> -		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x00000080);
> -	qmc_write32(chan->s_param + QMC_SPE_RSTATE, 0x31000000);
> +	qmc_write32(chan->s_param + QMC_SPE_ZDSTATE,
> +		    chan->mode == QMC_TRANSPARENT ?
> +			chan->qmc->data->zdstate_transp :
> +			chan->qmc->data->zdstate_hdlc);
> +	qmc_write32(chan->s_param + QMC_SPE_RSTATE, chan->qmc->data->rstate);
>   	chan->is_rx_halted = false;
>   
>   	chan->is_rx_stopped = false;
> @@ -1121,8 +1130,8 @@ static void qmc_chan_reset_tx(struct qmc_chan *chan)
>   		    qmc_read16(chan->s_param + QMC_SPE_TBASE));
>   
>   	/* Reset TSTATE and ZISTATE to their initial value */
> -	qmc_write32(chan->s_param + QMC_SPE_TSTATE, 0x30000000);
> -	qmc_write32(chan->s_param + QMC_SPE_ZISTATE, 0x00000100);
> +	qmc_write32(chan->s_param + QMC_SPE_TSTATE, chan->qmc->data->tstate);
> +	qmc_write32(chan->s_param + QMC_SPE_ZISTATE, chan->qmc->data->zistate);
>   
>   	spin_unlock_irqrestore(&chan->tx_lock, flags);
>   }
> @@ -1393,11 +1402,11 @@ static int qmc_setup_chan(struct qmc *qmc, struct qmc_chan *chan)
>   	val = ((chan->id * (QMC_NB_TXBDS + QMC_NB_RXBDS)) + QMC_NB_TXBDS) * sizeof(cbd_t);
>   	qmc_write16(chan->s_param + QMC_SPE_RBASE, val);
>   	qmc_write16(chan->s_param + QMC_SPE_RBPTR, val);
> -	qmc_write32(chan->s_param + QMC_SPE_TSTATE, 0x30000000);
> -	qmc_write32(chan->s_param + QMC_SPE_RSTATE, 0x31000000);
> -	qmc_write32(chan->s_param + QMC_SPE_ZISTATE, 0x00000100);
> +	qmc_write32(chan->s_param + QMC_SPE_TSTATE, chan->qmc->data->tstate);
> +	qmc_write32(chan->s_param + QMC_SPE_RSTATE, chan->qmc->data->rstate);
> +	qmc_write32(chan->s_param + QMC_SPE_ZISTATE, chan->qmc->data->zistate);
>   	if (chan->mode == QMC_TRANSPARENT) {
> -		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x18000080);
> +		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, chan->qmc->data->zdstate_transp);
>   		qmc_write16(chan->s_param + QMC_SPE_TMRBLR, 60);
>   		val = QMC_SPE_CHAMR_MODE_TRANSP;
>   		if (chan->is_reverse_data)
> @@ -1407,7 +1416,7 @@ static int qmc_setup_chan(struct qmc *qmc, struct qmc_chan *chan)
>   		if (ret)
>   			return ret;
>   	} else {
> -		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x00000080);
> +		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, chan->qmc->data->zdstate_hdlc);
>   		qmc_write16(chan->s_param + QMC_SPE_MFLR, 60);
>   		qmc_write16(chan->s_param + QMC_SPE_CHAMR,
>   			    QMC_SPE_CHAMR_MODE_HDLC | QMC_SPE_CHAMR_HDLC_IDLM);
> @@ -1535,11 +1544,12 @@ static void qmc_irq_gint(struct qmc *qmc)
>   			/* Restart the receiver if needed */
>   			spin_lock_irqsave(&chan->rx_lock, flags);
>   			if (chan->rx_pending && !chan->is_rx_stopped) {
> -				if (chan->mode == QMC_TRANSPARENT)
> -					qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x18000080);
> -				else
> -					qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x00000080);
> -				qmc_write32(chan->s_param + QMC_SPE_RSTATE, 0x31000000);
> +				qmc_write32(chan->s_param + QMC_SPE_ZDSTATE,
> +					    chan->mode == QMC_TRANSPARENT ?
> +						chan->qmc->data->zdstate_transp :
> +						chan->qmc->data->zdstate_hdlc);
> +				qmc_write32(chan->s_param + QMC_SPE_RSTATE,
> +					    chan->qmc->data->rstate);
>   				chan->is_rx_halted = false;
>   			} else {
>   				chan->is_rx_halted = true;
> @@ -1597,6 +1607,11 @@ static int qmc_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	qmc->dev = &pdev->dev;
> +	qmc->data = of_device_get_match_data(&pdev->dev);
> +	if (!qmc->data) {
> +		dev_err(qmc->dev, "Missing match data\n");
> +		return -EINVAL;
> +	}
>   	INIT_LIST_HEAD(&qmc->chan_head);
>   
>   	qmc->scc_regs = devm_platform_ioremap_resource_byname(pdev, "scc_regs");
> @@ -1752,8 +1767,16 @@ static void qmc_remove(struct platform_device *pdev)
>   	tsa_serial_disconnect(qmc->tsa_serial);
>   }
>   
> +static const struct qmc_data qmc_data_cpm1 = {
> +	.tstate = 0x30000000,
> +	.rstate = 0x31000000,
> +	.zistate = 0x00000100,
> +	.zdstate_hdlc = 0x00000080,
> +	.zdstate_transp = 0x18000080,
> +};
> +
>   static const struct of_device_id qmc_id_table[] = {
> -	{ .compatible = "fsl,cpm1-scc-qmc" },
> +	{ .compatible = "fsl,cpm1-scc-qmc", .data = &qmc_data_cpm1 },
>   	{} /* sentinel */
>   };
>   MODULE_DEVICE_TABLE(of, qmc_id_table);

