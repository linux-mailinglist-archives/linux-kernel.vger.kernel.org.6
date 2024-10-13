Return-Path: <linux-kernel+bounces-362952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FBF99BBAB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 22:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26781C20DBD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176C814D2A0;
	Sun, 13 Oct 2024 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="JPGZWtCs"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A887F48C;
	Sun, 13 Oct 2024 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728851265; cv=none; b=tZiJNfDf0/QxocjXMbJATqDP3x9QDs0gLk3x697v05VWxdmenINZE3mivHd3NwOCqd9pZakUJGkPYIJrOKVAq7ZLYRQ1J7sfyPzxcyd9MdF8/Oa0jZCy6v/l7dd5WsBcgUr+QcNui6bFhpLVjzHkR6bMDb4vevxjcuHRyJ//d+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728851265; c=relaxed/simple;
	bh=62/V9eJs/KS7YDoVYFGQZpWGLYhSj9R84vJQsQA0k0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5gO5RIG/XmGK8/uIhTaDQ4fsTmEJuQsTfZ4tCINJ3NUhrVIDgTLn7SN/8rfJ1mzj9PCKV4gr3xKnXW+QO9UNBkN11OVIH4zeZbMwsFwYsLyagxUuvtVDtcWTayCh59KbSxMkFO7q3/rze5JbV0VLMyc7odmwn2mXXxjIL70Kp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=JPGZWtCs; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QrBSdPL+PTvkNQLckrp23vyrqP/UgjfKLUytwWKGKho=; b=JPGZWtCsTMq3gEqBJj9Ed6XPaF
	O/Mx9hNnb4alm+ViB/ARZTLca7ji8OJ5szNaH5Itwcg+eHXtYUI8ToRVkPjWGqpIKUDo2bOOdjJmN
	dGaHoKmUzC5Y157E2hWFK/j0C6BtelRJSC6vD13dhcSJ65qnpZML39fGw6rsLrdzx8G6AQCN9/R6J
	HqMLzAOheY1kKJmuXleyaD6qs91RKee+xlQ5HRPjWb0tNgOSfA+rsS0TXHXW5Gqo4wM4VOJZ+jRDD
	C0ryetmMDOG2Nd79YBn+oiS1yyyVWDrs178iy7cKHx4mckcf3cu8q1EAMyK2zi9FWGA4noPq2o+6k
	HuH0WY9A==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t05Bj-0001Q6-WF; Sun, 13 Oct 2024 22:27:40 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 0/5] Binding and driver for gated-fixed-clocks
Date: Sun, 13 Oct 2024 22:27:39 +0200
Message-ID: <2342287.ElGaqSPkdT@diego>
In-Reply-To: <3dd94272e827703c2a2a390fcbd9ff5b@manjaro.org>
References:
 <20240906082511.2963890-1-heiko@sntech.de>
 <3dd94272e827703c2a2a390fcbd9ff5b@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Sonntag, 13. Oktober 2024, 21:58:41 CEST schrieb Dragan Simic:
> Hello Heiko,
> 
> On 2024-09-06 10:25, Heiko Stuebner wrote:
> > Rockchip boards with PCIe3 controllers inside the soc (rk3568, rk3588) 
> > have
> > external oscillators on the board to generate the needed 100MHz 
> > reference
> > clock the PCIe3 controller needs.
> > 
> > Often these clock generators need supplies to be enabled to run.
> > 
> > Modelling this clock has taken a number of shapes:
> > - The rk3568 Rock-3a modelled the generator-regulator as "phy-supply" 
> > [0]
> >   &pcie30phy {
> >   	phy-supply = <&vcc3v3_pi6c_03>;
> >   	status = "okay";
> >   };
> >   which is of course not part of the binding
> > 
> > - On the Rock-5-ITX the supply of the clock generator is controlled by
> >   the same gpio as the regulator supplying the the port connected to 
> > the
> >   pcie30x4 controller, so if this controller probes first, both
> >   controllers will just run. But if the pcie30x2 controller probes 
> > first
> >   (which has a different supply), the controller will stall at the 
> > first
> >   dbi read.
> > 
> > There are other types too, where an 25MHz oscillator supplies a PLL
> > chip like the diodes,pi6c557 used on Theobroma Jaguar and Tiger boards.
> > 
> > As we established in v1 [1], these are essentially different types, so
> > this series attempts to solve the first case of "voltage controlled
> > oscillators" as Stephen called them.
> > 
> > With the discussion in v2, gated-fixed-clock was deemed one possible
> > nice naming, so I did go with that.
> 
> Thanks, I find "gated-fixed-clock" a much better choice.
> 
> > Stephen also suggested reusing more of clk-gpio to not re-implement the
> > gpio handling wrt. sleeping and non-sleeping gpios.
> > 
> > Though instead of exporting masses of structs and ops, 
> > gated-fixed-clock
> > is quite close to the other gpio-clocks, so I've put it into the 
> > clk-gpio
> > file.
> 
> Just checking, what's the current state of this patch series?
> Would another review help with getting it accepted?

I guess me needing to ping Stephen to look at it now that the
merge window is done ;-) .

In the previous version he sounded ok with the naming, so hopefully
it'll just need a tiny ping.


Heiko



