Return-Path: <linux-kernel+bounces-528431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C081A417A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D32B16890F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABBC21D3C5;
	Mon, 24 Feb 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S2TCOFV/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381D21A424;
	Mon, 24 Feb 2025 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386480; cv=none; b=nwkVAQiIBPsBI8ug/mCHgLlhxlc2nHt6DGVaEqIXwBa5kDIaWLaB0tIN1jXRy5euNq9YYb9AmIgWrnPFYFqjAqnz9Xo2gTWlbHcF1uv6lSHW5bIQ78q+ubW5PNKgfcHZXiO9SwFZiFm7OFSj4mrO5B1osHYh2qd8hmfIP284RWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386480; c=relaxed/simple;
	bh=k6UdJhBqTfCBUtBvzFMc13KVp885py0a3yzx22j8SYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cm9MCeA5N0XAdezxP0fCtkDhz9tTfcJXcx9wDGce9X0uioG1GYKyW1iLgT4uC6Yl80o0DlUPqmYXagZAa1qP5/eMCW7XB80k9hBwzkxl6DjQEXT5B83zSHLhf2gs7/2e2OC9JoDJBlbdShJRMhb7XvpsOWV0L9kClkq6dDIHEtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S2TCOFV/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740386476;
	bh=k6UdJhBqTfCBUtBvzFMc13KVp885py0a3yzx22j8SYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S2TCOFV/QjHPshv+R9JmKMMzNCVLhoJsJrf163iVleicScFawfo6EpMhrjblaUDFi
	 2m7GIB1gVyA9WBlB34q0myeJ1s+MWJ2gMmEVvr22t2B1GijARFljWmovA4IwOmQTPQ
	 vf0qgN+YiEjrhM/JFxBZEMeHaHgac7uBQP9p8sAq0f/y3GTQC7v5pkGkBHuv7ZCVLd
	 2BH3ONXhKe/BxZmr4/Vc7pVCV4oVvLau5BitRWyus3Hy/8tmD7ybMg5cfL+BK05QGx
	 1K0GrMmXpRwm+qXrKFIMO5qLTgxlZO+htwJQ0Q/+ehjAg+85WzotyvspFpCoEc9F9w
	 tzdxZW5Ie7/fA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 462BE17E00A3;
	Mon, 24 Feb 2025 09:41:15 +0100 (CET)
Message-ID: <771e1460-2372-4ecd-949b-016c1b91adb3@collabora.com>
Date: Mon, 24 Feb 2025 09:41:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
To: Friday Yang <friday.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250221074846.14105-1-friday.yang@mediatek.com>
 <20250221074846.14105-3-friday.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250221074846.14105-3-friday.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/02/25 08:48, Friday Yang ha scritto:
> From: "Friday Yang" <friday.yang@mediatek.com>
> 
> To prevent handling glitch signals during MTCMOS on/off transitions,
> SMI requires clamp and reset operations. Parse the reset settings for
> SMI LARBs and the clamp settings for the SMI Sub-Common. Register
> genpd callback for the SMI LARBs located in image, camera and IPE
> subsystems, and apply reset and clamp operations within the callback.
> 
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>
> ---
>   drivers/memory/mtk-smi.c | 141 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 137 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 5710348f72f6..51235c2a2081 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -10,11 +10,15 @@
>   #include <linux/err.h>
>   #include <linux/io.h>
>   #include <linux/iopoll.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
>   #include <linux/soc/mediatek/mtk_sip_svc.h>
>   #include <soc/mediatek/smi.h>
>   #include <dt-bindings/memory/mt2701-larb-port.h>
> @@ -36,6 +40,12 @@
>   #define SMI_DCM				0x300
>   #define SMI_DUMMY			0x444
> 
> +#define SMI_COMMON_CLAMP_EN		0x3c0
> +#define SMI_COMMON_CLAMP_EN_SET		0x3c4
> +#define SMI_COMMON_CLAMP_EN_CLR		0x3c8
> +
> +#define SMI_SUB_COMM_INPORT_NR		(8)
> +
>   /* SMI LARB */
>   #define SMI_LARB_SLP_CON                0xc
>   #define SLP_PROT_EN                     BIT(0)
> @@ -134,6 +144,7 @@ struct mtk_smi_larb_gen {
>   	unsigned int			larb_direct_to_common_mask;
>   	unsigned int			flags_general;
>   	const u8			(*ostd)[SMI_LARB_PORT_NR_MAX];
> +	const u8			*clamp_port;
>   };
> 
>   struct mtk_smi {
> @@ -150,6 +161,7 @@ struct mtk_smi {
>   };
> 
>   struct mtk_smi_larb { /* larb: local arbiter */
> +	struct device			*dev;
>   	struct mtk_smi			smi;
>   	void __iomem			*base;
>   	struct device			*smi_common_dev; /* common or sub-common dev */
> @@ -157,6 +169,10 @@ struct mtk_smi_larb { /* larb: local arbiter */
>   	int				larbid;
>   	u32				*mmu;
>   	unsigned char			*bank;
> +	struct regmap			*sub_comm_syscon;
> +	u8				sub_comm_inport;
> +	struct notifier_block		nb;
> +	struct reset_control		*rst_con;
>   };
> 
>   static int
> @@ -377,6 +393,19 @@ static const u8 mtk_smi_larb_mt8195_ostd[][SMI_LARB_PORT_NR_MAX] = {
>   	[28] = {0x1a, 0x0e, 0x0a, 0x0a, 0x0c, 0x0e, 0x10,},
>   };
> 
> +static const u8 mtk_smi_larb_clamp_port_mt8188[MTK_LARB_NR_MAX] = {
> +	[9]	= BIT(1), /* larb10 */
> +	[10]	= BIT(2), /* larb11a */
> +	[11]	= BIT(2), /* larb11b */
> +	[12]	= BIT(3), /* larb11c */
> +	[13]	= BIT(0), /* larb12 */
> +	[16]	= BIT(1), /* larb15 */
> +	[17]	= BIT(2), /* larb16a */
> +	[18]	= BIT(2), /* larb16b */
> +	[19]	= BIT(3), /* larb17a */
> +	[20]	= BIT(3), /* larb17b */
> +};
> +
>   static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
>   	.port_in_larb = {
>   		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
> @@ -423,6 +452,7 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8188 = {
>   	.flags_general	            = MTK_SMI_FLAG_THRT_UPDATE | MTK_SMI_FLAG_SW_FLAG |
>   				      MTK_SMI_FLAG_SLEEP_CTL | MTK_SMI_FLAG_CFG_PORT_SEC_CTL,
>   	.ostd		            = mtk_smi_larb_mt8188_ostd,
> +	.clamp_port                 = mtk_smi_larb_clamp_port_mt8188,
>   };
> 
>   static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
> @@ -472,6 +502,46 @@ static void mtk_smi_larb_sleep_ctrl_disable(struct mtk_smi_larb *larb)
>   	writel_relaxed(0, larb->base + SMI_LARB_SLP_CON);
>   }
> 
> +static int mtk_smi_larb_clamp_protect_enable(struct device *dev, bool enable)
> +{
> +	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +	u32 reg;
> +	int ret;
> +
> +	/* sub_comm_syscon could be NULL if larb directly linked to SMI common */
> +	if (!larb->sub_comm_syscon)
> +		return -EINVAL;
> +
> +	reg = enable ? SMI_COMMON_CLAMP_EN_SET : SMI_COMMON_CLAMP_EN_CLR;
> +
> +	ret = regmap_write(larb->sub_comm_syscon, reg,
> +			   larb->sub_comm_inport);
> +	if (ret)
> +		dev_err(dev, "Unable to %s clamp for input port %d: %d\n",
> +			enable ? "enable" : "disable",
> +			larb->sub_comm_inport, ret);
> +
> +	return ret;
> +}
> +
> +static int mtk_smi_genpd_callback(struct notifier_block *nb,
> +				  unsigned long flags, void *data)
> +{
> +	struct mtk_smi_larb *larb = container_of(nb, struct mtk_smi_larb, nb);
> +	struct device *dev = larb->dev;
> +
> +	if (flags == GENPD_NOTIFY_PRE_ON || flags == GENPD_NOTIFY_PRE_OFF) {
> +		/* disable related SMI sub-common port */
> +		mtk_smi_larb_clamp_protect_enable(dev, true);
> +	} else if (flags == GENPD_NOTIFY_ON) {
> +		/* enable related SMI sub-common port */
> +		reset_control_reset(larb->rst_con);
> +		mtk_smi_larb_clamp_protect_enable(dev, false);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
>   static int mtk_smi_device_link_common(struct device *dev, struct device **com_dev)
>   {
>   	struct platform_device *smi_com_pdev;
> @@ -528,6 +598,53 @@ static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
>   	return ret;
>   }
> 
> +static int mtk_smi_larb_parse_clamp_optional(struct mtk_smi_larb *larb)
> +{
> +	struct device *dev = larb->dev;
> +	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> +	u32 larb_id;
> +	int ret;
> +
> +	/**
> +	 * Only SMI LARBs in camera, image and IPE subsys need to
> +	 * apply clamp and reset operations, others can be skipped.
> +	 */
> +	ret = of_property_read_u32(dev->of_node, "mediatek,larb-id", &larb_id);
> +	if (ret)
> +		return -EINVAL;
> +	if (!larb_gen->clamp_port || !larb_gen->clamp_port[larb_id])
> +		return 0;
> +
> +	larb->sub_comm_inport = larb_gen->clamp_port[larb_id];
> +	larb->sub_comm_syscon = syscon_regmap_lookup_by_phandle(dev->of_node,
> +								"mediatek,smi");
> +	if (IS_ERR(larb->sub_comm_syscon)) {
> +		larb->sub_comm_syscon = NULL;
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Unknown clamp port for larb %d\n", larb_id);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_smi_larb_parse_reset_optional(struct mtk_smi_larb *larb)
> +{
> +	struct device *dev = larb->dev;
> +	int ret;
> +
> +	larb->rst_con = devm_reset_control_get_optional_exclusive(dev, "larb");
> +	if (!larb->rst_con)
> +		return 0;
> +
> +	larb->nb.notifier_call = mtk_smi_genpd_callback;
> +	ret = dev_pm_genpd_add_notifier(dev, &larb->nb);
> +	if (ret)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Failed to add genpd callback %d\n", ret);
> +
> +	return 0;
> +}
> +
>   static int mtk_smi_larb_probe(struct platform_device *pdev)
>   {
>   	struct mtk_smi_larb *larb;
> @@ -538,6 +655,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>   	if (!larb)
>   		return -ENOMEM;
> 
> +	larb->dev = dev;
>   	larb->larb_gen = of_device_get_match_data(dev);
>   	larb->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(larb->base))
> @@ -554,15 +672,24 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		return ret;
> 
> -	pm_runtime_enable(dev);
> +	ret = mtk_smi_larb_parse_clamp_optional(larb);
> +	if (ret)
> +		goto err_link_remove;
> +
> +	ret = mtk_smi_larb_parse_reset_optional(larb);
> +	if (ret)
> +		goto err_link_remove;
> +

To avoid changing functionality, please call pm_runtime_enable() here, before
component_add().

If you want to remove the goto, you could (please do it!) instead call
devm_pm_runtime_enable() and error check.

Everything else looks good!

Cheers,
Angelo

>   	platform_set_drvdata(pdev, larb);
>   	ret = component_add(dev, &mtk_smi_larb_component_ops);
>   	if (ret)
> -		goto err_pm_disable;
> +		goto err_link_remove;
> +
> +	pm_runtime_enable(dev);
> +
>   	return 0;
> 
> -err_pm_disable:
> -	pm_runtime_disable(dev);
> +err_link_remove:
>   	device_link_remove(dev, larb->smi_common_dev);
>   	return ret;
>   }
> @@ -686,6 +813,11 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8188_vpp = {
>   	.init     = mtk_smi_common_mt8195_init,
>   };
> 
> +static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8188 = {
> +	.type     = MTK_SMI_GEN2_SUB_COMM,
> +	.has_gals = true,
> +};
> +
>   static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
>   	.type     = MTK_SMI_GEN2,
>   	.has_gals = true,
> @@ -729,6 +861,7 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
>   	{.compatible = "mediatek,mt8186-smi-common", .data = &mtk_smi_common_mt8186},
>   	{.compatible = "mediatek,mt8188-smi-common-vdo", .data = &mtk_smi_common_mt8188_vdo},
>   	{.compatible = "mediatek,mt8188-smi-common-vpp", .data = &mtk_smi_common_mt8188_vpp},
> +	{.compatible = "mediatek,mt8188-smi-sub-common", .data = &mtk_smi_sub_common_mt8188},
>   	{.compatible = "mediatek,mt8192-smi-common", .data = &mtk_smi_common_mt8192},
>   	{.compatible = "mediatek,mt8195-smi-common-vdo", .data = &mtk_smi_common_mt8195_vdo},
>   	{.compatible = "mediatek,mt8195-smi-common-vpp", .data = &mtk_smi_common_mt8195_vpp},
> --
> 2.46.0
> 



