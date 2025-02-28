Return-Path: <linux-kernel+bounces-538316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 342DCA4970C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFB61894458
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7F225DAE0;
	Fri, 28 Feb 2025 10:19:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680825D53B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737998; cv=none; b=JPG4W2rwRCwHl4HabW23pbak+tzsb1Duix1ZVpHn6YQgyCYvgol2P/MXg9goYTzPVErYMgK9Heme8TP1bg2QIxHV9o5xxs8M0NdnwgKj7oCCbJLVkEipgBGYJsYzdVdCKrlE0ZcgRDFs4onvwV5wlYlYEasos2QlgAttevFY3jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737998; c=relaxed/simple;
	bh=wZZhMkhQRmVPgHtgd0PNxvh1/Smcic6VSazFh0kFzjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkoA+Ywmoj8iNkV+/WYdMHiJ4lxSlV8szNqplx85f8tayJ3Mxnhl3577X/XqsMpT2U/cdH3k+MFpqfpHdOwhRF/C9XhENN2y+IvapEhaLieT288qbIVnpEQc2UZ6HqS1XiyVMRW3FsRLQFAXtddrrFUg5s4BgIbfWcSKXyTtY5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tnxTE-0000p1-HQ; Fri, 28 Feb 2025 11:19:52 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tnxTE-003HFg-0g;
	Fri, 28 Feb 2025 11:19:52 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tnxTE-005Ghl-0F;
	Fri, 28 Feb 2025 11:19:52 +0100
Date: Fri, 28 Feb 2025 11:19:52 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
	Mihalcea Laurentiu <laurentiumihalcea111@gmail.com>,
	imx@lists.linux.dev,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Message-ID: <20250228101952.g6tae3ni5xrhjk3y@pengutronix.de>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
 <20250221191909.31874-5-laurentiumihalcea111@gmail.com>
 <Z7jahtO3bxjkMfnc@lizhi-Precision-Tower-5810>
 <cd6a84cd-ff17-45df-becc-9bfc74522f73@gmail.com>
 <20250227-monumental-whale-of-security-b1c84e-mkl@pengutronix.de>
 <Z8CWsI/DKZtDBkzE@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8CWsI/DKZtDBkzE@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On 25-02-27, Frank Li wrote:
> On Thu, Feb 27, 2025 at 11:57:54AM +0100, Marc Kleine-Budde wrote:
> > On 25.02.2025 16:14:34, Mihalcea Laurentiu wrote:
> > >
> > > On 21.02.2025 21:56, Frank Li wrote:
> > > > On Fri, Feb 21, 2025 at 02:19:08PM -0500, Laurentiu Mihalcea wrote:
> > > >> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> > > >>
> > > >> AIPS5 is actually AIPSTZ5 as it offers some security-related
> > > >> configurations. Since these configurations need to be applied before
> > > >> accessing any of the peripherals on the bus, it's better to make AIPSTZ5
> > > >> be their parent instead of keeping AIPS5 and adding a child node for
> > > >> AIPSTZ5. Also, because of the security configurations, the address space
> > > >> of the bus has to be changed to that of the configuration registers.
> > > > The orginal 0x30c0_0000..0x31200000 include 0x30df0000, why not map only
> > > > config address part in your drivers.
> > > >
> > > > Frank
> > >
> > > Any concerns/anything wrong with current approach?
> > >
> > >
> > > I find it a bit awkward to have the whole bus address space
> > > in the DT given that we're only interested in using the access
> > > controller register space.
> > >
> > >
> > > I'm fine with the approach you suggested but I don't see a
> > > reason for using it?
> >
> > Looking at the "AIPS5 Memory Map" (page 34/35 in i.MX 8M Plus
> > Applications Processor Reference Manual, Rev. 3, 08/2024), the
> > AIPS5_Configuration is part of the AIPS5 bus. IMHO the bus is something
> > different than the bus configuration. Why not model it as part of the
> > bus?
> >
> > > >> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > >> index e0d3b8cba221..a1d9b834d2da 100644
> > > >> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > >> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > >> @@ -1399,11 +1399,13 @@ eqos: ethernet@30bf0000 {
> > > >>  			};
> > > >>  		};
> > > >>
> > > >> -		aips5: bus@30c00000 {
> > > >> -			compatible = "fsl,aips-bus", "simple-bus";
> > > >> -			reg = <0x30c00000 0x400000>;
> > > >> +		aips5: bus@30df0000 {
> >                        ^^^^^^^^^^^^
> > > >> +			compatible = "fsl,imx8mp-aipstz", "simple-bus";
> > > >> +			reg = <0x30df0000 0x10000>;
> > > >> +			power-domains = <&pgc_audio>;
> > > >>  			#address-cells = <1>;
> > > >>  			#size-cells = <1>;
> > > >> +			#access-controller-cells = <0>;
> > > >>  			ranges;
> > > >>
> > > >>  			spba-bus@30c00000 {
> >                         ^^^^^^^^^^^^^^^^^
> >
> > This looks very strange: The aips5 bus starts at 0x30df0000 and has a
> > child bus starting at 0x30c00000?
> 
> @30df0000 should match controller reg's address.
> 
> subnode address 0x30c00000,  should be descript in "ranges", which 1:1 map.
> 
> So it should be reasonable. another example:
> i2c@1000 {
> 
> 	device@1c <- which use difference address space.
> }
> 
> The similar case also happen at pcie.

I'm not really convinced that pcie and i2c are good examples here. I2C
does have an other addressing scheme by nature and the hotplug-able pcie
is dependeds on the pcie device memory map of course.

Here we're talking about an access control IP core on a bus which is
static.

But.. it looks like from DT abstraction it's fine because STM did
something similiar with their st,stm32mp25-rifsc or st,stm32-etzpc
albeit it does look strange and I don't know why we have to limit the
address space since it was already mapped but used by the fsl,aips-bus
driver.

Regards,
  Marco


> 
> Frank
> 
> >
> > regards,
> > Marc
> >
> > --
> > Pengutronix e.K.                 | Marc Kleine-Budde          |
> > Embedded Linux                   | https://www.pengutronix.de |
> > Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> > Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
> 
> 
> 
> 

