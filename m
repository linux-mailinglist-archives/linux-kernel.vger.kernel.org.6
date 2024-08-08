Return-Path: <linux-kernel+bounces-279113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9409F94B91C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB421C20B51
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B8C18953B;
	Thu,  8 Aug 2024 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="FFlGJReH"
Received: from msa.smtpout.orange.fr (msa-212.smtpout.orange.fr [193.252.23.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52DA1465B3;
	Thu,  8 Aug 2024 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723106149; cv=none; b=CMSNp6Nn1k2VURzQ9PBPpkUOx8gSYFFW9kw/bCVZVqj9Df18hjaa29KkQ1VYt+QTEcpCbMNe83YkFMGhMB1RvxeBhShZeR1kz3/kazqzOhnEX9T3O5IPmKTiL6r2PZxxqnyxrH/il4kyVJ7hM5+IuvUqpetwWOYKDRGzfWTAzKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723106149; c=relaxed/simple;
	bh=N1qrktCO+PnnJLGH/JzHZB2CZag+z4/xUv4WppOomdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rQ5MIm/sVfFgcEgBTJH1j51MvbHmniZZBQbY8fT/evAHhTEQTUqlZlnw8Z0BqjVaSnrLBRziimdhRcbQH978eelG88qlDy79Ah6vrk/g6zuySm8S1VAeiX0QHOxE/OV0U3/i1m4PDzsbK6K7meXjIPEzNhq/ArqV96rGJwabQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=FFlGJReH; arc=none smtp.client-ip=193.252.23.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bycMs4ANs6NRTbycMshqWM; Thu, 08 Aug 2024 10:35:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723106139;
	bh=EjZqCORS57HDZjbd4db9mB4VKAis0rKj0Ik5Pz95TOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=FFlGJReH+xdtjt4bd3YXAhR6QkakNjz5a/+1Bg7g1InkfmNA8igskSUTBKI5I3hI+
	 2k2HfjjMfRb7cS952A8iEkwYfWBr13xPpwY2FiggVxQhFVCNz+zACjscWpVIGJnLV1
	 hmQq5T/Jm1stTFE7606bH48YgcfiQchiWxRu3OdCpKZj2d6I/WpuPPzFsqK+Oq/pJi
	 5DUPFaglEqFBicjY+LJF47eckY+Pcz64de/4aJ9b3DqhsqKA4mq2ZVMhPXIFgFebcZ
	 AtRA+mrTQCJfH9y9ffI7GJeDfjOlrfg4rsOt9vjD+sQzR6EbKpA132ctW/y/b9S5B6
	 l3e9Dwlg2n7fA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 08 Aug 2024 10:35:39 +0200
X-ME-IP: 90.11.132.44
Message-ID: <0f227033-4818-4ff5-9140-851c6d802fb2@wanadoo.fr>
Date: Thu, 8 Aug 2024 10:35:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: reset Add AST2700 reset bindings
To: Ryan Chen <ryan_chen@aspeedtech.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-3-ryan_chen@aspeedtech.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240808075937.2756733-3-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/08/2024 à 09:59, Ryan Chen a écrit :
> Add dt bindings for AST2700 reset driver.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>   .../dt-bindings/reset/aspeed,ast2700-reset.h  | 132 ++++++++++++++++++
>   1 file changed, 132 insertions(+)
>   create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h
> 
> diff --git a/include/dt-bindings/reset/aspeed,ast2700-reset.h b/include/dt-bindings/reset/aspeed,ast2700-reset.h
> new file mode 100644
> index 000000000000..ea261108abfb
> --- /dev/null
> +++ b/include/dt-bindings/reset/aspeed,ast2700-reset.h
> @@ -0,0 +1,132 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Device Tree binding constants for AST2700 reset controller.
> + *
> + * Copyright (c) 2024 Aspeed Technology Inc.
> + */
> +
> +#ifndef _MACH_ASPEED_AST2700_RESET_H_
> +#define _MACH_ASPEED_AST2700_RESET_H_
> +
> +/* SOC0 */
> +#define SCU0_RESET_SDRAM		(0)
> +#define SCU0_RESET_DDRPHY		(1)
> +#define SCU0_RESET_RSA			(2)
> +#define SCU0_RESET_SHA3			(3)
> +#define SCU0_RESET_HACE			(4)
> +#define SCU0_RESET_SOC			(5)
> +#define SCU0_RESET_VIDEO		(6)
> +#define SCU0_RESET_2D			(7)
> +#define SCU0_RESET_PCIS			(8)
> +#define SCU0_RESET_RVAS0		(9)
> +#define SCU0_RESET_RVAS1		(10)
> +#define SCU0_RESET_SM3			(11)
> +#define SCU0_RESET_SM4			(12)
> +#define SCU0_RESET_CRT0			(13)
> +#define SCU0_RESET_ECC			(14)
> +#define SCU0_RESET_DP_PCI		(15)
> +#define SCU0_RESET_UFS			(16)
> +#define SCU0_RESET_EMMC			(17)
> +#define SCU0_RESET_PCIE1RST		(18)
> +#define SCU0_RESET_PCIE1RSTOE		(19)
> +#define SCU0_RESET_PCIE0RST		(20)
> +#define SCU0_RESET_PCIE0RSTOE		(21)
> +#define SCU0_RESET_JTAG			(22)
> +#define SCU0_RESET_MCTP0		(23)
> +#define SCU0_RESET_MCTP1		(24)
> +#define SCU0_RESET_XDMA0		(25)
> +#define SCU0_RESET_XDMA1		(26)
> +#define SCU0_RESET_H2X1			(27)
> +#define SCU0_RESET_DP			(28)
> +#define SCU0_RESET_DP_MCU		(29)
> +#define SCU0_RESET_SSP			(30)
> +#define SCU0_RESET_H2X0			(31)
> +#define SCU0_RESET_PORTA_VHUB1		(32)
> +#define SCU0_RESET_PORTA_PHY3		(33)
> +#define SCU0_RESET_PORTA_XHCI		(34)
> +#define SCU0_RESET_PORTB_VHUB1		(35)
> +#define SCU0_RESET_PORTB_PHY3		(36)
> +#define SCU0_RESET_PORTB_XHCI		(37)
> +#define SCU0_RESET_PORTA_EHCI		(38)
> +#define SCU0_RESET_PORTA_VHUB0		(38)

Is having 38 twice expected?
If not, why not use an enum, BTW?

> +#define SCU0_RESET_PORTB_EHCI		(39)
> +#define SCU0_RESET_PORTB_VHUB0		(39)
> +#define SCU0_RESET_UHCI			(40)
> +#define SCU0_RESET_TSP			(41)
> +#define SCU0_RESET_E2M0			(42)
> +#define SCU0_RESET_E2M1			(43)
> +#define SCU0_RESET_VLINK		(44)
> +
> +#define SCU0_RESET_NUMS		(SCU0_RESET_VLINK + 1)
> +
> +/* SOC1 */
> +#define SCU1_RESET_LPC0			(0)
> +#define SCU1_RESET_LPC1			(1)
> +#define SCU1_RESET_MII			(2)
> +#define SCU1_RESET_PECI			(3)
> +#define SCU1_RESET_PWM			(4)
> +#define SCU1_RESET_MAC0			(5)
> +#define SCU1_RESET_MAC1			(6)
> +#define SCU1_RESET_MAC2			(7)
> +#define SCU1_RESET_ADC			(8)
> +#define SCU1_RESET_SD			(9)
> +#define SCU1_RESET_ESPI0		(10)
> +#define SCU1_RESET_ESPI1		(11)
> +#define SCU1_RESET_JTAG1		(12)
> +#define SCU1_RESET_SPI0			(13)
> +#define SCU1_RESET_SPI1			(14)
> +#define SCU1_RESET_SPI2			(15)
> +#define SCU1_RESET_I3C0			(16)
> +#define SCU1_RESET_I3C1			(17)
> +#define SCU1_RESET_I3C2			(18)
> +#define SCU1_RESET_I3C3			(19)
> +#define SCU1_RESET_I3C4			(20)
> +#define SCU1_RESET_I3C5			(21)
> +#define SCU1_RESET_I3C6			(22)
> +#define SCU1_RESET_I3C7			(23)
> +#define SCU1_RESET_I3C8			(24)
> +#define SCU1_RESET_I3C9			(25)
> +#define SCU1_RESET_I3C10		(26)
> +#define SCU1_RESET_I3C11		(27)
> +#define SCU1_RESET_I3C12		(28)
> +#define SCU1_RESET_I3C13		(29)
> +#define SCU1_RESET_I3C14		(30)
> +#define SCU1_RESET_I3C15		(31)
> +#define SCU1_RESET_I3C15		(31)

SCU1_RESET_I3C15 is defined twice.

> +#define SCU1_RESET_MCU0			(32)
> +#define SCU1_RESET_MCU1			(33)
> +#define SCU1_RESET_H2A_SPI1		(34)
> +#define SCU1_RESET_H2A_SPI2		(35)
> +#define SCU1_RESET_UART0		(36)
> +#define SCU1_RESET_UART1		(37)
> +#define SCU1_RESET_UART2		(38)
> +#define SCU1_RESET_UART3		(39)
> +#define SCU1_RESET_I2C_FILTER		(40)
> +#define SCU1_RESET_CALIPTRA		(41)
> +#define SCU1_RESET_XDMA			(42)
> +/* reserved 43 */
> +#define SCU1_RESET_FSI			(44)
> +#define SCU1_RESET_CAN			(45)
> +#define SCU1_RESET_MCTP			(46)
> +#define SCU1_RESET_I2C			(47)
> +#define SCU1_RESET_UART6		(48)
> +#define SCU1_RESET_UART7		(49)
> +#define SCU1_RESET_UART8		(50)
> +#define SCU1_RESET_UART9		(51)
> +#define SCU1_RESET_LTPI			(52)
> +#define SCU1_RESET_VGAL			(53)
> +#define SCU1_RESET_LTPI1		(54)
> +#define SCU1_RESET_ACE			(55)
> +#define SCU1_RESET_E2M			(56)
> +#define SCU1_RESET_UHCI			(57)
> +#define SCU1_RESET_PORTC_EHCI		(58)
> +#define SCU1_RESET_PORTC_VHUB		(59)
> +#define SCU1_RESET_PORTD_EHCI		(60)
> +#define SCU1_RESET_PORTD_VHUB		(61)
> +#define SCU1_RESET_H2X			(62)
> +#define SCU1_RESET_I3CDMA		(63)
> +#define SCU1_RESET_PCIE2RST		(64)
> +
> +#define SCU1_RESET_NUMS		(SCU1_RESET_PCIE2RST + 1)
> +
> +#endif  /* _MACH_ASPEED_AST2700_RESET_H_ */


