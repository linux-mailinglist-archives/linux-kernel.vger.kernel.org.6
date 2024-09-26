Return-Path: <linux-kernel+bounces-340244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF4C98706A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CAC1C22B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B20E1AAE2A;
	Thu, 26 Sep 2024 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c5d60WBk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185CE146596
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343595; cv=none; b=F8nQ9Wj1RzhASmHpPEGAmdR2FBnbtG7eOXF7ZOMSZEM8qpNBDef6MR+Z9G0pSoFZ41hVe1Sqi6fnNLPKjXESy34HfUd36HJ15bxjtcob9fzyD6mthfufj6LutFgfLE44xswAl2zJ5crS4e/s9FBOOLiXMfmlQADgcj5ztz+Vmf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343595; c=relaxed/simple;
	bh=TDiXybMeYtcjqjBx92AhyDoKNyIG5PotfOZAabaX1Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjdEVVClzvv4GXGZ4z08FexiQ1F+aDhg4Cj6slJ/3QBedTrKoslj3zdAn8fRNWq5DcVcqRpU0iTZBJWwUQeXeJZyiZeyE+IYt0z/dOHia7zKIDtvXFUxBcEylG2abJHmXLWPirFdLj4zv5CAvwtXhUs1+laUv4SsOVCggfHrkko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c5d60WBk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727343592;
	bh=TDiXybMeYtcjqjBx92AhyDoKNyIG5PotfOZAabaX1Gw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c5d60WBkFGQ5Akzoc/3uBQvHv1XDYHqt+L6fd+vwLMzBBq7UyumanL8oemFcKR+hC
	 qA4ViIZHHhqPYszePwYdkE/dKfYbFRAeCC0RqRy9BwqnkkOp4p6Is+BcgshOjRZiqN
	 YXNU3dsDAidYj28SV846xUFQ7kXBNqjADZCJnbTzGCN0Cs2EVbr+7K8zokSI8jRksP
	 aciFZdCUEh5kzI/uFJ7QNvFkdTe9dNYXoSKY3tSIiIujXrfUOo95HZr74habGRxVZU
	 T59unfzI7Lv7SWJDWhigLdnkAh6ys+O5c0AMrOeYt+SZSdy5GqLxatfIBzHgjll7hw
	 E0t8U8Vo7zwvQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7A3F217E10AF;
	Thu, 26 Sep 2024 11:39:51 +0200 (CEST)
Message-ID: <9f637af5-9836-487a-88b6-1d1ac46e6976@collabora.com>
Date: Thu, 26 Sep 2024 11:39:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] drm: constify read-only regmap structs
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20240925-drm-const-regmap-v1-0-e609d502401b@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240925-drm-const-regmap-v1-0-e609d502401b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/09/24 17:42, Javier Carrasco ha scritto:
> This series adds the const modifier to the remaining regmap_bus and
> regmap_config structs under drm/ that are effectively used as const
> (i.e., only read after their declaration), but kept ad writtable data.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

For the entire series:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> Javier Carrasco (6):
>        drm/bridge: dpc3433: Constify struct regmap_config
>        drm/fsl-dcu: Constify struct regmap_config
>        drm/mediatek: dp: Constify struct regmap_config
>        drm/meson: Constify struct regmap_config
>        drm/panel: ili9322: Constify struct regmap_bus
>        drm/sprd: Constify struct regmap_bus
> 
>   drivers/gpu/drm/bridge/ti-dlpc3433.c         | 2 +-
>   drivers/gpu/drm/fsl-dcu/fsl_tcon.c           | 2 +-
>   drivers/gpu/drm/mediatek/mtk_dp.c            | 2 +-
>   drivers/gpu/drm/meson/meson_drv.c            | 2 +-
>   drivers/gpu/drm/panel/panel-ilitek-ili9322.c | 2 +-
>   drivers/gpu/drm/sprd/sprd_dsi.c              | 2 +-
>   6 files changed, 6 insertions(+), 6 deletions(-)
> ---
> base-commit: 2b7275670032a98cba266bd1b8905f755b3e650f
> change-id: 20240925-drm-const-regmap-307f2c358d10
> 
> Best regards,



