Return-Path: <linux-kernel+bounces-331026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54097A760
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 20:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB151C252F1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6B015D5C7;
	Mon, 16 Sep 2024 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Umuy9vmo"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7611581F2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512078; cv=none; b=T5o0UzpA2XHI+cwMnr5RA9wLaXuba166UIzsARkCTNPDrW8BXGqFDAqat1W6oIrbg/9GD4QprNwR7WYK6vNYgocGljDcBdnpuUIvE8ZvWb7Lrs9VEiUdUDvoJpld2RL/lcIaxtE+rbYdLpAJZhv8IZox8zoORk/jS0eHyfaMkGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512078; c=relaxed/simple;
	bh=z++b2vIVng5A7qfGWkzR33HvgEbugXtTHFnPz1pLS3c=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:Cc:To:
	 In-Reply-To:Content-Type; b=i6OBWQXCviz5XuFKnbCEBu+g3vEpDVngLZeVPoF4l9wNnvrkxAHGavP5Wre6bxRVgEJzyzcIGYuo2p3zZhi+y6uTtbimGvIXKavNGhaNmGYuFZ2kscsq6wfoTabw23Eh2UPpkXejQgtMQiKJU4Cc0ICpi27cAi7DkZKkgLszZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Umuy9vmo; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id qGejs0tbUMDtnqGejs6ORx; Mon, 16 Sep 2024 20:41:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726512068;
	bh=4xZynbdl8X5dZpBdrXoCTH9SQCCxnA23WyVw+eu7ov4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=Umuy9vmoqB8++ffA9IDEPiXyccpaqSGlZJ+hM6PzPz0YG+9NXI7rywiELOlaYJkn5
	 wmPHmP8tqV4sAg6yeGpgfTZOab4052OPPDujeZJfoGnAj15+6c7agfSql08BCQy2/t
	 Q+d284VcBFUGlTAlMD3XVVAjDNNa3AJF6z/wIBBtPzciUesU2DPdhsCN/fudipS7pF
	 C2i8EMzoSHLLi3fhx3946s4eo60JTpiBpIOx0/AHDfs29sInV3gj/lSXhWdbgvJv+U
	 KDafN/BsJyRSex913RgAE8CD+jUKxU7xZ1ibxseOMls2gA3FVsgXiOugrq0t+oCBJ5
	 I5Suw0wfVpd0g==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 16 Sep 2024 20:41:08 +0200
X-ME-IP: 90.11.132.44
Message-ID: <8412982c-17c0-4596-a9eb-cd28ad747048@wanadoo.fr>
Date: Mon, 16 Sep 2024 20:41:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] reset: aspeed: register AST2700 reset auxiliary
 bus device
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-4-ryan_chen@aspeedtech.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, p.zabel@pengutronix.de,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org
To: Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20240916091039.3584505-4-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/09/2024 à 11:10, Ryan Chen a écrit :
> The AST2700 reset driver is registered as an auxiliary device
> due to reset and clock controller share the same register region.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Hi,

...

> +static const struct ast2700_reset_signal ast2700_reset0_signals[] = {
> +	[SCU0_RESET_SDRAM] = { true, SCU0_RESET_CTRL1, BIT(0) },
> +	[SCU0_RESET_DDRPHY] = { true, SCU0_RESET_CTRL1, BIT(1) },
> +	[SCU0_RESET_RSA]     = { true, SCU0_RESET_CTRL1, BIT(2) },
> +	[SCU0_RESET_SHA3]	= { true, SCU0_RESET_CTRL1, BIT(3) },
> +	[SCU0_RESET_HACE]	= { true, SCU0_RESET_CTRL1, BIT(4) },
> +	[SCU0_RESET_SOC]	= { true, SCU0_RESET_CTRL1, BIT(5) },
> +	[SCU0_RESET_VIDEO]	= { true, SCU0_RESET_CTRL1, BIT(6) },
> +	[SCU0_RESET_2D]	= { true, SCU0_RESET_CTRL1, BIT(7) },
> +	[SCU0_RESET_PCIS]	= { true, SCU0_RESET_CTRL1, BIT(8) },
> +	[SCU0_RESET_RVAS0]		= { true, SCU0_RESET_CTRL1, BIT(9) },
> +	[SCU0_RESET_RVAS1]		= { true, SCU0_RESET_CTRL1, BIT(10) },
> +	[SCU0_RESET_SM3]		= { true, SCU0_RESET_CTRL1, BIT(11) },
> +	[SCU0_RESET_SM4]		= { true, SCU0_RESET_CTRL1, BIT(12) },
> +	[SCU0_RESET_CRT0]	= { true, SCU0_RESET_CTRL1, BIT(13) },
> +	[SCU0_RESET_ECC]	= { true, SCU0_RESET_CTRL1, BIT(14) },
> +	[SCU0_RESET_DP_PCI]	= { true, SCU0_RESET_CTRL1, BIT(15) },
> +	[SCU0_RESET_UFS]	= { true, SCU0_RESET_CTRL1, BIT(16) },
> +	[SCU0_RESET_EMMC]	= { true, SCU0_RESET_CTRL1, BIT(17) },
> +	[SCU0_RESET_PCIE1RST]	= { true, SCU0_RESET_CTRL1, BIT(18) },
> +	[SCU0_RESET_PCIE1RSTOE]	= { true, SCU0_RESET_CTRL1, BIT(19) },
> +	[SCU0_RESET_PCIE0RST]		= { true, SCU0_RESET_CTRL1, BIT(20) },
> +	[SCU0_RESET_PCIE0RSTOE]	= { true, SCU0_RESET_CTRL1, BIT(21) },
> +	[SCU0_RESET_JTAG]	= { true, SCU0_RESET_CTRL1, BIT(22) },
> +	[SCU0_RESET_MCTP0] = { true, SCU0_RESET_CTRL1, BIT(23) },
> +	[SCU0_RESET_MCTP1]		= { true, SCU0_RESET_CTRL1, BIT(24) },
> +	[SCU0_RESET_XDMA0]	= { true, SCU0_RESET_CTRL1, BIT(25) },
> +	[SCU0_RESET_XDMA1]	= { true, SCU0_RESET_CTRL1, BIT(26) },
> +	[SCU0_RESET_H2X1]	= { true, SCU0_RESET_CTRL1, BIT(27) },
> +	[SCU0_RESET_DP]	= { true, SCU0_RESET_CTRL1, BIT(28) },
> +	[SCU0_RESET_DP_MCU]	= { true, SCU0_RESET_CTRL1, BIT(29) },
> +	[SCU0_RESET_SSP]	= { true, SCU0_RESET_CTRL1, BIT(30) },
> +	[SCU0_RESET_H2X0]	= { true, SCU0_RESET_CTRL1, BIT(31) },
> +	[SCU0_RESET_PORTA_VHUB]	= { true, SCU0_RESET_CTRL2, BIT(0) },
> +	[SCU0_RESET_PORTA_PHY3]	= { true, SCU0_RESET_CTRL2, BIT(1) },
> +	[SCU0_RESET_PORTA_XHCI]	= { true, SCU0_RESET_CTRL2, BIT(2) },
> +	[SCU0_RESET_PORTB_VHUB]	= { true, SCU0_RESET_CTRL2, BIT(3) },
> +	[SCU0_RESET_PORTB_PHY3]	= { true, SCU0_RESET_CTRL2, BIT(4) },
> +	[SCU0_RESET_PORTB_XHCI]	= { true, SCU0_RESET_CTRL2, BIT(5) },
> +	[SCU0_RESET_PORTA_VHUB_EHCI]	= { true, SCU0_RESET_CTRL2, BIT(6) },
> +	[SCU0_RESET_PORTB_VHUB_EHCI]	= { true, SCU0_RESET_CTRL2, BIT(7) },
> +	[SCU0_RESET_UHCI]	= { true, SCU0_RESET_CTRL2, BIT(8) },
> +	[SCU0_RESET_TSP]	= { true, SCU0_RESET_CTRL2, BIT(9) },
> +	[SCU0_RESET_E2M0]	= { true, SCU0_RESET_CTRL2, BIT(10) },
> +	[SCU0_RESET_E2M1]	= { true, SCU0_RESET_CTRL2, BIT(11) },
> +	[SCU0_RESET_VLINK]	= { true, SCU0_RESET_CTRL2, BIT(12) },
> +};

The sapces and tabs in both tables look not consistent.

> +
> +static const struct ast2700_reset_signal ast2700_reset1_signals[] = {
> +	[SCU1_RESET_LPC0] = { true, SCU1_RESET_CTRL1, BIT(0) },
> +	[SCU1_RESET_LPC1] = { true, SCU1_RESET_CTRL1, BIT(1) },
> +	[SCU1_RESET_MII]     = { true, SCU1_RESET_CTRL1, BIT(2) },
> +	[SCU1_RESET_PECI]	= { true, SCU1_RESET_CTRL1, BIT(3) },
> +	[SCU1_RESET_PWM]	= { true, SCU1_RESET_CTRL1, BIT(4) },
> +	[SCU1_RESET_MAC0]	= { true, SCU1_RESET_CTRL1, BIT(5) },
> +	[SCU1_RESET_MAC1]	= { true, SCU1_RESET_CTRL1, BIT(6) },
> +	[SCU1_RESET_MAC2]	= { true, SCU1_RESET_CTRL1, BIT(7) },
> +	[SCU1_RESET_ADC]	= { true, SCU1_RESET_CTRL1, BIT(8) },
> +	[SCU1_RESET_SD]		= { true, SCU1_RESET_CTRL1, BIT(9) },
> +	[SCU1_RESET_ESPI0]		= { true, SCU1_RESET_CTRL1, BIT(10) },
> +	[SCU1_RESET_ESPI1]		= { true, SCU1_RESET_CTRL1, BIT(11) },
> +	[SCU1_RESET_JTAG1]		= { true, SCU1_RESET_CTRL1, BIT(12) },
> +	[SCU1_RESET_SPI0]	= { true, SCU1_RESET_CTRL1, BIT(13) },
> +	[SCU1_RESET_SPI1]	= { true, SCU1_RESET_CTRL1, BIT(14) },
> +	[SCU1_RESET_SPI2]	= { true, SCU1_RESET_CTRL1, BIT(15) },
> +	[SCU1_RESET_I3C0]	= { true, SCU1_RESET_CTRL1, BIT(16) },
> +	[SCU1_RESET_I3C1]	= { true, SCU1_RESET_CTRL1, BIT(17) },
> +	[SCU1_RESET_I3C2]	= { true, SCU1_RESET_CTRL1, BIT(18) },
> +	[SCU1_RESET_I3C3]	= { true, SCU1_RESET_CTRL1, BIT(19) },
> +	[SCU1_RESET_I3C4]		= { true, SCU1_RESET_CTRL1, BIT(20) },
> +	[SCU1_RESET_I3C5]	= { true, SCU1_RESET_CTRL1, BIT(21) },
> +	[SCU1_RESET_I3C6]	= { true, SCU1_RESET_CTRL1, BIT(22) },
> +	[SCU1_RESET_I3C7] = { true, SCU1_RESET_CTRL1, BIT(23) },
> +	[SCU1_RESET_I3C8]		= { true, SCU1_RESET_CTRL1, BIT(24) },
> +	[SCU1_RESET_I3C9]	= { true, SCU1_RESET_CTRL1, BIT(25) },
> +	[SCU1_RESET_I3C10]	= { true, SCU1_RESET_CTRL1, BIT(26) },
> +	[SCU1_RESET_I3C11]	= { true, SCU1_RESET_CTRL1, BIT(27) },
> +	[SCU1_RESET_I3C12]	= { true, SCU1_RESET_CTRL1, BIT(28) },
> +	[SCU1_RESET_I3C13]	= { true, SCU1_RESET_CTRL1, BIT(29) },
> +	[SCU1_RESET_I3C14]	= { true, SCU1_RESET_CTRL1, BIT(30) },
> +	[SCU1_RESET_I3C15]	= { true, SCU1_RESET_CTRL1, BIT(31) },
> +	[SCU1_RESET_MCU0]	= { true, SCU1_RESET_CTRL2, BIT(0) },
> +	[SCU1_RESET_MCU1]	= { true, SCU1_RESET_CTRL2, BIT(1) },
> +	[SCU1_RESET_H2A_SPI1]	= { true, SCU1_RESET_CTRL2, BIT(2) },
> +	[SCU1_RESET_H2A_SPI2]	= { true, SCU1_RESET_CTRL2, BIT(3) },
> +	[SCU1_RESET_UART0]	= { true, SCU1_RESET_CTRL2, BIT(4) },
> +	[SCU1_RESET_UART1]	= { true, SCU1_RESET_CTRL2, BIT(5) },
> +	[SCU1_RESET_UART2]	= { true, SCU1_RESET_CTRL2, BIT(6) },
> +	[SCU1_RESET_UART3]	= { true, SCU1_RESET_CTRL2, BIT(7) },
> +	[SCU1_RESET_I2C_FILTER]	= { true, SCU1_RESET_CTRL2, BIT(8) },
> +	[SCU1_RESET_CALIPTRA]	= { true, SCU1_RESET_CTRL2, BIT(9) },
> +	[SCU1_RESET_XDMA]	= { true, SCU1_RESET_CTRL2, BIT(10) },
> +	[SCU1_RESET_FSI]	= { true, SCU1_RESET_CTRL2, BIT(12) },
> +	[SCU1_RESET_CAN]	= { true, SCU1_RESET_CTRL2, BIT(13) },
> +	[SCU1_RESET_MCTP]	= { true, SCU1_RESET_CTRL2, BIT(14) },
> +	[SCU1_RESET_I2C]	= { true, SCU1_RESET_CTRL2, BIT(15) },
> +	[SCU1_RESET_UART6]	= { true, SCU1_RESET_CTRL2, BIT(16) },
> +	[SCU1_RESET_UART7]	= { true, SCU1_RESET_CTRL2, BIT(17) },
> +	[SCU1_RESET_UART8]	= { true, SCU1_RESET_CTRL2, BIT(18) },
> +	[SCU1_RESET_UART9]	= { true, SCU1_RESET_CTRL2, BIT(19) },
> +	[SCU1_RESET_LTPI0]	= { true, SCU1_RESET_CTRL2, BIT(20) },
> +	[SCU1_RESET_VGAL]	= { true, SCU1_RESET_CTRL2, BIT(21) },
> +	[SCU1_RESET_LTPI1]	= { true, SCU1_RESET_CTRL2, BIT(22) },
> +	[SCU1_RESET_ACE]	= { true, SCU1_RESET_CTRL2, BIT(23) },
> +	[SCU1_RESET_E2M]	= { true, SCU1_RESET_CTRL2, BIT(24) },
> +	[SCU1_RESET_UHCI]	= { true, SCU1_RESET_CTRL2, BIT(25) },
> +	[SCU1_RESET_PORTC_USB2UART]	= { true, SCU1_RESET_CTRL2, BIT(26) },
> +	[SCU1_RESET_PORTC_VHUB_EHCI]	= { true, SCU1_RESET_CTRL2, BIT(27) },
> +	[SCU1_RESET_PORTD_USB2UART]	= { true, SCU1_RESET_CTRL2, BIT(28) },
> +	[SCU1_RESET_PORTD_VHUB_EHCI]	= { true, SCU1_RESET_CTRL2, BIT(29) },
> +	[SCU1_RESET_H2X]	= { true, SCU1_RESET_CTRL2, BIT(30) },
> +	[SCU1_RESET_I3CDMA]	= { true, SCU1_RESET_CTRL2, BIT(31) },
> +	[SCU1_RESET_PCIE2RST]	= { false, SCU1_PCIE3_CTRL, BIT(0) },
> +};

...

> +static int aspeed_reset_probe(struct auxiliary_device *adev,
> +			      const struct auxiliary_device_id *id)
> +{
> +	struct aspeed_reset *reset;
> +	struct device *dev = &adev->dev;
> +
> +	reset = devm_kzalloc(dev, sizeof(*reset), GFP_KERNEL);
> +	if (!reset)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&reset->lock);
> +
> +	reset->info	= (struct aspeed_reset_info *)(id->driver_data);
> +	reset->rcdev.owner     = THIS_MODULE;
> +	reset->rcdev.nr_resets = reset->info->nr_resets;
> +	reset->rcdev.ops       = &aspeed_reset_ops;
> +	reset->rcdev.of_node   = dev->parent->of_node;
> +	reset->rcdev.dev	      = dev;
> +	reset->rcdev.of_reset_n_cells = 1;
> +	reset->base            = (void __iomem *)adev->dev.platform_data;

The spaces and tabs look broken for 'info' and 'rcdev.dev'.

> +
> +	if (!reset->base)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, reset);

Is it needed?
(there is no dev_get_drvdata())

> +
> +	return devm_reset_controller_register(dev, &reset->rcdev);
> +}

...

CJ

