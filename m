Return-Path: <linux-kernel+bounces-344563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8270698AB5C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9202811A6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82335198A24;
	Mon, 30 Sep 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=adamthiede.com header.i=@adamthiede.com header.b="A+GREaYN"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB238382
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718528; cv=none; b=MW2Sckx+PuCZ9ScnFujpqGzBtI0rb76l/sEyfV6okDyQrM09jv12Wpe/+jpqxktWSeEDrdP+Oh9T2iUENyX/wEj2JmBF2b9k+BhKBM5VaVO33uM2YhY/FnnzTPGp3+GZgXM7d0xQU05ggB+RYOtxjvvq1hvxXH1Ic2tlcFL+W9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718528; c=relaxed/simple;
	bh=Kki+Yd/NqWJxaGM3HE3XtC0ibY6abA95Uw859+djvv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UbptwlwtffNGJGWlOP8L1eUroiRRmCi3bxcyB5mWCzQMTxkBzLAIvU796WNnCCfYO1arwVV9lNW83GM8HvCs5g16bjCP5MCWSxyFZ0tKSAtNxdEPRH3ZKgOodezrmb4phinu5E9LCunoNFmk0Q+/bwv9t6K0KVRgeTttv+gKMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adamthiede.com; spf=pass smtp.mailfrom=adamthiede.com; dkim=pass (2048-bit key) header.d=adamthiede.com header.i=@adamthiede.com header.b=A+GREaYN; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adamthiede.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adamthiede.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XHT8864hHz9sRx;
	Mon, 30 Sep 2024 19:48:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adamthiede.com;
	s=MBO0001; t=1727718520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VJqTCbdTizlZhAz4A3yFXSPDCEce+S+AbNdmNPDrioU=;
	b=A+GREaYNnTthkGK+jJ24T+ohKWBkB/UumNmwDVhZ9fKN5fvKwYLWfNI5P/26K4a6m063qN
	ZjDOzlsoN0MWomKDnpM5sB4tCMEpp5ofBCx8r23iHXMFDRs8lwcpUovCKFq4iMRLWQi8fZ
	TnsxWXHiW3EutyyDmVky6QRvRYK7C5rL/nJqChmvH8PZCYP1xSYGoVG4nBNC7arWoqqLO0
	iKnpvoOgXsMf44rNYLci8vvdX2O/vGt8HeN3IsK5FNbEf9Q7DbQEpES9Uk+j6NoZHLwNEM
	j9yAIaUpFQgNZ9i4DruYj8MsRq40XAu/jy3r5kY+Urp98lvo4g96B3HKVdJOJw==
Message-ID: <1a3af354-bd15-4219-960e-089b6a6e673c@adamthiede.com>
Date: Mon, 30 Sep 2024 12:48:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 13/14] drm/mediatek: Support DRM plane alpha in OVL
To: shawn.sung@mediatek.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>,
 Daniel Kurtz <djkurtz@chromium.org>, Mao Huang <littlecvr@chromium.org>,
 "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: YT Shen <yt.shen@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
 <20240620-igt-v3-13-a9d62d2e2c7e@mediatek.com>
Content-Language: en-US
From: Adam Thiede <me@adamthiede.com>
Autocrypt: addr=me@adamthiede.com; keydata=
 xsBNBF+n+90BCAC2ZRLVcvdXDgfY7EppN05eNor3U7/eeiNCCEIWZkYLhikUEP1ReLGBkXpK
 Pc70hfnKAKkCoth3IwhDty9WXMNU+iLNei4ieb2luW+UqluR6xIUIA+txahMU9YcjVaQTKf/
 yZWO4yl6pfBPCxC2UdPZKBAdGoi5NnE0ABFNbhBETQhhBic533lZn33ByupfI3acECnQdjgQ
 llCUpDbw4I+S/N1iFiEHcbMXH7ZB00e3IYNorZ1E9v7p++5rDY1fQ9gXpieg1vFKwSq1NJWo
 9xx336YjaTUbX0EwrdKd9l8AktA3yRjckaK5TAcwSQaDtHvhpbl4ebvPhtwHh699MroXABEB
 AAHNH0FkYW0gVGhpZWRlIDxtZUBhZGFtdGhpZWRlLmNvbT7CwI4EEwEIADgCGwMFCwkIBwIG
 FQoJCAsCBBYCAwECHgECF4AWIQQtG9pGQ7sz3tf8M/kC7fV9o/vRzgUCZL1HxQAKCRAC7fV9
 o/vRzgyRB/wLqRCvvWhQCMgvzeKvru9wcXquhb77K8H/ByLbfiT8YBuP3lZFVh0IQhgO9Ylk
 fIoOJE4V+jjxyOnO2d9xjGbvAmmR6yT0gfLzSVWqrC4k+V9MWLv43nrNzxt41dvo5j824FAl
 X+zaiRZCdO8Jtxg5Elpiop2SKLi1utX1Z8i6YZh+ccJZlchUBAGUTk+D4UjK7vUcjLWT96ya
 CtdtTfXyw36CvGOPEWfc6++Kkl/5sgej1i7biPYzu/r0vssaQYTXKSrv6Cfa3Maa89ASiTtv
 q4qmhLnJeCrPxWlRAf6LEizeBEkOasYni2u8sp4wBezEq45Ozu45sfPkqLpPolG7zsBNBF+n
 +90BCADBRt+vrToRBEG580n77S99qSEkbKD+oJtCVyovnjMNkg0K9UG68LIeCX/ezngiV1M8
 JISvw5iFOuUFqGX/1hLl9wgt/YpuIrgWOp8XxkotavTCloLDvQmufJPO1L8bnnA+WgP2YgVZ
 5MJTj/t4DI+yQgysEjsH8aurHO2uuqgJE+xK+2dy6Cl/wskuGxObksSPmmFH5PH0Joziwrtl
 61ouLE2XwKbkMgIGEKkbFgbfwz3/QuLZGBni+OOtLzXeZ9wNTW/AHUPy6S9U4F+5z6/09fVT
 tTH0cvrgAGjbASlYx2VqGONXAsxCfjulq6ryJBFlPLp949c/JTTgOojukCSbABEBAAHCwHYE
 GAEIACACGwwWIQQtG9pGQ7sz3tf8M/kC7fV9o/vRzgUCZL1H0gAKCRAC7fV9o/vRzlamCACs
 vHw+0heTm+BfC3S8DUST6889gidIIwdqBep1ByzetCph7Bq8Y8BlT5YTX0u/bSKkxCzFgeTm
 vC341Q09ST2XjLAl1ZTdzGhH9gcgYyOw34pr5fPQRJLB392mPzD8YReRzciNbhWzj+DLgeVe
 ouyfGajd6jDjkf4FEq+trQLGZhpfsKn3JnDbzBUs945D50l/vz9q/QN3qZO+H4F6g8ZeMnqo
 FOEFN26xVtdEDr+0DNFsbgKmEzs675kdAY78ZZdbEetX/FSknxJ+FK1ZW3J7Yswwulj34AXP
 LB49Mk8Ot7fo6mdt0DkV11JS9LmKxKvpY+KTlrKG+i7pVCSZvVUx
In-Reply-To: <20240620-igt-v3-13-a9d62d2e2c7e@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4XHT8864hHz9sRx

On 6/19/24 11:38, Hsiao Chien Sung via B4 Relay wrote:
> From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> 
> Set the plane alpha according to DRM plane property.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 943db4f1bd6b..4b370bc0746d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -458,8 +458,10 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
>   	}
>   
>   	con = ovl_fmt_convert(ovl, fmt);
> -	if (state->base.fb && state->base.fb->format->has_alpha)
> -		con |= OVL_CON_AEN | OVL_CON_ALPHA;
> +	if (state->base.fb) {
> +		con |= OVL_CON_AEN;
> +		con |= state->base.alpha & OVL_CON_ALPHA;
> +	}
>   
>   	/* CONST_BLD must be enabled for XRGB formats although the alpha channel
>   	 * can be ignored, or OVL will still read the value from memory.
> 
Hello, I believe that this commit has caused a problem for my Lenovo 
C330 Chromebook running postmarketOS.

With kernel 6.11 this device didn't show any text on the tty or splash 
screen during booting, but graphical environments (wayland, xorg) do 
appear. With a few bisects I found it to be this commit. With it 
reverted I'm able to get text on the tty again.

The kernel config is here: 
https://gitlab.com/adamthiede/pmaports/-/tree/mt8173-611/device/community/linux-postmarketos-mediatek-mt8173/
To be perfectly clear, this device is not running Chrome OS.

I'm still rather new at this so it's also likely I got something wrong 
or have a bad configuration option. If there is any more information I 
can provide please let me know. Thank you.

- Adam Thiede

