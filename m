Return-Path: <linux-kernel+bounces-432624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A81EC9E4DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742F2165F06
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D725B19D8B2;
	Thu,  5 Dec 2024 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FFd8SyEa"
Received: from mail-m127221.xmail.ntesmail.com (mail-m127221.xmail.ntesmail.com [115.236.127.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA91A8F72;
	Thu,  5 Dec 2024 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382016; cv=none; b=hUc8NYFm5vzG2SnIZ2wCiISU5a1JObXBVmeciDDfBsja2BY4Y3nT8D/Eram9PvtNzXfR6p5ajiQFKZCw51CkoFuDLYeEl8HSlGIX71brucX2qyaghAZj7BgEZ6QESDg5ijyv08gdP+IUj7PjIR+Hibym7aRMh0bJCg6uzMePoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382016; c=relaxed/simple;
	bh=MwL35SYAjZlSap2RAP+BluSk5s3UpEQRsOyZTDEgw7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdNimU8pDhTmGhChu1wtieuaAlgUAwxTRlAPO4K1nlgEZufmtkYrx6G7/bl7Jj8OftCTqK8B5ewiBNt5Jd5MMIrZOS/A9YOIO6fkgVALTwqQ10HjziSo+1B498ed1u0jUPwKftCV2gyA0uo+hgthxOzcHTJZ2S3f5vXzLPm+kGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FFd8SyEa; arc=none smtp.client-ip=115.236.127.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd59019;
	Thu, 5 Dec 2024 09:17:13 +0800 (GMT+08:00)
Message-ID: <11439cc8-82e7-4054-b5f1-e932c8ab5a4f@rock-chips.com>
Date: Thu, 5 Dec 2024 09:17:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 2/2] phy: rockchip-naneng-combo: add rk3576
 support
To: Frank Wang <frawang.cn@gmail.com>, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
References: <20241106021357.19782-1-frawang.cn@gmail.com>
 <20241106021357.19782-2-frawang.cn@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241106021357.19782-2-frawang.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRpIHVYfTUsaQx9KQk1JTUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a9394647b8303afkunm4bd59019
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oi46Ezo*ETIqNwgLHklMPQMD
	ATUaCgxVSlVKTEhISE1KT0hOSkJLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSENCTjcG
DKIM-Signature:a=rsa-sha256;
	b=FFd8SyEaaIKikGPsuF6Jef4Sei3ZG5QnXtOuDqDBc+jsTJ/rUmy0QHN+b9NbShmFrJ42+pNzaXbim8n8IxPyZlIR1xAo6bcULkGO9B7v2cBmBaJMeSNlwy2zEAg2KbaCq7iX2ZBGTiVZfYifRZ3tiwQrDuHEs+Krk4Pjr/F+suE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=LCe66WQL0rgFD4dnX/1euk0tuvPmIe8MhqHcV6BvUJ8=;
	h=date:mime-version:subject:message-id:from;

Hi Frank,

On 2024/11/6 10:13, Frank Wang wrote:
> From: Kever Yang <kever.yang@rock-chips.com>
>
> Rockchip RK3576 integrates two naneng-combo PHY, PHY0 is used for
> PCIE and SATA, PHY1 is used for PCIE, SATA and USB3.
>
> This adds device specific data support.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

Test on rk3576 evb with pcie port.

Test-by: Kever Yang <kever.yang@rock-chips.com>


Thanks,

- Kever

> ---
> Changelog:
> v3:
>   - add detail commit contents.
>   - using FIELD_PREP() instead of bit shift.
>   - leave a blank line after each switch break case.
>
> v2:
>   - using constants macro instead of magic values.
>   - add more comments for PHY tuning operations.
>
> v1:
>   - https://patchwork.kernel.org/project/linux-phy/patch/20241015013351.4884-2-frawang.cn@gmail.com/
>
>   .../rockchip/phy-rockchip-naneng-combphy.c    | 279 ++++++++++++++++++
>   1 file changed, 279 insertions(+)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 0a9989e41237f..eceb798567859 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -37,6 +37,10 @@
>   #define PHYREG8				0x1C
>   #define PHYREG8_SSC_EN			BIT(4)
>   
> +#define PHYREG10			0x24
> +#define PHYREG10_SSC_PCM_MASK		GENMASK(3, 0)
> +#define PHYREG10_SSC_PCM_3500PPM	7
> +
>   #define PHYREG11			0x28
>   #define PHYREG11_SU_TRIM_0_7		0xF0
>   
> @@ -61,17 +65,26 @@
>   #define PHYREG16			0x3C
>   #define PHYREG16_SSC_CNT_VALUE		0x5f
>   
> +#define PHYREG17			0x40
> +
>   #define PHYREG18			0x44
>   #define PHYREG18_PLL_LOOP		0x32
>   
> +#define PHYREG21			0x50
> +#define PHYREG21_RX_SQUELCH_VAL		0x0D
> +
>   #define PHYREG27			0x6C
>   #define PHYREG27_RX_TRIM_RK3588		0x4C
>   
> +#define PHYREG30			0x74
> +
>   #define PHYREG32			0x7C
>   #define PHYREG32_SSC_MASK		GENMASK(7, 4)
> +#define PHYREG32_SSC_DIR_MASK		GENMASK(5, 4)
>   #define PHYREG32_SSC_DIR_SHIFT		4
>   #define PHYREG32_SSC_UPWARD		0
>   #define PHYREG32_SSC_DOWNWARD		1
> +#define PHYREG32_SSC_OFFSET_MASK	GENMASK(7, 6)
>   #define PHYREG32_SSC_OFFSET_SHIFT	6
>   #define PHYREG32_SSC_OFFSET_500PPM	1
>   
> @@ -79,6 +92,7 @@
>   #define PHYREG33_PLL_KVCO_MASK		GENMASK(4, 2)
>   #define PHYREG33_PLL_KVCO_SHIFT		2
>   #define PHYREG33_PLL_KVCO_VALUE		2
> +#define PHYREG33_PLL_KVCO_VALUE_RK3576	4
>   
>   struct rockchip_combphy_priv;
>   
> @@ -98,6 +112,7 @@ struct rockchip_combphy_grfcfg {
>   	struct combphy_reg pipe_rxterm_set;
>   	struct combphy_reg pipe_txelec_set;
>   	struct combphy_reg pipe_txcomp_set;
> +	struct combphy_reg pipe_clk_24m;
>   	struct combphy_reg pipe_clk_25m;
>   	struct combphy_reg pipe_clk_100m;
>   	struct combphy_reg pipe_phymode_sel;
> @@ -584,6 +599,266 @@ static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
>   	.combphy_cfg	= rk3568_combphy_cfg,
>   };
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
> +		val = FIELD_PREP(PHYREG32_SSC_MASK, PHYREG32_SSC_DOWNWARD);
> +		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
> +
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
> +		break;
> +
> +	case PHY_TYPE_USB3:
> +		/* Set SSC downward spread spectrum */
> +		val = FIELD_PREP(PHYREG32_SSC_MASK, PHYREG32_SSC_DOWNWARD);
> +		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
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
> +		val = FIELD_PREP(PHYREG6_PLL_DIV_MASK, PHYREG6_PLL_DIV_2);
> +		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK, val, PHYREG6);
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
> +
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
> +
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
> +			val = FIELD_PREP(PHYREG15_SSC_CNT_MASK, PHYREG15_SSC_CNT_VALUE);
> +			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
> +						 val, PHYREG15);
> +
> +			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
> +		} else if (priv->type == PHY_TYPE_PCIE) {
> +			/* PLL KVCO tuning fine */
> +			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE_RK3576);
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
> +
> +	case REF_CLOCK_25MHz:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_25m, true);
> +		break;
> +
> +	case REF_CLOCK_100MHz:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
> +		if (priv->type == PHY_TYPE_PCIE) {
> +			/* gate_tx_pck_sel length select work for L1SS */
> +			writel(0xc0, priv->mmio + PHYREG30);
> +
> +			/* PLL KVCO tuning fine */
> +			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE_RK3576);
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
> +			val = FIELD_PREP(PHYREG32_SSC_DIR_MASK, PHYREG32_SSC_DOWNWARD);
> +			val |= FIELD_PREP(PHYREG32_SSC_OFFSET_MASK, PHYREG32_SSC_OFFSET_500PPM);
> +			rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
> +
> +			/* ssc ppm adjust to 3500ppm */
> +			rockchip_combphy_updatel(priv, PHYREG10_SSC_PCM_MASK,
> +						 PHYREG10_SSC_PCM_3500PPM,
> +						 PHYREG10);
> +		}
> +		break;
> +
> +	default:
> +		dev_err(priv->dev, "Unsupported rate: %lu\n", rate);
> +		return -EINVAL;
> +	}
> +
> +	if (priv->ext_refclk) {
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
> +		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
> +			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE_RK3576);
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
> +
> +			val = FIELD_PREP(PHYREG33_PLL_KVCO_MASK, PHYREG33_PLL_KVCO_VALUE_RK3576);
> +			writel(val, priv->mmio + PHYREG33);
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
>   static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
>   {
>   	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> @@ -775,6 +1050,10 @@ static const struct of_device_id rockchip_combphy_of_match[] = {
>   		.compatible = "rockchip,rk3568-naneng-combphy",
>   		.data = &rk3568_combphy_cfgs,
>   	},
> +	{
> +		.compatible = "rockchip,rk3576-naneng-combphy",
> +		.data = &rk3576_combphy_cfgs,
> +	},
>   	{
>   		.compatible = "rockchip,rk3588-naneng-combphy",
>   		.data = &rk3588_combphy_cfgs,

