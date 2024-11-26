Return-Path: <linux-kernel+bounces-422031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D55F9D9394
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4860284888
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD89F1B21AD;
	Tue, 26 Nov 2024 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R3YB630q"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5DF13C3F6;
	Tue, 26 Nov 2024 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611060; cv=none; b=SFaIUz0BNJD/0rfAbYIdao8H+k1uAXcB8SPXgLCLx2zfuFkQnTVwTkXYuM4LZN6+N/AvPBLSDQmOoisd4KrJ89KgdLt1OzgU53yMXGcjl6HBej1C3OUrKmrmhHHVEA3gum31mIRcuEbjqY5jaPW8j233xHmpyi3BqnTT7wg8MyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611060; c=relaxed/simple;
	bh=DD5KEenRbXh7Urnj+j3PXHTTd/zkE780TJdzO7LND4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOPfNhX/PI6i8E59AQwndGhzIgF5BuDbgt4kRQVWXdhu3rFW0s0GP2LSadTv/ui3ngVdYDsGXNRrFluGv1uEFveOD8zRfHNIlc7CnP/Mb3ggLf01U+lGOSEFpztWCFxwKDJojJM8UgIBc4d7n2oOVnrZpPSbAg/bTDBGjdq0Jgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R3YB630q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732611055;
	bh=DD5KEenRbXh7Urnj+j3PXHTTd/zkE780TJdzO7LND4g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R3YB630qDaKpg13hc2Fa8pIP0ESyLbSrMeq6oa807g0qeYitRqkUhKZQUHW4DS64Y
	 iuU9pSA5RXq46QwZC+ZiHKfpPOMe94mnU3DgZkiz3LjlfBXYbRzSd3KmIKK0PUQT4n
	 M/vLZ4+guHcLr2Z8pChR203Qf5WxNisjomoKpmQCWLB6H72fuGISBrPIVgoNB272Mz
	 whnfGiqH4Mz6pxTz8Vn5xYbpWgeRTfPY6Y31F2W0QzPxwl+TZzAbIHKhUc1NPMcvZm
	 1StzofXNG6p5n8gbrkbSDWmp1xIE6VUbXuylmFqERJU87YNahNd5MFFGctyii9bCIi
	 rLty49tFonm4A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5B8AA17E1366;
	Tue, 26 Nov 2024 09:50:55 +0100 (CET)
Message-ID: <207f9e96-3165-440d-8576-545bf2bc9dee@collabora.com>
Date: Tue, 26 Nov 2024 09:50:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: mtk-xhci: add support remote wakeup of mt8196
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Mathias Nyman <mathias.nyman@intel.com>,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241126025507.29605-1-chunfeng.yun@mediatek.com>
 <20241126025507.29605-2-chunfeng.yun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241126025507.29605-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/11/24 03:55, Chunfeng Yun ha scritto:
> There are 2 USB controllers on mt8196, each controller's wakeup control is
> different, add some specific versions for them.
> 

Is there any MTU3 controller in MT8196, like all other MediaTek SoCs?

If so, then please just add the wakeup control to the MTU3 driver, otherwise
we are going to duplicate this for yet another SoC, like we've done for MT8192,
MT8195, MT8188 and MT8186 already...

Cheers,
Angelo

> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   drivers/usb/host/xhci-mtk.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index 3252e3d2d79c..31223912b0b4 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -113,6 +113,12 @@
>   #define WC1_IS_P_95		BIT(12)
>   #define WC1_IS_EN_P0_95		BIT(6)
>   
> +/* mt8196 */
> +#define PERI_WK_CTRL0_8196	0x08
> +#define UWK_V1_7_CTRL2_MASK	0x5
> +
> +#define WCP1_IS_EN		BIT(7) /* port1 en bit */
> +
>   /* mt2712 etc */
>   #define PERI_SSUSB_SPM_CTRL	0x0
>   #define SSC_IP_SLEEP_EN	BIT(4)
> @@ -129,6 +135,8 @@ enum ssusb_uwk_vers {
>   	SSUSB_UWK_V1_4,		/* mt8195 IP1 */
>   	SSUSB_UWK_V1_5,		/* mt8195 IP2 */
>   	SSUSB_UWK_V1_6,		/* mt8195 IP3 */
> +	SSUSB_UWK_V1_7,		/* mt8196 IP0 */
> +	SSUSB_UWK_V1_8,		/* mt8196 IP1 */
>   };
>   
>   /*
> @@ -381,6 +389,16 @@ static void usb_wakeup_ip_sleep_set(struct xhci_hcd_mtk *mtk, bool enable)
>   		msk = WC0_IS_EN_P3_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
>   		val = enable ? (WC0_IS_EN_P3_95 | WC0_IS_C_95(0x1)) : 0;
>   		break;
> +	case SSUSB_UWK_V1_7:
> +		reg = mtk->uwk_reg_base + PERI_WK_CTRL0_8196;
> +		msk = UWK_V1_7_CTRL2_MASK;
> +		val = enable ? msk : 0;
> +		break;
> +	case SSUSB_UWK_V1_8:
> +		reg = mtk->uwk_reg_base + PERI_WK_CTRL0_8196;
> +		msk = WCP1_IS_EN;
> +		val = enable ? msk : 0;
> +		break;
>   	case SSUSB_UWK_V2:
>   		reg = mtk->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
>   		msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;




