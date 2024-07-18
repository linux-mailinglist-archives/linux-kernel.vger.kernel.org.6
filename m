Return-Path: <linux-kernel+bounces-256219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE73934AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2F81C20D05
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24068286A;
	Thu, 18 Jul 2024 09:29:12 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239878175F;
	Thu, 18 Jul 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294952; cv=none; b=FNso27zxegIlRGJLdv0rrZegnpWhb2WDkUWz+GmGEWJ0bBrC1ygauf75VPCC9jtVD5DH8yyDdBT854zov2x04b4OJRZ+/zAlHnrAeGC7lbWUM4ch9pkPGiMX+RW2l2PDzMNYSSa+yiJuYNi09SHfXpuakuVtFJ7LvlcFgsc/OiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294952; c=relaxed/simple;
	bh=G0/oroUA5i1e4r678ciLn1khuf0vA7H4MhJ/quAll4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtVHkzf/4IvKwY+iOKILAkXG7l5zRDWedwJBH7JC0XAiREeiej68nR9xXGzop64bie8Lr4fjYd8snYB5GAtrv4rESwdC0B0zuNzZ0ZKDOppmXdFbksQoJi3Ccez9TqPfElb9TTlmYS9+1PkJRkaYJ+tUcsyDbhb3enjeU8KeLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d09.versanet.de ([94.134.13.9] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sUNRf-0003M8-Iy; Thu, 18 Jul 2024 11:29:03 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>, Anand Moon <linux.amoon@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH v2 3/3] arm64: dts: rockchip: fix the pcie refclock oscillator on
 Rock 5 ITX
Date: Thu, 18 Jul 2024 11:29:02 +0200
Message-ID: <1829575.Zkmt1EvEu4@diego>
In-Reply-To:
 <CANAwSgS7qFZ4wbvLOxZ+9k=F7c3mFGo=Ab4aJjLgVu+JhfQneg@mail.gmail.com>
References:
 <20240715110251.261844-1-heiko@sntech.de>
 <72b84761ef93c1d4d6d61b16ef1bb1ce@manjaro.org>
 <CANAwSgS7qFZ4wbvLOxZ+9k=F7c3mFGo=Ab4aJjLgVu+JhfQneg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 18. Juli 2024, 10:00:51 CEST schrieb Anand Moon:
> Hi Dragan
> 
> On Thu, 18 Jul 2024 at 13:28, Dragan Simic <dsimic@manjaro.org> wrote:
> >
> > On 2024-07-18 09:52, Anand Moon wrote:
> > > On Thu, 18 Jul 2024 at 13:02, Dragan Simic <dsimic@manjaro.org> wrote:
> > >> On 2024-07-18 09:26, Anand Moon wrote:
> > >> > On Mon, 15 Jul 2024 at 16:35, Heiko Stuebner <heiko@sntech.de> wrote:
> > >> >>
> > >> >> The Rock 5 ITX uses two PCIe controllers to drive both a M.2 slot and
> > >> >> its
> > >> >> SATA controller with 2 lanes each. The supply for the refclk
> > >> >> oscillator is
> > >> >> the same that supplies the M.2 slot, but the SATA controller port is
> > >> >> supplied by a different rail.
> > >> >>
> > >> >> This leads to the effect that if the PCIe30x4 controller for the M.2
> > >> >> probes first, everything works normally. But if the PCIe30x2
> > >> >> controller
> > >> >> that is connected to the SATA controller probes first, it will hang on
> > >> >> the first DBI read as nothing will have enabled the refclock before.
> > >> >
> > >> > I just checked the rk3588-rock-5-itx.dts in the linux-next.
> > >> > You have not enabled sata0 and sata2, which might be the problem
> > >> > for the SATA controller not getting initialized.
> > >>
> > >> Rock 5 ITX doesn't use RK5588's built-in SATA interfaces, so that's
> > >> fine.
> > >> Please have a look at the board schematic, it uses a separate PCI
> > >> Express
> > >> SATA controller for its four SATA ports.
> > >>
> > > yes, But I am referring to sata node not enabled which enable
> > > the PHY_TYPE_SATA.
> > >
> > > see rk3588-coolpi-cm5-evb.dts and rk3588-edgeble-neu6a-io.dtsi
> > > rk3588-quartzpro64.dts
> > > which have sata port on board.
> > >
> > > &sata0 {
> > >         status = "okay";
> > > };
> >
> > QuartzPro64, as an example, uses RK3588's built-in SATA interfaces,
> > so it enables sata0 in its board dts.  Rock 5 ITX doesn't do that,
> > as I already described.
> 
> Ok no problem,

For the Rock 5 ITX it really only routes 2 PCIe lanes to one M.2 port
and the other 2 lanes to the separate ASMedia SATA controller.
So from the Rock5 PoV, it's really just 2 PCIe 2-lane slots and the
SATA controller simply gets probed as PCIe device.

I even have a sample of the Rock 5+ here, that actually drops the
separate SATA controller and instead provides a 2nd M.2 slot ;-)

Heiko



