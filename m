Return-Path: <linux-kernel+bounces-235761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8F391D956
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB471C21AB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AE461674;
	Mon,  1 Jul 2024 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="bDLcOEyg"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB037142
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819996; cv=none; b=B7P2BpI/3J4OkyRjOA538UJze51rxEnCRC0hlO1WCIb0ANx1iH4NdusQyrCQMu38sjZMHFfx9gqnz2FZYnXzUgzMjVG7ylVv090pdHX+6bCN1QmeM54WQoMdtqsaiWmcXdqZSiKg9Lxiz2f80Gst2aQnjPnXsn4khugsIhung4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819996; c=relaxed/simple;
	bh=4IuU3rL9MQkYSvOSjZrnPlocJmUuOKhy+jxUu+oFEug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L12+nafcwdTdPzexRNmc0+cEBZNkObq59W1zTAHrbpugaahEkVX9w5UwKo1UdqVIucOkGfCfi7OqLyrMHOUa9kULzzJcINI5qCkDyhfNwTMnxyHecdg+bKOUe+88gyRl0Bz2ZAFZc671Yji9KauAxH2RvRmtRVRhy7ua7rskRw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=bDLcOEyg; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C1A514868DC;
	Mon,  1 Jul 2024 09:41:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1719819666; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=38ns72u8iNLYvZX9CtZLrTvjFcrXs/evZ3NwzBdYp4E=;
	b=bDLcOEygba8aEwqpUqrIWKEt+go5w1XVL7wq52BCrpR+L2fipm2jTFgj3q1LehjBS9hqcM
	m4UYpnXKBlHkOlVKoqziYgnHiqrX8j9NDvWu2D/D6OOb/xhGzoHksdmcRjWcOPfi7V/ima
	CThzFS690em8xvUsmyW6ukMgmV0zk9+wQPASQUGM23mH6INi4FuiVsYQ6jW4QnqGDHlSJp
	ozz9aAudLrmP+GcVoXk6o+sG4YeXDuuBztsPJv0bQftH1x2CAEybpoCyXcB1MFaFVTNQhV
	rcZ3GWF0GYugMfZTsq0+79eUFMg2YowZXWlBndun/XpwTOspghSu1i0Gw2DRTg==
Date: Mon, 1 Jul 2024 09:40:56 +0200
From: Alexander Dahl <ada@thorsis.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Alexander Dahl <ada@thorsis.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Cyrille Pitchen <cyrille.pitchen@microchip.com>
Subject: Re: [RFC PATCH 0/1] Timeout error with Microchip OTPC driver on
 SAM9X60
Message-ID: <20240701-nuttiness-backlit-60ccfea75b56@thorsis.com>
Mail-Followup-To: claudiu beznea <claudiu.beznea@tuxon.dev>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Cyrille Pitchen <cyrille.pitchen@microchip.com>
References: <20240412140802.1571935-1-ada@thorsis.com>
 <d4dc3f45-5bae-44a8-8169-58077f8b7966@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4dc3f45-5bae-44a8-8169-58077f8b7966@tuxon.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hei hei,

Am Wed, Apr 24, 2024 at 10:32:02AM +0300 schrieb claudiu beznea:
> Hi, Alexander,
> 
> On 12.04.2024 17:08, Alexander Dahl wrote:
> > Hei hei,
> > 
> > on a custom sam9x60 based board we want to access a unique ID of the
> > SoC.  Microchip sam-ba has a command 'readuniqueid' which returns the
> > content of the OTPC Product UID x Register in that case.
> > 
> > (On a different board with a SAMA5D2 we use the Serial Number x Register
> > exposed through the atmel soc driver, which is not present in the
> > SAM9X60 series.)
> > 
> > There is a driver for the OTPC of the SAMA7G5 and after comparing
> > register layouts it seems that one is almost identical to the one used
> > by SAM9X60.  So I thought just adapting the driver for SAM9X60 should be
> > easy.  (At least as a start, the driver has no support for that UID
> > register, but I suppose it would be the right place to implement it.)
> > 
> > However it does not work.  I used the patch attached with
> > additional debug messages on a SAM9X60-Curiosity board.  (That patch is
> > not meant for inclusion, just for showing what I've tried.)
> > 
> > On probe the function mchp_otpc_init_packets_list() returns with
> > ETIMEDOUT, which it can only do if mchp_otpc_prepare_read() returns with
> > timeout and that can only happen if read_poll_timeout() times out on
> > reading the Status Register.  Poking that register with `devmem
> > 0xeff0000c 32` gives 0x00000040 which means "A packet read is on-going".
> 
> 
> Would it be possible that the OTP memory is not properly initialized and
> the algorithm to initialized the packet list to confuse the hardware?
> 
> I see in the datasheet the following: "The initial value of the OTP memory
> is ‘0’ but the memory may contain some “defective” bits already set to the
> value ‘1’."

Meanwhile we looked deeper into this driver.  I just drop here what we
found so far, because it's vacation time, and this will probably not
be picked up again this month because vacation etc.  I wanna get it
out of my head for now. ;-)

Note: most of this should also apply to sama7g5, from comparing data
sheets the OTPC is the same.

1. the call to read_poll_timeout() most probably has its sleep and
timeout paramaters swapped.

2. the read access to OTPC_CR register is not necessary, the datasheet
says the register is "write only".  It may even trigger an interrupt
for reading a write only register.  Furthermore the WPCTEN bit in the
OTPC Write Protection Mode register (OTPC_WPMR) is not checked before
accessing OTPC_CR as suggested by the datasheet.

3. the errata sheet for the SAM9X60 SoC (DS80000846) has a section on
the OTPC which recommends a fixup before the first write operation,
with code example:
https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/Errata/SAM9X60-Device-Silicon-Errata-and-Data-Sheet-Clarif-DS80000846.pdf
The same thing is implemented in 'atmel-software-package' which has
(at least had in the past) the code for the binary applets used in the
'sam-ba' tool:
https://github.com/atmelcorp/atmel-software-package/blame/master/drivers/nvm/otp/otpc.c#L86
I bet this fixup should be implemented in this driver here as well?

So far for now.

Greets
Alex

> 
> Otherwise, from the top of my mind I don't have any idea on what might happen.
> 
> Thank you,
> Claudiu Beznea
> 
> > 
> > Kinda stuck here.  Any ideas?
> > 
> > Greets and have a nice weekend everyone
> > Alex
> > 
> > Alexander Dahl (1):
> >   nvmem: microchip-otpc: Add support for SAM9X60
> > 
> >  .../dts/microchip/at91-sam9x60_curiosity.dts     |  4 ++++
> >  arch/arm/boot/dts/microchip/sam9x60.dtsi         |  7 +++++++
> >  drivers/nvmem/microchip-otpc.c                   | 16 +++++++++++++---
> >  3 files changed, 24 insertions(+), 3 deletions(-)
> > 
> > 
> > base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

