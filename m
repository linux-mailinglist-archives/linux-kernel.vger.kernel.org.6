Return-Path: <linux-kernel+bounces-433232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0830F9E5565
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803EE18841C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2688E218839;
	Thu,  5 Dec 2024 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SNpGXDmI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D896E2185B0;
	Thu,  5 Dec 2024 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401612; cv=none; b=UHgOa11HVxv2fafqN44wKKMJGN1ol+oiyf41fWzaNtcJrEnGjxETYoNaqQ+D11L6f9tX6YPW5xzT4Zu2AOlpayAscz3g5s+mXRpKZGUgxpphlP8DxfJ2u7zZqOpHR4NT14pFI1LMsRrQ1w1ms5q+YB75m0v6uTOq0CrydGuxoUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401612; c=relaxed/simple;
	bh=g9tQsWZEgpAzauiZeojXOmlzi/LihZGmyZsC+hkQVQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9dn8LrWx9k8vnJy2nEdio68xJ/uZXMJdnAH89EnKpEsEEYp6Kj566kIxW9XJ3UxG408flzLNiJi5sYVzRMw1N221RdUE35GF7ehelZkRp8xJnK/pv4iYuOsygFCS6BtFlpi05Y/l2B4tp6sgI04kXPPgXGKq6WlidszB552oOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SNpGXDmI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733401609;
	bh=g9tQsWZEgpAzauiZeojXOmlzi/LihZGmyZsC+hkQVQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SNpGXDmIAoC0TD0L9kg3VWYRWAwP4KJTgSTYwH8Lr1N/7sGp9O8i0exG+g4X66Arm
	 4L+iugIXkjSscNAMwoSKZMvCjChlWQ6gq8WhGjEccRaLnBmDpwNEG9kHPy9nby82rK
	 XL8O/QeZq9Oj3QJ42k1HCzYgj0ZHqa/8NH30onAnB/9ZovInivqb0DxzazmSEuyBSD
	 JeeDmihW+lMtSBVpkpTmEwGWaVeHBX/nFBLR9oTJXfhwIn2oLLT+fLGfk+SXnKMcFL
	 0Ruq0vc/oC62/1IJesNeUZQUiHGdR1JIkez0fZeXjtc0iZYCsjsYI5ZCLASgo43vfV
	 I4TS2OQ3nGHJQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B04E717E366D;
	Thu,  5 Dec 2024 13:26:48 +0100 (CET)
Message-ID: <ece47aeb-e9e2-4690-8103-a05a01ec7be5@collabora.com>
Date: Thu, 5 Dec 2024 13:26:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: mediatek: mt8516: fix wdt irq type
To: Val Packett <val@packett.cool>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Fabien Parent <fparent@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241204190524.21862-1-val@packett.cool>
 <20241204190524.21862-3-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241204190524.21862-3-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/12/24 20:05, Val Packett ha scritto:
> The GICv2 does not support EDGE_FALLING interrupts, so the watchdog
> would refuse to attach due to a failing check coming from the GIC driver.
> 
> Fixes: 5236347bde42 ("arm64: dts: mediatek: add dtsi for MT8516")
> Signed-off-by: Val Packett <val@packett.cool>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8516.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> index 444429341302..098c32ebf678 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> @@ -206,7 +206,7 @@ watchdog@10007000 {
>   			compatible = "mediatek,mt8516-wdt",
>   				     "mediatek,mt6589-wdt";
>   			reg = <0 0x10007000 0 0x1000>;
> -			interrupts = <GIC_SPI 198 IRQ_TYPE_EDGE_FALLING>;
> +			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
>   			#reset-cells = <1>;
>   		};
>   



