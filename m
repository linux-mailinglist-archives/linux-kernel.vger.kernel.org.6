Return-Path: <linux-kernel+bounces-429164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 916DF9E1B03
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE21DB468DC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DECB1E32A6;
	Tue,  3 Dec 2024 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NLFW4mjK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A501E261D;
	Tue,  3 Dec 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218853; cv=none; b=TtIqIWFHrHyiccH67UCX4mt/ov2USiiESnZpTRBJBs/QnPDgDJdKbf7oE686+eZg91MAS6TuHcePr1fRzU9Ch/DcTsZMwfkU6UnAgb5VZEviYEjFV2cAdgSkt084GqOXLPNitFfNpY3Fub2sIHD1Y1al+vslNvixsfgZQKQ0jEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218853; c=relaxed/simple;
	bh=bKDW6ggnTKm/6VAGSsVo0gDuMyIV040k1eYen7uZqfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0V0zArFsg5gYuT5VPvKYHYiVwkDncT9qiyU3Hd17OuKJGooK+cMWgAUd1VNqO+W6b/nTSR4cteNV7NeJly5hYTzSe7XekQWOggSKGIO2y6LTkoOB8KP9m07eOj7nDyNH9zodFgn60ieP01VZE6LCYL8FdR9GlSxwtY2HqDXwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NLFW4mjK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218850;
	bh=bKDW6ggnTKm/6VAGSsVo0gDuMyIV040k1eYen7uZqfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NLFW4mjK2zA+akjAzh7lncPcvHiA6Cj2D+A+iwwFmPWFlc3IUHNYtFOL5D9scbgKN
	 QA+gWoCzv9AusbdrCxJ4+gBwtfs15bJC/47dFfHCmy/LOQpLAftujjy5pX3a9IWS+G
	 FD/LYYmQZd02PoxnbAYQOomeHPwsz4OBg/vAWM971AWNgid6recpnIfZIVX7COFPAm
	 CoRQSKVPEtEBOHzkD/o6gtL8yHGGrCn/KlHnYVk1oqxIS1c+fCgffoZ9uph67o6EH7
	 Wuzkmt/ydSIRmGB2t6SGCro4YM1Ze5ofcdXSvdWrV0Fp52tBUBJHFI59NGcc/FK4aJ
	 1B2M+x6BRs7kw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 23BC917E35EA;
	Tue,  3 Dec 2024 10:40:50 +0100 (CET)
Message-ID: <aade3f32-b0c5-4f36-b3e4-f2ff077110e2@collabora.com>
Date: Tue, 3 Dec 2024 10:40:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/18] arm64: dts: mediatek: mt7988: add lvts node
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-5-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-5-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add Low Voltage Thermal Sensor (LVTS) node for mt7988 SoC.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes:
> 
> v2:
> squash
> - "arm64: dts: mediatek: mt7988: add label for efuse"
> - "arm64: dts: mediatek: mt7988: extend efuse node" (drop other efuse subnodes)
> ---
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index 5e40446cb7b3..f7748a840297 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -4,6 +4,7 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/pinctrl/mt65xx.h>
> +#include <dt-bindings/reset/mediatek,mt7988-resets.h>
>   
>   / {
>   	compatible = "mediatek,mt7988a";
> @@ -85,6 +86,7 @@ infracfg: clock-controller@10001000 {
>   			compatible = "mediatek,mt7988-infracfg", "syscon";
>   			reg = <0 0x10001000 0 0x1000>;
>   			#clock-cells = <1>;
> +			#reset-cells = <1>;
>   		};
>   
>   		topckgen: clock-controller@1001b000 {
> @@ -250,6 +252,17 @@ i2c@11005000 {
>   			status = "disabled";
>   		};
>   
> +		lvts: lvts@1100a000 {
> +			compatible = "mediatek,mt7988-lvts-ap";
> +			#thermal-sensor-cells = <1>;
> +			reg = <0 0x1100a000 0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_26M_THERM_SYSTEM>;
> +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&infracfg MT7988_INFRA_RST1_THERM_CTRL_SWRST>;
> +			nvmem-cells = <&lvts_calibration>;
> +			nvmem-cell-names = "lvts-calib-data-1";
> +		};
> +
>   		usb@11190000 {
>   			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
>   			reg = <0 0x11190000 0 0x2e00>,
> @@ -307,11 +320,15 @@ clock-controller@11f40000 {
>   			#clock-cells = <1>;
>   		};
>   
> -		efuse@11f50000 {
> +		efuse: efuse@11f50000 {

Okay but why are you adding the efuse handle name to this node?
You're not using it anywhere as far as I can see.

Please drop this change - after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>   			compatible = "mediatek,mt7988-efuse", "mediatek,efuse";
>   			reg = <0 0x11f50000 0 0x1000>;
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> +
> +			lvts_calibration: calib@918 {
> +				reg = <0x918 0x28>;
> +			};
>   		};
>   
>   		clock-controller@15000000 {


