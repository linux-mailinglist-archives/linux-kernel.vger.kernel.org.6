Return-Path: <linux-kernel+bounces-240940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E860C9274D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F821F21FAA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A931AC25D;
	Thu,  4 Jul 2024 11:21:58 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AAF1DA316;
	Thu,  4 Jul 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092117; cv=none; b=S/QyJi4yhdrAzebc9tKXfDfSjygTyN8KczCWk1Awcn3TRQ/XgxC1HpCvU9kXc23X68IX1AHBPQFyKxlyYTwK27fI3/XDdTcOk62p28mAV634hScV44yv9GYsXjHBxbmDuRZqCTidrScqIPrtpBfiDbfKawOiosv0PZCy1tS45nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092117; c=relaxed/simple;
	bh=8Lu+ko5XCeUskMjb7cl9FY9VNWGe3nY3ao9QKA1CCoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p79lsI2CtsS49NUF7tRuv4J8LZLrN5EF6+Pu3AfAoHTt1LLv2cxLMN/JcuhxIVU3Y0E5d8+doh0LCb7/E8jrq8xPqzIVEZAb16ai008G7lwf/KYdtfecXe8vw5ou24pIySHRg9YErawSoNlPBZJReZwsBCsPcWAIIoCX55pBkhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sPKX5-0008Oh-P3; Thu, 04 Jul 2024 13:21:47 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Alex Bee <knaerzche@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: add rock5 itx board
Date: Thu, 04 Jul 2024 13:21:46 +0200
Message-ID: <2224639.1BCLMh4Saa@diego>
In-Reply-To: <faeb87de-b97e-4f95-bbb0-edd03a411f4c@gmail.com>
References:
 <20240703210524.776455-1-heiko@sntech.de>
 <20240703210524.776455-3-heiko@sntech.de>
 <faeb87de-b97e-4f95-bbb0-edd03a411f4c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Alex,

Am Donnerstag, 4. Juli 2024, 12:52:35 CEST schrieb Alex Bee:
> Am 03.07.24 um 23:05 schrieb Heiko Stuebner:
> > The Rock 5 ITX as the name suggests is made in the ITX form factor and
> > actually build in a form to be used in a regular case even providing
> > connectors for regular front-panel io.
> > 
> > It can be powered either bei 12V, ATX power-supply or PoE.
> > 
> > Notable peripherals are the 4 SATA ports, M.2 M-Key slot, M.2 E-key slot,
> > 2*2.5Gb pcie-connected ethernet nics.
> > 
> > As of yet unsupported display options consist of 2*hdmi, DP via type-c,
> > eDP + 2*DSI via pcb connectors.
> > 
> > USB ports are 4*USB3 + 2*USB2 on the back panel and 2-port front-panel
> > connector.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---

> > +&usb_host1_xhci {
> > +	dr_mode = "host";
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	status = "okay";
> > +
> > +	/* 2.0 hub on port 1 */
> > +	hub_2_0: hub@1 {
> > +		compatible = "usb5e3,610";
> > +		reg = <1>;
> > +		peer-hub = <&hub_3_0>;
> > +		vdd-supply = <&vcc5v0_usb12>;
> Are you sure about this one? I couldn't find any schematics for this board,
> but both the bindings for usb5e3,610 and the datasheet[0] are saying this
> is the supply for the hub's internal logic which is typically ~3.3V. It's
> definitely not a supply for the vbus.
> 
> [0] http://www.sunnyqi.com/upLoad/product/month_1308/GL852G.pdf

yeah, you're right. The vdd-supply is coming from vcc_3v3 it seems
vcc5v0_usb12 is the phy supply instead.

Will fix that in v3.

Thanks for catching that
Heiko



