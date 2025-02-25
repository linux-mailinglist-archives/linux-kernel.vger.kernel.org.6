Return-Path: <linux-kernel+bounces-531052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6E6A43BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E841765FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2242673BD;
	Tue, 25 Feb 2025 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hN+jpoEG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B93266B62;
	Tue, 25 Feb 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479008; cv=none; b=aoK274NCpXtVCDpH/DLXlFgJbSBSBSdCu3Sz0drAIOt/nSkQGG+3rGoinnR1vJjlGOivzs5/Cpvk9Arul4r/ERCKuHuNlJp8/p4a2a+56tW8MScLJ5O0eRDdbvtkwgrPeYuTUzZZ1SSvKZjX7xH8dISM1r0xCCvFqVU9IEUQOjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479008; c=relaxed/simple;
	bh=CNvff+RVUf9q6DmURZwaRmGW7rpo3fSwYqmNvnCRmMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SM/1++ZVOg67MoDzYWggPn6C24v05qWMgH7csCLiEzV6dHEtj6LomTJ0yokSuPHTexWJy6yKwdlQ2ZeutKI6v906SqubOGsSi4orHEmNDpMm1fYYnd+TE/e+yF+uOsqFFuCIUFtDVpC7MQgY1aLggF49DM7oW5rkmC/9ohQVyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hN+jpoEG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740479004;
	bh=CNvff+RVUf9q6DmURZwaRmGW7rpo3fSwYqmNvnCRmMQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=hN+jpoEGjCDSbnpP+9gx0l0DifI2Au8F2f0rG7AI8v/HWycLTVDof/2PfqeAuXd2X
	 Dj8S8hAOlPhyKA0OjhykhGk7MfBGyU+EpGwThEUgGQKMqPD6RPcdOJMbAVsXqvIUD8
	 Kun5yD7MlgKOOU45vpHJBkQt6BXsHsUqcZzFtCJSU14HvqdMM37vAVecZ+cH5LLovd
	 D6B02K3nfiz6hMkpd0lZNCp5kHpLD5vLU4HF00aBe+CZVNPuTydaVNhTb1+05id9o7
	 6dNZuwbkQ5BkakfJMsrmj0L6e3/6tOZ6cMZ5ayNQ2lEGWlSNYdQUkytmdldrgEY8qe
	 sRrFXkpCUcxTA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A485117E09E7;
	Tue, 25 Feb 2025 11:23:23 +0100 (CET)
Message-ID: <c50e114a-bb5b-40a4-ab01-69ee33b984b8@collabora.com>
Date: Tue, 25 Feb 2025 11:23:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: dts: mediatek: mt8183: Switch to undeprecated
 qcom,calibration-variant
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250225101828.107509-1-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225101828.107509-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/25 11:18, Krzysztof Kozlowski ha scritto:
> The property qcom,ath10k-calibration-variant was deprecated in favor of
> recently introduced generic qcom,calibration-variant, common to all
> Qualcomm Atheros WiFi bindings.
> 
> Change will affect out of tree users, like other projects, of this DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Ah, finally. That's nice :-)

Regardless of the RFC status....:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> 
> Dependency/RFC!
> 
> RFC, because this should be merged release after driver support is
> merged:
> https://lore.kernel.org/linux-devicetree/20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org/T/#t
> ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts     | 2 +-
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts      | 2 +-
>   .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts      | 2 +-
>   .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts      | 2 +-
>   .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts      | 2 +-
>   .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts    | 2 +-
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts  | 2 +-
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi  | 2 +-
>   .../boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts      | 2 +-
>   .../boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts      | 2 +-
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi   | 2 +-
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi           | 2 +-
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts       | 2 +-
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts       | 2 +-
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi           | 2 +-
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi            | 2 +-
>   16 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts
> index 83bbcfe62083..f2303d9f125f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts
> @@ -35,5 +35,5 @@ trackpad@2c {
>   };
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_COZMO";
> +	qcom,calibration-variant = "GO_COZMO";
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
> index 3935d83a047e..13ec15fa284f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
> @@ -31,7 +31,7 @@ &mt6358codec {
>   };
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_DAMU";
> +	qcom,calibration-variant = "GO_DAMU";
>   };
>   
>   &i2c2 {
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
> index 72852b760038..b576b974cf23 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
> @@ -40,6 +40,6 @@ &touchscreen {
>   };
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_FENNEL";
> +	qcom,calibration-variant = "GO_FENNEL";
>   };
>   
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
> index 757d0afd14fb..d64581f35d2c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
> @@ -28,6 +28,6 @@ &touchscreen {
>   
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_FENNEL";
> +	qcom,calibration-variant = "GO_FENNEL";
>   };
>   
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
> index 6641b087e7c5..d0c98d0aba95 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
> @@ -28,6 +28,6 @@ &touchscreen {
>   
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_FENNEL";
> +	qcom,calibration-variant = "GO_FENNEL";
>   };
>   
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts
> index 877256eab262..3a81786084da 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts
> @@ -14,5 +14,5 @@ / {
>   };
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_FENNEL14";
> +	qcom,calibration-variant = "GO_FENNEL14";
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts
> index b981dd31a430..959c4d3d9707 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts
> @@ -14,5 +14,5 @@ / {
>   };
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_FENNEL14";
> +	qcom,calibration-variant = "GO_FENNEL14";
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi
> index 078bc765646f..4788edaeab87 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi
> @@ -22,6 +22,6 @@ trackpad@2c {
>   };
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_JUNIPER";
> +	qcom,calibration-variant = "GO_JUNIPER";
>   };
>   
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
> index ddb993521bbf..01cd59993a7c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
> @@ -14,7 +14,7 @@ / {
>   };
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_FENNEL14";
> +	qcom,calibration-variant = "GO_FENNEL14";
>   };
>   
>   &mmc1_pins_uhs {
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
> index 10c4f920a7d8..c939ef3965ec 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
> @@ -14,7 +14,7 @@ / {
>   };
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_FENNEL14";
> +	qcom,calibration-variant = "GO_FENNEL14";
>   };
>   
>   &mmc1_pins_uhs {
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
> index c942e461a177..14d03419b92c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
> @@ -37,5 +37,5 @@ trackpad@2c {
>   };
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_JUNIPER";
> +	qcom,calibration-variant = "GO_JUNIPER";
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> index ff02f63bac29..c4c08c0f715e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> @@ -370,7 +370,7 @@ keyboard-controller {
>   };
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_KAKADU";
> +	qcom,calibration-variant = "GO_KAKADU";
>   };
>   
>   &panel {
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
> index 2b5a8d1f900e..7428efec95a0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
> @@ -32,5 +32,5 @@ &panel {
>   };
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_KATSU";
> +	qcom,calibration-variant = "GO_KATSU";
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
> index 75fadf2c7059..a36b6ddb71f6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
> @@ -32,7 +32,7 @@ &panel {
>   };
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_KATSU";
> +	qcom,calibration-variant = "GO_KATSU";
>   };
>   
>   &sound {
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> index da6e767b4cee..2b283a55f653 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> @@ -349,7 +349,7 @@ keyboard-controller {
>   };
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "GO_KODAMA";
> +	qcom,calibration-variant = "GO_KODAMA";
>   };
>   
>   &i2c_tunnel {
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> index 8b56b8564ed7..00da50a41574 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> @@ -353,7 +353,7 @@ keyboard-controller {
>   };
>   
>   &qca_wifi {
> -	qcom,ath10k-calibration-variant = "LE_Krane";
> +	qcom,calibration-variant = "LE_Krane";
>   };
>   
>   &sound {



