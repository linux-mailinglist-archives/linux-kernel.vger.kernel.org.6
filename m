Return-Path: <linux-kernel+bounces-185081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5F88CB042
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD855B25B69
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9E412F38C;
	Tue, 21 May 2024 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o70/lrZQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EDD12F367;
	Tue, 21 May 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301254; cv=none; b=fHC9BKhGniFQnHmU318Jn0cu9lsSu4Fj0qUdoclfJUrOK5C877DKB5fAu6Hr6Cj5vUXyMyLFEwCeTJ+VentnrRP+3SvzDLeuFAF+v4cSr9F8fMWXAPiZaSszwTBT2FfPbLneX/MpU69XgbIvj6S4ogm7HjSayEYVO67UBVh90io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301254; c=relaxed/simple;
	bh=ob1GNOfz5cddtQfrGwpItXm/m+C87OwgfymK2tp/LRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCgvjjbKqe7caax5jTDw1f9vxwvBq3d3e2NBD0k/VHbzRUOZeIu64zqRZB/xsBQdBbQavDE/i5vr2iitQEPZsXS4S4uBAERRMStobA285PSOpOTDfhtxKHErTnHYE+e4T3I+IM9gPV1C+uKLuo/yHZUHiBBGbWNfpCok/p2GJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o70/lrZQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716301251;
	bh=ob1GNOfz5cddtQfrGwpItXm/m+C87OwgfymK2tp/LRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o70/lrZQvTnRoU+FH0yy9rWF7cq1CtvKK2YvBBP31GynGjQQ5pdli6lR+lBq4VaTx
	 8pOxQeS8WJWJKiHxAsnd1zZj5sJz6xqPhMbSwsFOzDXMao+j2KvWNsCcRMmvruKTa3
	 m5w9+LC0ZtvLfgCYL3OpFoMNsO89HBwBLI/B7im2UhTlb86VXdQ1F6sNkzBDfC0nY3
	 f+t8xIemA3E2CygpctLfZPnuYBdKvgyG+74VJUIStK5YhG2VUpLMoUAozJFHhgEU8T
	 X0RcKWhsv5fXY/qDbVZ2pEAT6/mBDPEX17JngKgUrRluQge1eDZ0cYYu/JocKUwDTM
	 K4QGTCYnYnO/g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0C5103782137;
	Tue, 21 May 2024 14:20:50 +0000 (UTC)
Message-ID: <cdc6288f-c118-445f-8c06-b979e243d38c@collabora.com>
Date: Tue, 21 May 2024 16:20:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] arm64: dts: mediatek: mt8186: add default thermal
 zones
To: Julien Panis <jpanis@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240521-mtk-thermal-mt818x-dtsi-v4-0-b91ee678411c@baylibre.com>
 <20240521-mtk-thermal-mt818x-dtsi-v4-2-b91ee678411c@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240521-mtk-thermal-mt818x-dtsi-v4-2-b91ee678411c@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/05/24 16:05, Julien Panis ha scritto:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Inspired by the vendor kernel but adapted to the upstream thermal
> driver version.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 290 +++++++++++++++++++++++++++++++
>   1 file changed, 290 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index caec83f5eece..ac49a33d1b54 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -13,6 +13,8 @@
>   #include <dt-bindings/power/mt8186-power.h>
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/reset/mt8186-resets.h>
> +#include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
>   
>   / {
>   	compatible = "mediatek,mt8186";
> @@ -2197,4 +2199,292 @@ larb19: smi@1c10f000 {
>   			power-domains = <&spm MT8186_POWER_DOMAIN_IPE>;
>   		};

.snip..

> +
> +		mfg-thermal {

This is the GPU zone. For this entire node, s/mfg/gpu/g

> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
> +			thermal-sensors = <&lvts MT8186_MFG>;
> +
> +			trips {
> +				mfg_alert0: trip-alert0 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				mfg_alert1: trip-alert1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +
> +				mfg_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};

Regards,
Angelo


