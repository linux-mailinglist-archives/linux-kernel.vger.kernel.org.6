Return-Path: <linux-kernel+bounces-272655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD60945F7C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F9A1F223B5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546D821019E;
	Fri,  2 Aug 2024 14:34:16 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA6F1E2875;
	Fri,  2 Aug 2024 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609255; cv=none; b=rbEEC+tHl0YCKZth/2mpNslPhao3yZX/fq6wum1KKwl5Ki4SieA/KMlJwWPUsYuSRCfvVFcPdAIlP9CjhtZysoijljxxpH4fXufPUilVYvK/fhKCd15/He2d5Umi8c0XtMezD5peI2aRUd1znb/5rt0xn1G7d9O96EEZhQ13JIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609255; c=relaxed/simple;
	bh=kT1NudS6A1VBu00pH0wix5fkzSs86n7Vt9obyt3Xj/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohcZxINWL4omT/QZh0RAukrG7b51n3x9GlEW3ncU47MYu8hhJKRindDhQfod31aNcgDQpVSWrK0MRZRBO6LdJxvfLZ4ogmCDobaU3Fn1VyvsM8LMY6++P7uByOxftAv6+vxtjiNRuEUS6IaAm9QuUsPpmKvjHHpSj9mujCaQPt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a76.versanet.de ([83.135.90.118] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sZtM9-0002uP-Ce; Fri, 02 Aug 2024 16:34:09 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Sugar Zhang <sugar.zhang@rock-chips.com>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 2/3] clk: rockchip: Add dt-binding header for rk3576
Date: Fri, 02 Aug 2024 16:34:07 +0200
Message-ID: <4084310.iTQEcLzFEP@diego>
In-Reply-To: <20240802141816.288337-3-detlev.casanova@collabora.com>
References:
 <20240802141816.288337-1-detlev.casanova@collabora.com>
 <20240802141816.288337-3-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Detlev,

Am Freitag, 2. August 2024, 16:12:49 CEST schrieb Detlev Casanova:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> Add the dt-bindings header for the rk3576, that gets shared between
> the clock controller and the clock references in the dts.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  .../dt-bindings/clock/rockchip,rk3576-cru.h   | 1149 +++++++++++++++++
>  1 file changed, 1149 insertions(+)
>  create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h
> 
> diff --git a/include/dt-bindings/clock/rockchip,rk3576-cru.h b/include/dt-bindings/clock/rockchip,rk3576-cru.h
> new file mode 100644
> index 0000000000000..19d25f082dc57
> --- /dev/null
> +++ b/include/dt-bindings/clock/rockchip,rk3576-cru.h
> @@ -0,0 +1,1149 @@

> +#define CLK_NR_CLKS			(ACLK_KLAD + 1)

this needs to go please. Take a look at how Sebastian got rid of needed
that max-constant for rk3588.

[...]

> +#define SRST_H_VEPU1			1267
> +#define SRST_A_VEPU1			1268
> +#define SRST_VEPU1_CORE			1269
> +
> +/********Name=PHPPHYSOFTRST_CON00,Offset=0x8A00********/
> +#define SRST_P_PHPPHY_CRU		131073
> +#define SRST_P_APB2ASB_SLV_CHIP_TOP	131075
> +#define SRST_P_PCIE2_COMBOPHY0		131077
> +#define SRST_P_PCIE2_COMBOPHY0_GRF	131078
> +#define SRST_P_PCIE2_COMBOPHY1		131079
> +#define SRST_P_PCIE2_COMBOPHY1_GRF	131080

this seems to lump together different components and with that creates
these gaps. I.e. I really don't think the phpphy in these registers is part
of the core CRU.

That huge memory length of 0x5c000 in your dt-binding is also a good
indicator that this needs to have more separation and not span multiple
devices.

> +/********Name=PHPPHYSOFTRST_CON01,Offset=0x8A04********/
> +#define SRST_PCIE0_PIPE_PHY		131093
> +#define SRST_PCIE1_PIPE_PHY		131096
> +
> +/********Name=SECURENSSOFTRST_CON00,Offset=0x10A00********/
> +#define SRST_H_CRYPTO_NS		262147
> +#define SRST_H_TRNG_NS			262148
> +#define SRST_P_OTPC_NS			262152
> +#define SRST_OTPC_NS			262153
> +
> +/********Name=PMU1SOFTRST_CON00,Offset=0x20A00********/
> +#define SRST_P_HDPTX_GRF		524288

same here, that is also most likely not part of the CRU but a different block.
Other socs already implement separate clock controllers for different
parts, so please take a look there.


Thanks
Heiko



