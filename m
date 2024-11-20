Return-Path: <linux-kernel+bounces-415694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25389D3A15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54BC5B2A420
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BBE1A2567;
	Wed, 20 Nov 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c0XuMoN3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13D1A0BED;
	Wed, 20 Nov 2024 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103401; cv=none; b=cEs96iqEoq0IyTmGxZ/LiQcSI37Br543HMnLC71Ehyj1tew1YpXdalIvSVwM9VrLbuTrASUyJ2CCybeytTWbG94uau3Jt9Lc+aZae9CUfTfRoZN3Bx2EeFlePvm5aljYmRJT8WsWOruL2eb1IJ1ySjFTEWfA6+AK/KkfMvOlwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103401; c=relaxed/simple;
	bh=JbVhUtQoKVg89Tsfa9Ry4aZkEgusELoLUSeDUejcENk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFSG902eIJcQCc1o9yfVbLhJ4Pu6DlTSEkfnSxu8OxAt3xOEDJcN/lfTCOp/RfGW3qZfkSQyN94Y/mUAgTc3wmkilcLV3Rcz4du2r2J5xFRBekPOMZj8WoF/VtH1jr6Sx5f3v/MOPw1xA6EHho4x7N8LStJrsvqMmdD0ySUQF+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c0XuMoN3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732103396;
	bh=JbVhUtQoKVg89Tsfa9Ry4aZkEgusELoLUSeDUejcENk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c0XuMoN3Cyu1rTyR06g651e9hHrLWtE/+NH614uMOD1VnfLYtZ8isi8gx5Bm0LJZl
	 mpIbVBSICMNcvsiRHD7Tk0ytPXyJH3pSzPYq3avtY0Y4W3WbEOxDpBq/kt6lBCFa0/
	 erAjZS3md7iC2ktoMzZZMiDc7JYgNyZGSzi5DjIAahrvpm78ob6fI6bZwcXYdiTLjI
	 rykXIYMncptLr5bt8VR+d4R0z/3df3CdCuLg2q2VLjOchCd9jMA2dV1WjjzRU8/b6m
	 yXMex9UmupDRKz6yvLM6cCmPHxI8xd87NRCwsEognwNNeXUDtZGn8DbGu09M4qRd1k
	 Kvf1bsvLOcQ8w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EDFF017E3631;
	Wed, 20 Nov 2024 12:49:55 +0100 (CET)
Message-ID: <e32620d5-48f9-4290-9a5e-2d3e3eed0dfa@collabora.com>
Date: Wed, 20 Nov 2024 12:49:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] memory: mtk-smi: mt8188: Add SMI clamp function
To: Friday Yang <friday.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241120063701.8194-1-friday.yang@mediatek.com>
 <20241120063701.8194-3-friday.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241120063701.8194-3-friday.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/11/24 07:36, Friday Yang ha scritto:
> In order to avoid handling glitch signal when MTCMOS on/off, SMI need
> clamp and reset operation. Parse power reset settings for LARBs which
> need to reset. Register genpd callback for SMI LARBs and apply reset
> operations in the callback.
> 
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>
> ---
>   drivers/memory/mtk-smi.c | 175 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 171 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 2bc034dff691..c7119f655350 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -10,15 +10,21 @@
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
> +#include <linux/reset-controller.h>
>   #include <linux/soc/mediatek/mtk_sip_svc.h>
>   #include <soc/mediatek/smi.h>
>   #include <dt-bindings/memory/mt2701-larb-port.h>
>   #include <dt-bindings/memory/mtk-memory-port.h>
> +#include <dt-bindings/reset/mt8188-resets.h>
>   
>   /* SMI COMMON */
>   #define SMI_L1LEN			0x100
> @@ -36,6 +42,13 @@
>   #define SMI_DCM				0x300
>   #define SMI_DUMMY			0x444
>   
> +#define SMI_COMMON_CLAMP_EN		0x3c0
> +#define SMI_COMMON_CLAMP_EN_SET		0x3c4
> +#define SMI_COMMON_CLAMP_EN_CLR		0x3c8
> +#define SMI_COMMON_CLAMP_MASK(inport)	BIT(inport)
> +
> +#define SMI_SUB_COMM_INPORT_NR		(8)
> +
>   /* SMI LARB */
>   #define SMI_LARB_SLP_CON                0xc
>   #define SLP_PROT_EN                     BIT(0)
> @@ -134,6 +147,7 @@ struct mtk_smi_larb_gen {
>   	unsigned int			larb_direct_to_common_mask;
>   	unsigned int			flags_general;
>   	const u8			(*ostd)[SMI_LARB_PORT_NR_MAX];
> +	const u8			*clamp_port;
>   };
>   
>   struct mtk_smi {
> @@ -150,6 +164,7 @@ struct mtk_smi {
>   };
>   
>   struct mtk_smi_larb { /* larb: local arbiter */
> +	struct device			*dev;
>   	struct mtk_smi			smi;
>   	void __iomem			*base;
>   	struct device			*smi_common_dev; /* common or sub-common dev */
> @@ -157,6 +172,10 @@ struct mtk_smi_larb { /* larb: local arbiter */
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
> @@ -377,6 +396,19 @@ static const u8 mtk_smi_larb_mt8195_ostd[][SMI_LARB_PORT_NR_MAX] = {
>   	[28] = {0x1a, 0x0e, 0x0a, 0x0a, 0x0c, 0x0e, 0x10,},
>   };
>   
> +static const u8 mtk_smi_larb_clamp_port_mt8188[] = {

You can just set these to BIT(x) directly, like:

	[MT8188_SMI_RST_LARB10] = BIT(0),

so that you can check if there's actually a supported/valid clamp port in function
mtk_smi_larb_parse_clamp_info() - check below for comments in that function.

Note that you are declaring SMI_SUB_COMM_INPORT_NR = 8 and this means that there
are a maximum of 8 ports, with each port having its own BIT, starting from BIT 0
and ending at BIT 7 (so [7:0]).

This means that we have a maximum of 8 bits here, so even if you assign BIT(x) it
all still fits in a u8! :-)

> +	[MT8188_SMI_RST_LARB10]		= 1,
> +	[MT8188_SMI_RST_LARB11A]	= 2,
> +	[MT8188_SMI_RST_LARB11C]	= 3,
> +	[MT8188_SMI_RST_LARB12]		= 0,
> +	[MT8188_SMI_RST_LARB11B]	= 2,
> +	[MT8188_SMI_RST_LARB15]		= 1,
> +	[MT8188_SMI_RST_LARB16B]	= 2,
> +	[MT8188_SMI_RST_LARB17B]	= 3,
> +	[MT8188_SMI_RST_LARB16A]	= 2,
> +	[MT8188_SMI_RST_LARB17A]	= 3,
> +};
> +
>   static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
>   	.port_in_larb = {
>   		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
> @@ -423,6 +455,7 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8188 = {
>   	.flags_general	            = MTK_SMI_FLAG_THRT_UPDATE | MTK_SMI_FLAG_SW_FLAG |
>   				      MTK_SMI_FLAG_SLEEP_CTL | MTK_SMI_FLAG_CFG_PORT_SEC_CTL,
>   	.ostd		            = mtk_smi_larb_mt8188_ostd,
> +	.clamp_port                 = mtk_smi_larb_clamp_port_mt8188,
>   };
>   
>   static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
> @@ -472,6 +505,60 @@ static void mtk_smi_larb_sleep_ctrl_disable(struct mtk_smi_larb *larb)
>   	writel_relaxed(0, larb->base + SMI_LARB_SLP_CON);
>   }
>   
> +static int mtk_smi_larb_clamp_protect_enable(struct device *dev)
> +{
> +	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* sub_comm_syscon could be NULL if larb directly linked to SMI common */
> +	if (!larb->sub_comm_syscon)
> +		return -EINVAL;
> +
> +	ret = regmap_write(larb->sub_comm_syscon, SMI_COMMON_CLAMP_EN_SET,
> +			   SMI_COMMON_CLAMP_MASK(larb->sub_comm_inport));
> +	if (ret)
> +		dev_err(dev, "Unable to enable clamp, inport %d, ret %d\n",
> +			larb->sub_comm_inport, ret);
> +
> +	return ret;
> +}
> +
> +static int mtk_smi_larb_clamp_protect_disble(struct device *dev)

typo: mtk_smi_larb_clamp_protect_disable

> +{
> +	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* sub_comm_syscon could be NULL if larb directly linked to SMI common */
> +	if (!larb->sub_comm_syscon)
> +		return -EINVAL;
> +
> +	ret = regmap_write(larb->sub_comm_syscon, SMI_COMMON_CLAMP_EN_CLR,
> +			   SMI_COMMON_CLAMP_MASK(larb->sub_comm_inport));
> +	if (ret)
> +		dev_err(dev, "Unable to disable clamp, inport %d, ret %d\n",
> +			larb->sub_comm_inport, ret);
> +
> +	return ret;
> +}

...but anyway, I would rather do it like that:

static int mtk_smi_larb_clamp_protect_enable(struct device *dev, bool enable)
{
	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
	u32 reg;
	int ret;

	/* sub_comm_syscon could be NULL if larb directly linked to SMI common */
	if (!larb->sub_comm_syscon)
		return -EINVAL;

	reg = enable ? SMI_COMMON_CLAMP_EN_SET : SMI_COMMON_CLAMP_EN_CLR;

	ret = regmap_write(larb->sub_comm_syscon, reg,
			   SMI_COMMON_CLAMP_MASK(larb->sub_comm_inport));
	if (ret) {
		dev_err(dev, "Unable to %s clamp for input port %d: %d\n",
			enable ? "enable" : "disable",
			larb->sub_comm_inport, ret);
		return ret;
	}

	return 0;
}

...and then call it like
ret = mtk_smi_larb_clamp_protect_enable(dev, true);

or

ret = mtk_smi_larb_clamp_protect_enable(dev, false);

> +
> +static int mtk_smi_genpd_callback(struct notifier_block *nb,
> +				  unsigned long flags, void *data)
> +{
> +	struct mtk_smi_larb *larb = container_of(nb, struct mtk_smi_larb, nb);
> +	struct device *dev = larb->dev;
> +
> +	if (flags == GENPD_NOTIFY_PRE_ON || flags == GENPD_NOTIFY_PRE_OFF) {
> +		/* disable related SMI sub-common port */
> +		mtk_smi_larb_clamp_protect_enable(dev);
> +	} else if (flags == GENPD_NOTIFY_ON) {
> +		/* enable related SMI sub-common port */
> +		reset_control_reset(larb->rst_con);
> +		mtk_smi_larb_clamp_protect_disble(dev);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
>   static int mtk_smi_device_link_common(struct device *dev, struct device **com_dev)
>   {
>   	struct platform_device *smi_com_pdev;
> @@ -528,6 +615,66 @@ static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
>   	return ret;
>   }
>   
> +static int mtk_smi_larb_parse_clamp_info(struct mtk_smi_larb *larb)
> +{
> +	struct device *dev = larb->dev;
> +	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> +	struct device_node *smi_node;
> +	struct of_phandle_args args;
> +	int ret, index;
> +
> +	/* Only SMI LARBs located in camera and image subsys need to
> +	 * apply clamp and reset operation, others can be skipped.
> +	 */
> +	ret = of_parse_phandle_with_fixed_args(dev->of_node,
> +					       "resets", 1, 0, &args);
> +	if (ret)
> +		return 0;
> +
> +	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
> +	if (!smi_node)
> +		return -EINVAL;
> +
> +	index = args.args[0];
> +	larb->sub_comm_inport = larb_gen->clamp_port[index];
> +	larb->sub_comm_syscon = device_node_to_regmap(smi_node);
> +	of_node_put(smi_node);

If you declare BIT(x) as clamp_ports, or if your clamp_ports start from 1,
anything that is not more than 0 is something that was not declared, and
this means that you can then error check:

if (!larb->sub_comm_inport)
	return dev_err_probe(dev, -EINVAL, "Unknown clamp port for larb %d\n", index);

> +
> +	if (IS_ERR(larb->sub_comm_syscon) ||
> +	    larb->sub_comm_inport >= SMI_SUB_COMM_INPORT_NR) {
> +		larb->sub_comm_syscon = NULL;
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_smi_larb_parse_reset_info(struct mtk_smi_larb *larb)
> +{
> +	struct device *dev = larb->dev;
> +	int ret;
> +
> +	/* Only SMI LARBs located in camera and image subsys need to
> +	 * apply clamp and reset operation, others can be skipped.
> +	 */
> +	if (!of_find_property(dev->of_node, "resets", NULL))
> +		return 0;

You don't have to manually check whether 'resets' exists or not - that's already
done (devm_)reset_control_get in a way, as that will return -ENOENT if there is
no 'reset-names' property. Check the comments down there....

> +
> +	larb->rst_con = devm_reset_control_get(dev, "larb");
> +	if (IS_ERR(larb->rst_con))
> +		return dev_err_probe(dev, PTR_ERR(larb->rst_con),
> +				     "Can not get larb reset controller\n");
> +
> +	larb->nb.notifier_call = mtk_smi_genpd_callback;
> +	ret = dev_pm_genpd_add_notifier(dev, &larb->nb);
> +	if (ret) {
> +		dev_err(dev, "Failed to add genpd callback %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   static int mtk_smi_larb_probe(struct platform_device *pdev)
>   {
>   	struct mtk_smi_larb *larb;
> @@ -538,6 +685,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>   	if (!larb)
>   		return -ENOMEM;
>   
> +	larb->dev = dev;
>   	larb->larb_gen = of_device_get_match_data(dev);
>   	larb->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(larb->base))
> @@ -554,15 +702,29 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		return ret;
>   
> -	pm_runtime_enable(dev);

	ret = mtk_smi_larb_parse_reset_optional(larb);

Choose between:

	if (ret == 0) {
		ret = mtk_smi_larb_parse_smi_clamp(larb);
		if (ret) {
			dev_err_probe(dev, ret, "Failed to get SMI clamp\n");
			goto err_link_remove;
		}
	} else if (ret != -ENOENT) {
		dev_err_probe(dev, ret, "Cannot get larb resets\n");
		goto err_link_remove;
	} else {
		/*
		 * Only SMI LARBs located in camera and image subsys need to apply
		 * clamp and reset operation. For the others, resets are optional.
		 */
		ret = 0;
	}

and...

	if (ret && ret != -ENOENT) {
		dev_err_probe .....
	} else if (ret) {
		/* only smi larbs .... */
		ret = 0;
	} else {
		ret = mtk_smi_larb_parse_smi_clamp .....
	}

whatever you like the most.

> +	/* find sub common to clamp larb for ISP software reset */
> +	ret = mtk_smi_larb_parse_clamp_info(larb);
> +	if (ret) {
> +		dev_err(dev, "Failed to get clamp setting for larb\n");
> +		goto err_link_remove;
> +	}
> +
> +	ret = mtk_smi_larb_parse_reset_info(larb);
> +	if (ret) {
> +		dev_err(dev, "Failed to get power setting for larb\n");
> +		goto err_link_remove;
> +	}
> +
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
> @@ -686,6 +848,10 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8188_vpp = {
>   	.init     = mtk_smi_common_mt8195_init,
>   };
>   
> +static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8188 = {
> +	.type     = MTK_SMI_GEN2_SUB_COMM,

...no gals in MT8188?!

Cheers,
Angelo

> +};
> +
>   static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
>   	.type     = MTK_SMI_GEN2,
>   	.has_gals = true,
> @@ -729,6 +895,7 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
>   	{.compatible = "mediatek,mt8186-smi-common", .data = &mtk_smi_common_mt8186},
>   	{.compatible = "mediatek,mt8188-smi-common-vdo", .data = &mtk_smi_common_mt8188_vdo},
>   	{.compatible = "mediatek,mt8188-smi-common-vpp", .data = &mtk_smi_common_mt8188_vpp},
> +	{.compatible = "mediatek,mt8188-smi-sub-common", .data = &mtk_smi_sub_common_mt8188},
>   	{.compatible = "mediatek,mt8192-smi-common", .data = &mtk_smi_common_mt8192},
>   	{.compatible = "mediatek,mt8195-smi-common-vdo", .data = &mtk_smi_common_mt8195_vdo},
>   	{.compatible = "mediatek,mt8195-smi-common-vpp", .data = &mtk_smi_common_mt8195_vpp},



