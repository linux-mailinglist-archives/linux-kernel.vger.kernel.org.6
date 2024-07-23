Return-Path: <linux-kernel+bounces-260180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30FB93A433
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81AE283CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28DA157E62;
	Tue, 23 Jul 2024 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWA4Ej3o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1263D156F40;
	Tue, 23 Jul 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751179; cv=none; b=FrRDJExMaDUa8WNXU0JNO/ycpGAuudjSdRM8uFnxuK5fZp6bmGGTjQ/GrM64ztVwa7m5jOkP5O9/8o9HrHnZFDlzZEHYy82zJpI3fJci1hBe0dsk8V+4EeHZoQKsylcasHIcLVgPDyEOfBFVU4trUvC+VXnuUAMykR9ZSxe6S1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751179; c=relaxed/simple;
	bh=RCY/QKWXLvXlxWiYxx3GP8JxTLcTW8WXv93dS1Ctx7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX7pSmETeM+jTSeC++nbXFPmk5c6pqFwBiP2EHVYQsF2g0BTPCOzg42ENkGr9b/ZTNDpHrhhH0VKlAOvF+YIRKiqhblAZLDzo7ZJRzdALKO/2+ak4GM296phXKcbg2Ct819/bkJstVo9uhlRP+FRq1HLZzrzbXn2hN8AUuXGups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWA4Ej3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA29C4AF09;
	Tue, 23 Jul 2024 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721751178;
	bh=RCY/QKWXLvXlxWiYxx3GP8JxTLcTW8WXv93dS1Ctx7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWA4Ej3os8mtDAsmYe/LCG8wJnvGiFeZa4b1kfZOWCuOWnh/WHr+z4FpvBYY8LIKx
	 lFciV5+P2+vwFTUUua0tq/PE3fle4fhj88M0yk16j5arljzvmakxIAhPvweCJ/haTy
	 ZXBAJqloV5Tr39siLNC2nOWUUL8QzYV1vilrlAmMli0n6QOzMJcdW9em29FPUAGynw
	 eyPVIIJsr6+SpXN0QOSzw4ixJgAF2ZYcJUjX320RvF0lhVb2ccHDmd7c6yjRDfT/c2
	 SYDqe6NYYEwUD+d0v4zMigpv7IB7y7a520AvXYUzovUVpJBUWa8ShpNyBZYzPTVDZc
	 k8zn+ZbH/rxgA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sWI8I-000000002Vl-0umG;
	Tue, 23 Jul 2024 18:12:58 +0200
Date: Tue, 23 Jul 2024 18:12:58 +0200
From: Johan Hovold <johan@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	david@ixit.cz
Subject: Re: [PATCH 1/1 v7] usb: serial: add support for CH348
Message-ID: <Zp_WiocH4D14mEA7@hovoldconsulting.com>
References: <20240507131522.3546113-1-clabbe@baylibre.com>
 <20240507131522.3546113-2-clabbe@baylibre.com>
 <Zp5q5V_OnLAdvBrU@hovoldconsulting.com>
 <CAFBinCC9ftXxkyoiY=3ia6UubTeG-cHXa40ddd7WMNUhvVjr+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCC9ftXxkyoiY=3ia6UubTeG-cHXa40ddd7WMNUhvVjr+g@mail.gmail.com>

On Mon, Jul 22, 2024 at 11:22:32PM +0200, Martin Blumenstingl wrote:

> On Mon, Jul 22, 2024 at 4:21 PM Johan Hovold <johan@kernel.org> wrote:
> > On Tue, May 07, 2024 at 01:15:22PM +0000, Corentin Labbe wrote:

> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * USB serial driver for USB to Octal UARTs chip ch348.
> > > + *
> > > + * Copyright (C) 2022 Corentin Labbe <clabbe@baylibre.com>
> >
> > Do you need to include any copyrights from the vendor driver? It looks
> > like at least some of the code below was copied from somewhere (but
> > perhaps not that much).

> If you - or someone else - have any advice on this I'd be happy to go with that!

If you copy code directly (even if you clean it up after) you should
include it, but not necessarily if you just use it for reference for the
protocol.

It doesn't hurt mentioning anyway when you add the reference to the
vendor driver, for example:

	Based on the XXX driver:

		https://...

	Copyright YYY

> > > +     u8 reg_iir;
> > > +     union {
> > > +             u8 lsr_signal;
> > > +             u8 modem_signal;
> > > +             u8 init_data[10];
> >
> > This init_data field is never used and looks a bit odd. What is it used
> > for?
> I think the firmware is sending back the configuration that was
> applied (see ch348_set_termios())
> 
> > You mentioned that that the modem lines are not yet used either.

> My understanding is: we neither use init_data nor modem_signal in the
> driver so let's drop them for now (and add them back when they're
> actually needed).

I think it's ok to keep, as reference. You do dump this data later even
if you don't currently use this union I noticed.

> > > +static int ch348_write(struct tty_struct *tty, struct usb_serial_port *port,
> > > +                    const unsigned char *buf, int count)
> > > +{
> > > +     struct ch348 *ch348 = usb_get_serial_data(port->serial);
> > > +     struct ch348_port *ch348_port = &ch348->ports[port->port_number];
> > > +     int ret, max_tx_size;
> > > +
> > > +     if (tty_get_baud_rate(tty) < 9600 && count >= 128)
> >
> > You don't hold the termios lock here so this needs to be handled
> > differently. Perhaps you can set a flag in set_termios if this is
> > really needed.
> >
> > > +             /*
> > > +              * Writing larger buffers can take longer than the hardware
> > > +              * allows before discarding the write buffer. Limit the
> > > +              * transfer size in such cases.
> > > +              * These values have been found by empirical testing.
> > > +              */
> > > +             max_tx_size = 128;
> >
> > Can you elaborate on you findings here? According to the vendor homepage
> > this device has a 1024 byte TX fifo per port. Are you really saying that
> > for some reason you can only fill it with 128 b when the line speed is
> > below 9600?

> For slow speeds I never receive the "Transmitter holding register
> empty" interrupt/signal when using the full TX buffer.
> It's not that the interrupt/signal is late - it just never arrives.
> I don't know why that is (whether the firmware tries to keep things
> "fair" for other ports, ...) though.

Perhaps you can run some isolated experiments if you haven't already.
Submitting just a single URB with say 128, 512 or 1024 bytes of data and
see when/if you ever receive a transmitter holding empty interrupt.

How does the vendor driver handle this? Does it really wait for the THRE
interrupt before submitting more data?

You could try increasing the buffer size to 2k and see how much is
received on the other end if you submit one URB (e.g. does the hardware
just drop the last 1k of data when the device fifo is full).
 
> > > +     else
> > > +             /*
> > > +             * Only ingest as many bytes as we can transfer with one URB at
> > > +             * a time. Once an URB has been written we need to wait for the
> > > +             * R_II_B2 status event before we are allowed to send more data.
> >
> > As I mentioned above R_II_B2 appears to be the transfer holding register
> > empty flag in IIR. So you write one endpoint size worth of data and then
> > wait for all of it to be processed on the device before sending more.
> >
> > How big is the endpoint (please post lsusb -v)?

>        wMaxPacketSize     0x0200  1x 512 bytes

> > > +             * If we ingest more data then usb_serial_generic_write() will
> > > +             * internally try to process as much data as possible with any
> > > +             * number of URBs without giving us the chance to wait in
> > > +             * between transfers.
> >
> > If the hardware really works this way, then perhaps you should not use
> > the generic write implementation. Just maintain a single urb per port
> > and don't submit it until the device fifo is empty.

> I tried to avoid having to copy & paste (which then also means having
> to maintain it down the line) most of the generic write
> implementation.
> This whole dance with waiting for the "Transmitter holding register
> empty" by the way was the reason why parts of the transmit buffer got
> lost, see the report from Nicolas in v6 [1]

I understand, but the generic implementation is not a good fit here as
it actively tries to make sure the device buffers are always full (e.g.
by using two URBs back-to-back).

If you can't find a way to make the hardware behave properly then a
custom implementation using a single URBs is preferable over trying
to limit the generic implementation like you did here. Perhaps bits can
be reused anyway (e.g. chars_in_buffer if you use the write fifo).

> > > +static struct usb_serial_driver ch348_device = {
> > > +     .driver = {
> > > +             .owner = THIS_MODULE,
> > > +             .name = "ch348",
> > > +     },
> > > +     .id_table =             ch348_ids,
> > > +     .num_ports =            CH348_MAXPORT,
> > > +     .num_bulk_in =          1,
> > > +     .num_bulk_out =         1,
> >
> > Set both of these to 2 so that core verifies that you have all four
> > endpoints.

> I will have to test this because I thought that:
> - using 2 here makes usb-serial allocate an URB as well and by default
> assign it to the first and second port
> - usb-serial should not touch the second bulk in / bulk out endpoint
> (as they're entirely vendor / chip specific)

Setting these two should make core make sure that the endpoints exist,
and by default they will be assigned to the first and second port, but
you can override that calc_num_endpoints() (as you already do).

For the second IN EP, you could even let core allocate the URB and use
that instead of doing so manually (e.g. by submitting yourself or using
the generic read implementation as mxuport does).

Johan

