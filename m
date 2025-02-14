Return-Path: <linux-kernel+bounces-514918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90D0A35D54
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B0716975A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10CD263C9C;
	Fri, 14 Feb 2025 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxR3U64x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0127A2139A8;
	Fri, 14 Feb 2025 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535227; cv=none; b=GX/nMm4kdF+fQPpEgqU+y5Ql7zMe0s4oGgMF/KsP7dE5D+o8Ee32gK5iVnB8ZI0AHMxIGzDo0t4lwOp3VxsShrdyV86foexVq0//zqMplhOUBzE1BS5TbcSLqPk6DupXwl83I6ApnZRaSu7FFhNpHwFeK0EViWTMHNdRP258grA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535227; c=relaxed/simple;
	bh=iBts8iIQtzQel9dZiL97eiLaLFzBf2jp89FOZmsjRrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATbrbBaSXbuv6IPcMPmk6Wjw7yLrqQFUuuc9bOf6rfDnuQOy1d4W0PeOFTB2wkxPe1h7soiiQDZ/6RSghRTAmSAGoYMe/JH9EgfKjfvijQGaHJC/SMLfYfW0wn7O22TM3nNIHQ66vzji+9lkj4+IzW5YjYGfHx8UVgQob0mOoNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxR3U64x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A632DC4CED1;
	Fri, 14 Feb 2025 12:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739535226;
	bh=iBts8iIQtzQel9dZiL97eiLaLFzBf2jp89FOZmsjRrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxR3U64x0UbHv7UIXxJIeRLfMqYvQizaIEArf05g6aIFOfETi5Tr+hBTOo3Ngj/Ix
	 4SBmwsQBt8+uCGHIiDXfieBYV+wKiVfW45YgidsnbAH8+BIsNJcDJkf5NfLGbHASCE
	 1vz7YWuLbzYqyYTONU9XuSQjvvYiezcMvAuAvtOxD8lxxWzEBLW/lDAPA8DGyqfDlB
	 1SzaOkh9vIwdp+NsSmG3+kT3OHJb/0cuffvEtzsF3F1fUqHGFJm3gsH6UZvAEmFzTQ
	 UXN21RC8JeGZR6/tAFUzJ9kirpiAExQMo0uTeM+CZ9claceVIivDg0FTH6glU8pl/j
	 tscqRblX7As8Q==
Date: Fri, 14 Feb 2025 17:43:42 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, quentin.schulz@cherry.de,
	sebastian.reichel@collabora.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	dse@thaumatec.com, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v6 2/2] phy: rockchip: Add Samsung MIPI D-/C-PHY driver
Message-ID: <Z68zdiIl75k2Vv9i@vaman>
References: <20250213210554.1645755-1-heiko@sntech.de>
 <20250213210554.1645755-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213210554.1645755-3-heiko@sntech.de>

On 13-02-25, 22:05, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>

> +#define PLL_CON0		0x0100
> +#define PLL_EN			BIT(12)
> +#define S_MASK			GENMASK(10, 8)
> +#define S(x)			FIELD_PREP(S_MASK, x)
> +#define P_MASK			GENMASK(5, 0)
> +#define P(x)			FIELD_PREP(P_MASK, x)
> +#define PLL_CON1		0x0104
> +#define PLL_CON2		0x0108
> +#define M_MASK			GENMASK(9, 0)
> +#define M(x)			FIELD_PREP(M_MASK, x)
> +#define PLL_CON3		0x010c

lower case, nice.

...

> +#define COMBO_MD0_GNR_CON0	0x0400
> +#define COMBO_MD0_GNR_CON1	0x0404
> +#define COMBO_MD0_ANA_CON0	0x0408
> +#define COMBO_MD0_ANA_CON1      0x040C

upper one!

> +#define COMBO_MD0_ANA_CON2	0x0410
> +
> +#define COMBO_MD0_TIME_CON0	0x0430
> +#define COMBO_MD0_TIME_CON1	0x0434
> +#define COMBO_MD0_TIME_CON2	0x0438
> +#define COMBO_MD0_TIME_CON3	0x043C

and few more, lets be lower case everywhere please?

> +	{ 200,  7,   1,  0, 33,  9,  0, 26,  5,  0, 11},
> +	{ 190,  7,   1,  0, 32,  9,  0, 25,  5,  0, 11},
> +	{ 180,  6,   1,  0, 32,  8,  0, 25,  5,  0, 10},
> +	{ 170,  6,   0,  0, 32,  8,  0, 25,  5,  0, 10},
> +	{ 160,  5,   0,  0, 31,  8,  0, 24,  4,  0,  9},
> +	{ 150,  5,   0,  0, 31,  8,  0, 24,  5,  0,  9},
> +	{ 140,  5,   0,  0, 31,  8,  0, 24,  5,  0,  8},
> +	{ 130,  4,   0,  0, 30,  6,  0, 23,  3,  0,  8},
> +	{ 120,  4,   0,  0, 30,  6,  0, 23,  3,  0,  7},
> +	{ 110,  3,   0,  0, 30,  6,  0, 23,  3,  0,  7},
> +	{ 100,  3,   0,  0, 29,  5,  0, 22,  2,  0,  6},
> +	{  90,  3,   0,  0, 29,  5,  0, 22,  2,  0,  6},
> +	{  80,  2,   0,  0, 28,  5,  0, 22,  2,  0,  5},
> +};

any word on where this table came from, maybe worth documenting that
part

> +
> +static void samsung_mipi_dcphy_bias_block_enable(struct samsung_mipi_dcphy *samsung)
> +{
> +	u32 bias_con2 = 0x3223;

magic value?

> +static void samsung_mipi_dphy_lane_disable(struct samsung_mipi_dcphy *samsung)
> +{
> +	regmap_update_bits(samsung->regmap, DPHY_MC_GNR_CON0, PHY_ENABLE, 0);
> +	regmap_update_bits(samsung->regmap, COMBO_MD0_GNR_CON0, PHY_ENABLE, 0);
> +	regmap_update_bits(samsung->regmap, COMBO_MD1_GNR_CON0, PHY_ENABLE, 0);
> +	regmap_update_bits(samsung->regmap, COMBO_MD2_GNR_CON0, PHY_ENABLE, 0);
> +	regmap_update_bits(samsung->regmap, DPHY_MD3_GNR_CON0, PHY_ENABLE, 0);

Is writing to a register (mmio) faster than a switch case for checking
lane count and disabling specific lanes?

> +static void samsung_mipi_dcphy_pll_configure(struct samsung_mipi_dcphy *samsung)
> +{
> +	regmap_update_bits(samsung->regmap, PLL_CON0, S_MASK | P_MASK,
> +			   S(samsung->pll.scaler) | P(samsung->pll.prediv));
> +
> +	if (samsung->pll.dsm < 0) {
> +		u16 dsm_tmp;
> +
> +		/* Using opposite number subtraction to find complement */
> +		dsm_tmp = abs(samsung->pll.dsm);
> +		dsm_tmp = dsm_tmp - 1;
> +		dsm_tmp ^= 0xffff;
> +		regmap_write(samsung->regmap, PLL_CON1, dsm_tmp);
> +	} else {
> +		regmap_write(samsung->regmap, PLL_CON1, samsung->pll.dsm);
> +	}
> +
> +	regmap_update_bits(samsung->regmap, PLL_CON2,
> +			   M_MASK, M(samsung->pll.fbdiv));
> +
> +	if (samsung->pll.ssc_en) {
> +		regmap_write(samsung->regmap, PLL_CON3,
> +			     MRR(samsung->pll.mrr) | MFR(samsung->pll.mfr));
> +		regmap_update_bits(samsung->regmap, PLL_CON4, SSCG_EN, SSCG_EN);
> +	}
> +
> +	regmap_write(samsung->regmap, PLL_CON5, RESET_N_SEL | PLL_ENABLE_SEL);
> +	regmap_write(samsung->regmap, PLL_CON7, PLL_LOCK_CNT(0xf000));
> +	regmap_write(samsung->regmap, PLL_CON8, PLL_STB_CNT(0xf000));

I guess you are writing to upper nibble, maybe define that, if we can

> +static __maybe_unused int samsung_mipi_dcphy_runtime_resume(struct device *dev)
> +{
> +	struct samsung_mipi_dcphy *samsung = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(samsung->pclk);
> +	if (ret) {
> +		dev_err(samsung->dev, "Failed to enable pclk, %d\n", ret);
> +		return ret;
> +	}
> +
> +	clk_prepare_enable(samsung->ref_clk);
> +	if (ret) {
> +		dev_err(samsung->dev, "Failed to enable reference clock, %d\n", ret);

No rollback of pclk here?

-- 
~Vinod

