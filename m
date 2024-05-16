Return-Path: <linux-kernel+bounces-180890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C368C7473
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035BC1C226BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89705143890;
	Thu, 16 May 2024 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U4jJXRQE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76332143754
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854324; cv=none; b=a7N91GnRJ4chPwXPiu7GFnETTZy0wBneb1SzYmgfuVzqsLBXt8BJdVDAEqaQjb/9DBduIvpOJWvCdL6Rjnd9TnfiUHrx0QgHonk9CspxbfielZI9lO1t4OLtxb7O8DJUIF2QyYLFzZdB/10ljIKSBxRb8nNuww1D/jbj/cCcXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854324; c=relaxed/simple;
	bh=fJVijZDsk7G+N5ZyDazIeeDuEW47pTV5GN2yegKbc4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzG3q4zqr/qdLuG9M89Y4bk7mrqmBKRVaAPO9bbpsliBSYKN14eJfoMVhqxQK8qodalkw7hbpLDAYY7mJ5HpdOlg2EO10JnT8A+Y7K7eHE36T1NIkLVzxIKESPC1Q5fFVamoIKnC+l6voGXlGVVT6ptUoS5OrLFGdbOR28ZcsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U4jJXRQE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715854321;
	bh=fJVijZDsk7G+N5ZyDazIeeDuEW47pTV5GN2yegKbc4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U4jJXRQEQ9NqrEbULaHQIdf6/LNc1tjtq9H0VDDd+AWcnVMH0yoqF1hM9h3BYYsrO
	 jmTs0f+wdu4NNZF8aUQ37jo4tY5jGlupeOt0silOa73/mVBuLZK8fpib56bgU9/mxk
	 hKECjqfE+bnd0ah2bzSZmtNwMw2IVBGDJgHFzw3jH2kB7fM2uMUOK/bYxzpuCDY5ov
	 Y8HmqA03vGqdBQb3FEF7U+CWLdIiecb23ypUyYhLcUUTLP3d6u5vil1hR5Le0RfDb0
	 xXG7jNYW21Qd71b0yl1I2wIH35KRecTOi+qBEOEmh8RRr9kKd+kVOrljGHLE1N0uyF
	 CaqBGh//bGyfQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4A61C3780C13;
	Thu, 16 May 2024 10:12:01 +0000 (UTC)
Message-ID: <671f4976-46e6-4873-98b2-89df896e4a4f@collabora.com>
Date: Thu, 16 May 2024 12:12:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/mediatek: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
 <4a64dfbfbcfdf9b7cd46bc8026223e69a4b453b4.1712681770.git.u.kleine-koenig@pengutronix.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <4a64dfbfbcfdf9b7cd46bc8026223e69a4b453b4.1712681770.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 09/04/24 19:02, Uwe Kleine-König ha scritto:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_padding.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_padding.c b/drivers/gpu/drm/mediatek/mtk_padding.c
> index 0d6451c149b6..9f92b720aaae 100644
> --- a/drivers/gpu/drm/mediatek/mtk_padding.c
> +++ b/drivers/gpu/drm/mediatek/mtk_padding.c
> @@ -137,10 +137,9 @@ static int mtk_padding_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static int mtk_padding_remove(struct platform_device *pdev)
> +static void mtk_padding_remove(struct platform_device *pdev)
>   {
>   	component_del(&pdev->dev, &mtk_padding_component_ops);
> -	return 0;
>   }
>   
>   static const struct of_device_id mtk_padding_driver_dt_match[] = {
> @@ -151,7 +150,7 @@ MODULE_DEVICE_TABLE(of, mtk_padding_driver_dt_match);
>   
>   struct platform_driver mtk_padding_driver = {
>   	.probe		= mtk_padding_probe,
> -	.remove		= mtk_padding_remove,
> +	.remove_new	= mtk_padding_remove,
>   	.driver		= {
>   		.name	= "mediatek-disp-padding",
>   		.owner	= THIS_MODULE,


