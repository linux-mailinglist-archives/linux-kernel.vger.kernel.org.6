Return-Path: <linux-kernel+bounces-220886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4001290E89B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CDA284407
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B5B130AFC;
	Wed, 19 Jun 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T4mY5J0k"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AA73398B;
	Wed, 19 Jun 2024 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794063; cv=none; b=XLdlpiiB31H3jl0/s5rJ3453kprOhKrtYG/owMNXrTXBMcz3W8EL6z5BUel9Pd+V/FFWzk7t1v/BAHugyytcNG+gArN2MlvD6hiDlu9nElPSRkzGu/9+57K5s6iLcoRbZyE0RGWT5TwVmysx4jdaks9sqjAagljjCf2pJ72GspQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794063; c=relaxed/simple;
	bh=s5naf1uttC3SK4CM5eDhQozogAI6TwHH9teO5TqANBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKYHUH47thgKMwCnBa7EdcOrluF7ZVt8t8FHp+kMKgAY/SGh1mSqFabZeMoGFXF5iTGG0jmfFPfAgZpCDV2f0qm17ZshtK2Oy8j6M9KO+HoV8me804BQGlMD2Xs+bvNgclW/U94CObb+zDJAQ42stb2cs6ahQWc1WH4m+FfiKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T4mY5J0k; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718794059;
	bh=s5naf1uttC3SK4CM5eDhQozogAI6TwHH9teO5TqANBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T4mY5J0kWd9rWAuUygLrHgEwAvT+rBy5VzRpjzulnY1JnSwLd4y1yGT8QDq/sNbfU
	 BCLi1J9wgtKK353wEwEbhwtdUuRyoOhm92U1DpNxDSGRWbJJDeO3jD33qIsJKw7urk
	 fbcNFGkIwxDqZaiOW8U2Lj4iXJJLXwK+bUJUYNvTVfHoT9sTA2JfIy9PwdvPRGmos8
	 TxrmI5ClLetGkAAD1dVPJUa62ao8rdSg37awRUD5w/ugslTyegss3NBaQng+cTN5IA
	 oGJ04vUHIs7i04HjjOO2FmEjdP5OTYXAuSYPDjPWRr0KLr3KYUegH7IRzTcSq5XpGJ
	 SDkvSKRTe4fCQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 10A5B37821C3;
	Wed, 19 Jun 2024 10:47:38 +0000 (UTC)
Message-ID: <6ab278ab-b8ed-405c-8f37-fc28610eac4e@collabora.com>
Date: Wed, 19 Jun 2024 12:47:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] arm64: dts: mediatek: add display blocks support
 for the MT8365 SoC
To: Alexandre Mergnat <amergnat@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Jitao Shi <jitao.shi@mediatek.com>,
 CK Hu <ck.hu@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
 <20231023-display-support-v4-14-ed82eb168fb1@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231023-display-support-v4-14-ed82eb168fb1@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/05/24 14:49, Alexandre Mergnat ha scritto:
> - Add aliases for each display components to help display drivers.
> - Add the Display Pulse Width Modulation (DISP_PWM) to provide PWM signals
>    for the LED driver of mobile LCM.
> - Add the MIPI Display Serial Interface (DSI) PHY support. (up to 4-lane
>    output)
> - Add the display mutex support.
> - Add the following display component support:
>    - OVL0 (Overlay)
>    - RDMA0 (Data Path Read DMA)
>    - Color0
>    - CCorr0 (Color Correction)
>    - AAL0 (Adaptive Ambient Light)
>    - GAMMA0
>    - Dither0
>    - DSI0 (Display Serial Interface)
>    - RDMA1 (Data Path Read DMA)
>    - DPI0 (Display Parallel Interface)
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8365.dtsi | 336 +++++++++++++++++++++++++++++++
>   1 file changed, 336 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> index 24581f7410aa..9f88645141d6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -8,6 +8,7 @@
>   #include <dt-bindings/clock/mediatek,mt8365-clk.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/memory/mediatek,mt8365-larb-port.h>
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/power/mediatek,mt8365-power.h>
>   

..snip..

> +
> +		rdma1: rdma@14016000 {
> +			compatible = "mediatek,mt8365-disp-rdma", "mediatek,mt8183-disp-rdma";
> +			reg = <0 0x14016000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_MM_DISP_RDMA1>;
> +			interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
> +			iommus = <&iommu M4U_PORT_DISP_RDMA1>;
> +			mediatek,rdma-fifo-size = <2048>;
> +			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0>;

Hey Alex,

only one nit here - trying to get the formatting consistent between devicetrees for
all MediaTek SoCs.

VDOSYS/MMSYS:
			port {
				#address-cells = <1>;
				#size-cells = <0>;

				vdosys0_ep_main: endpoint@0 {
					reg = <0>;
					remote-endpoint = <&ovl0_in>;
				};
			};

RDMA/OVL/other components:

			ports {
				#address-cells = <1>;
				#size-cells = <0>;

				port@0 {
					reg = <0>;

					rdma0_in: endpoint {
						remote-endpoint = <&ovl0_out>;
					};
				};

Can you please follow the style that I've shown up there for all of the ports
nodes and resend the devicetree commits?

P.S.: This is a paste from the MT8195 devicetree that I'll send soon, probably
tomorrow or something along those lines.

After which, the devicetree looks ok to me.

Thanks,
Angelo



