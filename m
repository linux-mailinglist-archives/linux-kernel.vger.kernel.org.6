Return-Path: <linux-kernel+bounces-263157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5F993D1C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1443F1F22C98
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213CB179955;
	Fri, 26 Jul 2024 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8qVUKL2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433A71EF01;
	Fri, 26 Jul 2024 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992298; cv=none; b=qUXJCdBTPB7ccMBLMrYhEteWNS9kcjL69Ph7Uqboa2w4ebSJq5ip9/ZemAxytm+XMxbmiIBH9Waj2xFzhc87Z/k+1ZU9VTcioLUceLqw6OLOTnz1A73RXGJ2QzwOk3o4IWeVsltinRkgbmyjGdyV+SfbW0aNj3Y7bOAWHbz2ouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992298; c=relaxed/simple;
	bh=Sh7X1lINTazHWZKt0CMgzCpSwuDELIvWLdHJIjtQG3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YKKvrFVEOqH0Kn3XrCGuMmec73bdORw3sgCQxESZWcENqty4caQt9x03LT6cz674QA09GQmyxr2tPS8bYujlBS25gWq5m7F4P+5L8E+zM8wnzxvvd5S2XUQqr4cfPWzNWubNhLQvFkfHLhBBTYkv9IOVDN9XEHXrP6wCiszQr9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8qVUKL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5B5C32782;
	Fri, 26 Jul 2024 11:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721992297;
	bh=Sh7X1lINTazHWZKt0CMgzCpSwuDELIvWLdHJIjtQG3o=;
	h=Date:Subject:List-Id:To:References:From:In-Reply-To:From;
	b=a8qVUKL2owWxSsrF+zPXD2OZdzXnehFR9grXYTgNVz6+AJ2ZdfqQN00rw7mfcE90L
	 yx1HjKed4Tg3s5WomY10M45HcnwLDcpPGnrSZ18EL2CPgNGfRPWVk3lQzTnCtbla4X
	 0kOp46mfasAdAHWomy+SBBbjyPOTyIq6J7u+F0tStXGQzZNhJ4oH3qykLxsmSFT6AT
	 xFNbW8KOYkf5G+AcGNlnASLDbvow7dKHGy6DIEtkoP85OXC30fCG5d+gJm94t2PHUu
	 2rZagHxRR9fAW/VEY1vzUoSi3ASP/vPqhvVIspJb6wymOYC3xzMnKCV9VFMcau8leD
	 L0V4cyOMsGqcg==
Message-ID: <e13c16db-e1a7-4ee0-867b-b184d421de7f@kernel.org>
Date: Fri, 26 Jul 2024 13:11:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/10] dt-binding: clk: ast2700: Add binding for Aspeed
 AST27xx Clock
To: Kevin Chen <kevin_chen@aspeedtech.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, lee@kernel.org, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 quic_bjorande@quicinc.com, geert+renesas@glider.be,
 dmitry.baryshkov@linaro.org, shawnguo@kernel.org, neil.armstrong@linaro.org,
 m.szyprowski@samsung.com, nfraprado@collabora.com, u-kumar1@ti.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-3-kevin_chen@aspeedtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240726110355.2181563-3-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/07/2024 13:03, Kevin Chen wrote:
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>

Missing commit msg.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters



> ---
>  .../dt-bindings/clock/aspeed,ast2700-clk.h    | 180 ++++++++++++++++++

This is supposed to be part of bindings adding the clock controller.

>  1 file changed, 180 insertions(+)
>  create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
> 
> diff --git a/include/dt-bindings/clock/aspeed,ast2700-clk.h b/include/dt-bindings/clock/aspeed,ast2700-clk.h
> new file mode 100644
> index 000000000000..5ca85503736d
> --- /dev/null
> +++ b/include/dt-bindings/clock/aspeed,ast2700-clk.h
> @@ -0,0 +1,180 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Device Tree binding constants for AST2700 clock controller.
> + *
> + * Copyright (c) 2023 Aspeed Technology Inc.
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_AST2700_H
> +#define __DT_BINDINGS_CLOCK_AST2700_H
> +
> +/* SOC0 clk-gate */
> +#define SCU0_CLK_GATE_MCLK	(0)
> +#define SCU0_CLK_GATE_ECLK	(1)

Drop all (). Not needed, not useful.

> +#define SCU0_CLK_GATE_GCLK	(2)
> +#define SCU0_CLK_GATE_VCLK	(3)
> +#define SCU0_CLK_GATE_BCLK	(4)
> +#define SCU0_CLK_GATE_D1CLK	(5)
> +#define SCU0_CLK_GATE_REFCLK	(6)
> +#define SCU0_CLK_GATE_USB0CLK	(7)
> +#define SCU0_CLK_GATE_RSV8	(8)
> +#define SCU0_CLK_GATE_USB1CLK	(9)
> +#define SCU0_CLK_GATE_D2CLK	(10)
> +#define SCU0_CLK_GATE_RSV11	(11)
> +#define SCU0_CLK_GATE_RSV12	(12)
> +#define SCU0_CLK_GATE_YCLK	(13)
> +#define SCU0_CLK_GATE_USB2CLK	(14)
> +#define SCU0_CLK_GATE_UART4CLK	(15)
> +#define SCU0_CLK_GATE_SLICLK	(16)
> +#define SCU0_CLK_GATE_DACCLK	(17)
> +#define SCU0_CLK_GATE_DP	(18)
> +#define SCU0_CLK_GATE_RSV19	(19)
> +#define SCU0_CLK_GATE_CRT1CLK	(20)
> +#define SCU0_CLK_GATE_CRT2CLK	(21)
> +#define SCU0_CLK_GATE_VLCLK	(22)
> +#define SCU0_CLK_GATE_ECCCLK	(23)
> +#define SCU0_CLK_GATE_RSACLK	(24)
> +#define SCU0_CLK_GATE_RVAS0CLK	(25)
> +#define SCU0_CLK_GATE_UFSCLK	(26)
> +#define SCU0_CLK_GATE_EMMCCLK	(27)
> +#define SCU0_CLK_GATE_RVAS1CLK	(28)
> +/* reserved 29 ~ 31*/

IDs cannot be reserved. It is a binding, not a hardware number.

> +#define SOC0_CLK_GATE_NUM	(SCU0_CLK_GATE_RVAS1CLK + 1)

No drop. Others as well.

Best regards,
Krzysztof


