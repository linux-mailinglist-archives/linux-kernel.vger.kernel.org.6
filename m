Return-Path: <linux-kernel+bounces-575132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A0FA6EDE1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD041675AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1B0254859;
	Tue, 25 Mar 2025 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta/3XDN/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C63B1DE8A0;
	Tue, 25 Mar 2025 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899179; cv=none; b=IBR/aJo7yz3y0WyFBIkqqNTxwe7QGbfHuwGUA3N6DMdcC+4yxSHss+dCGP8Nr2RDAdl72ptCgPH8RzujTJHHyvUNkiK4BPMx8LlvZ9o0n6PBpbHEhskKvLZ7F9Q50Je7kmtd6zdR4VL/NCO6VsN9Tfhyi6ylMRocAJE4KMugx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899179; c=relaxed/simple;
	bh=AOb2VvQ2ywXqpOshgUwjJTMO0uh4dYwd2qYWkJurz2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBoQRYcvaGNGzGQbpuNtUzGTS9Hmo0eylqIZCqpJDbQPFXw9Dp/WBFTrQ4GRYgyJMvtsLxFLmyQvo3ddqVRnI+zBhomiUkPQHkzk7ZwJ58+T56lsn6UmYr9n788ws6vpj0TSW8Bi/qgahpSFhZXJ/3boabm6EimjmJjGlv/qhhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta/3XDN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12208C4CEE4;
	Tue, 25 Mar 2025 10:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742899178;
	bh=AOb2VvQ2ywXqpOshgUwjJTMO0uh4dYwd2qYWkJurz2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ta/3XDN/kMKixfVqd1PC8nphflCfFPuSrfspQckg2glXl7Jn+qTr+y/obopsETbus
	 sGcokAU/VXZx1vpX9ZAproZDIrJRw71L3siW6DGXzChz/fueXsTbGtoNVvT4weKY47
	 HmfIn9Nfc3I7Qk9aUGxux5qxn4f0MTB5SKF8nn4TC8AHSp2WksZ2uc8hzVhyoKfST1
	 0aN/6ruQBsx4AbjmWTAubDZGGUBUAAjNPDiNz8iSkdDIaPwO/00SlsJbulPnSGWrJc
	 rz2gj/nvy6oHfFkikjRmGn0rmbKD2YzB5pRuy2i3Yd0G5Ryin0LzwAxzQwuGNBA1/D
	 8IN4B4Ti49zdQ==
Message-ID: <410f05ba-73e2-45fd-9d31-0c07d648cdd5@kernel.org>
Date: Tue, 25 Mar 2025 11:39:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mailbox: add Cixtech mailbox driver
To: Guomin Chen <guomin.chen@cixtech.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 cix-kernel-upstream@cixtech.com, Peter Chen <peter.chen@cixtech.com>,
 Lihua Liu <Lihua.Liu@cixtech.com>
References: <20250325101807.2202758-1-guomin.chen@cixtech.com>
 <20250325101807.2202758-3-guomin.chen@cixtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250325101807.2202758-3-guomin.chen@cixtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2025 11:18, Guomin Chen wrote:
> +
> +static int cix_mbox_startup(struct mbox_chan *chan)
> +{
> +	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> +	struct cix_mbox_con_priv *cp = chan->con_priv;
> +	int ret;
> +	int index = cp->index;
> +	u32 val_32;
> +
> +	ret = request_irq(priv->irq, cix_mbox_isr, 0,
> +			  dev_name(priv->dev), chan);
> +	if (ret) {
> +		dev_err(priv->dev,
> +			"Unable to acquire IRQ %d\n",
> +			priv->irq);

Odd wrapping. All over the code. See coding style. Please follow it
precisely.

> +		return ret;
> +	}
> +
> +	dev_info(priv->dev, "%s, irq %d, dir %d, type %d, index %d\n",
> +		 __func__, priv->irq, priv->dir, cp->type, cp->index);

Drop or dev_dbg.

> +
> +	switch (cp->type) {
> +	case CIX_MBOX_TYPE_DB:
> +		/* Overwrite txdone_method for DB channel */
> +		chan->txdone_method = TXDONE_BY_ACK;
> +		fallthrough;
> +	case CIX_MBOX_TYPE_REG:
> +		if (priv->dir == MBOX_TX) {
> +			/* Enable ACK interrupt */
> +			val_32 = cix_mbox_read(priv, INT_ENABLE);
> +			val_32 |= ACK_INT;
> +			cix_mbox_write(priv, val_32, INT_ENABLE);
> +		} else {
> +			/* Enable Doorbell interrupt */
> +			val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
> +			val_32 |= DB_INT;
> +			cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
> +		}
> +		break;
> +	case CIX_MBOX_TYPE_FIFO:
> +		/* reset fifo */
> +		cix_mbox_write(priv, FIFO_RST_BIT, FIFO_RST);
> +		/* set default watermark */
> +		cix_mbox_write(priv, FIFO_WM_DEFAULT, FIFO_WM);
> +		if (priv->dir == MBOX_TX) {
> +			/* Enable fifo overflow interrupt */
> +			val_32 = cix_mbox_read(priv, INT_ENABLE);
> +			val_32 |= FIFO_OFLOW_INT;
> +			cix_mbox_write(priv, val_32, INT_ENABLE);
> +		} else {
> +			/* Enable fifo full/underflow interrupt */
> +			val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
> +			val_32 |= FIFO_UFLOW_INT|FIFO_WM01_INT;
> +			cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
> +		}
> +		break;
> +	case CIX_MBOX_TYPE_FAST:

...

> +
> +static int cix_mbox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cix_mbox_priv *priv;
> +	int ret;
> +	u32 dir;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->irq = platform_get_irq(pdev, 0);
> +	if (priv->irq < 0)
> +		return priv->irq;
> +
> +	if (device_property_read_u32(dev, "cix,mbox-dir", &dir)) {
> +		dev_err(priv->dev, "cix,mbox_dir property not found\n");
> +		return -EINVAL;
> +	}
> +
> +	if ((dir != MBOX_TX)
> +	    && (dir != MBOX_RX)) {

Odd style. Please follow Linux kernel coding style. There is no wrapping
after 20 characters.

> +		dev_err(priv->dev, "Dir value is not expected! dir %d\n", dir);
> +		return -EINVAL;
> +	}
> +
> +	cix_mbox_init(priv);
> +
> +	priv->dir = (int)dir;
> +	priv->mbox.dev = dev;
> +	priv->mbox.ops = &cix_mbox_chan_ops;
> +	priv->mbox.chans = priv->mbox_chans;
> +	priv->mbox.txdone_irq = true;
> +	priv->mbox.num_chans = CIX_MBOX_CHANS;
> +	priv->mbox.of_xlate = NULL;
> +	dev_info(priv->dev, "%s, irq %d, dir %d\n",
> +		 __func__, priv->irq, priv->dir);

Drop, your driver is supposed to be silent on success.

> +
> +	platform_set_drvdata(pdev, priv);
> +	ret = devm_mbox_controller_register(dev, &priv->mbox);
> +	if (ret)
> +		dev_err(dev, "Failed to register mailbox %d\n", ret);
> +
Best regards,
Krzysztof

