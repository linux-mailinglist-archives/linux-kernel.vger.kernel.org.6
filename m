Return-Path: <linux-kernel+bounces-177610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5028C4185
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F83B22246
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDA01514E9;
	Mon, 13 May 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I32CpzZM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC441509BA;
	Mon, 13 May 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605871; cv=none; b=V59x6bwchYjdG1lgKNO2UzvlWGOBQ7AOa8WBnfkBF/xRmQIgcfpphLTtlCQ2vro0/e08zFb1qJyF2dwfheYW5kOBvMnPHEkG2/4H6rB7+BOXHAekClmxCxk+W3Pe6IthqsAV4yMQBe7k14+3mTdmGZRdIQEL1oPuVXwUIGloHI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605871; c=relaxed/simple;
	bh=vb6VU8I039xfs50EqqXBhoNIQO7NhR8KG4nRvOrcCHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fpas70Nja9epKdTI0+Pll2Sp5T7UBG48ERuch86Jxsv3QgcObaBtCFTZ5rsH55sbi+NDwOQNhAsRDg5DcBq2kR4IZQJKSlz+U4oPleHJMy7SYPqo/6LR8vuSLwNWVnHg88iZyrApUPe31pR7TpqdYr0N0v+uAyWyxu62WZAqdpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I32CpzZM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715605867;
	bh=vb6VU8I039xfs50EqqXBhoNIQO7NhR8KG4nRvOrcCHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I32CpzZMSeEnyQQCPetjzV9Baf0RaDjXYyWuOQ7GalN+1Snmnyj2y5odmTtvsfEbn
	 eY6qK+WoDRvy6NqqRZ1qi3OQw5Wug8y0FrgEwyHAiX3laIbkUf2WolxGx57mvVWnTM
	 so1gyFQccRJL6+MiYYOGxyCvGrf3jMVbwuwAsFTB6X6WwIkXOfT/cWZEv+91soz08w
	 IXZhG0wH/tSdB5mvWOG0kE0hkl82yBmMTB6PgyuDLcp2mbvajMZ17OflNB9Y0maGww
	 Q92JrkYD8782MJcckvuL29IpeF35t5+Xp7JYHiKpfu2tJ8W7Tl6kspnb/EqRAzEQ3B
	 kFp+dQgqwr5Hw==
Received: from [IPV6:fd00::2a:39ce] (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7380A3782139;
	Mon, 13 May 2024 13:11:05 +0000 (UTC)
Message-ID: <ffa57617-3c87-47d7-8882-becfe40abc17@collabora.com>
Date: Mon, 13 May 2024 15:11:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Add write DP phyd register from parse dts
To: Liankun Yang <liankun.yang@mediatek.com>, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
 matthias.bgg@gmail.com, jitao.shi@mediatek.com, mac.shen@mediatek.com,
 Project_Global_Chrome_Upstream_Group@mediatek.com
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20240510110523.12524-1-liankun.yang@mediatek.com>
 <20240510110523.12524-2-liankun.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240510110523.12524-2-liankun.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/05/24 13:04, Liankun Yang ha scritto:
> During the testing phase, screen flickering is observed when
> using displayport for screen casting. Relevant SSC register parameters
> are set in dts to address the screen flickering issue effectively and
> improve compatibility with different devices by adjusting the SSC gear.
> 
> Obtaining the DPTX node, parsing the dts to obtain PHY register address
> and value can adapt to settings of different manufacturers projects.
> 
> Changeds in v2:
> - Optimized method of writing to DP PHY register
> https://patchwork.kernel.org/project/linux-mediatek/patch/
> 20240403040517.3279-1-liankun.yang@mediatek.com/
> 
> Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>

There's no devicetree support in this driver - infact, it's being probed by
mtk-dp as a platform device.

You keep sending untested stuff. Fourth time in a row.

Please, TEST YOUR COMMITS upstream before sending!

Regards,
Angelo

> ---
>   drivers/phy/mediatek/phy-mtk-dp.c | 37 +++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
> index d7024a144335..ce78112d5938 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
> @@ -28,6 +28,10 @@
>   #define MTK_DP_PHY_DIG_SW_RST		(PHY_OFFSET + 0x38)
>   #define DP_GLB_SW_RST_PHYD		BIT(0)
>   
> +#define MTK_DP_PHY_DIG_GLB_DA_REG_14	(PHY_OFFSET + 0xD8)
> +#define XTP_GLB_TXPLL_SSC_DELTA_RBR_DEFAULT	GENMASK(15, 0)
> +#define XTP_GLB_TXPLL_SSC_DELTA_HBR_DEFAULT	GENMASK(31, 16)
> +
>   #define MTK_DP_LANE0_DRIVING_PARAM_3		(PHY_OFFSET + 0x138)
>   #define MTK_DP_LANE1_DRIVING_PARAM_3		(PHY_OFFSET + 0x238)
>   #define MTK_DP_LANE2_DRIVING_PARAM_3		(PHY_OFFSET + 0x338)
> @@ -78,10 +82,39 @@
>   #define DRIVING_PARAM_8_DEFAULT	(XTP_LN_TX_LCTXCP1_SW2_PRE1_DEFAULT | \
>   				 XTP_LN_TX_LCTXCP1_SW3_PRE0_DEFAULT)
>   
> +#define SSC_SETTING	"dp-ssc-setting"
> +#define RG_XTP_GLB_TXPLL_SSC_DELTA_HBR	"ssc-delta-hbr"
> +
>   struct mtk_dp_phy {
>   	struct regmap *regs;
> +	struct device *dev;
>   };
>   
> +static int mtk_dp_set_ssc_config(struct phy *phy, struct mtk_dp_phy *dp_phy)
> +{
> +	int ret;
> +	u32 read_value = 0, reg_mask = 0;
> +	struct device_node *ssc_node = NULL;
> +
> +	ssc_node = of_find_node_by_name(dp_phy->dev->of_node, SSC_SETTING);
> +	if (!ssc_node) {
> +		dev_err(&phy->dev, "SSC node is NULL\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_property_read_u32(ssc_node, RG_XTP_GLB_TXPLL_SSC_DELTA_HBR, &read_value);
> +	if (ret < 0 || !read_value) {
> +		dev_err(&phy->dev, "Read SSC vlaue fail!\n");
> +		return -EINVAL;
> +	}
> +	read_value |= read_value << 16;
> +	reg_mask |= XTP_GLB_TXPLL_SSC_DELTA_HBR_DEFAULT;
> +
> +	regmap_update_bits(dp_phy->regs, MTK_DP_PHY_DIG_GLB_DA_REG_14, reg_mask, read_value);
> +
> +	return 0;
> +}
> +
>   static int mtk_dp_phy_init(struct phy *phy)
>   {
>   	struct mtk_dp_phy *dp_phy = phy_get_drvdata(phy);
> @@ -137,6 +170,8 @@ static int mtk_dp_phy_configure(struct phy *phy, union phy_configure_opts *opts)
>   	regmap_update_bits(dp_phy->regs, MTK_DP_PHY_DIG_PLL_CTL_1,
>   			   TPLL_SSC_EN, opts->dp.ssc ? TPLL_SSC_EN : 0);
>   
> +	mtk_dp_set_ssc_config(phy, dp_phy);
> +
>   	return 0;
>   }
>   
> @@ -186,6 +221,8 @@ static int mtk_dp_phy_probe(struct platform_device *pdev)
>   	if (!dev->of_node)
>   		phy_create_lookup(phy, "dp", dev_name(dev));
>   
> +	dp_phy->dev = dev;
> +
>   	return 0;
>   }
>   



