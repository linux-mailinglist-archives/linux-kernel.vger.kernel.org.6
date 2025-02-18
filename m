Return-Path: <linux-kernel+bounces-518933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5428A39670
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C793A867E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7164822FADE;
	Tue, 18 Feb 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WTYsTaJL"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B1622F144;
	Tue, 18 Feb 2025 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869037; cv=none; b=Z1Hx6H5V4ibTjOCUbWI5+Do8+4d1fKYctNzA00QfWoHUgk5tKLDd5WxDubktrFT4ooSW0TFoTUYbTvfPjQ56WxvBMCh0HfCopd9kzrDbQCEEKmuPM9tj0ZVuRJNZJmB66WJNLcTOMAUSG/zxR9GHPks0eW1XBdgVDj12JjwRnng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869037; c=relaxed/simple;
	bh=SquZsIzoLNV/ScddoBqqYtNvHls6hV/j6HdDoLuHReA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RynYZnrU+zPy8GxAeMtjVME4xmfeRqCxBvBB0QQ5BwyCgStYsnMai0t40c5gHrE7XnjHvA9Lj24c/v0DHmGGfNp0InxYiJiv/1iAFOepVRHLe9U906vby7mqJ8AZGNWn3HBVORD2FdjuxcGfnctdOlFwjAxUx7Mps3z8HzAHyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WTYsTaJL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739869032;
	bh=SquZsIzoLNV/ScddoBqqYtNvHls6hV/j6HdDoLuHReA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WTYsTaJLxwvClHM0Xq6WIHtoyBSL4dL6tezkvyILCOs1tgmLcLlY4r/j9KnkN/GfU
	 wAZbYFsYZl3SjAqw7eRPmNjPD3WTu581lgBWZPqr65DpRKadXDpYfJffKo27Dw+VbA
	 /SY/EmUjFZzmIjAr68nXCFld45VGRO9aWZnhEpamVGGuna+O5OVXs7yv+v0grFiAna
	 yHUOakkZCarmgwOSwrbQLJugGJ9VOLuViJ9iUM2F1sH8IG6Blbxc80wnIS0KqAuEqT
	 ZBVWtYmIkek5ttyiLDW/06u8OmyAkrifsoCjXRu09bmYoDgFvHNY2X5yVRktYPAnbj
	 TSb3zfHDyOx9g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B63B517E0E8E;
	Tue, 18 Feb 2025 09:57:11 +0100 (CET)
Message-ID: <dac4879c-4354-40bb-91f3-3e7e4eb98c44@collabora.com>
Date: Tue, 18 Feb 2025 09:57:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] usb: mtu3: add support remote wakeup of mt8196
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
 <20250215100615.808-4-chunfeng.yun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250215100615.808-4-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/02/25 11:06, Chunfeng Yun ha scritto:
> There are three USB controllers on mt8196, each controller's wakeup
> control is different, add some specific versions for them.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> v3: add the ommitted third dual-role controller suggested by Angelo
> v2: add wakeup for dual-role controllers
> ---
>   drivers/usb/mtu3/mtu3_host.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
> index 7c657ea2dabd..8138b3f3096a 100644
> --- a/drivers/usb/mtu3/mtu3_host.c
> +++ b/drivers/usb/mtu3/mtu3_host.c
> @@ -46,6 +46,14 @@
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
> @@ -59,6 +67,9 @@ enum ssusb_uwk_vers {
>   	SSUSB_UWK_V1_3,		/* mt8195 IP0 */
>   	SSUSB_UWK_V1_5 = 105,	/* mt8195 IP2 */
>   	SSUSB_UWK_V1_6,		/* mt8195 IP3 */
> +	SSUSB_UWK_V1_7, 	/* mt8196 IP0 */
> +	SSUSB_UWK_V1_8, 	/* mt8196 IP1 */
> +	SSUSB_UWK_V1_9, 	/* mt8196 IP2 */
>   };
>   
>   /*
> @@ -100,6 +111,21 @@ static void ssusb_wakeup_ip_sleep_set(struct ssusb_mtk *ssusb, bool enable)
>   		msk = WC0_IS_EN_P3_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
>   		val = enable ? (WC0_IS_EN_P3_95 | WC0_IS_C_95(0x1)) : 0;
>   		break;
> +	case SSUSB_UWK_V1_7:
> +		reg = ssusb->uwk_reg_base + PERI_WK_CTRL0_8196;
> +		msk = WC0_IS_EN_P0_96;
> +		val = enable ? msk : 0;
> +		break;
> +	case SSUSB_UWK_V1_8:
> +		reg = ssusb->uwk_reg_base + PERI_WK_CTRL0_8196;
> +		msk = WC0_IS_EN_P1_96;
> +		val = enable ? msk : 0;
> +		break;
> +	case SSUSB_UWK_V1_9:
> +		reg = ssusb->uwk_reg_base + PERI_WK_CTRL1_8196;
> +		msk = WC1_IS_EN_P2_96;
> +		val = enable ? msk : 0;
> +		break;
>   	case SSUSB_UWK_V2:
>   		reg = ssusb->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
>   		msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;



