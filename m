Return-Path: <linux-kernel+bounces-335589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D13797E7CE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA951F21E39
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1EC1946AA;
	Mon, 23 Sep 2024 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ab2SuDMw"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CC194138;
	Mon, 23 Sep 2024 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081156; cv=none; b=BeW/byNSwnvLLd/inMm2P4BWXSBe0PSkJe5JkYoEgsLGXWaEnfOJF2PZAyOA9gUSl/iLxINkDuIFAJY54Ous/jgr95JGNsc0p5of2UCfs345XT8MrnUYuoSwAyP1W1O8oIOwzxbotGN+wq5ejWICmC4WsSz6uVDPHEY9aqHZGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081156; c=relaxed/simple;
	bh=mXPvosYulSuPT7ayp0NuQzaRA/qTKHHryuamBJ6tKAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkl1CVSYSGn+84inLuquQA8JyAYtEODwJb1wf5xg6dfkN7Wg/kaiEQPv+YF7pAH59Ye+kmoTMb6xNbyeQFETMO35FLzG+pVs5AXwIMwO/tFinvrIOEwVpL2AIPucmC/i+AQ8H/EnbgulWagnz9Ryto1Oew2VmthSS9X1m2kWu7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ab2SuDMw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727081152;
	bh=mXPvosYulSuPT7ayp0NuQzaRA/qTKHHryuamBJ6tKAg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ab2SuDMwkBRp5z1ddjV1kndbZFoRoDJs/gbRp/1F6QHds+SsCPAzvxlvzwfr1kenn
	 NZiDzC1RWIb20y3TC0kfXXVsLYmVVvs0+TWow8hdLM2B0/jhqI99oyJuR5RGymHlIZ
	 vQ1niFnx6iCwtONJyeTXI6WtJK1pC3JKJVebO6e03M1PGQAg/AilT3w3v6VFyn2m4i
	 iTvp8OTsqw+/CUexEupeYI1I7VjyV69dstsjESnmZPGG4LYz5O+6D3azcm6dhKapdS
	 9lYKdJ1R2mcDAxtgizIdjq1TGMDv2N4nJSqCnYsMc8bJ3GU0ANeYVZliPo/qFcoj/R
	 HaAZMWUNdAj7Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4419E17E1063;
	Mon, 23 Sep 2024 10:45:52 +0200 (CEST)
Message-ID: <eb17085d-78ff-4833-a4de-17b9327d776c@collabora.com>
Date: Mon, 23 Sep 2024 10:45:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: mediatek: mt8390-genio-700-evk: Enable
 Mali GPU
To: Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240920134111.19744-1-pablo.sun@mediatek.com>
 <20240920134111.19744-6-pablo.sun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240920134111.19744-6-pablo.sun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/09/24 15:41, Pablo Sun ha scritto:
> Configure GPU regulator supplies and enable GPU for GENIO 700 EVK.
> 
> The GPU in MT8390 & MT8188 has two power inputs: "DVDD_GPU" and
> "DVDD_SRAM_GPU". In Genio 700 EVK, DVDD_GPU is supplied by
> mt6359_vproc2_buck_reg, and DVDD_SRAM_GPU is supplied by
> mt6359_vsram_others_ldo_reg.
> 
> According to section 5.2 "Recommended Operating Conditions" in
> MT8390 IoT Application Processor Datasheet v1.9, The recommended
> operating voltage ranges are:
> 
> - DVDD_GPU: min 0.55V, max 0.86V, typical 0.75V
> - DVDD_SRAM_GPU: min 0.71V, max 0.92V, typical 0.85V
> 
> In this commit, we set DVDD_SRAM_GPU to typical 0.85V. It is possbile
> to couple it to the DVDD_GPU in future patches.
> 
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>

Is there any real difference between MT8390 and MT8188 in terms of the GPU OPPs?

I see that on MT8188, frequencies up to 880MHz want a DVDD_SRAM_GPU of 0.750V,
then 0.775/0.762/0.750 (bin1-4/5/6) on 915MHz, and 0.800/0.775/0.750 (bin1-4/5/6)
on 950MHz.

Those never call for 0.850V...! So is MT8188 (Chromebooks) wrong, or is MT8390
different in that?

Cheers,
Angelo

> ---
>   .../dts/mediatek/mt8390-genio-700-evk.dts     | 24 +++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> index 1474bef7e754..a1d6f4cd4e5f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> @@ -190,6 +190,11 @@ usb_p2_vbus: regulator-10 {
>   	};
>   };
>   
> +&gpu {
> +	mali-supply = <&mt6359_vproc2_buck_reg>;
> +	status = "okay";
> +};
> +
>   &i2c0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2c0_pins>;
> @@ -253,6 +258,14 @@ &i2c6 {
>   	status = "okay";
>   };
>   
> +&mfg0 {
> +	domain-supply = <&mt6359_vproc2_buck_reg>;
> +};
> +
> +&mfg1 {
> +	domain-supply = <&mt6359_vsram_others_ldo_reg>;
> +};
> +
>   &mmc0 {
>   	status = "okay";
>   	pinctrl-names = "default", "state_uhs";
> @@ -314,6 +327,11 @@ &mt6359_vpa_buck_reg {
>   	regulator-max-microvolt = <3100000>;
>   };
>   
> +&mt6359_vproc2_buck_reg {
> +	regulator-min-microvolt = <550000>;
> +	regulator-max-microvolt = <860000>;
> +};
> +
>   &mt6359_vpu_buck_reg {
>   	regulator-always-on;
>   };
> @@ -326,6 +344,12 @@ &mt6359_vsim1_ldo_reg {
>   	regulator-enable-ramp-delay = <480>;
>   };
>   
> +/* for GPU SRAM */
> +&mt6359_vsram_others_ldo_reg {
> +	regulator-min-microvolt = <850000>;
> +	regulator-max-microvolt = <850000>;
> +};
> +
>   &mt6359_vufs_ldo_reg {
>   	regulator-always-on;
>   };


