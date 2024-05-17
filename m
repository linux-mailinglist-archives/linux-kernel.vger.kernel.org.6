Return-Path: <linux-kernel+bounces-182001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9768C84EF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 12:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4DC281865
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3C138384;
	Fri, 17 May 2024 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GVRaEZQ9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AAE134BF
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715942110; cv=none; b=pvffmpxI3ds9TZ2Masba2N/1jsLKX6e49HT5gqq2Y1on668KWjnO4hzbyd4/ww059jE4wgVrPrG430/0gM/pb9Am9GrH5w1rYVToN+I6PEucnr9Db4oST7Y1luvqKgAmJcz6KhQwQhSCcs+r75J9boxQk+aJHl4emY4gRKUKQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715942110; c=relaxed/simple;
	bh=so8083+XXFPwmPiUAe9pwH122x32KJYu7Z5cJlP4fbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kr1zWkNgsMoV43UDD06cf92rKeXVIURZ3AO8oCwl8D4GyVPec8K6oMYQADIQdc99rg5IOsu8hyah1njawgtWC+v/LJyl+JHmz393+pz2D90sxarbGzDpXlG49cZ/obNsc5ib+g123hlkO4Bh2Grc5iTaCtrBCLTjRHvBnLlo8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GVRaEZQ9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715942106;
	bh=so8083+XXFPwmPiUAe9pwH122x32KJYu7Z5cJlP4fbo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GVRaEZQ9H2SKdq0VVIXT+gcllkY2PMORQtl6/qHv2TFAibtwTeYtKcCtaAE5UAyj9
	 6s6TDJVI61Z90/TVpAXvnvNLu+tadovRA8ZwhD138f6ihFuuahHz1tKhtkyxPBgAVJ
	 96pv4IY/wLXLeJf1RX0oqR0Q+cUHz7fOq/wkgLUKiyXGfEnqrzPW2vAz22NXXt7iGt
	 3pkNH9jBHLuCk9vq5Hiv2ocXq47TpuOd7TTuLPg8ueM2Hvvxniq0StYYu36vOgGLwP
	 bdCEcajMl8KCEjk4dNmCoWOCmhqrHLwQSaBn1QM+3kF+j0Mt6RuFYHsvbGWaNwYQx0
	 8+8jzQIdyL9Dg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0D24F3782198;
	Fri, 17 May 2024 10:35:05 +0000 (UTC)
Message-ID: <de0191f3-271b-4f0e-aa73-910543587c9d@collabora.com>
Date: Fri, 17 May 2024 12:35:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek/dp: fix spurious kfree()
To: Michael Walle <mwalle@kernel.org>, Chun-Kuang Hu
 <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jani Nikula <jani.nikula@intel.com>, Chen-Yu Tsai <wenst@chromium.org>,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240517093024.1702750-1-mwalle@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240517093024.1702750-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/05/24 11:30, Michael Walle ha scritto:
> drm_edid_to_sad() might return an error or just zero. If that is the
> case, we must not free the SADs because there was no allocation in
> the first place.
> 
> Fixes: dab12fa8d2bd ("drm/mediatek/dp: fix memory leak on ->get_edid callback audio detection")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>   drivers/gpu/drm/mediatek/mtk_dp.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
> index 536366956447..ada12927bbac 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -2073,9 +2073,15 @@ static const struct drm_edid *mtk_dp_edid_read(struct drm_bridge *bridge,
>   		 */
>   		const struct edid *edid = drm_edid_raw(drm_edid);
>   		struct cea_sad *sads;
> +		int ret;
>   
> -		audio_caps->sad_count = drm_edid_to_sad(edid, &sads);
> -		kfree(sads);
> +		ret = drm_edid_to_sad(edid, &sads);
> +		/* Ignore any errors */
> +		if (ret < 0)
> +			ret = 0;
> +		if (ret)

Eh, this will never work, because you're clearing the error before checking
if there's any error here?!?! :-P


Anyway in reality, it returns -ENOMEM if the allocation was not successful...
in the event that any future update adds any other error we'd be back with the same
issue, but I'm not sure how much should we worry about that.

To be extremely safe, we could do...

if (ret != -ENOMEM)
	kfree(sads)

audio_caps->sad_count = ret < 0 ? 0 : ret;

Cheers!
Angelo

> +			kfree(sads);
> +		audio_caps->sad_count = ret;
>   
>   		/*
>   		 * FIXME: This should use connector->display_info.has_audio from



