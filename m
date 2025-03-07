Return-Path: <linux-kernel+bounces-550160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D4A55C02
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9FB3B9771
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072B918C0C;
	Fri,  7 Mar 2025 00:29:57 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A1314293;
	Fri,  7 Mar 2025 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307396; cv=none; b=TH7/KFzjoXvlpUNBiCX3IuefdyT7lBG1tRskdk9TO7moKpflbN3rVcP1klrKaSWzT/y3vxLwvFFNW/oN7mRtTALzb0JN3H8GOx45xbBrkgxusSgcaLJoXfIu7wpt6BpNDTYZOzDdbYGEZu9zhCdDIjyvD/pDc618lTIzrEq6QBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307396; c=relaxed/simple;
	bh=AHkW94xodJ1r5ECcBs0x4ZJ4jz7qNAVgbYf3jZilLZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kx2iLy4hCMUB4XDV7zQEewTQqJ8k+GuY2dZhJC1qUxASxrPNLDcIuHfNv6dxkw/K5/jyTawicsHnJir/1h3qrAAGxCXDJh6pRaHyUC62KEBcSTi6cC6ABAwslnj+NFvJX9AaCDUGU23jxWU3j71BL/XJk4c1j6179DwlXXs+sqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id DF268342FF0;
	Fri, 07 Mar 2025 00:29:53 +0000 (UTC)
Date: Fri, 7 Mar 2025 00:29:43 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Haylen Chu <heylenay@4d2.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: clock: spacemit: Add spacemit,k1-pll
Message-ID: <20250307002943-GYA64516@gentoo>
References: <20250306175750.22480-2-heylenay@4d2.org>
 <20250306175750.22480-4-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306175750.22480-4-heylenay@4d2.org>

Hi Haylen:

On 17:57 Thu 06 Mar     , Haylen Chu wrote:
> Add definition for the PLL found on Spacemit K1 SoC, which takes the
> external 24MHz oscillator as input and generates clocks in various
> frequencies for the system.
> 
> Signed-off-by: Haylen Chu <heylenay@4d2.org>
> ---
>  .../bindings/clock/spacemit,k1-pll.yaml       | 50 +++++++++++++++++++
>  include/dt-bindings/clock/spacemit,k1-ccu.h   | 37 ++++++++++++++
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/spacemit,k1-pll.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/spacemit,k1-pll.yaml b/Documentation/devicetree/bindings/clock/spacemit,k1-pll.yaml
> new file mode 100644
> index 000000000000..23d7aa1bc573
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/spacemit,k1-pll.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/spacemit,k1-pll.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spacemit K1 PLL
> +
> +maintainers:
> +  - Haylen Chu <heylenay@4d2.org>
> +
> +properties:
> +  compatible:
> +    const: spacemit,k1-pll
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: External 24MHz oscillator
> +
> +  spacemit,mpmu:
how about naming it as "spacemit,mpmu-syscon" explicitly?
to indicate this is a syscon phandle, it's more readable

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the "Main PMU (MPMU)" syscon. It is used to check PLL
> +      lock status.
> +
> +  "#clock-cells":
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/spacemit,k1-ccu.h> for valid indices.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - spacemit,mpmu
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@d4090000 {
> +        compatible = "spacemit,k1-pll";
> +        reg = <0xd4090000 0x1000>;
> +        clocks = <&vctcxo_24m>;
> +        spacemit,mpmu = <&sysctl_mpmu>;
> +        #clock-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/clock/spacemit,k1-ccu.h b/include/dt-bindings/clock/spacemit,k1-ccu.h
> index 1f8b01db44ca..4a0c7163257e 100644
> --- a/include/dt-bindings/clock/spacemit,k1-ccu.h
> +++ b/include/dt-bindings/clock/spacemit,k1-ccu.h
> @@ -6,6 +6,43 @@
>  #ifndef _DT_BINDINGS_SPACEMIT_CCU_H_
>  #define _DT_BINDINGS_SPACEMIT_CCU_H_
>  
> +/*	APBS (PLL) clocks	*/
> +#define CLK_PLL1		0
> +#define CLK_PLL2		1
> +#define CLK_PLL3		2
> +#define CLK_PLL1_D2		3
> +#define CLK_PLL1_D3		4
> +#define CLK_PLL1_D4		5
> +#define CLK_PLL1_D5		6
> +#define CLK_PLL1_D6		7
> +#define CLK_PLL1_D7		8
> +#define CLK_PLL1_D8		9
> +#define CLK_PLL1_D11		10
> +#define CLK_PLL1_D13		11
> +#define CLK_PLL1_D23		12
> +#define CLK_PLL1_D64		13
> +#define CLK_PLL1_D10_AUD	14
> +#define CLK_PLL1_D100_AUD	15
> +#define CLK_PLL2_D1		16
> +#define CLK_PLL2_D2		17
> +#define CLK_PLL2_D3		18
> +#define CLK_PLL2_D4		19
> +#define CLK_PLL2_D5		20
> +#define CLK_PLL2_D6		21
> +#define CLK_PLL2_D7		22
> +#define CLK_PLL2_D8		23
> +#define CLK_PLL3_D1		24
> +#define CLK_PLL3_D2		25
> +#define CLK_PLL3_D3		26
> +#define CLK_PLL3_D4		27
> +#define CLK_PLL3_D5		28
> +#define CLK_PLL3_D6		29
> +#define CLK_PLL3_D7		30
> +#define CLK_PLL3_D8		31
> +#define CLK_PLL3_80		32
> +#define CLK_PLL3_40		33
> +#define CLK_PLL3_20		34
> +
>  /*	MPMU clocks	*/
>  #define CLK_PLL1_307P2		0
>  #define CLK_PLL1_76P8		1
> -- 
> 2.48.1
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

