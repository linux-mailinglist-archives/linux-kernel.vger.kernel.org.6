Return-Path: <linux-kernel+bounces-429054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952159E16C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4943C1630CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C231DE4E3;
	Tue,  3 Dec 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lV97jLpE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A291DE2CB;
	Tue,  3 Dec 2024 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216969; cv=none; b=O/s5OWAjO2FNyimPQIv+e4yMLquRM6E8WRylU+gBnWJFSqssbQnboQPlf/pjuhnLsytdSabDAvlhFsz+l9JPl1ObWiv4kPZaKdZoxsQAQ4SxCQHs+qW0JUBZdCcFvv4EM1Z9CnLG+Qa17daRmy/IscRQsewjjQLI8/dX/TmJCx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216969; c=relaxed/simple;
	bh=4wHuBLrcnDcfK8k1xUlCGXFlvPL57xKxmHh+JQRhPao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IU7SZa1CuoD+/xd0OTxI3i1zMr5+PfZdOG8XVNjhWYD8XljpjOIBGeA6WtO10DvdpfN3YEvthIMEdn2D9leelOe0IeytHLHmhHmfihLkSuff6sSZh/mhOiQdwKfwegkDs4wZ/wh9lhOLJS+1//CwwDl0bdY2P0q7oWlOR3Ltb7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lV97jLpE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733216965;
	bh=4wHuBLrcnDcfK8k1xUlCGXFlvPL57xKxmHh+JQRhPao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lV97jLpElDVc+Sq5P8OKNe7kvIO4veToTfLY1Yoq6l8uhousvMxrW76D5Oj9MTx45
	 +D3sQrRRw9eWq+Tw3xtqNlKvU6eTR1dFACB9NBcc4eTa2WRCCKeKxAUzMv7GWJj6IP
	 SzNVp0X33F5kn0oDlNj1846wn4tdANTUJC0i1HxXcMU8qougkPw7aojcs/lbyf86mU
	 JAsaafxOr2+Ih3CS63b6aK+aIkvLvA02/ZnCXITf/3KgcKbDzcIE51Db25uNE613WV
	 T0fTjGk+s9kwUdVSJgBfpNjjbqsMzXH5kgHIGHhyz2yn7g9PdA+a9pn6CirHhApd7P
	 Zp8QXYUOJGIKA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D260E17E14D7;
	Tue,  3 Dec 2024 10:09:24 +0100 (CET)
Message-ID: <9f55bfdb-d4c5-48d2-8a6b-fee5dc147d94@collabora.com>
Date: Tue, 3 Dec 2024 10:09:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] arm64: dts: mediatek: Add MT8186 Chinchou
 Chromebooks
To: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, wenst@chromium.org, hsinyi@chromium.org,
 sean.wang@mediatek.com, dianders@google.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241202032035.29045-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20241202032035.29045-3-xiazhengqiao@huaqin.corp-partner.google.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202032035.29045-3-xiazhengqiao@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 04:20, Zhengqiao Xia ha scritto:
> MT8186 chinchou, known as ASUS Chromebook CZ12 Flip (CZ1204F)
> and CZ12(CZ1204C), is a MT8186 based laptop.
> It is based on the "corsola" design.It includes chinchou and chinchou360,
> including LTE, stylus, touchscreen combinations.
> 
> Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile         |   3 +
>   .../mediatek/mt8186-corsola-chinchou-sku0.dts |  18 +
>   .../mediatek/mt8186-corsola-chinchou-sku1.dts |  35 ++
>   .../mt8186-corsola-chinchou-sku16.dts         |  29 ++
>   .../dts/mediatek/mt8186-corsola-chinchou.dtsi | 321 ++++++++++++++++++
>   5 files changed, 406 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 8fd7b2bb7a15..0db7770e8907 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -55,6 +55,9 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-chinchou-sku0.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-chinchou-sku1.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-chinchou-sku16.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393216.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393217.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393218.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
> new file mode 100644
> index 000000000000..5d012bc4ff0d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2024 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola-chinchou.dtsi"
> +
> +/ {
> +	model = "Google chinchou CZ1104CM2A/CZ1204CM2A";
> +	compatible = "google,chinchou-sku0", "google,chinchou-sku2",
> +			"google,chinchou-sku4", "google,chinchou-sku5",
> +			"google,chinchou", "mediatek,mt8186";
> +};
> +
> +&gpio_keys {
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
> new file mode 100644
> index 000000000000..c18f473f6a0f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2024 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola-chinchou.dtsi"
> +
> +/ {
> +	model = "Google chinchou CZ1104FM2A/CZ1204FM2A/CZ1104CM2A/CZ1204CM2A";
> +	compatible = "google,chinchou-sku1", "google,chinchou-sku17",

As pointed out in the binding review, please move SKU17 after 7, before 20.

> +			"google,chinchou-sku3", "google,chinchou-sku6",
> +			"google,chinchou-sku7", "google,chinchou-sku20",
> +			"google,chinchou-sku22", "google,chinchou-sku23",
> +			"google,chinchou", "mediatek,mt8186";
> +};
> +

..snip..

> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
> new file mode 100644
> index 000000000000..c3835c7c4444
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
> @@ -0,0 +1,321 @@

..snip..

> +
> +&mmc1_pins_default {
> +	pins-clk {
> +		drive-strength = <MTK_DRIVE_8mA>;

Please do not use the MTK_DRIVE_xxx definitions.

This is just `drive-strength = <8>;`

> +	};
> +
> +	pins-cmd-dat {
> +		drive-strength = <MTK_DRIVE_8mA>;
> +	};
> +};
> +
> +&mmc1_pins_uhs {
> +	pins-clk {
> +		drive-strength = <MTK_DRIVE_8mA>;
> +	};
> +
> +	pins-cmd-dat {
> +		drive-strength = <MTK_DRIVE_8mA>;
> +	};
> +};
> +
Everything else looks good.

Cheers,
Angelo

