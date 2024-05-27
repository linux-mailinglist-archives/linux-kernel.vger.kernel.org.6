Return-Path: <linux-kernel+bounces-191403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD538D0EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F812824F0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0184AECE;
	Mon, 27 May 2024 20:54:57 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740FD1DA58;
	Mon, 27 May 2024 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843297; cv=none; b=Tl6hTogLmQIRcHduLnMceG2SJTz8lQVu0IrlzBUHhzAkW8ZimazujHBpxWno0YbPgVLMfr15RIVOshbBBvcGzAQSfXdZy3zhDxtKKVxGYR7u+aVDr7ZXZmYlE4DC4xiRvft4UdGOjB2REVPJZlFb7M8XcMtuGkHceHO4Z+B5Orw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843297; c=relaxed/simple;
	bh=qD4hGUyI+cMK31VDk1eSbNSrXXBbMKsY+o+vhgOE3qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXwdDp1ssGyNdSgyDTP+IP3iqX1eLZTRVyNzj18YgF/MLVhdimvwUoz/F7/mK9Q6gpEihSTcf1LMb1rlPDm45M3dRRls5W9P03vTG9Pi6PXXtVCiAtAQqJXFQLxS88TKJJXeN3FLougr3TBMW1vaHhziz9g/RQJy3GRkuFDmlMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86193d.versanet.de ([94.134.25.61] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sBhMi-0004Xw-Qy; Mon, 27 May 2024 22:54:44 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sebastian Kropatsch <seb-dev@web.de>, Jonas Karlman <jonas@kwiboo.se>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add CM3588 NAS board
Date: Mon, 27 May 2024 22:54:43 +0200
Message-ID: <3609340.LM0AJKV5NW@diego>
In-Reply-To: <9f40c748-691b-4a03-bbd6-54870f46bf05@kwiboo.se>
References:
 <20240526214340.8459-1-seb-dev@web.de> <20240526214820.9381-1-seb-dev@web.de>
 <9f40c748-691b-4a03-bbd6-54870f46bf05@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 27. Mai 2024, 21:02:02 CEST schrieb Jonas Karlman:
> Hi Sebastian,
> 
> On 2024-05-26 23:48, Sebastian Kropatsch wrote:
> > The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, based on
> > the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.
> > 
> > Hardware features:
> >     - Rockchip RK3588 SoC
> >     - 4GB/8GB/16GB LPDDR4x RAM
> >     - 64GB eMMC
> >     - MicroSD card slot
> >     - 1x RTL8125B 2.5G Ethernet
> >     - 4x M.2 M-Key with PCIe 3.0 x1 (via bifurcation) for NVMe SSDs
> >     - 2x USB 3.0 (USB 3.1 Gen1) Type-A, 1x USB 2.0 Type-A
> >     - 1x USB 3.0 Type-C with DP AltMode support
> >     - 2x HDMI 2.1 out, 1x HDMI in
> >     - MIPI-CSI Connector, MIPI-DSI Connector
> >     - 40-pin GPIO header
> >     - 4 buttons: power, reset, recovery, MASK, user button
> >     - 3.5mm Headphone out, 2.0mm PH-2A Mic in
> >     - 5V Fan connector, PWM buzzer, IR receiver, RTC battery connector
> > 
> > PCIe bifurcation is used to handle all four M.2 sockets at PCIe 3.0 x1
> > speed. Data lane mapping in the DT is done like described in commit
> > f8020dfb311d ("phy: rockchip-snps-pcie3: fix bifurcation on rk3588").
> > 
> > This device tree includes support for eMMC, SD card, ethernet, all USB2
> > and USB3 ports, all four M.2 slots, GPU, RTC, buzzer, UART debugging as
> > well as the buttons and LEDs.
> > The GPIOs are labeled according to the schematics.
> > 
> > Signed-off-by: Sebastian Kropatsch <seb-dev@web.de>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |    1 +
> >  .../boot/dts/rockchip/rk3588-cm3588-nas.dts   | 1269 +++++++++++++++++
> >  2 files changed, 1270 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-cm3588-nas.dts
> 
> Because the CM3588 is a SoM and the NAS is a carrier board this should
> probably be split in two, cm3588.dtsi and cm3588-nas.dts.

also, because of that way too generic name "cm", please incorporate the
company name in the filename as well. For the same reason we named
the rk3568-wolfvision-pf5.dts that way ;-) [Wolfvision being the company]

So maybe:
rk3588-friendlyelec-cm3588.dtsi and rk3588-friendlyelec-cm3588-nas.dts

 
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index c544ff507d20..f1ff58bdf2cd 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -114,6 +114,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-display-vz.dtbo
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-armsom-sige7.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-cm3588-nas.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-coolpi-cm5-evb.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-io.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-wifi.dtbo
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-cm3588-nas.dts b/arch/arm64/boot/dts/rockchip/rk3588-cm3588-nas.dts
> > new file mode 100644
> > index 000000000000..6c45b376d001
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-cm3588-nas.dts
> > @@ -0,0 +1,1269 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> > + * Copyright (c) 2023 FriendlyElec Computer Tech. Co., Ltd.
> > + * Copyright (c) 2023 Thomas McKahan
> > + * Copyright (c) 2024 Sebastian Kropatsch
> > + *
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/pinctrl/rockchip.h>
> > +#include <dt-bindings/soc/rockchip,vop2.h>
> > +#include <dt-bindings/usb/pd.h>
> > +#include "rk3588.dtsi"
> > +
> > +/ {
> > +	model = "FriendlyElec CM3588 NAS";
> > +	compatible = "friendlyarm,cm3588-nas", "rockchip,rk3588";
> 
> Maybe this should be something like:
> 
>   "friendlyarm,cm3588-nas", "friendlyarm,cm3588", "rockchip,rk3588";

This also needs an update of the binding document. Please use a similar
notion as the other som + baseboard entries
(const for the som + enum with one entry with the baseboard)

[...]


> > +/* Connected to 5V Fan */
> > +&pwm1 {
> > +	pinctrl-0 = <&pwm1m1_pins>;
> 
> pinctrl-names is missing, should typically always be defined together
> with pinctrl-X props, same for multiple nodes.

A rationale being that you don't want the soc dtsi in a later stage adding
a possible pinctrl-1 with the board only overriding the pinctrl-0.
When you set the pinctrl-names as well, you get independent from that.


Thanks
Heiko



