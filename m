Return-Path: <linux-kernel+bounces-429166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191B29E1811
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2025284742
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434131E32DE;
	Tue,  3 Dec 2024 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fe9PBMkt"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9731E32B5;
	Tue,  3 Dec 2024 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218856; cv=none; b=TKrTE5s1XKH6oE7x9yWyDwUpZqV1agjr4l8ghsyF0qSZc7N4inlocKn8Y4RHRgsE4cY3kH5IhiNMOCSl7mnpeyD+EZP5NFPTw5yR3UwxPbo/l+M+3u9WoNRvUwTEJkt/m5gdRxRCbDiAdyJ/STTtnlUZZo++EF8i6MbGP3cZGnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218856; c=relaxed/simple;
	bh=lCldB2eYepeDI9l0gNXW/pWwP1Kv8KXDDck4h6qdu5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzs4z1Ys5mnpg/X3hfjPE+bjogyNmEVaNeyeGTPxgWMSF81XEBf2XOVNws5DcEILlqHGCZx2Ljc7NOmDVwr98atD2bzd2QrYsaFvAMXtIOoRIEcmpV5YNsoZouDoMFxXWp7PIo0NaPKQxyRqVGmPp9GUsp0K/1mmHUVP6ptBsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fe9PBMkt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218853;
	bh=lCldB2eYepeDI9l0gNXW/pWwP1Kv8KXDDck4h6qdu5U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fe9PBMktSU7u8+E4ib2sLN6fEYPjnXiCh5a9w/C2cWXoJmIIK/0Cbnk7ANDYeNIz/
	 0gtpxbktLVKYOHjqIfPhLywzc0PfKV+yvcuuqwA2EeBFHVDqTX0TJBRnN/vpcYA+1l
	 SyX051kGyFTEU9BEAeojYIDmzN0F9awt+WBBwOLFfK52+z6HxpkdLRdd+7QFOLFH9o
	 Bbd2vJ4x7prK/E78kXRWEXZ4ZJxx8ck1PoISYVCNz7lmecu7fHW+2Q5Zr25ZF/NBSK
	 dwUHiQkcQ5Wki0WEDXn0X9+hEsloSOzQ7pVDPAlsO9yumdfNeOh9OfZfn+3rDV++xY
	 mhzccaWTTwU0Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1406517E35D8;
	Tue,  3 Dec 2024 10:40:53 +0100 (CET)
Message-ID: <d726c20e-a7fc-4477-b2f9-b933d993a566@collabora.com>
Date: Tue, 3 Dec 2024 10:40:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] arm64: dts: mediatek: mt7988: add mmc support
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-3-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add devicetree node for MMC controller.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes:
> v2:
> squash "add missing label for apmixedsys"
> ---
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 24 ++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index 46969577c87a..5e40446cb7b3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -100,7 +100,7 @@ watchdog: watchdog@1001c000 {
>   			#reset-cells = <1>;
>   		};
>   
> -		clock-controller@1001e000 {
> +		apmixedsys: clock-controller@1001e000 {
>   			compatible = "mediatek,mt7988-apmixedsys";
>   			reg = <0 0x1001e000 0 0x1000>;
>   			#clock-cells = <1>;
> @@ -278,6 +278,28 @@ usb@11200000 {
>   			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
>   		};
>   
> +		mmc0: mmc@11230000 {
> +			compatible = "mediatek,mt7988-mmc";
> +			reg = <0 0x11230000 0 0x1000>,
> +			      <0 0x11D60000 0 0x1000>;
> +			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&infracfg CLK_INFRA_MSDC400>,
> +				 <&infracfg CLK_INFRA_MSDC2_HCK>,
> +				 <&infracfg CLK_INFRA_66M_MSDC_0_HCK>,
> +				 <&infracfg CLK_INFRA_133M_MSDC_0_HCK>;
> +			assigned-clocks = <&topckgen CLK_TOP_EMMC_250M_SEL>,
> +					  <&topckgen CLK_TOP_EMMC_400M_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_NET1PLL_D5_D2>,
> +						 <&apmixedsys CLK_APMIXED_MSDCPLL>;
> +			clock-names = "source",
> +				      "hclk",
> +				      "axi_cg",
> +				      "ahb_cg";

One last nitpick: all of the clock-names *do* fit in one line.

			clock-names = "source", "hclk", "axi_cg", "ahb_cg";

After which

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



