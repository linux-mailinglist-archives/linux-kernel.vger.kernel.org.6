Return-Path: <linux-kernel+bounces-369978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 211279A2525
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA611F22FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B691DE881;
	Thu, 17 Oct 2024 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jq9FutbG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B1B1D47AC;
	Thu, 17 Oct 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175673; cv=none; b=kFfUb5DFkfTrJTixosmu9l402r6gbypauGrozrkCic7F5OWwSsJDG2JJut4f/PRgxrZoaDHGB8C6zNzOdmVO2gD1XA5n1mvaYTB81fQsSHfx3T0Y5I/lmSbPBsRNyXX7txGHgmgEEM2a9B60Lv2r5xU+Btm4GnCHQ3llOM65jjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175673; c=relaxed/simple;
	bh=z3sH/iFdeFwwU2Yx+z1KtYwm+ZFhM07gpyQq47OBCdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHMG2QFni67uUBDdSo9prX8DB4KP+AvxlG/2Y4yfkwXIx20kFLAdz0X+rWWbeiluKV+qhlA2B9g8q6808jCMSbJJmn8tkSAO13d6AFZRfkwvpgPd3DEZVOnH4vwYRwXCJ3hU8zWZE884yLEx8Ql17WckZYzmamBnWemasvYlxuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jq9FutbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75D8C4CEC7;
	Thu, 17 Oct 2024 14:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729175672;
	bh=z3sH/iFdeFwwU2Yx+z1KtYwm+ZFhM07gpyQq47OBCdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jq9FutbGZIghih2zqPWvOHsalwsil2qun1IbOft38F2KKFF8IBnhbYG641p8Fuq1q
	 tIhZr6sKIm2RiQsUvRJ24OyiyNPka0elcJwbD+vFtMjJBvbwncfS51UTZXuhDXtwgA
	 hugXim+Kex2/87nHMJNCE5GprTVkJo5sf4Mq+FK2ZLF9EQQOQxvWsL68qkeLR5l7Lf
	 q8oia4ukCBgNQjB6TLJZdMetaE+vVZFsVb9kSB1jkinSzywotxk5tFEIy/umDvDRFo
	 g1pe3vl4t2PZ3XbedDCaR8JI3WhTTYP5G55pi0FLbq4lCFkWSSkA5i1AVj4vhQ6Gq4
	 kWgGxi4ImMiLg==
Date: Thu, 17 Oct 2024 20:04:28 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Wang <frawang.cn@gmail.com>
Cc: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	william.wu@rock-chips.com, tim.chen@rock-chips.com,
	Kever Yang <kever.yang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH v2 2/2] phy: rockchip-naneng-combo: Support rk3576
Message-ID: <ZxEgdHCQ3dTQeMRm@vaman>
References: <20241016023533.12018-1-frawang.cn@gmail.com>
 <20241016023533.12018-2-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016023533.12018-2-frawang.cn@gmail.com>

On 16-10-24, 10:35, Frank Wang wrote:
> From: Kever Yang <kever.yang@rock-chips.com>
> 
> phy0: pcie, sata
> phy1: pcie, sata, usb3

Can this be more verbose to explain what is being added in the patch
below?

> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
> Changelog:
> v2:
>  - using constants macro instead of magic values.
>  - add more comments for PHY tuning operations.
> 
> v1:
>  - https://patchwork.kernel.org/project/linux-phy/patch/20241015013351.4884-2-frawang.cn@gmail.com/
> 
>  .../rockchip/phy-rockchip-naneng-combphy.c    | 274 ++++++++++++++++++
>  1 file changed, 274 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 0a9989e41237f..25aa8d1981abc 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -37,6 +37,10 @@
>  #define PHYREG8				0x1C
>  #define PHYREG8_SSC_EN			BIT(4)
>  
> +#define PHYREG10			0x24
> +#define PHYREG10_SSC_PCM_MASK		GENMASK(3, 0)
> +#define PHYREG10_SSC_PCM_3500PPM	7
> +
>  #define PHYREG11			0x28
>  #define PHYREG11_SU_TRIM_0_7		0xF0
>  
> @@ -61,12 +65,19 @@
>  #define PHYREG16			0x3C
>  #define PHYREG16_SSC_CNT_VALUE		0x5f
>  
> +#define PHYREG17			0x40
> +
>  #define PHYREG18			0x44
>  #define PHYREG18_PLL_LOOP		0x32
>  
> +#define PHYREG21			0x50
> +#define PHYREG21_RX_SQUELCH_VAL		0x0D
> +
>  #define PHYREG27			0x6C
>  #define PHYREG27_RX_TRIM_RK3588		0x4C
>  
> +#define PHYREG30			0x74
> +
>  #define PHYREG32			0x7C
>  #define PHYREG32_SSC_MASK		GENMASK(7, 4)
>  #define PHYREG32_SSC_DIR_SHIFT		4
> @@ -79,6 +90,7 @@
>  #define PHYREG33_PLL_KVCO_MASK		GENMASK(4, 2)
>  #define PHYREG33_PLL_KVCO_SHIFT		2
>  #define PHYREG33_PLL_KVCO_VALUE		2
> +#define PHYREG33_PLL_KVCO_VALUE_RK3576	4
>  
>  struct rockchip_combphy_priv;
>  
> @@ -98,6 +110,7 @@ struct rockchip_combphy_grfcfg {
>  	struct combphy_reg pipe_rxterm_set;
>  	struct combphy_reg pipe_txelec_set;
>  	struct combphy_reg pipe_txcomp_set;
> +	struct combphy_reg pipe_clk_24m;
>  	struct combphy_reg pipe_clk_25m;
>  	struct combphy_reg pipe_clk_100m;
>  	struct combphy_reg pipe_phymode_sel;
> @@ -584,6 +597,263 @@ static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
>  	.combphy_cfg	= rk3568_combphy_cfg,
>  };
>  
> +static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
> +{
> +	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	unsigned long rate;
> +	u32 val;
> +
> +	switch (priv->type) {
> +	case PHY_TYPE_PCIE:
> +		/* Set SSC downward spread spectrum */
> +		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
> +					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
> +					 PHYREG32);

If we use FIELD_GET|PREP, we can get rid of SHIFT defines

> +
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
> +		break;

Break here and before each case please

> +	case PHY_TYPE_USB3:
> +		/* Set SSC downward spread spectrum */
> +		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
> +					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
> +					 PHYREG32);
> +
> +		/* Enable adaptive CTLE for USB3.0 Rx */
> +		val = readl(priv->mmio + PHYREG15);
> +		val |= PHYREG15_CTLE_EN;
> +		writel(val, priv->mmio + PHYREG15);
> +
> +		/* Set PLL KVCO fine tuning signals */
> +		rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK, BIT(3), PHYREG33);
> +
> +		/* Set PLL LPF R1 to su_trim[10:7]=1001 */
> +		writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
> +
> +		/* Set PLL input clock divider 1/2 */
> +		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
> +					 PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT,
> +					 PHYREG6);
> +
> +		/* Set PLL loop divider */
> +		writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
> +
> +		/* Set PLL KVCO to min and set PLL charge pump current to max */
> +		writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
> +
> +		/* Set Rx squelch input filler bandwidth */
> +		writel(PHYREG21_RX_SQUELCH_VAL, priv->mmio + PHYREG21);
> +
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->usb_mode_set, true);
> +		break;
> +	case PHY_TYPE_SATA:
> +		/* Enable adaptive CTLE for SATA Rx */
> +		val = readl(priv->mmio + PHYREG15);
> +		val |= PHYREG15_CTLE_EN;
> +		writel(val, priv->mmio + PHYREG15);
> +
> +		/* Set tx_rterm = 50 ohm and rx_rterm = 43.5 ohm */
> +		val = PHYREG7_TX_RTERM_50OHM << PHYREG7_TX_RTERM_SHIFT;
> +		val |= PHYREG7_RX_RTERM_44OHM << PHYREG7_RX_RTERM_SHIFT;
> +		writel(val, priv->mmio + PHYREG7);
> +
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_sata, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_sata, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_sata, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_sata, true);
> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_con0_for_sata, true);
> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_con1_for_sata, true);
> +		break;
> +	default:
> +		dev_err(priv->dev, "incompatible PHY type\n");
> +		return -EINVAL;
> +	}
> +
> +	rate = clk_get_rate(priv->refclk);
> +
> +	switch (rate) {
> +	case REF_CLOCK_24MHz:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_24m, true);
> +		if (priv->type == PHY_TYPE_USB3 || priv->type == PHY_TYPE_SATA) {
> +			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz */
> +			val = PHYREG15_SSC_CNT_VALUE << PHYREG15_SSC_CNT_SHIFT;
> +			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
> +						 val, PHYREG15);
> +
> +			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
> +
> +		} else if (priv->type == PHY_TYPE_PCIE) {
> +			/* PLL KVCO tuning fine */
> +			val = PHYREG33_PLL_KVCO_VALUE_RK3576 << PHYREG33_PLL_KVCO_SHIFT;
> +			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
> +						 val, PHYREG33);
> +
> +			/* Set up rx_pck invert and rx msb to disable */
> +			writel(0x00, priv->mmio + PHYREG27);
> +
> +			/*
> +			 * Set up SU adjust signal:
> +			 * su_trim[7:0],   PLL KVCO adjust bits[2:0] to min
> +			 * su_trim[15:8],  PLL LPF R1 adujst bits[9:7]=3'b011
> +			 * su_trim[31:24], CKDRV adjust
> +			 */
> +			writel(0x90, priv->mmio + PHYREG11);
> +			writel(0x02, priv->mmio + PHYREG12);
> +			writel(0x57, priv->mmio + PHYREG14);
> +
> +			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
> +		}
> +		break;
> +	case REF_CLOCK_25MHz:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_25m, true);
> +		break;
> +	case REF_CLOCK_100MHz:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
> +		if (priv->type == PHY_TYPE_PCIE) {
> +			/* gate_tx_pck_sel length select work for L1SS */
> +			writel(0xc0, priv->mmio + PHYREG30);
> +
> +			/* PLL KVCO tuning fine */
> +			val = PHYREG33_PLL_KVCO_VALUE_RK3576 << PHYREG33_PLL_KVCO_SHIFT;
> +			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
> +						 val, PHYREG33);
> +
> +			/* Set up rx_trim: PLL LPF C1 85pf R1 1.25kohm */
> +			writel(0x4c, priv->mmio + PHYREG27);
> +
> +			/*
> +			 * Set up SU adjust signal:
> +			 * su_trim[7:0],   PLL KVCO adjust bits[2:0] to min
> +			 * su_trim[15:8],  bypass PLL loop divider code, and
> +			 *                 PLL LPF R1 adujst bits[9:7]=3'b101
> +			 * su_trim[23:16], CKRCV adjust
> +			 * su_trim[31:24], CKDRV adjust
> +			 */
> +			writel(0x90, priv->mmio + PHYREG11);
> +			writel(0x43, priv->mmio + PHYREG12);
> +			writel(0x88, priv->mmio + PHYREG13);
> +			writel(0x56, priv->mmio + PHYREG14);
> +		} else if (priv->type == PHY_TYPE_SATA) {
> +			/* downward spread spectrum +500ppm */
> +			val = PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT;
> +			val |= PHYREG32_SSC_OFFSET_500PPM << PHYREG32_SSC_OFFSET_SHIFT;
> +			rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
> +
> +			/* ssc ppm adjust to 3500ppm */
> +			rockchip_combphy_updatel(priv, PHYREG10_SSC_PCM_MASK,
> +						 PHYREG10_SSC_PCM_3500PPM,
> +						 PHYREG10);
> +		}
> +		break;
> +	default:
> +		dev_err(priv->dev, "Unsupported rate: %lu\n", rate);
> +		return -EINVAL;
> +	}
> +
> +	if (priv->ext_refclk) {
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
> +		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
> +			val = PHYREG33_PLL_KVCO_VALUE_RK3576 << PHYREG33_PLL_KVCO_SHIFT;
> +			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
> +						 val, PHYREG33);
> +
> +			/* Set up rx_trim: PLL LPF C1 85pf R1 2.5kohm */
> +			writel(0x0c, priv->mmio + PHYREG27);
> +
> +			/*
> +			 * Set up SU adjust signal:
> +			 * su_trim[7:0],   PLL KVCO adjust bits[2:0] to min
> +			 * su_trim[15:8],  bypass PLL loop divider code, and
> +			 *                 PLL LPF R1 adujst bits[9:7]=3'b101.
> +			 * su_trim[23:16], CKRCV adjust
> +			 * su_trim[31:24], CKDRV adjust
> +			 */
> +			writel(0x90, priv->mmio + PHYREG11);
> +			writel(0x43, priv->mmio + PHYREG12);
> +			writel(0x88, priv->mmio + PHYREG13);
> +			writel(0x56, priv->mmio + PHYREG14);
> +		}
> +	}
> +
> +	if (priv->enable_ssc) {
> +		val = readl(priv->mmio + PHYREG8);
> +		val |= PHYREG8_SSC_EN;
> +		writel(val, priv->mmio + PHYREG8);
> +
> +		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_24MHz) {
> +			/* Set PLL loop divider */
> +			writel(0x00, priv->mmio + PHYREG17);
> +			writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
> +
> +			/* Set up rx_pck invert and rx msb to disable */
> +			writel(0x00, priv->mmio + PHYREG27);
> +
> +			/*
> +			 * Set up SU adjust signal:
> +			 * su_trim[7:0],   PLL KVCO adjust bits[2:0] to min
> +			 * su_trim[15:8],  PLL LPF R1 adujst bits[9:7]=3'b101
> +			 * su_trim[23:16], CKRCV adjust
> +			 * su_trim[31:24], CKDRV adjust
> +			 */
> +			writel(0x90, priv->mmio + PHYREG11);
> +			writel(0x02, priv->mmio + PHYREG12);
> +			writel(0x08, priv->mmio + PHYREG13);
> +			writel(0x57, priv->mmio + PHYREG14);
> +			writel(0x40, priv->mmio + PHYREG15);
> +
> +			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
> +			writel(PHYREG33_PLL_KVCO_VALUE_RK3576 << PHYREG33_PLL_KVCO_SHIFT,
> +			       priv->mmio + PHYREG33);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct rockchip_combphy_grfcfg rk3576_combphy_grfcfgs = {
> +	/* pipe-phy-grf */
> +	.pcie_mode_set		= { 0x0000, 5, 0, 0x00, 0x11 },
> +	.usb_mode_set		= { 0x0000, 5, 0, 0x00, 0x04 },
> +	.pipe_rxterm_set	= { 0x0000, 12, 12, 0x00, 0x01 },
> +	.pipe_txelec_set	= { 0x0004, 1, 1, 0x00, 0x01 },
> +	.pipe_txcomp_set	= { 0x0004, 4, 4, 0x00, 0x01 },
> +	.pipe_clk_24m		= { 0x0004, 14, 13, 0x00, 0x00 },
> +	.pipe_clk_25m		= { 0x0004, 14, 13, 0x00, 0x01 },
> +	.pipe_clk_100m		= { 0x0004, 14, 13, 0x00, 0x02 },
> +	.pipe_phymode_sel	= { 0x0008, 1, 1, 0x00, 0x01 },
> +	.pipe_rate_sel		= { 0x0008, 2, 2, 0x00, 0x01 },
> +	.pipe_rxterm_sel	= { 0x0008, 8, 8, 0x00, 0x01 },
> +	.pipe_txelec_sel	= { 0x0008, 12, 12, 0x00, 0x01 },
> +	.pipe_txcomp_sel	= { 0x0008, 15, 15, 0x00, 0x01 },
> +	.pipe_clk_ext		= { 0x000c, 9, 8, 0x02, 0x01 },
> +	.pipe_phy_status	= { 0x0034, 6, 6, 0x01, 0x00 },
> +	.con0_for_pcie		= { 0x0000, 15, 0, 0x00, 0x1000 },
> +	.con1_for_pcie		= { 0x0004, 15, 0, 0x00, 0x0000 },
> +	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x0101 },
> +	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },
> +	.con0_for_sata		= { 0x0000, 15, 0, 0x00, 0x0129 },
> +	.con1_for_sata		= { 0x0004, 15, 0, 0x00, 0x0000 },
> +	.con2_for_sata		= { 0x0008, 15, 0, 0x00, 0x80c1 },
> +	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x0407 },
> +	/* php-grf */
> +	.pipe_con0_for_sata	= { 0x001C, 2, 0, 0x00, 0x2 },
> +	.pipe_con1_for_sata	= { 0x0020, 2, 0, 0x00, 0x2 },
> +};
> +
> +static const struct rockchip_combphy_cfg rk3576_combphy_cfgs = {
> +	.num_phys = 2,
> +	.phy_ids = {
> +		0x2b050000,
> +		0x2b060000
> +	},
> +	.grfcfg		= &rk3576_combphy_grfcfgs,
> +	.combphy_cfg	= rk3576_combphy_cfg,
> +};
> +
>  static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
>  {
>  	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> @@ -775,6 +1045,10 @@ static const struct of_device_id rockchip_combphy_of_match[] = {
>  		.compatible = "rockchip,rk3568-naneng-combphy",
>  		.data = &rk3568_combphy_cfgs,
>  	},
> +	{
> +		.compatible = "rockchip,rk3576-naneng-combphy",
> +		.data = &rk3576_combphy_cfgs,
> +	},
>  	{
>  		.compatible = "rockchip,rk3588-naneng-combphy",
>  		.data = &rk3588_combphy_cfgs,
> -- 
> 2.25.1

-- 
~Vinod

