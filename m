Return-Path: <linux-kernel+bounces-340100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A57986E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C302839BF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE6D1A3BC0;
	Thu, 26 Sep 2024 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L4Lq3nNi"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452DA192B72
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727338249; cv=none; b=G2ooLpaQJaY41MTXPAyodVEWSUmOGP7LOUIjrX1jdmUK82GMRzMnTLLj9neOzoRpM2KpR0mzd5v36FaBenOj/UB4idA3o4M3ldj1iZtRaryoFEOhavZ7bAz4Kl4Z2IOpzUO9QTeGKqzDhceBJ0qflOEN9+O16Va43CoHDfpP8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727338249; c=relaxed/simple;
	bh=Kzp7dM5sOI8NYDnR9ubmHtN9lHmysL8hlTCzyQ8KLqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDUntgL+m6r5nhAvEDn8OlLTEcZneJ1yPka8YCZiSgeFXrT0tekBgOiFd9fjkWv7LtWZLQzLKgBahvdJpfo0EgVeQc2R1kWoS4o2EsmIekQGGHp8vlcHP6YNXL0YCFqyLcO54MlUAtyRmcG5pWt4XUiOCuGoMEvcNgLeZzRUNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L4Lq3nNi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727338246;
	bh=Kzp7dM5sOI8NYDnR9ubmHtN9lHmysL8hlTCzyQ8KLqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L4Lq3nNiKfkxCKd8YGEqHiePZj45IwWTdMO9EoWtdNgqaxP7IInZBisXahsDFa+Fh
	 tfbaznrbTGB0mq0o/qNZAh48/lzUiId/6vrLh8JQZKJTlKkjkH+M5S+JniRwut1WeE
	 3rH3tC+7pL4eZyA6sM5Apuo8zSSvWRsAx8T46mK7BFA+fz+2+i92XXZsXLr8tJ3iEk
	 Y1LcVMBrsGVSuZfk93srtCsBRT7AM94Z82p7VJwFvsIQzi2eoY/Q7hKQKiJ97Aa46x
	 ccxGKRo4pDW03iuU/dYFzV4sl24VK7Bhedpc3Hl9VRjhdqnDisXwJsr6go1mxCcbkT
	 U7ObodagCmWSQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E8AA317E107A;
	Thu, 26 Sep 2024 10:10:45 +0200 (CEST)
Message-ID: <daa103bd-d70f-460f-8ecd-88da9da0eb03@collabora.com>
Date: Thu, 26 Sep 2024 10:10:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] drm/bridge: it6505: fix aux command write to aux
 operaction register
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
References: <20240926074755.22176-1-Hermes.Wu@ite.com.tw>
 <20240926074755.22176-5-Hermes.Wu@ite.com.tw>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240926074755.22176-5-Hermes.Wu@ite.com.tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/09/24 09:47, Hermes Wu ha scritto:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> The aux control register command is 4 bits LSB only, adding a MACRO to get
> correct operaction command.
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>   drivers/gpu/drm/bridge/ite-it6505.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 0583abdca75f..d1f5220e04a6 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -329,6 +329,8 @@ enum aux_cmd_type {
>   	CMD_AUX_GET_KSV_LIST = 0x10,
>   };
>   
> +#define GET_AUX_CONTROL_CODE(cmd) ((cmd) & 0x0F)

Just (cmd & 0xf) as the leading zero is meaningless.

As a out-of-scope consideration, though, this driver would really benefit from
a conversion to use bitfield macros... would be a nice cleanup.

Cheers,
Angelo

> +
>   enum aux_cmd_reply {
>   	REPLY_ACK,
>   	REPLY_NACK,
> @@ -1000,7 +1002,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>   				  size);
>   
>   	/* Aux Fire */
> -	it6505_write(it6505, REG_AUX_CMD_REQ, cmd);
> +	it6505_write(it6505, REG_AUX_CMD_REQ, GET_AUX_CONTROL_CODE(cmd));
>   
>   	ret = it6505_aux_wait(it6505);
>   	if (ret < 0)



