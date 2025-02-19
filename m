Return-Path: <linux-kernel+bounces-521512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B584A3BE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57777169D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FC81E0B61;
	Wed, 19 Feb 2025 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mV2BD9Hx"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCC41D5AC0;
	Wed, 19 Feb 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968678; cv=none; b=We3T4xTW04zJTB3dtgGv1GDN9iIAsB+fd1sL+J19zSm/+QpCrnQnWMDcKzZV7CrdBk13aXSa+ZHFxE/yvJQBK5OAywUv6TpPvhA8vPpgb74VCEypwHjrjakoYXhSXugouho9J3zmMBotELCRdTTxtRpKITrO063gccd/UENxJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968678; c=relaxed/simple;
	bh=yWQBctTmTYw2F6D0YrO+rF/Gn/2V69KKlL8m0tLUKc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0TLwmlU5F2uNbPI3dP+yT0wlAcDsD5BU3nKz0IICLtabd1oiEORwWWWQIQ50eTDFCGENcaz5BZURwqinb7j9zf0rjs8xlgu01ytBvByHSWt+4ZJf18zRYmFmdzWPEDuvyAFvVrtG4wbItzJ0tnAm/DuRQLHnRIw5TW/5CX13IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mV2BD9Hx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739968673;
	bh=yWQBctTmTYw2F6D0YrO+rF/Gn/2V69KKlL8m0tLUKc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mV2BD9Hxs36pOHX9FkZKfw+gQIuDnAd4bvjf8XtdSJvkyBEam5NsrQaAQl8M6WZgC
	 JYbwtlfxCcVCkQu1WD/vt4IOre8mbxHr3t6jwauve4CZr8UM6SEXmzeu9YgAOdHmHO
	 BUAUTvFJgAaN0yO05kunUr334Z+pKxln4ayffgJcZFjdwZNFwWLevzZNOa96gI776B
	 1iDhSr8QZGx6k+IrJNi1kQmWmcrp/OHnbUxAhpj889/coeYv0tsuI6EnNH0JeoqAcZ
	 7Fw2wINiqcbO5APmPZao8MXM8aRy6T31tllsqCZ4rCcXdZmMgmhnVE0xla5gKwBIku
	 1325lknngshbA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7BB7C17E154A;
	Wed, 19 Feb 2025 13:37:52 +0100 (CET)
Message-ID: <c72a8643-4211-40e1-a64d-6bf3c69bcae1@collabora.com>
Date: Wed, 19 Feb 2025 13:37:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drm/mediatek: Add TDSHP component support for MT8196
To: Jay Liu <jay.liu@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>,
 CK Hu <ck.hu@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250219092040.11227-1-jay.liu@mediatek.com>
 <20250219092040.11227-4-jay.liu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250219092040.11227-4-jay.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/02/25 10:20, Jay Liu ha scritto:
> Add TDSHP component support for MT8196.
> TDSHP is a hardware module designed to enhance the sharpness and
> clarity of displayed images by analyzing and improving edges and
> fine details in frames.
> 
> Signed-off-by: Jay Liu <jay.liu@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_ddp_comp.c | 58 +++++++++++++++++++++++++
>   drivers/gpu/drm/mediatek/mtk_ddp_comp.h |  1 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  2 +
>   3 files changed, 61 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
> index d7e230bac53e..b87fde64ee49 100644
> --- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
> @@ -57,6 +57,16 @@
>   #define POSTMASK_RELAY_MODE				BIT(0)
>   #define DISP_REG_POSTMASK_SIZE			0x0030
>   
> +#define DISP_REG_TDSHP_EN			0x0000
> +#define DISP_TDSHP_TDS_EN			BIT(31)
> +#define DISP_REG_TDSHP_CTRL			0x0100
> +#define DISP_TDSHP_CTRL_EN			BIT(0)
> +#define DISP_TDSHP_PWR_SCL_EN			BIT(2)
> +#define DISP_REG_TDSHP_CFG			0x0110

#define TDSHP_RELAY_MODE	BIT(0)

> +#define DISP_REG_TDSHP_INPUT_SIZE		0x0120
> +#define DISP_REG_TDSHP_OUTPUT_OFFSET		0x0124
> +#define DISP_REG_TDSHP_OUTPUT_SIZE		0x0128
> +
>   #define DISP_REG_UFO_START			0x0000
>   #define UFO_BYPASS				BIT(2)
>   
> @@ -261,6 +271,44 @@ static void mtk_postmask_stop(struct device *dev)
>   	writel_relaxed(0x0, priv->regs + DISP_REG_POSTMASK_EN);
>   }
>   
> +static void mtk_disp_tdshp_config(struct device *dev, unsigned int w,
> +				  unsigned int h, unsigned int vrefresh,
> +				  unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> +{
> +	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
> +	u32 tdshp_ctrl = (bpc == 8) ? DISP_TDSHP_PWR_SCL_EN | DISP_TDSHP_CTRL_EN : 0;
> +
> +	mtk_ddp_write(cmdq_pkt, tdshp_ctrl, &priv->cmdq_reg, priv->regs,
> +		      DISP_REG_TDSHP_CTRL);
> +
> +	mtk_ddp_write(cmdq_pkt, w << 16 | h, &priv->cmdq_reg, priv->regs,
> +		      DISP_REG_TDSHP_INPUT_SIZE);
> +	mtk_ddp_write(cmdq_pkt, w << 16 | h, &priv->cmdq_reg, priv->regs,
> +		      DISP_REG_TDSHP_OUTPUT_SIZE);
> +	mtk_ddp_write(cmdq_pkt, 0x0, &priv->cmdq_reg, priv->regs,
> +		      DISP_REG_TDSHP_OUTPUT_OFFSET);
> +
> +	mtk_ddp_write(cmdq_pkt, 0x1, &priv->cmdq_reg,

mtk_ddp_write(cmdq_pkt, TDSHP_RELAY_MODE, ... etc etc

> +		      priv->regs, DISP_REG_TDSHP_CFG);
> +
> +	mtk_ddp_write_mask(cmdq_pkt, DISP_TDSHP_TDS_EN, &priv->cmdq_reg, priv->regs,
> +			   DISP_REG_TDSHP_EN, DISP_TDSHP_TDS_EN);
> +}
> +
> +static void mtk_disp_tdshp_start(struct device *dev)
> +{
> +	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
> +
> +	writel(DISP_TDSHP_CTRL_EN, priv->regs + DISP_REG_TDSHP_CTRL);
> +}
> +
> +static void mtk_disp_tdshp_stop(struct device *dev)
> +{
> +	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
> +
> +	writel(0x0, priv->regs + DISP_REG_TDSHP_CTRL);

writel(0, priv->regs + DISP_REG_TDSHP_CTRL);

> +}
> +

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



