Return-Path: <linux-kernel+bounces-348773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D698EBBA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14572B21065
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B7113D245;
	Thu,  3 Oct 2024 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q/NqSKn5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1AC13B280;
	Thu,  3 Oct 2024 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944592; cv=none; b=oeCC+21R66HSTuiVFUKHXVV9OJOo7FJS6vkGwr21MnxLgRgDfU4hrN+Hmfbh3hiJdBqrtZWmy45DdddVafW96Hge0fATfOOaOR0MxEkejB7Z3pMa2FtShK7osM9uYJxKrwhT2+IxDJYa5NCMyqbdccZcU3P8XnXyCieTYjJNcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944592; c=relaxed/simple;
	bh=pt043Ff6H8qxgHmvl/WZhdH/nIcm8g4J984M1fzICQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRDga5LSkSbRTs0HsHuBA2aNu8pgZ8UMLmJsTazL9ZvoSAnkE85bcU2VZwUTS36MX+EK99kuIjzxL3xVKEcB34LxvCn2IGPWLYv/xl88DVt1w7tIr5d5oPe2Jp3RzrsZrnXziX+5b+iJY2SK9C800lr0qxV+9NNIAhjBEghtaDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q/NqSKn5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727944583;
	bh=pt043Ff6H8qxgHmvl/WZhdH/nIcm8g4J984M1fzICQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q/NqSKn51hsQfi2q3BwO6Lp83zdwze86CQnYOcKsrDfnMnchywKZRNGEmkOnuJZh2
	 mFb5Ouizs2prsCxLVI3eOR4YRbOlTUb/FaJ2t2F12bD8ow69VrgWNHny81HhpopGOS
	 eth2FOQa/0rcB2zaIkzOAlR7rY0ppSkg2usWCskaQhCMIqIcGy13xdBROCb6G/Nfpe
	 r+zJRTEXIHgWy5YnvT5g6SswhWnZV2duV8ffZvKZ1c0uif+QIRwF6PYKmQhsaqsnDo
	 pI1Vqz4Fems5+AhwjnmzA/YwpTcTNvihXfuLocrZaHDah7cZM6Ikuk8jZUWONd2ciQ
	 TrX9BAQiJ25uA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E4C7617E10B5;
	Thu,  3 Oct 2024 10:36:22 +0200 (CEST)
Message-ID: <d3052eb4-bfcb-4ee2-9b4b-a4845238c765@collabora.com>
Date: Thu, 3 Oct 2024 10:36:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] arm64: dts: mediatek: mt8188: Add MIPI DSI nodes
To: Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20241003070139.1461472-1-fshao@chromium.org>
 <20241003070139.1461472-4-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241003070139.1461472-4-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/10/24 08:59, Fei Shao ha scritto:
> Add MIPI DSI and the associated PHY node to support DSI panels.
> Individual board device tree should enable the nodes as needed.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi | 26 ++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> index 23101d316c4e..719d2409a7db 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -1839,6 +1839,16 @@ pcieport: pcie-phy@0 {
>   			};
>   		};
>   
> +		mipi_tx_phy: dsi-phy@11c80000 {

There are two DSI PHYs, one at 0x11c80000 and one at 0x11c90000

> +			compatible = "mediatek,mt8188-mipi-tx", "mediatek,mt8183-mipi-tx";
> +			reg = <0 0x11c80000 0 0x1000>;
> +			clocks = <&clk26m>;
> +			clock-output-names = "mipi_tx0_pll";
> +			#clock-cells = <0>;
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
>   		i2c1: i2c@11e00000 {
>   			compatible = "mediatek,mt8188-i2c";
>   			reg = <0 0x11e00000 0 0x1000>,
> @@ -2224,10 +2234,26 @@ larb19: smi@1a010000 {
>   			mediatek,smi = <&vdo_smi_common>;
>   		};
>   
> +		disp_dsi: dsi@1c008000 {

And there are two DSIs, one at 0x1c008000 and one at 0x1c012000

Cheers,
Angelo



