Return-Path: <linux-kernel+bounces-521533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF338A3BE98
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229881898394
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2A41E377E;
	Wed, 19 Feb 2025 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eEZD4Hga"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAE1E32A0;
	Wed, 19 Feb 2025 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969360; cv=none; b=Dc6WwcdD3gnLXho5/kZBV+naVMShgGQN/5NEvKbYtndmz0qAhWiyoTlkLJ4JjL57jEHreEhtl+lUdZHx9RymMbQLHOgaEiO4Zfd3v/9P5PuT81Hj/7HxXMqZUGIKiKLSUoTMEcXO3J/WNJHqpocVH9xyWuAEKl8ZtNp/zz49Ezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969360; c=relaxed/simple;
	bh=ZyOK9nag+8gUZ/F4eVgxxf/3BmUwS+AQI47Swx/xonk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaOusvqApnMy+d85pXmknl90kxo0VITP0xIs1AXD+5VMp3is16x9tmRKmxEjR3SslkvBRvAGWVDhk13lmZwGtVDPfUWTvJiA/6bP/qbNueXW0w6kISdtsX3yyHy455AgKzcLEvaa+0vB+B53yO5pDxfug5Is4GFHQMUTY+hE8oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eEZD4Hga; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739969356;
	bh=ZyOK9nag+8gUZ/F4eVgxxf/3BmUwS+AQI47Swx/xonk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eEZD4HgaCqIpEiiGGjAVB7dg/5/yZvma2y3+45M+1z5UcCk6/ZBRqop7gQHtrZqm0
	 Ev5GJbFPR/wyOU3Unn2sbzlGMdVbHszuF1aa6KSHAZpEnu+NITdWmBR3smM58aidCV
	 iTURTCaSl0Lbt/AKB7fJm/TK7/Js5L+0iWYutBwG3inRnizKQeaN0K6n7XzZr2PUSC
	 MqOdYF0dI5Fmb9KoFzhkb0kBdmqaU/8ZanjOk9Iep2rvDMFrQBhLdIIIsLKXO61/9i
	 0TUR4wyILZmgNNYKZPKs/u2vUnkSyUpsXZ10hg4dlZtFoAFq2OgRSrsBUAis0wfoBb
	 t8WzShqkm8Haw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6780B17E14E7;
	Wed, 19 Feb 2025 13:49:15 +0100 (CET)
Message-ID: <bb3fb8df-7a15-4732-a75f-8e2fc17c04fc@collabora.com>
Date: Wed, 19 Feb 2025 13:49:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] dt-bindings: display: mediatek: ccorr: Add support
 for MT8196
To: Jay Liu <jay.liu@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>,
 CK Hu <ck.hu@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250219092040.11227-1-jay.liu@mediatek.com>
 <20250219092040.11227-5-jay.liu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250219092040.11227-5-jay.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/02/25 10:20, Jay Liu ha scritto:
> Add a compatible string for MediaTek MT8196 SoC
> 

Add a compatible string for the CCORR IP found in the MT8196 SoC.
Each CCORR IP of this SoC is fully compatible with the ones found in MT8192.


Please fix the commit description here, other than in dither and gamma.

After which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Signed-off-by: Jay Liu <jay.liu@mediatek.com>
> ---
>   .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml     | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> index fca8e7bb0cbc..581003aa9b9c 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> @@ -32,6 +32,7 @@ properties:
>                 - mediatek,mt8186-disp-ccorr
>                 - mediatek,mt8188-disp-ccorr
>                 - mediatek,mt8195-disp-ccorr
> +              - mediatek,mt8196-disp-ccorr
>             - const: mediatek,mt8192-disp-ccorr
>   
>     reg:



