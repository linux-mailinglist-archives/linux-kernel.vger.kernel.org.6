Return-Path: <linux-kernel+bounces-252714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A3931733
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241971F224A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5105618F2C1;
	Mon, 15 Jul 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="aeTQOly2"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A13418EFDA;
	Mon, 15 Jul 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055322; cv=none; b=XoC9HAYvBzEEyfZDPwnuh/PUdmTyPEANHwMfvdQhFO5aGvUZrXQhxPmDVizJcLRu1wYFVkYb2gFDcyTwHCD3K1cKUACxlWpXdbPeeCyfVoS+FCjHBNPNfscVu7+TP48lEnce/cXtEQhNPRGh2oQbM+wk6PdPPywH2Bqoz/cXhgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055322; c=relaxed/simple;
	bh=R6GVR5nbrPK1ArJAmwv4TPVLMOMH4rsaJWjUIBHDlCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJj7n4a4codUSVCewHZ5fLZ/j6i3Izw3qHMoxZUMUt0soFlk/cG6mbt9VjXBqWBAVHpdFdIUUAa5j8oEW3zerFBNdmRw1fA/XtlKwknd6JyhX80hR74anh3+l3vH8yhHY3nBmFt4rgzApVSL3B745S3GFoMky4ZOoCGQPDgLKDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=aeTQOly2; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id D94131FBDC;
	Mon, 15 Jul 2024 16:55:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1721055308;
	bh=pDawVp5+7gMn51Cqr/yBhI3wgxySaQrWuVDy9+iNnbA=; h=From:To:Subject;
	b=aeTQOly2Z1GJ/aATB0SCPcHrVc3vCd2vPVsd56W25IQIAczovmm7917P45/L184vt
	 S3z6rTvO0t2cVb8X34mKvcRP40QyJl/Uo8PJ7xSDasm8KxxuXYaLYs8X16x0KWLTBd
	 SwLjz3pdnsZ+W8Iey0rrKBoIVVv7IiiRAvzUfQQJLOG32LQT76+hSjbbRAybjEG7VU
	 Dgltqv6GyGZDU9hxp7P08pfn0YYD4NU5OMBVIBpPjT/aB6OyM//lFxICaomBO3Sr1I
	 uQuHqF0FBH9A0BhkVThU+cBauvTs5rxTGE/sAQ+PKmi4XZOfVKhuiktpxcihAZCpyB
	 Di4w2/EZflwuQ==
Date: Mon, 15 Jul 2024 16:55:03 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Logan Bristol <l-bristol@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Krzysztof Kozlowski <krzk@kernel.org>, Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] arm64: dts: ti: introduce a minimal am642 device tree
Message-ID: <20240715145503.GA32273@francesco-nb>
References: <20220321155417.13267-1-bb@ti.com>
 <55e161d1-face-6958-1d86-8a85b82e8485@kernel.org>
 <766dceb1-222a-401b-95e3-69b7fb331411@ti.com>
 <20240710073811.GA4855@francesco-nb>
 <458e6141-abed-4301-ae76-c242c903ef61@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458e6141-abed-4301-ae76-c242c903ef61@ti.com>

On Mon, Jul 15, 2024 at 09:02:38AM -0500, Logan Bristol wrote:
> 
> Hello Francesco,
> 
> On 7/10/24 02:38, Francesco Dolcini wrote:
> > Hello Logan
> > 
> > On Tue, Jul 09, 2024 at 11:20:24AM -0500, Logan Bristol wrote:
> >> On 3/22/22 13:14, Krzysztof Kozlowski wrote:
> >>> On 21/03/2022 16:54, Bryan Brattlof wrote:
> >>>> Texas Instrument's am642 is one of many k3 based, low cost, low power,
> >>>> chips designed to work in a wide range of applications spanning an even
> >>>> wider range of industries that TI is actively developing
> >>>>
> >>>> With its pin-mux and peripheral rich designs, these chips will likely
> >>>> have a multitude of custom device trees that range wildly from one
> >>>> another and (hopefully) guarantee an influx of variants into the kernel
> >>>> in the coming years
> >>>>
> >>>> With overlays no longer a thing, I wanted to ask for opinions on how
> >>>> we can best help integrate these dt files as they begin to be developed
> >>>>
> >>>> I also wanted to introduce a skeletonized (nothing but uart) device tree
> >>>> to give others a good starting point while developing their projects.
> >>>
> >>> Real hardware as DTS please. There is no need to add some skeleton for
> >>> specific SoC. What if every SoC goes that way?
> >>>
> >>> Feel free to create re-usable components in DTSI ways, still reflecting
> >>> some hardware parts.
> >>>
> >>
> >> I am working on a project for the AM62 and came across this email thread.
> >>
> >> Following Krzysztof's direction, I am wanting to submit a DTSI to serve
> >> as a minimal configuration for the existing boards based on the AM62
> >> SoC, which are currently defined by bloated DTS files.
> >>
> >> This DTSI file can be consumed by other board DTS files to reduce the
> >> configuration. Krzysztof, could this be merged upstream?
> > 
> > Can you elaborate a little bit what you meant as bloated dts file? Why
> > would you need different DTSI files compared to the existing one?
> > Which problem are you trying to solve (make some example, be specific
> > please).
> > 
> > My experience with verdin am62 (k3-am62-verdin*dts*) was pretty smooth,
> > I was just able to use the SOC dtsi file and use it to define my own
> > board (and I had the same good experience with other SOC/Vendors).
> > 
> 
> The resulting DTB after compiling AM62 SoC DTSI files initializes a
> large number of devices.

I do not understand the issue. The SOC dtsi enables (or should enable) only
IP that are self contained within the SOC, everything else is disabled.

If you need something like that it means you are debugging the silicon,
am I wrong?

Francesco


