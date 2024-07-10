Return-Path: <linux-kernel+bounces-247561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5429592D135
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816291C237CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47139189F4D;
	Wed, 10 Jul 2024 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M7N0JbUq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A4824AD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612947; cv=none; b=hUogn5FNYZk6Y17P7p/Qb8C9x5Z7fophyvDz+3KE86NiT4yoE4OQgot2lpKO6M4V1WAgz5z3tGlDPs8FqEYSlyxFk0ZScj0njPnLE7nYXADcLKf5ynY49ipCvF+u/0WSmtvi19d2KHkEEavv8nOBoYLLs0Ts57EW7TMJAguqEoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612947; c=relaxed/simple;
	bh=N5cfTQaboV7BMNjSFWJkZ8/Yiw9vmeDA/9AlCrU3oK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKnuNp3KhRL0DUoXnjE0RxxMAnGQhHf0pza7sk6x9WXK+/LvMtHZz4lPXtK8Lie85Y85cQnHqVwuhbCZK+6ITZBgigDn6Lug3BjsqEKG9k/DHbzNrOvjz3/uDgsk7uma/B9Jrl7Xhlrl9PLWdX4PBjx4jdf6EXoU9eKpsjQ6ocA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=M7N0JbUq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720612944;
	bh=N5cfTQaboV7BMNjSFWJkZ8/Yiw9vmeDA/9AlCrU3oK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M7N0JbUqUZ2vQHTAx3dh9Ud6rzzPLnHVUsgPGi6zrUKhxER+HUuqzuo07vIUVC0tl
	 JNNQ12nb3lIElhmLWwJH5AOdg/FpzaTfTwU6SA8ZrGjgnjF2eVFOmcIjP+OI8ibb/A
	 Xzy70b1LdLTsHwJogNsR6WXpCKgEGKJ1NO1PGNfc7TIPa0mzAUazUDUU1M1W9ODuCs
	 W6uVjDO8j6vZNUY9p7YsJTEFCmInqu6fhNDv0KKRYu42R/Ef5jm1gP/6Z45Dli3tae
	 hmV8L2mwIKtRK3u9aCZA6L+Fsi3rVooVZGRcH2FQnJn9tjN9dCN1nbQ3rkbaHbvqxb
	 QBKfhAawMRoeQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 54DCF3781185;
	Wed, 10 Jul 2024 12:02:23 +0000 (UTC)
Message-ID: <d6517e21-8f6f-44e9-b7ac-93e0860a5e7a@collabora.com>
Date: Wed, 10 Jul 2024 14:02:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] drm/mediatek: Support "Pre-multiplied" blending in
 OVL
To: shawn.sung@mediatek.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>,
 CK Hu <ck.hu@mediatek.com>
References: <20240710-alpha-blending-v3-0-289c187f9c6f@mediatek.com>
 <20240710-alpha-blending-v3-3-289c187f9c6f@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240710-alpha-blending-v3-3-289c187f9c6f@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/07/24 10:52, Hsiao Chien Sung via B4 Relay ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> 
> Support "Pre-multiplied" alpha blending mode on in OVL.
> Before this patch, only the "coverage" mode is supported.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 32 +++++++++++++++++++++++++-------
>   1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index add671c38613..89b439dcf3a6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -56,8 +56,12 @@
>   #define GMC_THRESHOLD_HIGH	((1 << GMC_THRESHOLD_BITS) / 4)
>   #define GMC_THRESHOLD_LOW	((1 << GMC_THRESHOLD_BITS) / 8)
>   
> +#define OVL_CON_CLRFMT_MAN	BIT(23)
>   #define OVL_CON_BYTE_SWAP	BIT(24)
> -#define OVL_CON_MTX_YUV_TO_RGB	(6 << 16)
> +
> +/* OVL_CON_RGB_SWAP works only if OVL_CON_CLRFMT_MAN is enabled */
> +#define OVL_CON_RGB_SWAP	BIT(25)
> +
>   #define OVL_CON_CLRFMT_RGB	(1 << 12)
>   #define OVL_CON_CLRFMT_ARGB8888	(2 << 12)
>   #define OVL_CON_CLRFMT_RGBA8888	(3 << 12)
> @@ -65,6 +69,11 @@
>   #define OVL_CON_CLRFMT_BGRA8888	(OVL_CON_CLRFMT_ARGB8888 | OVL_CON_BYTE_SWAP)
>   #define OVL_CON_CLRFMT_UYVY	(4 << 12)
>   #define OVL_CON_CLRFMT_YUYV	(5 << 12)
> +#define OVL_CON_MTX_YUV_TO_RGB	(6 << 16)
> +#define OVL_CON_CLRFMT_PARGB8888 ((3 << 12) | OVL_CON_CLRFMT_MAN)


Shouldn't this be (OVL_CON_CLRFMT_RGBA8888 | OVL_CON_CLRFMT_MAN) ??

That's getting written to the same register, so I'd guess this is like that; but
then, if it is like that, why is it PARGB888 and not PRGBA888?!

Regards,
Angelo



