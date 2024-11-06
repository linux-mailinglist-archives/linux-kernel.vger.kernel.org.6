Return-Path: <linux-kernel+bounces-398278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525F79BEEA4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099E41F25BA2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1FA1E048E;
	Wed,  6 Nov 2024 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UN0qJRID"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162D71CC89D;
	Wed,  6 Nov 2024 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899156; cv=none; b=mf9fX5qjcOWnGo7PrXNKfpUVaVo0LVYHSokMv0hdr6dytkDfmc70OSYV2WxBpDMTH1EXQpGiZazlh6cUD+9ECCz7QWX/Hd0ws7LEseXqfRW9p5/PXFWW9b1DY6hRlSP4SxTu71oOu3zgH9p3rviJ9aygv+xAF2CqfwbJ1a+CngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899156; c=relaxed/simple;
	bh=Y2kuF1y/NzxzZSdECkHXDyEvhGwvQEEzHrCK+JiFvvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/ta9EwG0Ofar5T5FRjwUxp/nDRsOsRVqHbEsKiZaT4BaTwphAS7AeInqQ/VGkb0hV0aIkE8DvWwL6a3uuKnzmEg9bFkYG67Rq7CzMchx5tkO2+gUWJ4gu1lrSBVhNL0WryOFdwcE8Dj/UIvzGC0wbDPiUH3ecFSnGKP3JlblWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UN0qJRID; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730899152;
	bh=Y2kuF1y/NzxzZSdECkHXDyEvhGwvQEEzHrCK+JiFvvM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UN0qJRIDf4u6ncttlCK8iOruGkwAbwef2x9WrpUy9FNLFlitXgFWepwQ+0TNStCA0
	 13oClNhi0cghSZgnpcGa+2XyB6g9s3LyaNFRlZhV6HkLtzV+YCp52WkYxl+6rhhJ0l
	 tjtRNaEbm8uNuSELwvJFR6floWAkbKrolFLAgKLuUay+ZcKMeiuJgKKh/U9qhOpIcB
	 rkjiU2uzTUJkhN0PFi/gL27q/pxy0ynZHQfdtYZkwdzNFucQmnzAhbQVAbg6nom+8h
	 8s79lL/sp4rZ/N9q3pLpX6MTjtfsqF0QeGUcM090msrFrOTiCOXkrwGRYulYL2lsjI
	 bD9TJoq+mZCyA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D9BD917E3624;
	Wed,  6 Nov 2024 14:19:11 +0100 (CET)
Message-ID: <eb0a7307-de25-47b1-aaed-032c7734ec70@collabora.com>
Date: Wed, 6 Nov 2024 14:19:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: mediatek: Add MT8188 Lenovo
 Chromebook Duet (11", 9)
To: Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20241105093222.4055774-1-fshao@chromium.org>
 <20241105093222.4055774-2-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241105093222.4055774-2-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/11/24 10:30, Fei Shao ha scritto:
> Add entries for the MT8188-based Chromebook "Ciri", also known as
> Lenovo Chromebook Duet (11", 9).
> 
> This device features a detachable design with touchscreen, detachable
> keyboard and USI 2.0 Stylus support, and has 8 SKUs to accommodate the
> combinations of second-source components.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


> ---
> 
> (no changes since v1)
> 
>   Documentation/devicetree/bindings/arm/mediatek.yaml | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 1d4bb50fcd8d..4b68f0baf010 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -307,6 +307,19 @@ properties:
>             - enum:
>                 - mediatek,mt8186-evb
>             - const: mediatek,mt8186
> +      - description: Google Ciri (Lenovo Chromebook Duet (11", 9))
> +        items:
> +          - enum:
> +              - google,ciri-sku0
> +              - google,ciri-sku1
> +              - google,ciri-sku2
> +              - google,ciri-sku3
> +              - google,ciri-sku4
> +              - google,ciri-sku5
> +              - google,ciri-sku6
> +              - google,ciri-sku7
> +          - const: google,ciri
> +          - const: mediatek,mt8188
>         - items:
>             - enum:
>                 - mediatek,mt8188-evb



