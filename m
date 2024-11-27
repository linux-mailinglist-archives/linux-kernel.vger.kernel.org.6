Return-Path: <linux-kernel+bounces-423509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE79DA897
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E0E28467C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7195418FC7E;
	Wed, 27 Nov 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bS9JR0IJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E8C1FCFC7;
	Wed, 27 Nov 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714493; cv=none; b=bJpHo+fn+mxGMHU4jzLZCPDHx12R1Z0LulRRfbt7Vt7tlrMn4Y4hgYOwMOK0GLQ2WKgML6zZD9rDAbiKlPp4UbAl3AmyrREfM+oN/GOdZzb83YS743wcHMPi1a6d+mz2HDVZtQWhiBuBKwGRhEy/Ih+4yxUDlaBJLnGliLN/y0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714493; c=relaxed/simple;
	bh=T3PqAZ1gv2KDsHreRq8BGjwnMaVHeqx9vPlukKqRFu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGHoYyqo1AQbGV4cyqIuJ3ko4jr1rsNAje3rxnS5mK15160wq3U3CFo8OB7EniYYGbMmbBCRpRnfAwr2Dnns8Mr4NIb4IOz583LYL/Z9wTukoCGE1P1TB5QBsLaN0O2ObjjaoDgH/82ererB3iGva/jtTZgzSYTbf2r7tWoz4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bS9JR0IJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732714490;
	bh=T3PqAZ1gv2KDsHreRq8BGjwnMaVHeqx9vPlukKqRFu8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bS9JR0IJQiyd1jIu3rf3OiTJt5mRv9NpWUTkJPT00SuCJV7IiSKeIZRU0DLxH5923
	 QgLLy6xzB1/8l4spxihGoLch5OVoxQ8nWXskcweSkqTOaNuzhHrup3bz3Wjenpwja9
	 aeCVXi+q8YvaE/0ZwPes+C8G3zQxOMOlO9+MGk4WpaJKt23JUfhRqhOWim7fMR0ff7
	 fP37a6S6Bt6zzpcowK5hj3uwFVIVc+5s6+jXBvu9i1cnoflWGDK81CFgBeBtxXJJ3W
	 UrZKMNuo3rBesXcDWU5DTDnsrW43zRj917jbb/avJ+gOFWvLPFHIyKSyPzLqiCs6cG
	 d05uFtampZ8mg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B80C317E374E;
	Wed, 27 Nov 2024 14:34:49 +0100 (CET)
Message-ID: <6725747d-2db4-4f80-be25-4b314e59ab9a@collabora.com>
Date: Wed, 27 Nov 2024 14:34:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 10/14] arm64: dts: mediatek: mt7988: add lvts node
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241029103937.45852-1-linux@fw-web.de>
 <20241029103937.45852-11-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241029103937.45852-11-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/10/24 11:39, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add Low Voltage Thermal Sensor (LVTS) node for mt7988 SoC.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Please add the lvts_calibration nvmem entry in this commit instead.

Cheers,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index ed8ce1e6f68b..de9a9ff2edd8 100644
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
> @@ -103,6 +104,7 @@ infracfg: clock-controller@10001000 {
>   			compatible = "mediatek,mt7988-infracfg", "syscon";
>   			reg = <0 0x10001000 0 0x1000>;
>   			#clock-cells = <1>;
> +			#reset-cells = <1>;
>   		};
>   
>   		topckgen: clock-controller@1001b000 {
> @@ -268,6 +270,17 @@ i2c2: i2c@11005000 {
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
>   		ssusb0: usb@11190000 {
>   			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
>   			reg = <0 0x11190000 0 0x2e00>,


