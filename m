Return-Path: <linux-kernel+bounces-330280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BE1979BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF1E1F2192A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2FD13A863;
	Mon, 16 Sep 2024 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IqQxikJ/"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513C91FAA;
	Mon, 16 Sep 2024 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726471454; cv=none; b=klUt7D64fy6xJTCzjAKDfVAYudVZtv4m8XpYZyTUurbOBfiAeRe+l28UckEjIk0+fTDAeZ4iRxkrWm21vRduhhaASWPTZnZVbzPN/ZfDPYc1E1uGNaTsBYYROclqCfG+a/GWFE8AKt0roHBLpkJmVdLZJjnlq8gw/e7Ay8u+VHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726471454; c=relaxed/simple;
	bh=7HdfdAuYOXtzpuZeeI+Yr0Hwt6eDeO1YBtPamvGsXiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jc6NWZugMZyRpYPIDRjXcJgVu6dGb+OCJP5ntMs/T7zs3Ji6M0qgSqJ6ehdIfM5FtlQFtFK/lw+S4+3aXZFQ4ky+LHd4JBwKelqAoQAuLIEEz1YpV2YYtAulWfn7FQ+wv5FVKdrj8JnKI7+0pkB0ssy9DonZnnEVyT3Hh/WTmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IqQxikJ/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726471452; x=1758007452;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7HdfdAuYOXtzpuZeeI+Yr0Hwt6eDeO1YBtPamvGsXiQ=;
  b=IqQxikJ/CpHQJml/6H53KAIYY9J1hb0wCqDwyU07WVi0E1Jk0zsoRthG
   HZB7tRribRbCveJIDaDLOiywprkS+fjObn8Vsg9Rl06SvGM7oBJKzXu6W
   jL4ZjwspK7DG/gfMUk2dnZVMo7OpLH6Z4s+mIV2bgj6bnRK+a1NqoZ79X
   PkwScwVbRDvNDa2W2DEVjHurE8x57LCb5TAp/tY0ERCEHUik0dsEJ7Ysa
   uJfWsFIvJ6VXSqW9yo55wvzyF6RFwqKFuxtb22jiWIY61xVMFQnynvP7/
   Adb6mqM1IsBXn3jqDkzBYzeZ2148o27Ew7O1fq5OtIqDzJ9MRZDNGhPDk
   g==;
X-CSE-ConnectionGUID: tsAC/8XwRP2MTt/y/cnXKg==
X-CSE-MsgGUID: 19NcF4nmQhewUaHyp5jtlA==
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="199255006"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 00:24:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 00:23:41 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 16 Sep 2024 00:23:39 -0700
Message-ID: <67d0e60f-718f-4496-bb7f-aa5180291cfd@microchip.com>
Date: Mon, 16 Sep 2024 09:23:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: Add trng labels for all at91 SoCs
Content-Language: en-US, fr-FR
To: Alexander Dahl <ada@thorsis.com>, Conor Dooley <conor+dt@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>
References: <20240916064233.697215-1-ada@thorsis.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240916064233.697215-1-ada@thorsis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexander,

On 16/09/2024 at 08:42, Alexander Dahl wrote:
> SAM9X60 and SAMA7G5 already have those labels.  Add it for the other SoC
> families so it can be referenced in board files.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Thanks for the patch.

While we are at it, now that we have a proper label, can you please 
change the node name which should be "rng" ?

It will be aligned with latest Device Tree specification and what we 
tried to follow for newer sama7g5 for instance:

https://elixir.bootlin.com/linux/v6.10.10/source/arch/arm/boot/dts/microchip/sama7g5.dtsi#L774

Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/microchip/at91sam9g45.dtsi | 2 +-
>   arch/arm/boot/dts/microchip/sama5d2.dtsi     | 2 +-
>   arch/arm/boot/dts/microchip/sama5d3.dtsi     | 2 +-
>   arch/arm/boot/dts/microchip/sama5d4.dtsi     | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91sam9g45.dtsi b/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
> index 325c63a53118..02bd5a1833e8 100644
> --- a/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
> @@ -753,7 +753,7 @@ macb0: ethernet@fffbc000 {
>                                  status = "disabled";
>                          };
> 
> -                       trng@fffcc000 {
> +                       trng: trng@fffcc000 {
>                                  compatible = "atmel,at91sam9g45-trng";
>                                  reg = <0xfffcc000 0x100>;
>                                  interrupts = <6 IRQ_TYPE_LEVEL_HIGH 0>;
> diff --git a/arch/arm/boot/dts/microchip/sama5d2.dtsi b/arch/arm/boot/dts/microchip/sama5d2.dtsi
> index 5f8e297e19ed..2fefe3efa769 100644
> --- a/arch/arm/boot/dts/microchip/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama5d2.dtsi
> @@ -1019,7 +1019,7 @@ AT91_XDMAC_DT_PER_IF(1) |
>                                  };
>                          };
> 
> -                       trng@fc01c000 {
> +                       trng: trng@fc01c000 {
>                                  compatible = "atmel,at91sam9g45-trng";
>                                  reg = <0xfc01c000 0x100>;
>                                  interrupts = <47 IRQ_TYPE_LEVEL_HIGH 0>;
> diff --git a/arch/arm/boot/dts/microchip/sama5d3.dtsi b/arch/arm/boot/dts/microchip/sama5d3.dtsi
> index d4fc0c1dfc10..8335e0c8066f 100644
> --- a/arch/arm/boot/dts/microchip/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama5d3.dtsi
> @@ -419,7 +419,7 @@ tdes: crypto@f803c000 {
>                                  clock-names = "tdes_clk";
>                          };
> 
> -                       trng@f8040000 {
> +                       trng: trng@f8040000 {
>                                  compatible = "atmel,at91sam9g45-trng";
>                                  reg = <0xf8040000 0x100>;
>                                  interrupts = <45 IRQ_TYPE_LEVEL_HIGH 0>;
> diff --git a/arch/arm/boot/dts/microchip/sama5d4.dtsi b/arch/arm/boot/dts/microchip/sama5d4.dtsi
> index 58ceed997889..20b8a9b123e1 100644
> --- a/arch/arm/boot/dts/microchip/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama5d4.dtsi
> @@ -658,7 +658,7 @@ macb1: ethernet@fc028000 {
>                                  status = "disabled";
>                          };
> 
> -                       trng@fc030000 {
> +                       trng: trng@fc030000 {
>                                  compatible = "atmel,at91sam9g45-trng";
>                                  reg = <0xfc030000 0x100>;
>                                  interrupts = <53 IRQ_TYPE_LEVEL_HIGH 0>;
> 
> base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
> --
> 2.39.5
> 


