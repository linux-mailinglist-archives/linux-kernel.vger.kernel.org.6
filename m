Return-Path: <linux-kernel+bounces-345925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED8298BCFB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46328B2200E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9176D1A0733;
	Tue,  1 Oct 2024 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="TxEw9KOb"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AEF637;
	Tue,  1 Oct 2024 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787701; cv=none; b=UxKVlmg0mQJY5r/7UT1RzlB4n3geI4ChrfIRxCmRfRuaSa7F5LNvVL9sBzx6hflG0O4J2+etJ8A7VADa2hMhGXD0gxE3Rh+ptSt0SG4r+7AbdJMw7GZk0lqz3ychaDSecxPnrClkcnVIonCIQ+h0KitYW0my00s5ZZGCf/wt0WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787701; c=relaxed/simple;
	bh=PZiG0Lzo3b4dwONDy4nc7/i5CifFOpTyHJxqbkb483A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWJ9uhzLRZq90KufLp59TZi4SDFJ/2PJVYOw7zC2kvk9bvqhaXjFDnEI0yKSsLn/eEAIjNdemk4LR/hqGXDx0jP1slkWcwaxaLjCPXDsBEtaMmVhVTVYnsKsm/Scz6S43qFuk8XZVTFkJRDvO4/i14G7SlnL8mjwpj6WopxwkUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=TxEw9KOb; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 13BA820A7A;
	Tue,  1 Oct 2024 15:01:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727787693;
	bh=BrmTtrED+Gk2rQUZAOzWnLCa/og6AoFCe+d+X82XMJM=; h=From:To:Subject;
	b=TxEw9KObn81KfvZ8gKGdzt+gVnh6oJYcBMm2yI2KVVye3VC5G6rMWU6nucuwcBp9m
	 5SYkgbwcStAOYeGxlzO2OyyL3jaUEWxyj+VDp1gYEzCVSliWMCvLOp5CSJ9iaW2EXb
	 Y22Jk2ZCJAmPHij16FpVN5OPBbJ+LXCoAsFs6zJZbMVisI7/rgjm8mx97Z9u2B4TGZ
	 77U08cZczpEV2LcId0DrUvulmta3dk0ncDJ86x/ygi7EPSlt59+mzZtqW4TK6oHgYQ
	 YsA2iuAaqwiylsVWHgJQpo97fw/iljx+9zv0sNmHgRqWXjPTUUxZU+8VDGEQp0/wkt
	 /vWQ6uRKl7CmQ==
Date: Tue, 1 Oct 2024 15:01:28 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzk@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-verdin: Update tla2024 adc
 compatible
Message-ID: <20241001130128.GA36341@francesco-nb>
References: <20241001111413.10390-1-jpaulo.silvagoncalves@gmail.com>
 <a5890be6-914c-48cc-9abd-761961ccb7ca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5890be6-914c-48cc-9abd-761961ccb7ca@kernel.org>

Hello Krzysztof,

On Tue, Oct 01, 2024 at 01:54:56PM +0200, Krzysztof Kozlowski wrote:
> On 01/10/2024 13:14, João Paulo Gonçalves wrote:
> > From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > 
> > With commit f1c9ce0ced2d ("iio: adc: ti-ads1015: Add TLA2024 support") a
> > new compatible was introduced for TLA2024 ADC. Update the device
> > tree to use the correct compatible for the Verdin-AM62 hardware.
> > 
> > Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > index 5bef31b8577b..f201722d81b3 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > @@ -1220,7 +1220,7 @@ sensor@48 {
> >  	};
> > 
> >  	adc@49 {
> > -		compatible = "ti,ads1015";
> > +		compatible = "ti,tla2024";
> 
> So it is not always TI, who breaks their users. :) (as pointed out in
> LPC DT BoF).

So, let's adjust what I said at that time, I think is important, and I
appreciate you giving me an excuse for doing that :-)

Lately as Toradex we are working a lot with TI, and one of the reasons is
that they have a great software support, backed-up by a great strategy
on the way they contribute to the various upstream projects they build
their SDK on top (Linux, U-Boot, and more).

With that is normal that while working so closely with them we find
issues, everybody have those, it's just that those are the one we
care the most at the moment :-). Not to mention that we started working
with TI a couple of years ago, so TI is still somehow "new" to us and we
are still "learning".

On this regards I was recently working on updating our BSP to the
latest SDK from TI, that is based on a v6.6 stable kernel and looking at
the patches we had to apply on top, the total counts of the patches we
do not have in mainline to support the board subject of this patch is
just _zero_. This to me is a great achievement.

Nishant: this is also for you, and feel free to "market" this
internally/externally :-)


> If you want to break users, sure, but at least explain in commit msg why.

Now, on this specific topic, the actual device that is assembled on this
board is a TI TLA2024, and it's like that since ever, the board never
changed. The current compatible is not matching what is assembled on
board. It works because the device is close enough to TI ADS1015.

With that said, I do not think this is breaking any actual compatibility
issue.

 - The old DTB will keep working with old and new kernel.
 - The commit adding support for TI TLA2024 is in v5.19, and this board
   is supported only from kernel v6.5, so you cannot run an older kernel
   with this board. In addition to that I do not think that is
   reasonable to have someone using a "new" dtb with an "old" kernel.
 - The firmware, U-Boot, the only one that currently supports this board,
   is not making any use of this compatible nor of this ADC.


Francesco


