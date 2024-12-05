Return-Path: <linux-kernel+bounces-433264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF1D9E55BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1439164E21
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273D2218AA1;
	Thu,  5 Dec 2024 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e0zKmW/e"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF41FA179;
	Thu,  5 Dec 2024 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402530; cv=none; b=QyjOICK8fGyugtRjjnIMhsH9L2xWvvf0qdAWGZt/10IEtsErVE02Otx1k6VqRfeSn60bzWZLP6dyJU+q8O+scfe01wKLWZaO//BNUI78+ePI1r9z/ICwKpvjBvP82Dw0OgRmoKFOHJdM3jqin6OxdG/5E/8/dPDuhNz6ua1f/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402530; c=relaxed/simple;
	bh=LM2gUsX/c1KVTYV3HmF0p9792S12iewI4CRKDypr+as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J48/6+Hul8xGBu5wxLYYR8eoZ2JsyZEN02fKVpV8U4FHKIrYbaRQQf0IHwSBFCf8P49DxNeplah2+0nqWULZM+N5fFEdXyvUD1vf5X2kRvehGrGnj4fGu7XFXytVvGBRfctG5EFuYFJ0K63UV51M8MlJIeTX2OCDSMk8gS6ie1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e0zKmW/e; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733402527;
	bh=LM2gUsX/c1KVTYV3HmF0p9792S12iewI4CRKDypr+as=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e0zKmW/eBTcWod3x01BANWCi2/KHwDjSdRb9jaCq0pv8j2puM8OFQ8CY4ZbUboONF
	 xcIfdySa4bT4UbJviXFc7XTv/0D1LRrt2gnhO6qfPWT1DcTgNEna/uXvC76kvZ/sqn
	 LzTRf89s8zrcVzPUJQvSdZVtMLNiU92WI/yfuF7BBbZDXoCPqtdk7otxuk08laXnT9
	 m9buhbyjhHqkAnsaF+N5PG6MVkiTqwUTX0d13GnshiMbjcnYB0PZaJEa+1dPKswzlk
	 1Nq+ReaDNS6SW0qlGisTH0CvdFO0k6y91n4BNNcTjwv+6vMPkY7RZZnGoWEe3k9iz6
	 ovUvEzRTUb+7g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8852C17E367E;
	Thu,  5 Dec 2024 13:42:06 +0100 (CET)
Message-ID: <ce2f6f07-0276-4a8b-ae3f-4188c707c6e7@collabora.com>
Date: Thu, 5 Dec 2024 13:42:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: mediatek: mt8390-genio-700-evk: Add sound
 output support
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org,
 Aary Patil <aary.patil@mediatek.com>,
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>,
 parkeryang <Parker.Yang@mediatek.com>
References: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
 <20241205-genio700-audio-output-v1-5-0e955c78c29e@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241205-genio700-audio-output-v1-5-0e955c78c29e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/12/24 13:13, Nícolas F. R. A. Prado ha scritto:
> Describe all the components to get sound output working on the two audio
> jacks, Earphone and Speaker, present on the Genio 700 EVK board with the
> audio DSP enabled.
> 
> Co-developed-by: Aary Patil <aary.patil@mediatek.com>
> Signed-off-by: Aary Patil <aary.patil@mediatek.com>
> Co-developed-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
> Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
> Co-developed-by: parkeryang <Parker.Yang@mediatek.com>
> Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   .../boot/dts/mediatek/mt8390-genio-700-evk.dts     | 50 ++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> index bb68665f0b2da80397b833db0241a06648a322a0..2fded39078773e81d8e0313d6b118b3064be308d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> @@ -92,6 +92,24 @@ vpu_mem: memory@57000000 {
>   			compatible = "shared-dma-pool";
>   			reg = <0 0x57000000 0 0x1400000>; /* 20 MB */
>   		};
> +
> +		adsp_mem: memory@60000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x60000000 0 0xf00000>;
> +			no-map;
> +		};
> +
> +		afe_dma_mem: memory@60f00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x60f00000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		adsp_dma_mem: memory@61000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x61000000 0 0x100000>;
> +			no-map;
> +		};
>   	};
>   
>   	common_fixed_5v: regulator-0 {
> @@ -209,6 +227,16 @@ usb_p2_vbus: regulator-9 {
>   	};
>   };
>   
> +&adsp {
> +	memory-region = <&adsp_dma_mem>, <&adsp_mem>;
> +	status = "okay";
> +};
> +
> +&afe {
> +	memory-region = <&afe_dma_mem>;
> +	status = "okay";
> +};
> +
>   &gpu {
>   	mali-supply = <&mt6359_vproc2_buck_reg>;
>   	status = "okay";
> @@ -912,6 +940,28 @@ &scp {
>   	status = "okay";
>   };
>   
> +&sound {
> +	compatible = "mediatek,mt8390-mt6359-evk", "mediatek,mt8188-mt6359-evb";
> +	model = "mt8390-evk";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&audio_default_pins>;
> +	audio-routing =
> +		"Headphone", "Headphone L",
> +		"Headphone", "Headphone R";
> +	mediatek,adsp = <&adsp>;
> +	mediatek,dai-link = "DL_SRC_BE", "UL_SRC_BE", "AFE_SOF_DL2",
> +		"AFE_SOF_DL3", "AFE_SOF_UL4", "AFE_SOF_UL5";

Are you really, really, really, extremely sure that you need mediatek,dai-link?

I say you don't... :-)

Cheers,
Angelo


