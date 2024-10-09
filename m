Return-Path: <linux-kernel+bounces-356768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C1899665B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F291AB246EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1857B18E032;
	Wed,  9 Oct 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MVJ0xQTn"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD5915382F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468099; cv=none; b=a8okz23WDsnRqVpgSOohTXnrBbj6NwhRmVaTRZxe/5uIeF0R/WdEstlCVxMTvgXnPrdYZP+MV7qBH9EPNk0+BjO7W9HsGXKLTJNLpxCeuEbq6Up36ZJE7luxs6F9Lu+Qb5M36351XlQA54rdRN3A2Ptzou6Tg80Jpvyesha1FXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468099; c=relaxed/simple;
	bh=yOp0NvImxbBTVc57uS8Sx//uC+khLg+Tk6wsD0DGbDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpZ3jr9EyLfw/+8zCGzakUCQtdjCBZmZmO9OYO7NDKLWtkxgIGIGCpB3rvW+v1TpP60dFxt29yrtOFchAX7YVkKux2zCJUZsZpNSofffkUYKRwqcE+qobzoLAUSwzKp3yDUlNICWP7I1E8GRHu0LhH2vMl2vL6GyR5LMvh2v5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MVJ0xQTn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728468095;
	bh=yOp0NvImxbBTVc57uS8Sx//uC+khLg+Tk6wsD0DGbDc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MVJ0xQTnYZR94WuYkCWwYcsuy6YLWhhKTXsPzouu5dQ6DYBslc3Jt9mzfRrklehvg
	 XeVVoVcvFZ2PuR+gcstE3Wp0TsHHpQllffj/ERLVmnN+rki++mY7yU1HROcieNHA1W
	 gP+d4CRN/7LmC4hRpwhzjMallThcgz6pwfhhHnJ+dM6rgGfR/US/lYHEnM4EhB6uPA
	 YodryI9xvPRGEwwh+rMVV+rdQzq/hKthbGHj4J8LniHm93Ff8I6d1eg1R4DAjmLW3h
	 DrHbU6vDGbiViAFP6MC8rXkc//fIImKsorDeKxFXyW8CGUVjDrDXd85/7aTaAPcT97
	 KledHZ4R/o5VQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CB78E17E1232;
	Wed,  9 Oct 2024 12:01:34 +0200 (CEST)
Message-ID: <59470ed7-621b-43c5-82a0-9384df7c7e9f@collabora.com>
Date: Wed, 9 Oct 2024 12:01:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/5] drm/mediatek: ovl: Fix XRGB format breakage for
 blend_modes unsupported SoCs
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Adam Thiede <me@adamthiede.com>, Yassine Oudjana
 <yassine.oudjana@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Shawn Sung <shawn.sung@mediatek.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241009034646.13143-1-jason-jh.lin@mediatek.com>
 <20241009034646.13143-2-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241009034646.13143-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/10/24 05:46, Jason-JH.Lin ha scritto:
> OVL_CON_AEN is for alpha blending enable.
> For the SoC that is supported the blend_modes, OVL_CON_AEN will always
> enabled to use constant alpha and then use the ignore_pixel_alpha bit
> to do the alpha blending for XRGB8888 format.
> Note that ignore pixel alpha bit is not supported if the SoC is not
> supported the blend_modes.
> So it will break the original setting of XRGB8888 format for the
> blend_modes unsupported SoCs, such as MT8173.
> 
> To fix the downgrade issue, enable alpha blending only when a valid
> blend_mode or has_alpha is set.
> 
> Fixes: bc46eb5d5d77 ("drm/mediatek: Support DRM plane alpha in OVL")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



