Return-Path: <linux-kernel+bounces-268766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3466694290A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C701C2284E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805FF1A76B3;
	Wed, 31 Jul 2024 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ex5C/Yg7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222E01A7F9F;
	Wed, 31 Jul 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413999; cv=none; b=ERm1tVd6gUTIBt2Cu/n1my0pbXVW81eLfMWu3oNnhjQLGLuc7UZ9qmZ/Pui8rZeCWkgOSTPn7tGxfTVN614+QIMfDCifLy4CwavCJBI6/LKc3njwe5ECcs6DtusoPwY839UnO4qjpabHpdWXxraFqPBp07L/B6koXZ6M7Ul3308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413999; c=relaxed/simple;
	bh=mrhS/CCOOLZe9KQcoq1oQixTFVyt0KJQA7x9+zGR/K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxgdwxJ9w+RToewRnoFhWDwAvpdea7izfS9YY1mHj+b7TA/WLWLjVqPhkFCBw/pMFb68ZUVqNKVwa6wcjEPVsYrQBAXyzx3tzYbBSaN8qnjdBUIBk7XeFq3GuKFHw88WsHgvOIhZ44y3NR9YHZ3ychRpHvIHPuTgbLXz67Xg4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ex5C/Yg7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722413996;
	bh=mrhS/CCOOLZe9KQcoq1oQixTFVyt0KJQA7x9+zGR/K8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ex5C/Yg7cE3mf8MoncxyQ8zZv7dkOOubpQA0xVjlLHlRZN0moIPuegQyZMWxZLR1C
	 ILgzNQAdoIOJ9waU0cbz9b5D15Ggb4I3n9PIAxzEaOnB1WgYd5AdPU/qYiP+13VR1K
	 hpgRidRV5LAqeGrVcx55LiVXqb2tGZvaRfRRG32zwDUGKA964buoKYV7XKDUNHaWrI
	 5KNDC/ypO8R32WZxz9fhePPgsK+i+McMaTAsiIPfkVbrWZUXpH95YIIdH4M5tPSUSs
	 cUrB4nKMV03GDvEJSliA4Oh9jasyqXfQ0pta9c51dozkXuoZtETBtCPgYx1EYrzpPP
	 ILiDa1lCMpmcQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 06B9E378000B;
	Wed, 31 Jul 2024 08:19:55 +0000 (UTC)
Message-ID: <a5d5d7f1-535c-4139-9cfb-b4e4fffc3083@collabora.com>
Date: Wed, 31 Jul 2024 10:19:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: arm64: mediatek: Add
 kukui-jacuzzi-cerise board
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240731-jacuzzi_dt-v2-0-4995335daa30@chromium.org>
 <20240731-jacuzzi_dt-v2-2-4995335daa30@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240731-jacuzzi_dt-v2-2-4995335daa30@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 31/07/24 08:26, Hsin-Te Yuan ha scritto:
> Cerise is known as ASUS Chromebook CZ1.
> Stern is known as ASUS Chromebook Flip CZ1.
> 
> They are almost identical. The only difference is that Cerise is a
> clamshell device without touchscreen and Stern is a convertible device.
> 
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   Documentation/devicetree/bindings/arm/mediatek.yaml | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 1d4bb50fcd8d..087773a43673 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -146,6 +146,20 @@ properties:
>           items:
>             - const: google,burnet
>             - const: mediatek,mt8183
> +      - description: Google Cerise (ASUS Chromebook CZ1)
> +        items:
> +          - enum:
> +              - google,cerise-sku0
> +              - google,cerise-rev3-sku0
> +          - const: google,cerise
> +          - const: mediatek,mt8183
> +      - description: Google Stern (ASUS Chromebook Flip CZ1)
> +        items:
> +          - enum:
> +              - google,cerise-sku1
> +              - google,cerise-rev3-sku1
> +          - const: google,cerise
> +          - const: mediatek,mt8183
>         - description: Google Cozmo (Acer Chromebook 314)
>           items:
>             - const: google,cozmo
> 


