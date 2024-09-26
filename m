Return-Path: <linux-kernel+bounces-340236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2753D987059
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECF01C2484D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5531A42AB;
	Thu, 26 Sep 2024 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LUI9tduO"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113F7224D6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343243; cv=none; b=Zt48oigKmjjaX2mZGtfRFzKc5jEtiJsjBGeL+3/zv+DujCm1XXS7zDjlC2PZPZd9D0LZ8c1QXgBaMYQy3Jtq/PXWQfrJnmNLGB6ZfuUf02jzcXpG5dRtAWVv8FWfI8Kc+H4BaZYjJd+QzPfXc3wA2+whUmTMEsPQRQlx4iU7enw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343243; c=relaxed/simple;
	bh=Df5Y9+CiHpGGKQOzwFg0ep4DadWij8jUa5ykfjb2WLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhBLUcUL8HRLQVswaR6T00YPsKTW8qbMRPjqINQISHMQpPz7RTo2S5UY5zl6PsWqme9ZOVGGCRx+5qVG1SSo5QxlLlxh+IjwhB6iEAphbeC1rQdjrfQSPYRsoKkPjpXajkvN8J60mvLjJn1q5aqdDggNSJliCzazozJRLDJlz88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LUI9tduO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727343240;
	bh=Df5Y9+CiHpGGKQOzwFg0ep4DadWij8jUa5ykfjb2WLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LUI9tduOcNBvZPpnTbgYRam64lWcZhKujisk4t/35GFgvZ3/st0pJn2jrXSu2Lam/
	 Gx47u64L0EkRtup8c5zi8swKwdFlx+VVe7hNov7e3ADoinAftAd76eU7zuq+HxTjnC
	 3nAtsNaz0uSLtWynTVo4uMw6aIk7jVob4wcZG0JzCgJU7pZCzpLNcGrFJVYdKsz7HK
	 jDX1G+UG1G76vTDUzqWghRCbx7RcZZkZgveShv9jaXsmoYbcs/0wV9fGORZ5AUW2TN
	 wlvkAcEaJSeG8jOFcRyzWjw598PAtHi7g0GXzvExvy4ERbfmz8rapp2Rp7/L+rCD0B
	 +e5zymaIdn3ug==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A271117E10AE;
	Thu, 26 Sep 2024 11:33:59 +0200 (CEST)
Message-ID: <d8f54575-6df8-4198-a078-70debc9f8e0b@collabora.com>
Date: Thu, 26 Sep 2024 11:33:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] drm/mediatek: Fix wrong check of nvmem_cell_read
To: Liankun Yang <liankun.yang@mediatek.com>, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 matthias.bgg@gmail.com, rex-bc.chen@mediatek.com, msp@baylibre.com,
 granquet@baylibre.com, dmitry.osipenko@collabora.com,
 jitao.shi@mediatek.com, mac.shen@mediatek.com, peng.liu@mediatek.com
Cc: Project_Global_Chrome_Upstream_Group@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240925084116.28848-1-liankun.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240925084116.28848-1-liankun.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/09/24 10:40, Liankun Yang ha scritto:
> If the len is 0, kernel crash will occur when performing operations.
> Add the len check conditions to prevent kernel crash.
> 

Please fix the commit title:

drm/mediatek: mtk_dp: Fix potential KP on 0 bytes nvmem cell read

> Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
> 

Please remove this blank line between the Fixes tag and your S-o-b.

> Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_dp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
> index d8796a904eca..0cc75ba96b98 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -1082,7 +1082,7 @@ static void mtk_dp_get_calibration_data(struct mtk_dp *mtk_dp)
>   	buf = (u32 *)nvmem_cell_read(cell, &len);
>   	nvmem_cell_put(cell);
>   
> -	if (IS_ERR(buf) || ((len / sizeof(u32)) != 4)) {
> +	if (IS_ERR(buf) || (len == 0) || ((len / sizeof(u32)) != 4)) {

if (IS_ERR(buf) || !len || ((len / sizeof(u32)) != 4)) {

Cheers,
Angelo


