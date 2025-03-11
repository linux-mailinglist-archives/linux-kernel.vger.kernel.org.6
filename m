Return-Path: <linux-kernel+bounces-556065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824E1A5C08F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C201889FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48029260A5B;
	Tue, 11 Mar 2025 12:05:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD39260A50
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694710; cv=none; b=S+fjCGvqLbXC2ITxY1blcithPnT6iBFgjfM/JzZjvecapBUJJnYK8KK2hcCNnbhhqoAo4jhv2Nsoz4NMaEokcwwsqAv3V/1jol+Abq7INvURM417xXRwGaRj5TyZXwoK7rWaVH8iQ0+I+TvdSLjlpAI7AY7JF9VlNnKFAIo+J6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694710; c=relaxed/simple;
	bh=t20yuOvGQQsvRDlo35tvfwHYzGxDYPuVQtBjEcVnqQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQR6D1XLG854zb6D+/wgYyEwG9Y4jjt32e50ywKGpDqMGSy+JLx7heJ5P9Hs6/0KbD0p5fdFx/wk8uATPigeEKqZ6W1if2eam3PPum2I6dkLAwxROGC2N/GhfTh8QxkPg+dAWTKTk9T2Se7hxCw/nl2xFAPQ5yVI0DJH4hesaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tryM5-0008Nt-Gb; Tue, 11 Mar 2025 13:05:05 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tryM3-005B4L-13;
	Tue, 11 Mar 2025 13:05:03 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tryM3-007j7z-0d;
	Tue, 11 Mar 2025 13:05:03 +0100
Date: Tue, 11 Mar 2025 13:05:03 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Frank Li <Frank.li@nxp.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Message-ID: <20250311120503.ryqg2thnj4mkgsjz@pengutronix.de>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
 <20250221191909.31874-5-laurentiumihalcea111@gmail.com>
 <Z7jahtO3bxjkMfnc@lizhi-Precision-Tower-5810>
 <cd6a84cd-ff17-45df-becc-9bfc74522f73@gmail.com>
 <20250227-monumental-whale-of-security-b1c84e-mkl@pengutronix.de>
 <Z8CWsI/DKZtDBkzE@lizhi-Precision-Tower-5810>
 <20250228101952.g6tae3ni5xrhjk3y@pengutronix.de>
 <bfe3c719-f1c5-4ae5-9a40-45ad75cd5855@gmail.com>
 <20250307152236.3ayulbjqnu3vn7mf@pengutronix.de>
 <ec38d41d-f2ce-4a98-bb02-d1ae9beb0b3b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec38d41d-f2ce-4a98-bb02-d1ae9beb0b3b@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-03-10, Laurentiu Mihalcea wrote:
> On 3/7/2025 5:22 PM, Marco Felsch wrote:
> > On 25-03-04, Laurentiu Mihalcea wrote:
> >> On 2/28/2025 12:19 PM, Marco Felsch wrote:
> >>> Hi,
> >>>
> >>> On 25-02-27, Frank Li wrote:
> >>>> On Thu, Feb 27, 2025 at 11:57:54AM +0100, Marc Kleine-Budde wrote:
> >>>>> On 25.02.2025 16:14:34, Mihalcea Laurentiu wrote:
> >>>>>> On 21.02.2025 21:56, Frank Li wrote:
> >>>>>>> On Fri, Feb 21, 2025 at 02:19:08PM -0500, Laurentiu Mihalcea wrote:
> >>>>>>>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>>>>>>>
> >>>>>>>> AIPS5 is actually AIPSTZ5 as it offers some security-related
> >>>>>>>> configurations. Since these configurations need to be applied before
> >>>>>>>> accessing any of the peripherals on the bus, it's better to make AIPSTZ5
> >>>>>>>> be their parent instead of keeping AIPS5 and adding a child node for
> >>>>>>>> AIPSTZ5. Also, because of the security configurations, the address space
> >>>>>>>> of the bus has to be changed to that of the configuration registers.
> >>>>>>> The orginal 0x30c0_0000..0x31200000 include 0x30df0000, why not map only
> >>>>>>> config address part in your drivers.
> >>>>>>>
> >>>>>>> Frank
> >>>>>> Any concerns/anything wrong with current approach?
> >>>>>>
> >>>>>>
> >>>>>> I find it a bit awkward to have the whole bus address space
> >>>>>> in the DT given that we're only interested in using the access
> >>>>>> controller register space.
> >>>>>>
> >>>>>>
> >>>>>> I'm fine with the approach you suggested but I don't see a
> >>>>>> reason for using it?
> >>>>> Looking at the "AIPS5 Memory Map" (page 34/35 in i.MX 8M Plus
> >>>>> Applications Processor Reference Manual, Rev. 3, 08/2024), the
> >>>>> AIPS5_Configuration is part of the AIPS5 bus. IMHO the bus is something
> >>>>> different than the bus configuration. Why not model it as part of the
> >>>>> bus?
> >>>>>
> >>>>>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >>>>>>>> index e0d3b8cba221..a1d9b834d2da 100644
> >>>>>>>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >>>>>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >>>>>>>> @@ -1399,11 +1399,13 @@ eqos: ethernet@30bf0000 {
> >>>>>>>>  			};
> >>>>>>>>  		};
> >>>>>>>>
> >>>>>>>> -		aips5: bus@30c00000 {
> >>>>>>>> -			compatible = "fsl,aips-bus", "simple-bus";
> >>>>>>>> -			reg = <0x30c00000 0x400000>;
> >>>>>>>> +		aips5: bus@30df0000 {
> >>>>>                        ^^^^^^^^^^^^
> >>>>>>>> +			compatible = "fsl,imx8mp-aipstz", "simple-bus";
> >>>>>>>> +			reg = <0x30df0000 0x10000>;
> >>>>>>>> +			power-domains = <&pgc_audio>;
> >>>>>>>>  			#address-cells = <1>;
> >>>>>>>>  			#size-cells = <1>;
> >>>>>>>> +			#access-controller-cells = <0>;
> >>>>>>>>  			ranges;
> >>>>>>>>
> >>>>>>>>  			spba-bus@30c00000 {
> >>>>>                         ^^^^^^^^^^^^^^^^^
> >>>>>
> >>>>> This looks very strange: The aips5 bus starts at 0x30df0000 and has a
> >>>>> child bus starting at 0x30c00000?
> >>>> @30df0000 should match controller reg's address.
> >>>>
> >>>> subnode address 0x30c00000,  should be descript in "ranges", which 1:1 map.
> >>>>
> >>>> So it should be reasonable. another example:
> >>>> i2c@1000 {
> >>>>
> >>>> 	device@1c <- which use difference address space.
> >>>> }
> >>>>
> >>>> The similar case also happen at pcie.
> >>> I'm not really convinced that pcie and i2c are good examples here. I2C
> >>> does have an other addressing scheme by nature and the hotplug-able pcie
> >>> is dependeds on the pcie device memory map of course.
> >>>
> >>> Here we're talking about an access control IP core on a bus which is
> >>> static.
> >>>
> >>> But.. it looks like from DT abstraction it's fine because STM did
> >>> something similiar with their st,stm32mp25-rifsc or st,stm32-etzpc
> >>> albeit it does look strange and I don't know why we have to limit the
> >>> address space since it was already mapped but used by the fsl,aips-bus
> >>> driver.
> >>>
> >>> Regards,
> >>>   Marco
> >> The address space of the bridge was changed to that of the bridge's
> >> configuration space because I think it's very awkward from the
> >> software's point of view to have to hardcode the offset and size of
> >> the configuration space inside the driver. 
> > You mean the access-controller IP core. I could also arguee that it's
> > akward to put the bridge access-controller IP core into the middle of
> > the bridge address-space instead of placing it at the very beginning of
> > the bridge. But this doesn't help here :)
> >
> > I see what you mean but from DT abstraction POV it seems more reasonable
> > to keep it as it is and just adapt the compatible. The current driver
> > maps the whole address space too, so I don't see why we need to change
> > it if we change it to the aipstz driver. If you see the
> > access-controller IP core as part of the bus I don't see any problem and
> > would argue that the offset detail needs to be handled within the
> > driver.
> >
> >> I also looked at what STM did with "st,stm32-etzpc" so I thought this
> >> would be acceptable from the DT's POV.
> >>
> >> Regarding why I chose not to model the access controller part as a subnode of the
> >> bus:
> >>
> >>     1) The access controller is part of the bridge itself (not a separate module accessible
> >>     via the bridge like it's the case for its children) so I think the current approach
> >>     should also make sense if we take the hardware into consideration.
> > I don't like this approach if you see the controller as part of the
> > bridge because the offset could be handled within the bridge driver.
> > I also that the register offset needs to be supplied else we can't reuse
> > the driver and we don't want to adapt the driver for each SoC.
> >
> > What came into my mind is the following:
> >
> > 	spba-bus@30c00000 {
> > 		compatible = "nxp,imx8mp-aiptz-bus", "nxp,aiptz-bus";
> > 		reg = <0x30c00000 0x400000>, <0x30df0000 0x10000>;
> > 		reg-names = "bus", "aipstz";
> >
> > 		child-nodes {};
> > 		child-nodes {};
> > 		child-nodes {};
> > 	}
> >
> > This way we can abstract the access-controller register space and the
> > whole bus register space and a generic driver could be written just by
> > making use two reg fields.
> 
> by changing the compatible, we've also effectively changed the
> programming model.

You need to keep the backward compatible which means, a new kernel have
to boot an old dts (firmware), which is stil the case since the
"simple-bus" driver sill matches on the old dts files.

But this doesn't mean that a new dts (firmware) have to be compatible
with an old kernel.

> I don't really see why we need to stick to the old way of configuring
> the bus node (i.e: specify the whole address space of the bus as well)
> when all we really care about is the AC configuration region?

I see and as I said it's just my oppinion that we should abstract it
this way since upstream already accepted the approach you implemented
for the STM32 case.

If NXP would have placed the AC at the beginning of each AIPS bus you
wouldn't need to deal with this problem too since you would have the
base register already.

> anyhow, I'm not going to insist on this. I think the proposed approach
> will work just fine. If there's no other comments on this then I'll
> just switch to it in V3.

That would be nice but please wait for maintainers feedback e.g Shawn.

Regards,
  Marco

