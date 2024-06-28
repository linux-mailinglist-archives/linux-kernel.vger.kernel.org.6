Return-Path: <linux-kernel+bounces-234000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CBD91C098
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92F01F220F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A603A1BF326;
	Fri, 28 Jun 2024 14:13:37 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8815886A;
	Fri, 28 Jun 2024 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584017; cv=none; b=QdS9M15GQ7gKMX3kWt2NJZ0zI6Gu2dIXbFQizPKckEBkxPcZzuj0vEEFSPOnjwcJmVLrhc70kiHTG1wAm0NxGc3V7Wl8xLaKbApdq3+jq2I5XM1+Nw6qGBNcM5EQBVRq6c6UvvGgUOZcHTFJsCZ8Ky+RxTQ2Vwu1qQdslyAKyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584017; c=relaxed/simple;
	bh=iisC1B21y+cGmgIvl5L5E3tSQXxDoTSSFnQWyK+orR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fglflG0I3F+EiKjj3zxRWFw9ZqP9H83R2jU3a0DIc97TKa6Eyh3vzoxkAD9xx5X/TWnqwvAUA6plwmipWeClWudLd84zS4Jrk5PMHkczSX2P71vLKsfj0A1kJN3cAoDw0ZphmgfBk49s/8EXSlX9xFhqmHtYPTKJMCE0wxvCovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sNCLy-0007nT-U2; Fri, 28 Jun 2024 16:13:30 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Chukun Pan <amadeus@jmu.edu.cn>
Subject:
 Re: [PATCH 4/5] arm64: dts: rockchip: use generic Ethernet PHY reset bindings
 for Lunzn Fastrhino R68S
Date: Fri, 28 Jun 2024 16:13:30 +0200
Message-ID: <10487566.nUPlyArG6x@diego>
In-Reply-To: <20240628140104.551760-4-amadeus@jmu.edu.cn>
References:
 <20240628140104.551760-1-amadeus@jmu.edu.cn>
 <20240628140104.551760-4-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 28. Juni 2024, 16:01:03 CEST schrieb Chukun Pan:
> Replace the deprecated snps,reset-xxx bindings to the generic Ethernet PHY
> reset GPIO bindings. Also fixed the PHY address and reset GPIOs (does not
> match the corresponding pinctrl). Since we use rgmii-id as the phy mode,
> remove the useless tx_delay and rx_delay.

Please split this commit into multiple ones.

When need to "list" changes in your commit message, it is often a good
indicator for needing to split a change.


> Fixes: b9f8ca655d80 ("arm64: dts: rockchip: Add Lunzn Fastrhino R68S")
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  .../dts/rockchip/rk3568-fastrhino-r68s.dts    | 26 +++++++------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
> index a3339186e89c..d27eb37b5b35 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
> @@ -39,12 +39,6 @@ &gmac0_tx_bus2
>  		     &gmac0_rx_bus2
>  		     &gmac0_rgmii_clk
>  		     &gmac0_rgmii_bus>;
> -	snps,reset-gpio = <&gpio0 RK_PB0 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	/* Reset time is 15ms, 50ms for rtl8211f */
> -	snps,reset-delays-us = <0 15000 50000>;
> -	tx_delay = <0x3c>;
> -	rx_delay = <0x2f>;
>  	status = "okay";
>  };
>  
> @@ -61,30 +55,30 @@ &gmac1m1_tx_bus2
>  		     &gmac1m1_rx_bus2
>  		     &gmac1m1_rgmii_clk
>  		     &gmac1m1_rgmii_bus>;
> -	snps,reset-gpio = <&gpio0 RK_PB1 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	/* Reset time is 15ms, 50ms for rtl8211f */
> -	snps,reset-delays-us = <0 15000 50000>;
> -	tx_delay = <0x4f>;
> -	rx_delay = <0x26>;
>  	status = "okay";
>  };
>  
>  &mdio0 {
> -	rgmii_phy0: ethernet-phy@0 {
> +	rgmii_phy0: ethernet-phy@1 {
>  		compatible = "ethernet-phy-ieee802.3-c22";
> -		reg = <0>;
> +		reg = <0x1>;
>  		pinctrl-0 = <&eth_phy0_reset_pin>;
>  		pinctrl-names = "default";
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio1 RK_PB0 GPIO_ACTIVE_LOW>;
>  	};
>  };
>  
>  &mdio1 {
> -	rgmii_phy1: ethernet-phy@0 {
> +	rgmii_phy1: ethernet-phy@1 {
>  		compatible = "ethernet-phy-ieee802.3-c22";
> -		reg = <0>;
> +		reg = <0x1>;
>  		pinctrl-0 = <&eth_phy1_reset_pin>;
>  		pinctrl-names = "default";
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio1 RK_PB1 GPIO_ACTIVE_LOW>;
>  	};
>  };
>  
> 





