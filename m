Return-Path: <linux-kernel+bounces-538525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4047A499A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E158B172A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EC026B2C8;
	Fri, 28 Feb 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="nxpObFjD"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7523526738F;
	Fri, 28 Feb 2025 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746636; cv=none; b=KERtQ6588Qiuv/v6brwlsr7NFuvvQnA7W7SI9XlovCE4dTtCqfdsVnrF3f3fcG56uVrrR+eJd0qM+lPZN7AUz/EFAIKHQEFzMxQsP1PeBpAnijJYmIrt9X7H5rZ2g8M8xGD2uNJCz80Q1unTcrT24gift+AZ3AiC6aiuw0HrkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746636; c=relaxed/simple;
	bh=vPH+VoX6X3XsxX/Aw/GrX1H8PHOA588xBWRnuXlPizA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfxJAHk6eMFC8wS7T5SqjNTxybq7BBjXOsaDlEqDOqn0xPdk9EKG7ViFgCJ4lxZEVjZNoz1GWcVMGI+8wgNDUrXSkDfhH7AQxKOHJk+95bFv2ygRfnTON8LwPlypVRh9Qa6aXUxVriBpbbBjtc1rPJ3/geR9rz36EOIqMcq1vSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=nxpObFjD; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 177021F9D0;
	Fri, 28 Feb 2025 13:43:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740746632;
	bh=NFxeqb2w6p/HM7KrbyHkPToUG2g8rWkVuLOzQ+f45vs=; h=From:To:Subject;
	b=nxpObFjDS+xoC+STRpagsX4FWph0sBnWrOMrSK3YKRSZR1J0p0sVD8w0jxP3Pl8AT
	 2hnUXAGt5V/Uw+7Ael657bMHbMydhx89VKnS9U/U981cVlNg36eXOYy55Vv84V8vcW
	 /kUht3tOoSG0/HtuEJB3QTFzYo7A1UIGcirYYqvZsob4GSGcvBvvnAfz2X+i9OVLLU
	 YDsfVfTC84uLXYat3AjU/RmXYSTVoWdjloWLwzDO0XG3YZrP5EBiU+UpoT1LF/1ocZ
	 Y4upNOSX4RmdSqXKoads6uywDhsaOV4n3t+CUAj+IeFuvBunQW5CeOM1VJ4VODpyvs
	 PTNMIiwD8lfwA==
Date: Fri, 28 Feb 2025 13:43:47 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62p: Enable AUDIO_REFCLKx
Message-ID: <20250228124347.GA20656@francesco-nb>
References: <20250206153911.414702-1-francesco@dolcini.it>
 <20250207014239.xzm6rfnusckql2uo@litigator>
 <Z6XFPYaj069fvW1h@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6XFPYaj069fvW1h@gaggiata.pivistrello.it>

On Fri, Feb 07, 2025 at 09:33:01AM +0100, Francesco Dolcini wrote:
> On Thu, Feb 06, 2025 at 07:42:39PM -0600, Nishanth Menon wrote:
> > On 16:39-20250206, Francesco Dolcini wrote:
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > 
> > > On AM62P-based SoCs the AUDIO_REFCLKx clocks can be used as an input to
> > > external peripherals when configured through CTRL_MMR, so add the
> > > clock nodes.
> > > 
> > > Link: http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am62px/clocks.html
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > >  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > > index 420c77c8e9e5..4b47b0774330 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > > +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > > @@ -42,6 +42,26 @@ &inta_main_dmss {
> > >  	ti,interrupt-ranges = <5 69 35>;
> > >  };
> > >  
> > > +&main_conf {
> > 
> > 	Why not add it to main_conf section it self in the file?
> 
> The reason is that main_conf is defined in k3-am62p-j722s-common-main.dtsi,
> that is shared between am62p and j722s.
> 
> On j722s the audio refclk is added in k3-j722s-main.dtsi the same way as I did
> here, so I cannot move this to k3-am62p-j722s-common-main.dtsi without updating
> also k3-j722s-main.dtsi.
> 
> I looked into the differences of j722s and am62p, and from my understanding,
> from the audio refclk point of view, they are identical (same IP, same reg, same
> clocks and same IDs), so this should naturally be moved to
> k3-am62p-j722s-common-main.dtsi as you are suggesting.
> 
> ... however, for some reason I am not aware of, on k3-j722s-main.dtsi a different
> parent clock is used, and I cannot understand the reason. The actual parent clocks
> in this patch are just the same we already have everywhere apart on j722s. I tried
> to look at the history of this and it seems that on the TI downstream kernel branch
> this is defined in the board dts file (!) and this confused me even more.
> 
> So, not wanting to break stuff I was not able to understand I came up with this
> proposal.
> 
> An alternative could be to override the "unexpected" clocks from
> k3-j722s-main.dtsi to the board dts file, and have the "standard" clocks, as
> proposed in this patch and already used on all the other AM62 variants, in
> k3-am62p-j722s-common-main.dtsi.
> 
> +Jayesh that is the author of this specific change in k3-j722s-main.dtsi.

Jayesh, Nishanth, any comment on this?

Should I proceed with this last option ?

   An alternative could be to override the "unexpected" clocks from
   k3-j722s-main.dtsi to the board dts file, and have the "standard" clocks, as
   proposed in this patch and already used on all the other AM62 variants, in
   k3-am62p-j722s-common-main.dtsi.

Francesco


