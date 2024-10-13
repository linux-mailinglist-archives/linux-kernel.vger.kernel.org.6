Return-Path: <linux-kernel+bounces-362974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FBC99BBF6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 23:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76272827CE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 21:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B58814AD2E;
	Sun, 13 Oct 2024 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="POiuGuFX"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0C67F48C
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853853; cv=none; b=VK1HkxOcNfoKURmgqDf53m5EJVVl5wD6sIUcDLefXIBL4bjC5IyWNiyqZT2g4I8JtrJOaVRdku9AW1Vg6p4+gD7laHJ2cZcAMti+Ey/wmgTLd5cV2zuHo/tl9SGZbcy1Em8b/cq1pCIYPiuG4gXk+ViJTcwlc+zPsIAoaINHOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853853; c=relaxed/simple;
	bh=ENifbT9ph8f2YNauKL4oY2Jedty+AhHnRU9arzoobfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3tWqMLG/85Hk1CZuNYHbvcRGrTddTxpSUlPB+Z6cADMR5aUUzGwNgopB/3FUVuDt/z+oZ4mFl1k2/KWFqIsQRn79ivzxgjFt+UKwzuzJtjFHQTvdOf16uLnIdVC+WIqNCe3hHv7EP36YGRCoxjlu1m1ioUrVMnjoIsefQ8fSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=POiuGuFX; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5F1DB88E12;
	Sun, 13 Oct 2024 23:10:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728853843;
	bh=CZADMR0UjWah1D08Xkik9RrEse5XEJUY2gNVHdcSY2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=POiuGuFXncMQn2R7UV4zOZh/qw+pNUXkNvcUTrChJRD5Z4fXIsFJmIYtxCOCNrYy2
	 wdOfCk3t68Xo7lzcZMOq5kr2L33BirUWo03V69iQw+F77n+a+3xWDkFBMRsVDVwYwA
	 8+wACntQITTb6Wphma2h9Hpdoksy/0RvxvIlm3SSdV9kkJ+yfIPPQsbIL28j78UDDO
	 5rcY/tuqjSAZO1EZtjdAK2BYeAxPxs+RmRfjlrJ4FkOIpex5e5CSUjPpnBq2iQm1fb
	 0TMedidrXZrE0CIynVVLhftSOICdoxa7ndVCR47ik1F7ABycsPjD6suP0Qch3TTEew
	 v1/nnNz6PeUIg==
Message-ID: <5c355ec8-85e2-4c60-8573-4c21bc8a0d83@denx.de>
Date: Sun, 13 Oct 2024 22:36:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: tc358767: fix missing of_node_put() in
 for_each_endpoint_of_node()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241013-tc358767-of_node_put-v1-1-97431772c0ff@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241013-tc358767-of_node_put-v1-1-97431772c0ff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/13/24 8:11 PM, Javier Carrasco wrote:
> for_each_endpoint_of_node() requires a call to of_node_put() for every
> early exit. A new error path was added to the loop without observing
> this requirement.
> 
> Add the missing call to of_node_put() in the error path.
> 
> Fixes: 1fb4dceeedc5 ("drm/bridge: tc358767: Add configurable default preemphasis")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/gpu/drm/bridge/tc358767.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 159c95b26d33..942fbaa1413a 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -2405,6 +2405,7 @@ static int tc_probe_bridge_endpoint(struct tc_data *tc)
>   			if (tc->pre_emphasis[0] < 0 || tc->pre_emphasis[0] > 2 ||
>   			    tc->pre_emphasis[1] < 0 || tc->pre_emphasis[1] > 2) {
>   				dev_err(dev, "Incorrect Pre-Emphasis setting, use either 0=0dB 1=3.5dB 2=6dB\n");
> +				of_node_put(node);
>   				return -EINVAL;
Right, thanks!

Reviewed-by: Marek Vasut <marex@denx.de>

