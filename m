Return-Path: <linux-kernel+bounces-279117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B93D94B928
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E580F1F21614
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F851898E1;
	Thu,  8 Aug 2024 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="YwrCK3Bi"
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76766188017;
	Thu,  8 Aug 2024 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723106395; cv=none; b=kY+y9qRFLCqjwS6fNLENlDwshyopgRxptcNGO1o+2hlmmtvFqw2R1IQ2IKM74ON0+dpZoZt1OW31q0Dxo5jJAlLEdt+U/KT6in2jhlH1jT2FeGXvdf6upa180KwIDvSVs9Xtze1ENeV4yqaSn9S8/DPkvb4ojS7Iy+pmHOER/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723106395; c=relaxed/simple;
	bh=TFrnilnjgD0a8YA9+CwPjBQv8dy23a/EUbo4mRdjaQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qnLzFlaBIlACnbrHw50x4R5GwrqMchKx9RqA0WWO2uTmR4UrDc6WyJe/8AIYC+kdq/A1Am06xwKeSlaUl5mnPNCqNpbNTAawGA58oFuXdo3LLVaX1Tno8hezkFqXNHTC11qOH/0zsYBOWHDh9fjzzjv7ayxPnH5CF1rdAjJSwR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=YwrCK3Bi; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bygMs1WA1j4pfbygMs0Sl1; Thu, 08 Aug 2024 10:39:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723106386;
	bh=clc8+qLSQc4IJ8Eo2E+itAv4AyWz9hMSaxLRJC2XBVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=YwrCK3Bi5RAPUYYMryFqaR6gycvmvqQyJoABzpvaKJP9Alp4S7xH90da/Bl2/iSrd
	 R7Znr7Lc7e+SMUj7mjTih3bx87fLwArT4ln67hCZSEzpgc5MmtL46H3ZCOnLKYteow
	 UKLwavmCtKkQP8Z16FZGY3FtAB9n/uJHGYOLbFa/cisUoY/sV6Ed/U0mGH9AOY/Z6A
	 ashps3bKtm+l9L2jYkxQaV42ItTccRHgb6fUpNcbh5UzbqAX8yX9AFgJTWuJO8rTC9
	 rJPK1pucj0tKABXFwJdxnof2Co72wdFhisgiJsbPBRoRKjKivLbjEOq2byKOYviNqk
	 4eS7rL/Xwdi7Q==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 08 Aug 2024 10:39:46 +0200
X-ME-IP: 90.11.132.44
Message-ID: <14ef9485-54ba-402b-9b90-5f10c1523d4e@wanadoo.fr>
Date: Thu, 8 Aug 2024 10:39:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
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
 <20240808075937.2756733-4-ryan_chen@aspeedtech.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240808075937.2756733-4-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/08/2024 à 09:59, Ryan Chen a écrit :
> Add dt bindings for AST2700 clock controller
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>   .../dt-bindings/clock/aspeed,ast2700-clk.h    | 175 ++++++++++++++++++
>   1 file changed, 175 insertions(+)
>   create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
> 
> diff --git a/include/dt-bindings/clock/aspeed,ast2700-clk.h b/include/dt-bindings/clock/aspeed,ast2700-clk.h
> new file mode 100644
> index 000000000000..facf72352c3e
> --- /dev/null
> +++ b/include/dt-bindings/clock/aspeed,ast2700-clk.h
> @@ -0,0 +1,175 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Device Tree binding constants for AST2700 clock controller.
> + *
> + * Copyright (c) 2024 Aspeed Technology Inc.
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_AST2700_H
> +#define __DT_BINDINGS_CLOCK_AST2700_H
> +
> +/* SOC0 clk-gate */
> +#define SCU0_CLK_GATE_MCLK	(0)
> +#define SCU0_CLK_GATE_ECLK	(1)
> +#define SCU0_CLK_GATE_2DCLK	(2)
> +#define SCU0_CLK_GATE_VCLK	(3)
> +#define SCU0_CLK_GATE_BCLK	(4)
> +#define SCU0_CLK_GATE_VGA0CLK	(5)
> +#define SCU0_CLK_GATE_REFCLK	(6)
> +#define SCU0_CLK_GATE_PORTBUSB2CLK	(7)
> +#define SCU0_CLK_GATE_RSV8	(8)
> +#define SCU0_CLK_GATE_UHCICLK	(9)
> +#define SCU0_CLK_GATE_VGA1CLK	(10)
> +#define SCU0_CLK_GATE_DDRPHYCLK	(11)
> +#define SCU0_CLK_GATE_E2M0CLK	(12)
> +#define SCU0_CLK_GATE_HACCLK	(13)
> +#define SCU0_CLK_GATE_PORTAUSB2CLK	(14)
> +#define SCU0_CLK_GATE_UART4CLK	(15)
> +#define SCU0_CLK_GATE_SLICLK	(16)
> +#define SCU0_CLK_GATE_DACCLK	(17)
> +#define SCU0_CLK_GATE_DP	(18)
> +#define SCU0_CLK_GATE_E2M1CLK	(19)
> +#define SCU0_CLK_GATE_CRT0CLK	(20)
> +#define SCU0_CLK_GATE_CRT1CLK	(21)
> +#define SCU0_CLK_GATE_VLCLK	(22)
> +#define SCU0_CLK_GATE_ECDSACLK	(23)
> +#define SCU0_CLK_GATE_RSACLK	(24)
> +#define SCU0_CLK_GATE_RVAS0CLK	(25)
> +#define SCU0_CLK_GATE_UFSCLK	(26)
> +#define SCU0_CLK_GATE_EMMCCLK	(27)
> +#define SCU0_CLK_GATE_RVAS1CLK	(28)
> +/* reserved 29 ~ 31*/
> +#define SCU0_CLK_GATE_NUM	(SCU0_CLK_GATE_RVAS1CLK + 1)
> +
> +/* SOC0 clk */
> +#define SCU0_CLKIN		(SCU0_CLK_GATE_NUM + 0)

So SCU0_CLKIN is 28+1+0 = 29 which is said to be reserved in the comment 
above.

> +#define SCU0_CLK_24M		(SCU0_CLK_GATE_NUM + 1)
> +#define SCU0_CLK_192M		(SCU0_CLK_GATE_NUM + 2)
> +#define SCU0_CLK_UART		(SCU0_CLK_GATE_NUM + 3)
> +#define SCU0_CLK_PSP		(SCU0_CLK_GATE_NUM + 4)
> +#define SCU0_CLK_HPLL		(SCU0_CLK_GATE_NUM + 5)

...


