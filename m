Return-Path: <linux-kernel+bounces-267433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BDD94116F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F4F1C22E51
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B92B19DFBB;
	Tue, 30 Jul 2024 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="eRPQVMsY"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4B757FC;
	Tue, 30 Jul 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722340883; cv=none; b=tO63LGa4ZQ7qoXh3/dwqPi3sgn1ypa47AdhqVTwDVUDmaSfBFeCvWVer3u8yS3fHoRO3QtJmrVP6aAJ/4k2CkGhmhGimbiE/RK6MvxhbkIiCoVc8jJz0X7kJz08cEBTVeP+JWWbC1SXEuSMbKI0+FLmGl8x/FOVUsfRgZuorfkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722340883; c=relaxed/simple;
	bh=4jKsHKTvty4PUcCCXuhg1uYU4hjwbtkRKIr+BCTwAiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2REb6kKIZ5TrcQkPdQGr0mBBI9SnTM71U9QJMHKYcjaf6OhswOE3tN5R6IScXtsEFY/UyQold1hSMp5ifA+4HFad6ov5f2KAS0bVeZ0oBvQmkMeDwpsqfeBj74BJZJSYPv7dTdn89yjFIZFadxtaz4eXXH/0rhYZobLbh6ApNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=eRPQVMsY; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A8EA71F91A;
	Tue, 30 Jul 2024 14:01:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1722340869;
	bh=gJKco2VTa1Fg2A5oLOeS7gBjwDsEG+Heea3+gbMISO4=; h=From:To:Subject;
	b=eRPQVMsY/03MnTkG/WjZxFzc4Jz85M6st+Klt0Ub0ncT0tzWbIWTo/m1JCfIknjln
	 sNfhSPPybYLaX07us+Sw5ldCXvHnBhSFWMsOQ4TNkq07MsOEJlQPRUBo1DO0mP3Myb
	 k5IjQ8jE4nUVIx0kcEyZMK+HeoJv45jUZcHUzLK8J+/w0ChEIXzp9BkOEcAf4ESja6
	 LOG5x6I5HiiS5RUiyCMMen9gqmYlRKDzmY59CubZZ4GPyXIwENdU0fgMq8gFm4Ln22
	 B2U07DyloYIebyOIiZ60zUJnRUQqf1Zd0CubsWNzlA1p/8+jc3V7skNWd7LEIELgd/
	 x3z8jPEMTOp8A==
Date: Tue, 30 Jul 2024 14:01:04 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	"vigneshr@ti.com" <vigneshr@ti.com>,
	"parth105105@gmail.com" <parth105105@gmail.com>,
	"kristo@kernel.org" <kristo@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"j-choudhary@ti.com" <j-choudhary@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: Correct McASP DMAs
Message-ID: <20240730120034.GA39114@francesco-nb>
References: <20240730093754.1659782-1-parth105105@gmail.com>
 <94a0be3616425c7aef7bb0507d60ee11d4776545.camel@toradex.com>
 <20240730110444.fctc2lje62ewg4ob@safari>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240730110444.fctc2lje62ewg4ob@safari>

Hello Nishanth,

On Tue, Jul 30, 2024 at 06:04:44AM -0500, Nishanth Menon wrote:
> On 10:50-20240730, Parth Pancholi wrote:
> > On Tue, 2024-07-30 at 11:37 +0200, Parth Pancholi wrote:
> > This message originated from outside your organization
> > 
> > From: Parth Pancholi <parth.pancholi@toradex.com>
> > 
> > Correct the McASP nodes - mcasp3 and mcasp4 with the right
> > DMAs thread IDs as per TISCI documentation [1] for J784s4.
> > This fixes the related McASPs probe failure due to incorrect
> > DMA IDs.
> > 
> > Link: http://downloads.ti.com/tisci/esd/latest/5_soc_doc/j784s4/psil_cfg.html#psi-l-source-and-destination-thread-ids/<http://downloads.ti.com/tisci/esd/latest/5_soc_doc/j784s4/psil_cfg.html#psi-l-source-and-destination-thread-ids> [1]
> > Fixes: 5095ec4aa1ea ("arm64: dts: ti: k3-j784s4-main: Add McASP nodes")
> > Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> > ---
> > arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> > index f170f80f00c1..d4ac1c9872a5 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> > @@ -2755,7 +2755,7 @@ mcasp3: mcasp@2b30000 {
> > interrupts = <GIC_SPI 550 IRQ_TYPE_LEVEL_HIGH>,
> > <GIC_SPI 551 IRQ_TYPE_LEVEL_HIGH>;
> > interrupt-names = "tx", "rx";
> > - dmas = <&main_udmap 0xc500>, <&main_udmap 0x4500>;
> > + dmas = <&main_udmap 0xc403>, <&main_udmap 0x4403>;
> > dma-names = "tx", "rx";
> > clocks = <&k3_clks 268 0>;
> > clock-names = "fck";
> > @@ -2773,7 +2773,7 @@ mcasp4: mcasp@2b40000 {
> > interrupts = <GIC_SPI 552 IRQ_TYPE_LEVEL_HIGH>,
> > <GIC_SPI 553 IRQ_TYPE_LEVEL_HIGH>;
> > interrupt-names = "tx", "rx";
> > - dmas = <&main_udmap 0xc501>, <&main_udmap 0x4501>;
> > + dmas = <&main_udmap 0xc404>, <&main_udmap 0x4404>;
> > dma-names = "tx", "rx";
> > clocks = <&k3_clks 269 0>;
> > clock-names = "fck";
> > 
> I think your patch got corrupted. Could you use git send-email or a
> proper client?

Are you sure it was not your side to mess-up with it?

I tested and it applies fine to me

$ b4 shazam 20240730093754.1659782-1-parth105105@gmail.com
Grabbing thread from lore.kernel.org/all/20240730093754.1659782-1-parth105105%40gmail.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 2 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH] arm64: dts: ti: k3-j784s4-main: Correct McASP DMAs
  ---
  ✓ Signed: DKIM/gmail.com
---
Total patches: 1
---
Applying: arm64: dts: ti: k3-j784s4-main: Correct McASP DMAs



