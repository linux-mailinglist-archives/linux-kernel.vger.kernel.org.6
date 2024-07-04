Return-Path: <linux-kernel+bounces-240880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 992F4927422
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA54B1C211A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7355D1ABC35;
	Thu,  4 Jul 2024 10:34:52 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833AF1A38EE;
	Thu,  4 Jul 2024 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089292; cv=none; b=HmDd8xk8WuRwQn3nX9KwPJVclbVNkFvR4PgV9kwl1jFdU4BF+8ojyHIoW6dLq/hGVQRIOxqIBbVcrsr2O+q/YIFuPWqHuhG3QZcmUAGQ0BCw7oc9bD2Ys+njFakxGUpGTSedsMXkJtOdAjJGF/D7vHYgw8IB5hdpvbzTe7an+oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089292; c=relaxed/simple;
	bh=9x884QPeFxXwZ0OXmLJUd9B/teStIfi/NN0Sob0MXqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujkF1JSoz6LP8lvCzQZr17v5wo46xdjb+KdHE/Gf25P92zoiWiC3B7wEIVsMNWctN5x9/7oH/0PtT4cwzpquA2KjAq/HiZIdIZvVLmzZmltfbEodQMLyLxggbV/OqYkj+Qc+GLVp+Zb6eaqf7qtkrJ9c82I+lTQbuyjrtbsjsZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sPJnY-0007sF-N5; Thu, 04 Jul 2024 12:34:44 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dsimic@manjaro.org
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: add ROCK 5 ITX board
Date: Thu, 04 Jul 2024 12:34:43 +0200
Message-ID: <2025932.PIDvDuAF1L@diego>
In-Reply-To: <20240704095524.788607-3-heiko@sntech.de>
References:
 <20240704095524.788607-1-heiko@sntech.de>
 <20240704095524.788607-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 4. Juli 2024, 11:55:24 CEST schrieb Heiko Stuebner:
> The ROCK 5 ITX as the name suggests is made in the ITX form factor and
> actually built in a form to be used in a regular case even providing
> connectors for regular front-panel io.
> 
> It can be powered either by 12V, ATX power-supply or PoE.
> 
> Notable peripherals are the 4 SATA ports, M.2 M-Key slot, M.2 E-key slot,
> 2*2.5Gb PCIe-connected Ethernet NICs.
> 
> As of yet unsupported display options consist of 2*HDMI, DP via USB-c,
> eDP + 2*DSI via PCB connectors.
> 
> USB ports are 4*USB3 + 2*USB2 on the back panel and 2-port front-panel
> connector.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |    1 +
>  .../boot/dts/rockchip/rk3588-rock-5-itx.dts   | 1186 +++++++++++++++++
>  2 files changed, 1187 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index e8eba631da23e..41ee495a91f6b 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -129,6 +129,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-ok3588-c.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-5-plus.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-quartzpro64.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5-itx.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> new file mode 100644
> index 0000000000000..605277525a4ad
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> @@ -0,0 +1,1186 @@

[...]

> +/* FUSB302 and LCD1 connector */
> +&i2c8 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c8m4_xfer>;
> +	status = "okay";
> +
> +	usbc0: usb-typec@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbc0_int>;
> +		vbus-supply = <&typec_vin>;
> +
> +		usb_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			data-role = "dual";
> +			power-role = "dual";
> +			try-power-role = "sink";
> +			op-sink-microwatt = <1000000>;
> +			sink-pdos =
> +				<PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM)>;
> +			source-pdos =
> +				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;

as sigmaris noted on IRC:
  I think the usb-c-connector on the Rock 5 ITX dts should not be a PD sink.
  The schematic from Radxa shows TYPEC_VIN only connected to the output
  of regulator U2603, there is no power path I can see for it to power the
  board [...] and powering via USB-C isn't mentioned in the other docs

  and I'd remove try-power-role and sink-pdos (try-power-role seems
  optional if power-role is not dual)

  and also remove op-sink-microwatt




