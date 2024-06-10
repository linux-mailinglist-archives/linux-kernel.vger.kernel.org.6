Return-Path: <linux-kernel+bounces-207823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9A8901CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FF93B22A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274F657CB4;
	Mon, 10 Jun 2024 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mOnAwwTG"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FED6BFD4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007289; cv=none; b=bo1keAC8fNBX3nWpjX3g3H/qvNC5NeCEjS44xlSF4Jbuqzt2mE+28s3SQHWmbo+DfkVRUzt/liFDjyMZew+9GR2i9ggi3p+aL+fHPfzrE+voxfQYk5f4Lhpaershp098UfzLyvTJ7MuPiX7XkMxZxwI+eh5FPhfGccy9ZXU0JDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007289; c=relaxed/simple;
	bh=hiymsBDkWx+5f+WbKRv/x3OWu8HZLGmoG8GTw35O2Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0+uqBKZpHNXhcj3dS+6yta+RAhtB5Mp+ULt8YJCRTZU5O8SqVf85rk2gYgiT4bKprpyQp7O15O/lJpHyTFYIpk8+DbiEIbD0fve9yNqybJimiSB9MbWW2hrd6w4MoI7kdND9rF18COjHMLI1zsrnmObeQAso/ZBVxADU4rlLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mOnAwwTG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718007286;
	bh=hiymsBDkWx+5f+WbKRv/x3OWu8HZLGmoG8GTw35O2Qg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mOnAwwTGZ+Ixo/GyUOcrUmw/ItEwWb2jBikLWg+TG/bLU8YYLUxxU6f+6g2R3RWES
	 CitorP61LjJpZ1+DtbgwvXtoVw2WMwX84DL0qmp/NKbsjaBM1159mTZhZZxZlQwa0P
	 T8D8UO9YNZzIG8fmdqEcAhp5gHeg8iStd10x3sNRFzSz3hEQtpVYB4TznPavzLJN06
	 gFbyt5UDrs3IP3xU2kecgb2UpBdhFKSQ10Tquhbu6P4BLcwGdE46Isg6wV/ZxSO7c/
	 2nw0sbVb8uX3YQ6IQk0CegS3iLri1Zj4bA5UGY8Su7U2uW8YS+6JeoquD3Y24do1Yr
	 Eg+SnN3LnShrA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7FA2A3780575;
	Mon, 10 Jun 2024 08:14:45 +0000 (UTC)
Message-ID: <3dd1631a-fbd0-44a5-8119-c03e8a186da0@collabora.com>
Date: Mon, 10 Jun 2024 10:14:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/16] drm/mediatek: Set DRM mode configs accordingly
To: Shawn Sung <shawn.sung@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Bibby Hsieh <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
 "Nancy . Lin" <nancy.lin@mediatek.com>, Sean Paul <sean@poorly.run>,
 Jason Chen <jason-ch.chen@mediatek.corp-partner.google.com>,
 Fei Shao <fshao@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240606092635.27981-1-shawn.sung@mediatek.com>
 <20240606092635.27981-6-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240606092635.27981-6-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/06/24 11:26, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> 
> Set DRM mode configs limitation according to the hardware capabilities
> and pass the IGT checks as below:
> 
> - The test "graphics.IgtKms.kms_plane" requires a frame buffer with
>    width of 4512 pixels (> 4096).
> - The test "graphics.IgtKms.kms_cursor_crc" checks if the cursor size is
>    defined, and run the test with cursor size from 1x1 to 512x512.
> 
> Please notice that the test conditions may change as IGT is updated.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 22 ++++++++++++++++++++++
>   drivers/gpu/drm/mediatek/mtk_drm_drv.h |  4 ++++
>   2 files changed, 26 insertions(+)
> 

..snip..

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index 78d698ede1bf..6cfa790e8df5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -46,6 +46,10 @@ struct mtk_mmsys_driver_data {
>   	bool shadow_register;
>   	unsigned int mmsys_id;
>   	unsigned int mmsys_dev_num;
> +
> +	int max_width;
> +	int min_width;
> +	int min_height;

Only one nit here.

Since {min,max}_{width,height}:
  - Will never be negative; and
  - Will never need more than 16 bits; and
  - Are local to this driver and anyway copied to drm later

Can you please change them to unsigned 16-bits (u16)?

After which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

>   };
>   
>   struct mtk_drm_private {



