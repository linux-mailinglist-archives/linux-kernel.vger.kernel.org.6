Return-Path: <linux-kernel+bounces-178660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41638C560D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCD3281D03
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CAC5CDF0;
	Tue, 14 May 2024 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qTpZKrBA"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335E433CE
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689965; cv=none; b=V5YzelkuSCTdelbHlj5CJpgHcnpuMsjynp4pkgodcHLoK1hhILsk6wOHYNLTD0e/6EZkoBmvYysxcANU94bm3qvePd0KM/5oo5s90sw0o9008PiONW2RGhmJRHYdao70HVh6rnLGgQsUOSpLMGOIgqOrHq6RYK4lzuUEwrEm69E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689965; c=relaxed/simple;
	bh=I9pm5ltuRP7CtyZZABgcYsllXH5JG+kEGVHyLkkT8pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8/1Dv5a50QdG4gKnVN6vXzPgipeUD1O472zlujcYLAiDyg8SF/kW/MqppGNcJ6/HmzhGFRqGNztMfLh0hHJSzVDBavrDIPwwv9Z4zk0EDJc4EeAfcYuKs2Gxv74NPHQZtGJgXTShnNnYC9UfzRLk3YZGJd7NJihUTikJW6Slis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qTpZKrBA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=h+Th6xmT1MpeIKC5d/s5VDGWqlNBXzjBRZNOOPTDpeU=; b=qT
	pZKrBAljR+2Owa6RKVtxjKAzMYjwXytVqkeIpY5BkVuJUEl59DrqAKLOmbEo6oXlDDkHo9syWsygS
	6l9ksWDUvF10kPaiXjKi+p96bJnJIaV/HACVPSUgi1CBMWyz5olSWpgC/8dutZi1QL7XrUPpaBs3h
	mPVd9BbSLRFnS4g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6rKi-00FO2N-E8; Tue, 14 May 2024 14:32:40 +0200
Date: Tue, 14 May 2024 14:32:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stephen Langstaff <stephenlangstaff1@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org,
	OlteanV@gmail.com
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
Message-ID: <c8c01e53-0a45-4319-88ff-bfb0caba150c@lunn.ch>
References: <7efffaa0-6330-4b01-b3d2-63eb063cbbb0@gmail.com>
 <CAHx5RXD8qFmbEytrPcd40Pj0VRo7uOvZjucrMj6Xxqw73YyS1Q@mail.gmail.com>
 <212a9464-d52b-4730-95b9-5a0aebd38c91@gmail.com>
 <CAHx5RXCWW5M-eW5v65bAkQWZemsU2NTvDv3jA9_XKz=+YP56Qg@mail.gmail.com>
 <688e54ec-3b29-4e3b-a2c3-f2c83b9c97b7@lunn.ch>
 <CAHx5RXBFdzsgKXR94gdZd2b=uz8PJDg4OjLPJxKtsdhcjJq3Qw@mail.gmail.com>
 <e307a237-68e3-40c9-be31-4fe3d560ada2@lunn.ch>
 <CAHx5RXCF0=Soz_k88RGvJFGrajaxn=mVnqpb99GAQ=b7XOcWiw@mail.gmail.com>
 <732d8bb2-1d4f-4958-b130-0bd15a407271@gmail.com>
 <CAHx5RXDaweFTF_Qt0GdBH4nBeMqwL4VVto7xzHBvFgFL5n=Ebg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHx5RXDaweFTF_Qt0GdBH4nBeMqwL4VVto7xzHBvFgFL5n=Ebg@mail.gmail.com>

On Tue, May 14, 2024 at 10:28:55AM +0100, Stephen Langstaff wrote:
> On Mon, May 13, 2024 at 8:05 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > Attached is a configuration that I use on a x86-64 VM for testing that
> > is started with:
> 
> That's kind of what I expect to be happening on my target, but it's not.
> 
> I notice that your configuration does not define CONFIG_FIXED_PHY as
> either a module or built-in - could that explain both the fact that my
> dsa_loop_bdinfo.c does not get compiled when using the default
> Makefiles, and that if I force compilation to a module it does not
> appear to create the expected lanX@eth0 interfaces?
> 
> I have added some printk debug lines to the dsa_loop_init and
> dsa_loop_drv_probe functions, and only see the one from the init
> function, which makes me suspect that something is stopping the probe
> from happening - I assume this should happen when the dsa_loop_bdinfo
> module is inserted?
> 
> root@machine:~/dsa_test# ls
> dsa_loop.ko  dsa_loop_bdinfo.ko
> 
> root@machine:~/dsa_test# modprobe dsa_core
> root@machine:~/dsa_test#
> 
> root@machine:~/dsa_test# insmod dsa_loop_bdinfo.ko
> [   51.742367] dsa_loop_bdinfo_init
> 
> root@machine:~/dsa_test# insmod dsa_loop.ko
> [   58.485104] dsa_loop_init

This is probably an ordering problem.

dsa_loop_bdinfo calls mdiobus_register_board_info() with the bus_id
"fixed-0". That call adds it to a linked list, but does nothing else.

mdiobus_setup_mdiodev_from_board_info() is what walks the linked list
and sees if an MDIO bus matches the ID, and if so, calls the callback
to add a device to the bus. mdiobus_setup_mdiodev_from_board_info() is
only called from __mdiobus_register(). So the boardinfo needs to be
registered before the bus is registers. The other way around does not
work.

So try to making FIXED_PHY = m, and load it after dsa_loop_bdinfo.ko.

   Andrew

