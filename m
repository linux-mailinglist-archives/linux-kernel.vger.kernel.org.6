Return-Path: <linux-kernel+bounces-294048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F87195883F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E3EB22159
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12020190674;
	Tue, 20 Aug 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="xKuUCpPt"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D5318FC93
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161699; cv=none; b=B+7cuQ+uPFcpXHk6Oec/ji2uXAY9lNMQkClga6Q9B46xErDR8QCTX3fLIgFWGh4kBjE41Q5gd60N60M1K0mLazyN3mut4Ti6z6T1mTal0t1L6jaR8ooiYiJdqr4pr7zxl+/+/6oMbKOUyu1IstLXEK8jJZ+E3NC/amKk/8oOl7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161699; c=relaxed/simple;
	bh=XKqfsrq7/wcoGof4n+JoaeI8Gs4XkC8iip3eEnMzc1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+kmO6LgA1L5vqdVOj2HBdi03uWK+u54JcZC87ku0aOvP01sseDYV1Vpo3t5JPWOx+6wRiuDYEJSxEHn1kbEV8gAj3/wIMlr7P8BPir9ZZS6QSxEhGM6B1mY2x6Kx4AGGIXydtG8ZOOvwjMGkYkys3vtRs7WCfqTCNkTd9gj3eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=xKuUCpPt; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCDE21487C87;
	Tue, 20 Aug 2024 15:48:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724161694; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=e1+sGjy8VBENsMfMwQKYHqIK+7Ps82ZuhZuVrasf+w0=;
	b=xKuUCpPtOi7GdI2VP4ldZQAZvcdApMpybA9opjTKQyThUSXOI5FegOu03axfGV0irWfWS9
	PKdwwa5T74iw/NxfptN4h3UtjY+YJ8hxQV+aJKMYwEIiGb1T8ZkQ9+nuJ/7y+SFGgg17qJ
	/hJnfpox+QbzQZuUUsTGDhlSBn8PjZl6AqVnL45/i0Gj8a81pr30Vn04uvRn0S1t36L/GH
	yaSjHBVclhfiuOdKUvsJWomKxLAzm/m5e/bI09bZyPpE67nLWqws7r1H7c+zOPiv8Sp67H
	N23Qo+eVIURLA5j+x44hUfI/kFRKvX0wAA4XnnZoVfd2iLqMI3Op6Q9DmO0Skw==
Date: Tue, 20 Aug 2024 15:48:12 +0200
From: Alexander Dahl <ada@thorsis.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 0/1] Timeout error with Microchip OTPC driver on
 SAM9X60
Message-ID: <20240820-operating-surgical-9a7a877256ff@thorsis.com>
Mail-Followup-To: claudiu beznea <claudiu.beznea@tuxon.dev>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20240412140802.1571935-1-ada@thorsis.com>
 <d4dc3f45-5bae-44a8-8169-58077f8b7966@tuxon.dev>
 <20240813-payable-ecology-8a9e739704bb@thorsis.com>
 <479c083b-9c1a-4200-aff5-77dc250e536c@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <479c083b-9c1a-4200-aff5-77dc250e536c@tuxon.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Claudiu,

Am Tue, Aug 20, 2024 at 02:59:03PM +0300 schrieb claudiu beznea:
> Hi, Alexander,
> 
> On 13.08.2024 11:55, Alexander Dahl wrote:
> > Hello Claudiu,
> > 
> > Am Wed, Apr 24, 2024 at 10:32:02AM +0300 schrieb claudiu beznea:
> >> Hi, Alexander,
> >>
> >> On 12.04.2024 17:08, Alexander Dahl wrote:
> >>> Hei hei,
> >>>
> >>> on a custom sam9x60 based board we want to access a unique ID of the
> >>> SoC.  Microchip sam-ba has a command 'readuniqueid' which returns the
> >>> content of the OTPC Product UID x Register in that case.
> >>>
> >>> (On a different board with a SAMA5D2 we use the Serial Number x Register
> >>> exposed through the atmel soc driver, which is not present in the
> >>> SAM9X60 series.)
> >>>
> >>> There is a driver for the OTPC of the SAMA7G5 and after comparing
> >>> register layouts it seems that one is almost identical to the one used
> >>> by SAM9X60.  So I thought just adapting the driver for SAM9X60 should be
> >>> easy.  (At least as a start, the driver has no support for that UID
> >>> register, but I suppose it would be the right place to implement it.)
> >>>
> >>> However it does not work.  I used the patch attached with
> >>> additional debug messages on a SAM9X60-Curiosity board.  (That patch is
> >>> not meant for inclusion, just for showing what I've tried.)
> >>>
> >>> On probe the function mchp_otpc_init_packets_list() returns with
> >>> ETIMEDOUT, which it can only do if mchp_otpc_prepare_read() returns with
> >>> timeout and that can only happen if read_poll_timeout() times out on
> >>> reading the Status Register.  Poking that register with `devmem
> >>> 0xeff0000c 32` gives 0x00000040 which means "A packet read is on-going".
> >>
> >>
> >> Would it be possible that the OTP memory is not properly initialized and
> >> the algorithm to initialized the packet list to confuse the hardware?
> >>
> >> I see in the datasheet the following: "The initial value of the OTP memory
> >> is ‘0’ but the memory may contain some “defective” bits already set to the
> >> value ‘1’."
> > 
> > I think this might be possible?  SAM-BA also stumbles here, but the
> > SoC is like shipped by the vendor, no OTPC writes ever from my side.
> 
> I'm not sure how the SAM9X60 OTP memory is shipped by vendor. If I remember
> correctly the user must flash the bootconfig packet depending on his needs.

User can do that, but does not need to if the defaults are sufficient.
On sam9x60-curiosity it just boots with defaults from SD card or raw
NAND flash.  No bootconfig packets are set here.

> > When calling this …
> > 
> >     $ sam-ba -p serial -d sam9x60:0:1 -t 5 -a bootconfig -c readcfg:bcp-otp
> > 
> > … I get this on serial debug output:
> > 
> >     Applet 'BootConfig' from SAM-BA Applets Framework 3.8 (v3.8).
> >     -E- Cannot read Boot Config Packet.
> >     -E- Invalid parameter for read config: index 0
> > 
> > Question is: how should the driver behave in this case?  Fail like it
> > does now?  Or load in some kind of safe state with "empty" nvmem?
> 
> The driver cannot know if the memory is defective or not. Not that I've
> know. It expects the memory to be in a proper state.

Datasheet says:

    After each reset, the OTPC parses the User area to check its
    content. The header of each packet will be read, depending on the
    header value some actions can be triggered:
    • If the header is corrupted, the init sequence is interrupted and
    the OTPC_ISR.COERR bit is set.

The COERR bit in OTPC_ISR can be checked in the driver of course.  Not
sure if that adds any real value however.  Maybe issue a warning in
that case?

> E.g. On SAMA7G5 the OTP memory has at lest the temperature sensor
> calibration data packet. And if I remember correctly, it also has the
> bootconfig packet on the first position.

Nice to know, however I don't have a board featuring the sama7g5 at hand.

Greets
Alex

> 
> Thank you,
> Claudiu Beznea
> 
> > This is especially interesting with regard to a new question below.
> > 
> >> Otherwise, from the top of my mind I don't have any idea on what might happen.
> > 
> > I have some debug code here, and digging deeper into this currently to
> > see what's really happening.  While at it, a new question came up:
> > 
> > There's this OTP memory which the driver tries to expose as NVMEM.
> > However what I really want to do is getting access to the OTPC Product
> > UID x Registers, which are not OTP memory but plain registers inside
> > of the address space of the OTPC here.  Should this be exposed as a
> > second nvmem device then, or handled by a different driver?  How would
> > accessing the same register space from different drivers be handled
> > then?
> > 
> > Greets
> > Alex
> > 
> >>
> >> Thank you,
> >> Claudiu Beznea
> >>
> >>>
> >>> Kinda stuck here.  Any ideas?
> >>>
> >>> Greets and have a nice weekend everyone
> >>> Alex
> >>>
> >>> Alexander Dahl (1):
> >>>   nvmem: microchip-otpc: Add support for SAM9X60
> >>>
> >>>  .../dts/microchip/at91-sam9x60_curiosity.dts     |  4 ++++
> >>>  arch/arm/boot/dts/microchip/sam9x60.dtsi         |  7 +++++++
> >>>  drivers/nvmem/microchip-otpc.c                   | 16 +++++++++++++---
> >>>  3 files changed, 24 insertions(+), 3 deletions(-)
> >>>
> >>>
> >>> base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

