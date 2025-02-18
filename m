Return-Path: <linux-kernel+bounces-518935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7571A3967B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8150D3A4C46
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3352309AE;
	Tue, 18 Feb 2025 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FERSaw+w"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C822FDE2;
	Tue, 18 Feb 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869041; cv=none; b=oxSw5vEXTWWh92VchL2kLFnHqL2dQi5viX+HeGen0GCu7koz+01lN+DwO+/siRRFNI0TdkEU2OeaUj0rjzGjDFMUraYWBi62dmY/SG0qjExSYxbsBfmTcRJVGtuKQ5avUBUPZjmlIpYgDQiNMiVdHKt6gUmsxkeBlaNF1RO+d9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869041; c=relaxed/simple;
	bh=mhaR2Trnlsu8FfYdF9a/LlPy376WKizOyZDhx/r8OTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVpQxKZHGWlo5juTpeQb+XuGJD76vk8+sgmUefT3BOcDKzVj0wLXCFeRJp9aGKY7+2rBvb3Aooozzt2JoggdQDkqJkJMXwJ723eMQLYsuMs6qBubg9LVQWZhYC+PhySUJK2KdXxEGcREhKIZ+s0x21XhDGggz4w/pMzRf6kpNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FERSaw+w; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739869033;
	bh=mhaR2Trnlsu8FfYdF9a/LlPy376WKizOyZDhx/r8OTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FERSaw+wUWOJgkTZm1leH65FcMticAx2ZDEkReE80eTRzAVt9txumwGUCAKfspNmc
	 C7NTo7l5jcGXmclVLKA82mcoI9NhdambccpMm6NoxeGrBSWIjXXqnJvodIo8Zlqvdl
	 kJGFbw6dkqivDA7MHQDyPm+tbw67VX4q/JFzzS4+N34JS6krZhHcoEgcLtASxkGi/G
	 iN68mETOMiboV58T8sC8CJtWImg/gj+22aU39j2m/hu65ldnzLP2Dlb2c2j84xIcRj
	 YUxcmNcGkgFA191chGVGDoM8uzYl/kdzIonJjEbp9vKidJMvFwWLJfeBNc2Yahw5y3
	 qPgbOc9Auxzgw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 329F417E1562;
	Tue, 18 Feb 2025 09:57:13 +0100 (CET)
Message-ID: <7804ef70-efe7-476b-ae5e-bf665bfb4a47@collabora.com>
Date: Tue, 18 Feb 2025 09:57:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] usb: mtk-xhci: add support remote wakeup of mt8196
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Mathias Nyman <mathias.nyman@intel.com>,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250215100615.808-1-chunfeng.yun@mediatek.com>
 <20250215100615.808-3-chunfeng.yun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250215100615.808-3-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/02/25 11:06, Chunfeng Yun ha scritto:
> There are three USB controllers on mt8196, each controller's wakeup
> control is different, add some specific versions for them.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Since all of the USB controllers of the MT8196 SoC are behind MTU3, and
since the wakeup control for all of them will be handled by the MTU3 driver
and *not* by the xhci-mtk driver....

NACK!

Please drop this commit.

Cheers,
Angelo

> ---
> v3: no changes
> v2: modify marcos name
> ---
>   drivers/usb/host/xhci-mtk.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index 904831344440..3f8e37b25322 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -113,6 +113,14 @@
>   #define WC1_IS_P_95		BIT(12)
>   #define WC1_IS_EN_P0_95		BIT(6)
>   
> +/* mt8196 */
> +#define PERI_WK_CTRL0_8196	0x08
> +#define WC0_IS_EN_P0_96		BIT(0)
> +#define WC0_IS_EN_P1_96		BIT(7)
> +
> +#define PERI_WK_CTRL1_8196	0x10
> +#define WC1_IS_EN_P2_96		BIT(0)
> +
>   /* mt2712 etc */
>   #define PERI_SSUSB_SPM_CTRL	0x0
>   #define SSC_IP_SLEEP_EN	BIT(4)
> @@ -129,6 +137,9 @@ enum ssusb_uwk_vers {
>   	SSUSB_UWK_V1_4,		/* mt8195 IP1 */
>   	SSUSB_UWK_V1_5,		/* mt8195 IP2 */
>   	SSUSB_UWK_V1_6,		/* mt8195 IP3 */
> +	SSUSB_UWK_V1_7,		/* mt8196 IP0 */
> +	SSUSB_UWK_V1_8,		/* mt8196 IP1 */
> +	SSUSB_UWK_V1_9,		/* mt8196 IP2 */
>   };
>   
>   /*
> @@ -381,6 +392,21 @@ static void usb_wakeup_ip_sleep_set(struct xhci_hcd_mtk *mtk, bool enable)
>   		msk = WC0_IS_EN_P3_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
>   		val = enable ? (WC0_IS_EN_P3_95 | WC0_IS_C_95(0x1)) : 0;
>   		break;
> +	case SSUSB_UWK_V1_7:
> +		reg = mtk->uwk_reg_base + PERI_WK_CTRL0_8196;
> +		msk = WC0_IS_EN_P0_96;
> +		val = enable ? msk : 0;
> +		break;
> +	case SSUSB_UWK_V1_8:
> +		reg = mtk->uwk_reg_base + PERI_WK_CTRL0_8196;
> +		msk = WC0_IS_EN_P1_96;
> +		val = enable ? msk : 0;
> +		break;
> +	case SSUSB_UWK_V1_9:
> +		reg = mtk->uwk_reg_base + PERI_WK_CTRL1_8196;
> +		msk = WC1_IS_EN_P2_96;
> +		val = enable ? msk : 0;
> +		break;
>   	case SSUSB_UWK_V2:
>   		reg = mtk->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
>   		msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;




