Return-Path: <linux-kernel+bounces-543944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93158A4DBB5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FB51886DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112571FFC49;
	Tue,  4 Mar 2025 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltk75wvx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B951FCF60;
	Tue,  4 Mar 2025 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085957; cv=none; b=hpY+KvpcCjbXhHDQ+AIVAKOHrMYw0DfI6SkbH4P3MfBBUI9wdj6bYcuIl3GO0geNw9uylBlJPw7FVZ3dWbAvlqBQ3KcDTS4a/S8ZMjgmvbRg2aqJ0zVHEU3RHkGCFiQJD+QXADABOx44LJ4if8gvCvzCeRzcAoXKikpvI7ydD2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085957; c=relaxed/simple;
	bh=hLcfv8cs2z2Jzw4ezqrU3L60vIn/qFCZlb93ktP+vOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IYJY1Z//i3ay9Kbeu5njDKLg4BXGiWUA0vp9MTF7cHDLhw520AOHFaV7V01xhBqI6GUSCPxTklZPEGInwpMZCpQmj+OysPc06QYRm3NLvoGlNkzlaJozh1BIema13Mwu1TwcmvATyFlw8bLCDFhxKzipIwNlFJHzcBK+BVZXxsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltk75wvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5F0C4CEE5;
	Tue,  4 Mar 2025 10:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741085955;
	bh=hLcfv8cs2z2Jzw4ezqrU3L60vIn/qFCZlb93ktP+vOo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ltk75wvxFHW+T4iiJgW7O6TBUcKFhqD1F4X0JzxqGWZU3uJtEylOTZ7mxwi+cQ4Lu
	 YS9ZdFekDA/xzlVDafe2AJ0odtoomBSmIM4JNtwwWUDyfITWFIPXDYjjQ8tOHYR0KT
	 Zr/wfr5oAjg43m7Bp1HZoLM00VRobrcILffveSYw6+bPrO0+0VgKteLRqvH7Rk3NNx
	 nxfRZ06+cGxWwuyVfLfOlUGm85rss/J6npdiY4JXEV/ASWIH9floHLHvWBbT4DqRXt
	 lFQJSvkYEVbDYV+pMFEF3MBy7/n42GigzI7x0ynSZRnCpKjf/3P0AwAM0X5lMO4jkC
	 KYZIffSX7psPw==
Message-ID: <2fd83d68-7104-4755-a0f0-8ce4a2601e09@kernel.org>
Date: Tue, 4 Mar 2025 11:59:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
To: Kevin Chen <kevin_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, derek.kiernan@amd.com, dragan.cvetic@amd.com,
 arnd@arndb.de, gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
 <20250304104434.481429-4-kevin_chen@aspeedtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250304104434.481429-4-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2025 11:44, Kevin Chen wrote:
> +
> +static int aspeed_pcc_probe(struct platform_device *pdev)
> +{
> +	int rc;
> +	struct aspeed_pcc_ctrl *pcc;
> +	struct device *dev;
> +	uint32_t fifo_size = PAGE_SIZE;
> +
> +	dev = &pdev->dev;

This goes to declaration.

> +
> +	pcc = devm_kzalloc(&pdev->dev, sizeof(*pcc), GFP_KERNEL);

Maybe my previous comment was not clear, but you agreed with it. Anyway
nothing improved here.

If you have 'dev' variable, use it.

> +	if (!pcc)
> +		return -ENOMEM;
> +
> +	pcc->regmap = syscon_node_to_regmap(pdev->dev.parent->of_node);

same here and everywhere else.

> +	if (IS_ERR(pcc->regmap)) {
> +		dev_err(dev, "Couldn't get regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	rc = of_property_read_u32(dev->of_node, "pcc-ports", &pcc->port);
> +	if (rc) {
> +		dev_err(dev, "no pcc ports configured\n");
> +		return -ENODEV;
> +	}
> +
> +	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (rc) {
> +		dev_err(dev, "cannot set 64-bits DMA mask\n");
> +		return rc;
> +	}
> +
> +	pcc->dma.size = PCC_DMA_BUFSZ;
> +	pcc->dma.virt = dmam_alloc_coherent(dev,
> +					    pcc->dma.size,
> +					    &pcc->dma.addr,
> +					    GFP_KERNEL);
> +	if (!pcc->dma.virt) {
> +		dev_err(dev, "cannot allocate DMA buffer\n");
> +		return -ENOMEM;
> +	}
> +
> +	fifo_size = roundup(pcc->dma.size, PAGE_SIZE);
> +	rc = kfifo_alloc(&pcc->fifo, fifo_size, GFP_KERNEL);
> +	if (rc) {
> +		dev_err(dev, "cannot allocate kFIFO\n");

Drop

> +		return -ENOMEM;
> +	}
> +
> +	/* Disable PCC to clean up DMA buffer before request IRQ. */
> +	rc = aspeed_pcc_disable(pcc);
> +	if (rc) {
> +		dev_err(dev, "Couldn't disable PCC\n");
> +		goto err_free_kfifo;
> +	}
> +
> +	pcc->irq = platform_get_irq(pdev, 0);
> +	if (pcc->irq < 0) {
> +		dev_err(dev, "Couldn't get IRQ\n");

Drop, core already prints this. Do not duplicate messages.

> +		rc = -ENODEV;

Why not using pcc->irq as rc?

> +		goto err_free_kfifo;
> +	}
> +
Best regards,
Krzysztof

