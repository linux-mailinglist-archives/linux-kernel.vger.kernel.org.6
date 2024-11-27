Return-Path: <linux-kernel+bounces-423510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC4E9DA899
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73F9166E60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939691FDE3F;
	Wed, 27 Nov 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="InYNZXhi"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B51FCFF3;
	Wed, 27 Nov 2024 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714495; cv=none; b=iHxgM1SoXdwvRcRkbL5uNNPkYVZCqra1IYPfe/ILHA8KaVr4zqJsS7YaNLOUf2K5hAfYcXdZxmWA72FkpQ1g9i6o/0q5Pq2gHs+7EafTQ0anuqCSulmv85Tc9h0Zls9XcvUfPe0bIVP2Z7CJz3Y8TIjtLtxh4wjY6CAsvoYXDxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714495; c=relaxed/simple;
	bh=sdoa3Ne+JZfyGrUUlsVEBdOsjkPTBJLSWaehMxJ0ACA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlbUQ29pOBQaGVdCDZImmLeIkDlhjzlU0aMP9DDaL3XUwsk7eC81s3eY5m6KkIx7/hf4YGXgyFJGNrMzQWPATnyccmuOCKWqAbf3AVVFYWrwW64vgO/xPrHFZRz2p/rSnmWXLZKsKFotDjfdOM7KILdbc7tFgriIrXa7JX4SM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=InYNZXhi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732714491;
	bh=sdoa3Ne+JZfyGrUUlsVEBdOsjkPTBJLSWaehMxJ0ACA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=InYNZXhiFkr6p53KM3FGah8zfTBO12oNo7UbkyufiWo6tUA/4c3cUHeYWbUGdcKcf
	 HObY80/yOF2SKr2k6Yzt4cpyyypJPogjOtyeyZAvTxcxTVKlEagVmDtFd9ZzgM+Ms0
	 E6CpSgPX+PNZxp+X2/PlkLFEpreTIxZxgaUTDpCNhHhq28FxSi068upZUAA4XD6+cW
	 yPBPMXBVGS0TDkhRyryKcTA+e9FzON5wcaLqT2RL2qdvTzpWaSeHNKUk1RZMvwRwt6
	 6j5Px9fqg/w3UzRPSjObcQYkXjtZOcBNwub/NVSy1KRQYPEk+7GspJBHwAOuxTyT/J
	 SKNe/ayVGOz0A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3BEB117E3700;
	Wed, 27 Nov 2024 14:34:51 +0100 (CET)
Message-ID: <28d06e3d-f589-4da8-a7d2-5c0bf263d2e5@collabora.com>
Date: Wed, 27 Nov 2024 14:34:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 08/14] arm64: dts: mediatek: mt7988: add fixed regulators
 for 1v8 and 3v3
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241029103937.45852-1-linux@fw-web.de>
 <20241029103937.45852-9-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241029103937.45852-9-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/10/24 11:39, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add regulator nodes used for mmc.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

That's a board specific thing, not a SoC one; please add it to your board dts
instead.

Cheers,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index 639c307b9984..7371cd80a4ff 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -62,6 +62,24 @@ psci {
>   		method = "smc";
>   	};
>   
> +	reg_1p8v: regulator-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-1.8V";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-3.3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
>   	soc {
>   		compatible = "simple-bus";
>   		ranges;


