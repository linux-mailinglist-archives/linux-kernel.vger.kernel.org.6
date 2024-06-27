Return-Path: <linux-kernel+bounces-232019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9E791A1A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E40B1C219D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DE284E1C;
	Thu, 27 Jun 2024 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f4sQNpyS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F49E7C097;
	Thu, 27 Jun 2024 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477435; cv=none; b=eG3uK5dIHG5XHpoGYW0V+nKOF8zGo1LJsy8lNAcpgECTRtXPgFLHRzc+SFGUYHe/Euk3u1I0ef0rESTElCl+nAunr5JqnZiogkW70a3ITyhJTvivqZ+sO4G3mU6U7++rQorJrNmcAC/9E4MxvHGF8Qf0bbRnOzAPUJwZ9vGyRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477435; c=relaxed/simple;
	bh=XREYqkvCwbtnY/wTDk2oBMANkBPSKjKF3TFWthonUGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNLGZiXKI14uRpKe4IRRPsLzOMjqUkcIGffMUed0X/UdXPIoGnkT+3n1hGanSGvIGiOp0+dLZ/PttW8ORRpoDsDEIYT0028CVngn3L4DpN+WDdYr07+K6ukJCjdf++AURghEqXqefFtqSSn0T4B/ZXP39gYOTXRHVqaYur84HNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f4sQNpyS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719477425;
	bh=XREYqkvCwbtnY/wTDk2oBMANkBPSKjKF3TFWthonUGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f4sQNpySpezWwtUlEczADnMWiKwsxMhyPdXapEZq0VoLPmutf2cJeMw9wtQfdGaYB
	 cHEqweDX1YFIJkZimqnOZC5LyTlgTX+uygBFFZ7nbDrHRZQyFxGLgbFsJRHws9Ix8a
	 VQxgGsFYbyeJcAZNlPUyqf5jIWwVHSzEQt4oE/PKzqJMqA10S2Ku+fBZCJPCeVJ/nX
	 2fnJ11lzRk6irZIL9Kq5wi3+uN2Ok2FXZrgGnIGrlfBoZW+10cnmn3swpLHfBRc1Ep
	 nzWm2QuBjscLmHodCrScrQA9bYMB8TRyT9aADw07nCMsJzjit599SB41UMJvKgZxic
	 7NDGEp7U76DuA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 940C83780626;
	Thu, 27 Jun 2024 08:37:04 +0000 (UTC)
Message-ID: <96b436c1-50c3-4091-9577-c00187518779@collabora.com>
Date: Thu, 27 Jun 2024 10:37:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: Add MediaTek MT6735 clock and
 reset bindings
To: Yassine Oudjana <yassine.oudjana@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Daniel Golle
 <daniel@makrotopia.org>, jason-ch chen <Jason-ch.Chen@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240626202406.846961-1-y.oudjana@protonmail.com>
 <20240626202406.846961-2-y.oudjana@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240626202406.846961-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/06/24 22:24, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add DT bindings for for the main clock and reset controllers of MT6735
> (apmixedsys, topckgen, infracfg and pericfg).
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

This commit needs just one small nit to be fixed before being ready to be picked,
check below...

> ---
>   .../arm/mediatek/mediatek,infracfg.yaml       |  8 +-
>   .../arm/mediatek/mediatek,pericfg.yaml        |  1 +
>   .../bindings/clock/mediatek,apmixedsys.yaml   |  4 +-
>   .../bindings/clock/mediatek,topckgen.yaml     |  4 +-
>   MAINTAINERS                                   | 12 +++
>   .../clock/mediatek,mt6735-apmixedsys.h        | 16 ++++
>   .../clock/mediatek,mt6735-infracfg.h          | 25 ++++++
>   .../clock/mediatek,mt6735-pericfg.h           | 37 +++++++++
>   .../clock/mediatek,mt6735-topckgen.h          | 79 +++++++++++++++++++
>   .../reset/mediatek,mt6735-infracfg.h          | 31 ++++++++
>   .../reset/mediatek,mt6735-pericfg.h           | 31 ++++++++
>   11 files changed, 243 insertions(+), 5 deletions(-)
>   create mode 100644 include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
>   create mode 100644 include/dt-bindings/clock/mediatek,mt6735-infracfg.h
>   create mode 100644 include/dt-bindings/clock/mediatek,mt6735-pericfg.h
>   create mode 100644 include/dt-bindings/clock/mediatek,mt6735-topckgen.h
>   create mode 100644 include/dt-bindings/reset/mediatek,mt6735-infracfg.h
>   create mode 100644 include/dt-bindings/reset/mediatek,mt6735-pericfg.h
> 

..snip..

> diff --git a/include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h b/include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
> new file mode 100644
> index 0000000000000..3dda719fd5d53
> --- /dev/null
> +++ b/include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_CLK_MT6735_APMIXEDSYS_H
> +#define _DT_BINDINGS_CLK_MT6735_APMIXEDSYS_H
> +
> +#define ARMPLL				0

All of the definitions inside of the clock bindings for MediaTek have a specific
format and, for consistency, you *shall* follow that.

#define CLK_(ip-name)_(clock)    x

For example,

#define CLK_APMIXED_ARMPLL	0
#define CLK_APMIXED_MAINPLL	1
... etc

> +#define MAINPLL				1
> +#define UNIVPLL				2
> +#define MMPLL				3
> +#define MSDCPLL				4
> +#define VENCPLL				5
> +#define TVDPLL				6
> +#define APLL1				7
> +#define APLL2				8
> +
> +#endif
> diff --git a/include/dt-bindings/clock/mediatek,mt6735-infracfg.h b/include/dt-bindings/clock/mediatek,mt6735-infracfg.h
> new file mode 100644
> index 0000000000000..a42be76c778d1
> --- /dev/null
> +++ b/include/dt-bindings/clock/mediatek,mt6735-infracfg.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_CLK_MT6735_INFRACFG_H
> +#define _DT_BINDINGS_CLK_MT6735_INFRACFG_H
> +
> +#define CLK_DBG				0

#define CLK_INFRA_DBG	0
#define CLK_INFRA_GCE	1
.....etc

> +#define CLK_GCE				1
> +#define CLK_TRBG			2
> +#define CLK_CPUM			3
> +#define CLK_DEVAPC			4
> +#define CLK_AUDIO			5
> +#define CLK_GCPU			6
> +#define CLK_L2C_SRAM			7
> +#define CLK_M4U				8
> +#define CLK_CLDMA			9
> +#define CLK_CONNMCU_BUS			10
> +#define CLK_KP				11
> +#define CLK_APXGPT			12
> +#define CLK_SEJ				13
> +#define CLK_CCIF0_AP			14
> +#define CLK_CCIF1_AP			15
> +#define CLK_PMIC_SPI			16
> +#define CLK_PMIC_WRAP			17
> +
> +#endif
> diff --git a/include/dt-bindings/clock/mediatek,mt6735-pericfg.h b/include/dt-bindings/clock/mediatek,mt6735-pericfg.h
> new file mode 100644
> index 0000000000000..72401f009176a
> --- /dev/null
> +++ b/include/dt-bindings/clock/mediatek,mt6735-pericfg.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_CLK_MT6735_PERICFG_H
> +#define _DT_BINDINGS_CLK_MT6735_PERICFG_H
> +
> +#define CLK_DISP_PWM			0

#define CLK_PERI_DISP_PWM
#define CLK_PERI_THERM
....etc

> +#define CLK_THERM			1
> +#define CLK_PWM1			2

..snip..

> +
> +#endif
> diff --git a/include/dt-bindings/clock/mediatek,mt6735-topckgen.h b/include/dt-bindings/clock/mediatek,mt6735-topckgen.h
> new file mode 100644
> index 0000000000000..a771910a4b8a6
> --- /dev/null
> +++ b/include/dt-bindings/clock/mediatek,mt6735-topckgen.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_CLK_MT6735_TOPCKGEN_H
> +#define _DT_BINDINGS_CLK_MT6735_TOPCKGEN_H
> +
> +#define AD_SYS_26M_CK			0

#define CLK_TOP_AD_SYS_26M_CK
#define CLK_TOP_CLKPH_MCK_O
#define CLK_TOP_DMPLL

....etc

> +#define CLKPH_MCK_O			1
> +#define DMPLL				2

..snip...

> +
> +#endif
> diff --git a/include/dt-bindings/reset/mediatek,mt6735-infracfg.h b/include/dt-bindings/reset/mediatek,mt6735-infracfg.h
> new file mode 100644
> index 0000000000000..5d24c7a1317f8
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt6735-infracfg.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_RESET_MT6735_INFRACFG_H
> +#define _DT_BINDINGS_RESET_MT6735_INFRACFG_H
> +

For resets, the names are, instead...

#define (socmodel)_(ip-name)_(instance)_(reset-name)

so, for example...

#define MT6735_INFRA_RST0_EMI_REG	0
#define MT6735_INFRA_RST0_DRAMC0_AO	1

and no holes are permitted, so:

#define MT6735_INFRA_RST0_AP_CIRQ_EINT	2

...this means that, unless you know what is at 2, you have to define
a .rst_idx_map which will effectively map the binding to the actual
real reset bit in the reset register.

In the driver:

#define RST_NR_PER_BANK		32

static u16 infra_idx_map[] = {
	[MT6735_INFRA_RST0_EMI_REG] = 0 * RST_NR_PER_BANK + 0
	......
	[MT7635_INFRA_RST0_AP_CIRQ_EINT] = 0 * RST_NR_PER_BANK + 3
	... etc
};

> +#define RST_EMI_REG			0
> +#define RST_DRAMC0_AO			1
> +#define RST_AP_CIRQ_EINT		3
> +#define RST_APXGPT			4
> +#define RST_SCPSYS			5
> +#define RST_KP				6
> +#define RST_PMIC_WRAP			7
> +#define RST_CLDMA_AO_TOP		8
> +#define RST_EMI				16
> +#define RST_CCIF			17
> +#define RST_DRAMC0			18
> +#define RST_EMI_AO_REG			19
> +#define RST_CCIF_AO			20
> +#define RST_TRNG			21
> +#define RST_SYS_CIRQ			22
> +#define RST_GCE				23
> +#define RST_M4U				24
> +#define RST_CCIF1			25
> +#define RST_CLDMA_TOP_PD		26
> +#define RST_CBIP_P2P_MFG		27
> +#define RST_CBIP_P2P_APMIXED		28
> +#define RST_CBIP_P2P_CKSYS		29
> +#define RST_CBIP_P2P_MIPI		30
> +#define RST_CBIP_P2P_DDRPHY		31
> +
> +#endif
> diff --git a/include/dt-bindings/reset/mediatek,mt6735-pericfg.h b/include/dt-bindings/reset/mediatek,mt6735-pericfg.h
> new file mode 100644
> index 0000000000000..90ee8ed8923fd
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt6735-pericfg.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_RESET_MT6735_PERICFG_H
> +#define _DT_BINDINGS_RESET_MT6735_PERICFG_H
> +
> +#define RST_UART0			0

#define MT6735_PERI_RST0_UART0 ......etc


You're almost there, getting this stuff upstream is just one small effort ahead.
Keep it up!

Cheers,
Angelo



