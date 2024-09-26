Return-Path: <linux-kernel+bounces-340099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A5E986E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA091C217F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D251891BB;
	Thu, 26 Sep 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bjIFEMvT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396C13CABC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727338247; cv=none; b=TZF8uGVQ15w7wIIELp02Df5VdAsRd5xFVBscgCDihCCgEXBVbckVjeGrsa7mNcb4SwtRUyu3/SQcMhXQD8c3rNLQwqpqhkChuikBBTtR3PhtJYds/om2w4FOC5AHqC274f6wDktlA3NZ8NAUL2r//KUbrprj/vNmmjphgXE9S+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727338247; c=relaxed/simple;
	bh=TBmk3ukpcvLGeY8jcL1yDRNbiLdMv3jrNZBwxVdpxU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqS4XJPE+GaGqAp2gWEudLDy460EuMddi4T+cASCEMgCgiVWEgQw2/8oyYjSHdKWPVVLRnqIIwuRK8dX0scvvjyZOJWZx9qAnSL3pRZHYMgiv+rjZTTKuLNaLxLeDxJy/hI8kyLuH49B7Vo6ER7uWEFo51jrAVbMowSQ3H++lyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bjIFEMvT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727338243;
	bh=TBmk3ukpcvLGeY8jcL1yDRNbiLdMv3jrNZBwxVdpxU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bjIFEMvTQ/zSTgBy/QFyhptphlBSFexJoVE6vclwN8OvM3xGCsi8w47d/Riu2G+vQ
	 utUCfiZYkAvMGsVQircttdobMtn/YQBZd4mUJwHo9/uD2Fdc+5b1QBye0d7PddEBc1
	 0gTAVhyrxpO9MI/1+vOvSw34A2t50hdnjNZn3fDfDnUvIEpCSTr+nVEpKGfcSu9+9j
	 HsHGVnT8gRTjFkt0yAcwGHjYUpS9IGjaS4bh+szBLaj1sH/31DDY6/78KFZ97o8WRK
	 R2sV8H6E9AO1i8PtBKzBVK+DV4jvHq6/BEpZMaVnBYXtpQcHmA4i3lV3YfAae+x9yK
	 pX3BA/62HLXhw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3465D17E1060;
	Thu, 26 Sep 2024 10:10:43 +0200 (CEST)
Message-ID: <06569bf4-4ec5-4ea8-a2df-e696deb9d4e2@collabora.com>
Date: Thu, 26 Sep 2024 10:10:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] drm/bridge: it6505: fix HDCP Bstatus check.
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Kenneth Hung <Kenneth.hung@ite.com.tw>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Allen Chen <allen.chen@ite.com.tw>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240926075018.22328-1-Hermes.Wu@ite.com.tw>
 <20240926075018.22328-2-Hermes.Wu@ite.com.tw>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240926075018.22328-2-Hermes.Wu@ite.com.tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/09/24 09:50, Hermes Wu ha scritto:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> When HDCP is activated, A DisplayPort source receives CP_IRQ from the
> sink shall check Bstatus from DPCD and process the corresponding value.
> 
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>   drivers/gpu/drm/bridge/ite-it6505.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 5d5ce12cd054..d2ec3dfc57d6 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2322,14 +2322,20 @@ static int it6505_process_hpd_irq(struct it6505 *it6505)
>   	DRM_DEV_DEBUG_DRIVER(dev, "dp_irq_vector = 0x%02x", dp_irq_vector);
>   
>   	if (dp_irq_vector & DP_CP_IRQ) {
> -		it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CPIRQ,
> -				HDCP_TRIGGER_CPIRQ);
> -
>   		bstatus = it6505_dpcd_read(it6505, DP_AUX_HDCP_BSTATUS);
>   		if (bstatus < 0)
>   			return bstatus;
>   
>   		DRM_DEV_DEBUG_DRIVER(dev, "Bstatus = 0x%02x", bstatus);
> +
> +		/*check BSTATUS when recive CP_IRQ */

/* Check .... */

> +		if (bstatus & DP_BSTATUS_R0_PRIME_READY &&
> +		    it6505->hdcp_status == HDCP_AUTH_GOING)
> +			it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CPIRQ,
> +					HDCP_TRIGGER_CPIRQ);
> +		else if (bstatus & (DP_BSTATUS_REAUTH_REQ | DP_BSTATUS_LINK_FAILURE) &&
> +			 it6505->hdcp_status == HDCP_AUTH_DONE)
> +			it6505_start_hdcp(it6505);
>   	}
>   
>   	ret = drm_dp_dpcd_read_link_status(&it6505->aux, link_status);


