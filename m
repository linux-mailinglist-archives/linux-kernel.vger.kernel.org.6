Return-Path: <linux-kernel+bounces-433233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC9E9E5566
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F711280CB1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A59218853;
	Thu,  5 Dec 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TTCBjD+t"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47015218597;
	Thu,  5 Dec 2024 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401617; cv=none; b=p1CqyoOBRDgwlBFSlKV6fKIjBJ4s0hKyN/36gs/k2SBGYKZNBAycsZH39kNDDyTeR/cGBqZUXrIYUKPc4Q1k0d9wB0xzAXABx6dVAaqu7K5h86/6LUcu2/pCXBZLJqE2g/wRuG1kCPKMaF1lgQXwwPBGRpMtO9tmyZ6r0JrPMXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401617; c=relaxed/simple;
	bh=zsPKHnrcacW6vTwMq+rykbMwQmETfVdATKj5CCRdNEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L87vzT2X28pBAjpdH0/HZzSxlH6uJDqnYnP9DIpYedQyhFC5JSzNRgdl6o5OG2VKvVKkg1nydY7odJ5ZRhcuPUq76ESferFd0u/kWAcWdQrHha6xasZBFaUGm848JC91m9JbE+CcHt9vUKrLKw70WS3Nm8yDtCfoxt+gVwOwgwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TTCBjD+t; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733401614;
	bh=zsPKHnrcacW6vTwMq+rykbMwQmETfVdATKj5CCRdNEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TTCBjD+tdZW5GtuKCQPy/E8lAVHKaqkuLpeREytZM3+ChFIFcx6LGYMTzl7NtDdJj
	 Pp+qTOEo0mhwDYWjHXGx/s0tXcbJ7peBuJ6s5G6GzGfpcDW2hqgKc2JwKaLY6gq6Ce
	 93KiPkfHC9WavruXoVdlFFqfFlZhjd9v+2h+RBbj/xQYpfCEOtiZ2sVoTGuXIfxqZT
	 2wRVJ71jgz4MYPDLulEOVH3s/Y7/fRL01HaS6d848u4JF6t6pOS8E4aHdh02hn1qi4
	 q1WJd7NPcgAIagjKs1pIFALiUgqDlSIvMKCGkof7d8oO20r9aPuSWw6ARXTf9ci0vv
	 hGp73UBEufrbw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2D79D17E35D8;
	Thu,  5 Dec 2024 13:26:54 +0100 (CET)
Message-ID: <9e19d117-ad78-43d0-990e-e3b881428601@collabora.com>
Date: Thu, 5 Dec 2024 13:26:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: dts: mediatek: mt8516: fix GICv2 range
To: Val Packett <val@packett.cool>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Fabien Parent <fparent@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241204190524.21862-1-val@packett.cool>
 <20241204190524.21862-2-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241204190524.21862-2-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/12/24 20:05, Val Packett ha scritto:
> On the MT8167 which is based on the MT8516 DTS, the following error
> was appearing on boot, breaking interrupt operation:
> 
> GICv2 detected, but range too small and irqchip.gicv2_force_probe not set
> 
> Similar to what's been proposed for MT7622 which has the same issue,
> fix by using the range reported by force_probe.
> 
> Link: https://lore.kernel.org/all/YmhNSLgp%2Fyg8Vr1F@makrotopia.org/
> Fixes: 5236347bde42 ("arm64: dts: mediatek: add dtsi for MT8516")
> Signed-off-by: Val Packett <val@packett.cool>

Yeah, that's fine, I agree.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8516.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> index d0b03dc4d3f4..444429341302 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> @@ -268,7 +268,7 @@ gic: interrupt-controller@10310000 {
>   			interrupt-parent = <&gic>;
>   			interrupt-controller;
>   			reg = <0 0x10310000 0 0x1000>,
> -			      <0 0x10320000 0 0x1000>,
> +			      <0 0x1032f000 0 0x2000>,
>   			      <0 0x10340000 0 0x2000>,
>   			      <0 0x10360000 0 0x2000>;
>   			interrupts = <GIC_PPI 9


