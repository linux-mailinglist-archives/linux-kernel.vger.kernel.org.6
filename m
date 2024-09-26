Return-Path: <linux-kernel+bounces-340128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D62AE986ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF2F1F228E4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B99A1AB6CF;
	Thu, 26 Sep 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l33DEuPa"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B41A76C9;
	Thu, 26 Sep 2024 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339622; cv=none; b=Sb2S/b3ne/3x06BHcQHj47ioKIPKjJRcceYRn+jBfgamYH7naSbB/CfB3Qbuqtg+PWcF2Pr4VrkIgr5oCVQ8o6ZB0cTNto6r9vHQg+A5qcoAlZKWNt2J+8Hr4CyoAdymp5WMqPpUE4KgZbCMwsl8ve0wM4F4YeTErr4CuQhK0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339622; c=relaxed/simple;
	bh=NpmX2svJJ4CDW8F4r8nC7PPzPmar7GK9o77BlzQWdfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p277/6THebVwkogzzht9Gb1bwJMD1qK3Nth2/o7MHAEicINAlSBnkcDiuaqdt367b5rLU+y2KRE06oMbaCYzeIOvURSsteLIa1W4F9+WiyhOb6hr1Yx5V8kbnq1yx0328t7NIXZIk8sG78O3ah8hOJcuBdC2ST/NYhRMDtxrUUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l33DEuPa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727339618;
	bh=NpmX2svJJ4CDW8F4r8nC7PPzPmar7GK9o77BlzQWdfA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l33DEuPa37wbIu4/YTxgFXOpuv2+j9FQdVilxgCsG8RI9RKwwN0HlPCfcrhB0K8nU
	 7yrga93CjN7+86ZbMlgVApQ2mGcvyRaGs//EAe3O2/ZjR6vnBOqBAlyBzujhGhIPap
	 zCFTBZnuOaaivCMHHpbXVWvllqF34bM6MFN6JDf6JXo4S+87A/XBb0Ansfi/Oq4Zso
	 oNoJ5oKT92Q2sH7RGAJgNj9T9zqeimYaJeE1Zypg+V4q0CAIjBD4xKOZiPCsCFUKxN
	 E0sTKdwxfMo2dvCH1k9giTF8nR6wnNZiEfp4Y1FQ82mazKSk2Kaw1jeXgZWk5zG8vC
	 gtceF0la5YUfQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6715017E1048;
	Thu, 26 Sep 2024 10:33:38 +0200 (CEST)
Message-ID: <fbdbe9ff-586a-429c-a987-b8ec39b485e8@collabora.com>
Date: Thu, 26 Sep 2024 10:33:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm64: dts: mediatek: mt8188: Define CPU big core
 cluster
To: Fei Shao <fshao@chromium.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240925110044.3678055-1-fshao@chromium.org>
 <20240925110044.3678055-4-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240925110044.3678055-4-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/09/24 12:57, Fei Shao ha scritto:
> The MT8188 SoC features two CPU clusters: one with 6 little Cortex-A55
> cores, and the other with 2 big Cortex-A78 cores.

No, it doesn't. It features only one cluster, so...

> 
> Update the CPU topology to reflect the actual hardware configurations.

...the actual hardware configuration is already reflected by the currently
declared CPU topology, so for this commit: NAK.

This SoC uses the ARM DynamIQ technology and embeds both LITTLE and big
cores in one single cluster.
Check the MT8188 datasheet for more information :-)

Cheers,
Angelo

> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> index cd27966d2e3c..51bf08b2ff9b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -195,12 +195,14 @@ core4 {
>   				core5 {
>   					cpu = <&cpu5>;
>   				};
> +			};
>   
> -				core6 {
> +			cluster1 {
> +				core0 {
>   					cpu = <&cpu6>;
>   				};
>   
> -				core7 {
> +				core1 {
>   					cpu = <&cpu7>;
>   				};
>   			};



