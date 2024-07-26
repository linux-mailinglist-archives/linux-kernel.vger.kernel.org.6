Return-Path: <linux-kernel+bounces-263049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF3993D054
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07D91C20CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3431D17798C;
	Fri, 26 Jul 2024 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0d2+CaX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C098174E;
	Fri, 26 Jul 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721985563; cv=none; b=EiujpkpAr8xILhoGJOxIhece1sKe8OmF3ekhnbeT5au9V9ZedTcxypRC8W2a9RwFeRdS5FsSTOHi36ln951h5+SItUC3/qQGQYZybQ9QvtJVV9XAke63bzD4OtEtjTBaKcWeVgzDH0UZ4vRuD2B31aBoftCjESYI9RtYMPzJ6GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721985563; c=relaxed/simple;
	bh=tMi0zgrFMpPuBV9tMsXKq38gTeYqBlk4gkAooZNByMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tk+PVqLfcDiVs03EQ95GQUv3LHas3D1H5X3tx358jKZW31WFvWIRq6bhPT6Pc6nLublAqUE6XnCpXYJqhqUY/pTRQiB7uwYsuvKpZhdiFUEZ3CQk3xiUPGoCUg8mtT5iZREKqRwjAW4Gb7RmlI/BXCfRzQVBhXKhMBNanrAofC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0d2+CaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FE1C32782;
	Fri, 26 Jul 2024 09:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721985563;
	bh=tMi0zgrFMpPuBV9tMsXKq38gTeYqBlk4gkAooZNByMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z0d2+CaXqpcgY/qKxO4r8zT0cguOQK8rctC3XSCYroSY6aJqFiDrs1gQpdx68XTd5
	 rqaDHk+1sdfmFKFVrdy4tTfEBhsmP+SvR4/sSkvuzkIY2qFDGfFy1J3VXGiXWTy2bY
	 hyViXo7x48g/b06dj8lnO9ppKWkAUMANWdvQB4qpZ/SEYVHr1dh6yOrTij1/wU80At
	 aExo4vEUFZaRVKk51HshkGctPkWA7ZYsKu0KwvB8+DRvdk7AEK0YpuxEpAtqzZV5Jz
	 6pw1gXMrAXHdd1HwiEYXHQyL8Qqy3mMQZctQxjxyYxD64tO9SpND/s32Y56/KDR4z1
	 iPJBPeJKEd7iQ==
Message-ID: <ff922cad-0e0a-4ab7-981b-62ac60ff2d26@kernel.org>
Date: Fri, 26 Jul 2024 11:19:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: Add phyBOARD-Pollux dts for rpmsg
To: Yashwanth Varakala <y.varakala@phytec.de>, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 upstream@lists.phytec.de
References: <20240725094457.37739-1-y.varakala@phytec.de>
 <20240725094457.37739-4-y.varakala@phytec.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240725094457.37739-4-y.varakala@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/07/2024 11:44, Yashwanth Varakala wrote:
> Adds a devicetree containing reserved memory regions used for intercore
> communication between A53 and M7 cores.
> 
> Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  2 +
>  .../dts/freescale/imx8mp-phycore-rpmsg.dtso   | 57 +++++++++++++++++++
>  2 files changed, 59 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index dedea4b5c319..80cc87d50301 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -177,9 +177,11 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
>  imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
>  imx8mp-phyboard-pollux-rdk-no-rtc-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-rtc.dtbo
>  imx8mp-phyboard-pollux-rdk-no-spiflash-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-spiflash.dtbo
> +imx8mp-phyboard-pollux-rdk-rpmsg-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-rpmsg.dtbo
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-rtc.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-spiflash.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-rpmsg.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-lt6.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-mi1010ait-1cp1.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso
> new file mode 100644
> index 000000000000..a5694f3aecaa
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 PHYTEC Messtechnik GmbH
> + * Author: Dominik Haller <d.haller@phytec.de>
> + * 	   Cem Tenruh <c.tenruh@phytec.de>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/clock/imx8mp-clock.h>
> +
> +&{/} {
> +	imx8mp-cm7 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "fsl,imx8mn-cm7";
> +		clocks = <&clk IMX8MP_CLK_M7_DIV>;
> +		mboxes = <&mu 0 1
> +			&mu 1 1
> +			&mu 3 1>;

That's one or there entries? look wrong.

> +		mbox-names = "tx", "rx", "rxdb";
> +		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>, <&rsc_table>;
> +		rsc-da = <0x55000000>;
> +		status = "okay";

Why? Did you disable it anywhere? You add a new node.

> +	};
> +
> +	reserved-memory {
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		m7_reserved: m7@0x80000000 {
> +			no-map;
> +			reg = <0 0x80000000 0 0x1000000>;
> +		};
> +
> +		rsc_table: rsc_table@550ff000 {

Please follow DTS coding style... This applies to all your contributions.

Best regards,
Krzysztof


