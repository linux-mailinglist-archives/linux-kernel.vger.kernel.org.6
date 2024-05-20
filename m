Return-Path: <linux-kernel+bounces-183588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19A68C9AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67EE1F217B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6811E4D9E7;
	Mon, 20 May 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cwMtKEnP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1544D58A;
	Mon, 20 May 2024 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199666; cv=none; b=gNx5cZuV4DawcHkwF2usijAuxArCAJpHE8/IeMRnlOTaviSiNEUmcycSvW3SNo6MwdAqzmxyeeBLqCFtpJVbUt/zgEzK6mdMQCpyftHbsBw6r8naa44//szM7Ipc0xtcmOcozTJ0CPoZlZVIMuxKHkW0xjL/4cVWF7BFxnAp/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199666; c=relaxed/simple;
	bh=Jl0VSMzpxw+uB3ZgHQznLYmi1oC4WCpBlOZgtEV3Z9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xv9tJNoQfW/Zmj3w8qJucKTLZy6Jk1VPDxTOoNzfAC5M3Fw4NNXx5qHhtGCf2iL3r5Gj+PHxGBizroKvnDIZIkdX0jncvQzBq3eiGRQ+oNoabFjr7XD0U3D+1F8xqwdInlQPSNGIRVGgp87KOtFG611JpGtinhO0G5Lq7Ztp8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cwMtKEnP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716199663;
	bh=Jl0VSMzpxw+uB3ZgHQznLYmi1oC4WCpBlOZgtEV3Z9w=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cwMtKEnPHOVhyE9B7bNRvji/07H+iAAD+TiOZlwX6sL9cz5I6jICgKOe1JFR+cWqc
	 Ol4wS21c02IOys3Zrclfhxahnq/z3fMWDM2y76akDefFU9D4U/V9dYaGG/5ovYA4Nr
	 kham+RZ162cGdNrUFLFOONayt7N/jD5K/dWdsgKHydCAiFSoth0zOP5LOYzng6qVrU
	 0XPZgPbmy7Bo3KF/R+a+NJfelYDbblq/hFayfB04NvVTHwmMRl0vy3qt2Mabrtgy66
	 W5//+FUGqFHmnNBSBLJmQn+LnTNEa+B6Fde8sA/bbzAwaHWgZ8mnPO1x6HWNOvv60s
	 dOXr/yjcTkqQQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EB54837809D1;
	Mon, 20 May 2024 10:07:42 +0000 (UTC)
Message-ID: <671a4b1e-3d95-438c-beae-d967e0ad1c77@collabora.com>
Date: Mon, 20 May 2024 12:07:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: mt8173-elm: correct PMIC's
 syscon reg entry
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
 <20240518211159.142920-4-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240518211159.142920-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/05/24 23:11, Krzysztof Kozlowski ha scritto:
> The MT6297 PMIC has address/size cells == 1, thus its syscon child node
> has incorrect number of entries in "reg" property.  Fix dtbs_check
> warning:
> 
>    mt8173-elm.dtb: syscon@c000: reg: [[0, 49152], [0, 264]] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

That node is unused and not needed at all, even...
Unless anyone has any strong opinion against, I suggest to simply remove it.

Cheers,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index 6d962d437e02..0e2439860223 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -1138,7 +1138,7 @@ rtc: mt6397rtc {
>   		syscfg_pctl_pmic: syscon@c000 {
>   			compatible = "mediatek,mt6397-pctl-pmic-syscfg",
>   				     "syscon";
> -			reg = <0 0x0000c000 0 0x0108>;
> +			reg = <0x0000c000 0x0108>;
>   		};
>   	};
>   };


