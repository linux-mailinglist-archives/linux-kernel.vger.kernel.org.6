Return-Path: <linux-kernel+bounces-518366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B20A38DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4522E16CBDE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068FC1A3177;
	Mon, 17 Feb 2025 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="J9Gsuz5s"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25327383;
	Mon, 17 Feb 2025 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827863; cv=none; b=jXRtxHFDpbAmPIJjuvZp8tBL5TBf6ZJLoHQvsWetO+Ml3L/qqaknjVl+TQ5RTqqPOgFXQBF22Zcum3pbQrZ9+h7ReXbc+EQ8qhwk0y56p7I3Dvworvjp1Hri7W6Xo+FxRdttET/5hSE/OOUYVQLtw9mWbSepBEcEkSahY/T7NuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827863; c=relaxed/simple;
	bh=sYlE2oo10D+zlZSU7JzjkABqbjlenUkrRatqjsLLxuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFyYhXzhcBXfVn7prYh4x1sbG9NIEn9i3f10Ur7GezhDqkqoJ6EDjlZkJU7Y09vTPgPiU9QS+ctKnYHS9k8/bgYbbQPyZP6e9MS9E+Ww/WYEzGe7hk3AnJl+fA5aZi5ZeRqWfl1lWgl/k65GMKqs5uAYCylPkitEFyoqoKISjLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=J9Gsuz5s; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=km4O/2HgH8CFmLxzZj0ztyAKVNJrr0OHpoZQa5eynRY=; b=J9Gsuz5sV/BSaYMRSzAmvv17GB
	GXqAZ9x22QoaVuXylY1bKwRYo9jS6ntWADALzdJKRCGnTvMov2e55KZ+aMofNVtZEBS0NOEChHfzu
	j5Zv7mz/CGIkHVClpNrpunKVsRp6e8vnTthm5IDQml/qC2oy7qzY9mx1GNtIBmHU4Efk10v6ZeowP
	70S70zQg1nOw2kdcPtSxWm4zLt4fApluCZvkDOxf2Ydbo3E+IJ7QdEOGLv//dO27Q++LEbOGc7nIA
	5LllI1aLEc5Ql8Gpkee0kfQDBNeVEs6npmukUoFPxtCvDpf0jut6npLKC0mhO8RGgk8vb8QuxHm9H
	anKKwjlw==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tk8hN-0007VX-JV; Mon, 17 Feb 2025 22:30:41 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>,
 Tim Lunn <tim@feathertop.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 Stephen Chen <stephen@radxa.com>, Elon Zhang <zhangzj@rock-chips.com>,
 Alexey Charkov <alchark@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v4 2/2] arm64: dts: rockchip: Add Radxa ROCK 4D device tree
Date: Mon, 17 Feb 2025 22:30:40 +0100
Message-ID: <3568510.6YUMPnJmAY@diego>
In-Reply-To: <1914418.tdWV9SEqCh@earth>
References:
 <20250217164009.130286-1-detlev.casanova@collabora.com>
 <01b72ad6-67bc-472e-b04d-c9fd42d37d8d@kwiboo.se> <1914418.tdWV9SEqCh@earth>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Montag, 17. Februar 2025, 22:07:06 MEZ schrieb Detlev Casanova:
> On Monday, 17 February 2025 12:08:47 EST Jonas Karlman wrote:
> > On 2025-02-17 17:34, Detlev Casanova wrote:
> > > +	pmic@23 {
> > > +		compatible = "rockchip,rk806";
> > > +		reg = <0x23>;
> > > +
> > > +		gpio-controller;
> > > +
> > > +		interrupt-parent = <&gpio0>;
> > > +		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&pmic_pins
> > > +			     &rk806_dvs1_null
> > > +			     &rk806_dvs2_null
> > > +			     &rk806_dvs3_null>;
> > > +
> > > +		system-power-controller;
> > > +
> > > +		vcc1-supply = <&vcc_5v0_sys>;
> > > +		vcc2-supply = <&vcc_5v0_sys>;
> > > +		vcc3-supply = <&vcc_5v0_sys>;
> > > +		vcc4-supply = <&vcc_5v0_sys>;
> > > +		vcc5-supply = <&vcc_5v0_sys>;
> > > +		vcc6-supply = <&vcc_5v0_sys>;
> > > +		vcc7-supply = <&vcc_5v0_sys>;
> > > +		vcc8-supply = <&vcc_5v0_sys>;
> > > +		vcc9-supply = <&vcc_5v0_sys>;
> > > +		vcc10-supply = <&vcc_5v0_sys>;
> > > +		vcc11-supply = <&vcc_2v0_pldo_s3>;
> > > +		vcc12-supply = <&vcc_5v0_sys>;
> > > +		vcc13-supply = <&vcc_1v1_nldo_s3>;
> > > +		vcc14-supply = <&vcc_1v1_nldo_s3>;
> > > +		vcca-supply = <&vcc_5v0_sys>;
> > > +
> > > +		#gpio-cells = <2>;
> > 
> > This should probably be sorted next to gpio-controller.
> 
> It's not unusual to put # props at the end. but I can move it up if it is 
> preferred.

That is actually a multi-colored bikeshed ;-)

When sorting alphabetically, do you
- just ignore the "#", this would move #gpio-cells to gpio*  but also
  split up #address-cells and #size-cells
- count "#" as special character and move them to the bottom, but this
  would split #gpio-cells from gpio-controller

--- TL;DR
So far I've not managed to come with a 1-size-fits-all opinion, but for
#gpio* and #clock* properties, readability gets better when they are
together with other gpio* / clock* properties .
----

Also I think you could do away with all the empty lines between properties
above (pinctrl <-> system-power-controller, etc), but of course keep the
empty between the subnodes below :-)


Heiko



