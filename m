Return-Path: <linux-kernel+bounces-190668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4408D8D0125
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751841C216C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918B615ECD1;
	Mon, 27 May 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IyYzKcd3"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96464EB55;
	Mon, 27 May 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815913; cv=none; b=JaU7x+I+YbdMe3jAPpaEBo56TKdO8EZGG1TIxxTF50G0UBYUYA28D0DnRfgkZjy6hEOb5kfm4L5M/N9RWLzuWm7QYnm6k8msP6BwTyX0F1FdlXBvyLuyhK+/656jJN/vresN2K9M466RZGGSMMFQLspZYWBAtf4OF0Tvl7sg5qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815913; c=relaxed/simple;
	bh=vUZt2pGjbC5IUomB5cGvwvlW828f5yDbSKPZoklG+Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+cEDhHm1Y99mnI2QR7syQDwltmJz3Y9wboNP3lBRROJjoER1pK8MwE9CjSLIB73iuSnhHOdM1RZRSabA17btin2Y5sgO7eW976qfr/lDQGvupoovq/s0+85zVwbKzxuLJqyz4V43N7w9QP2y+iDkPxdM/Rx+8kGc6OupuVmqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IyYzKcd3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=noCvl7iZaiJJWOq4Lf6jhwKTiTVNLLZfuz+6oNNv/sQ=; b=IyYzKcd3Au6t2asqS8w2aUpEse
	Gy/GZIRqxajxzRCNdRTepzYEGV3Dze8Xu5fNJQQZ1rHL/71TKzyi7W8t/0ZstXfWqeHfQiC8xoi6o
	tGszKffg85qvnUh/d9jFVSQpWnvkqM/UopYeMGJeB6MNXIl1Tex17vzHzWGtTwVXTg2t9FN1D7c2v
	aFn1CSkCdQVOtrMH3Q0DWi3mBw5KNQiVR2sdnd+PCOwipiH2FMg/orMlhBy7XgOlzFc6lG3uPcP6a
	JtyWfL45AATySMI+v838EkOhJzBmzJm0zkpexVVhmPq5PJI1gEdyI8J+i/q/H+Vjejc2I5rPsODTt
	LYBGYI+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45962)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBaF3-0003Yz-1X;
	Mon, 27 May 2024 14:18:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBaF5-0002Lp-Hm; Mon, 27 May 2024 14:18:23 +0100
Date: Mon, 27 May 2024 14:18:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ron Economos <re@w6rz.net>
Cc: Guenter Roeck <linux@roeck-us.net>, regressions@lists.linux.dev,
	linux-clk@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
Message-ID: <ZlSIH1/etwPQe+bQ@shell.armlinux.org.uk>
References: <28114882-f8d7-21bf-4536-a186e8d7a22a@w6rz.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28114882-f8d7-21bf-4536-a186e8d7a22a@w6rz.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 27, 2024 at 03:45:15AM -0700, Ron Economos wrote:
> On Fri, May 17, 2024 at 03:09:14PM -0700, Guenter Roeck wrote:
> > Hi,
> >
> > On Fri, Mar 15, 2024 at 11:47:55AM +0000, Russell King (Oracle) wrote:
> > > Report an error when an attempt to register a clkdev entry results in a
> > > truncated string so the problem can be easily spotted.
> > >
> > > Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> >
> > With this patch in the mainline kernel, I get
> >
> > 10000000.clock-controller:corepll: device ID is greater than 24
> > sifive-clk-prci 10000000.clock-controller: Failed to register clkdev for
> corepll: -12
> > sifive-clk-prci 10000000.clock-controller: could not register clocks: -12
> > sifive-clk-prci 10000000.clock-controller: probe with driver
> sifive-clk-prci failed with error -12
> > ...
> > platform 10060000.gpio: deferred probe pending: platform: supplier
> 10000000.clock-controller not ready
> > platform 10010000.serial: deferred probe pending: platform: supplier
> 10000000.clock-controller not ready
> > platform 10011000.serial: deferred probe pending: platform: supplier
> 10000000.clock-controller not ready
> > platform 10040000.spi: deferred probe pending: platform: supplier
> 10000000.clock-controller not ready
> > platform 10050000.spi: deferred probe pending: platform: supplier
> 10000000.clock-controller not ready
> > platform 10090000.ethernet: deferred probe pending: platform: supplier
> 10000000.clock-controller not ready
> >
> > when trying to boot sifive_u in qemu.
> >
> > Apparently, "10000000.clock-controller" is too long. Any suggestion on
> > how to solve the problem ? I guess using dev_name(dev) as dev_id parameter
> > for clk_hw_register_clkdev() is not or no longer a good idea.
> > What else should be used instead ?
> 
> This issue causes a complete boot failure on real hardware (SiFive
> Unmatched). The boot only gets as far as "Starting kernel ..." with no other
> indication of what's going on.
> 
> Guenter's suggested patch solves the issue.
> 
> diff --git a/drivers/clk/sifive/sifive-prci.c
> b/drivers/clk/sifive/sifive-prci.c
> index 25b8e1a80ddc..20cc8f42d9eb 100644
> --- a/drivers/clk/sifive/sifive-prci.c
> +++ b/drivers/clk/sifive/sifive-prci.c
> @@ -537,7 +537,7 @@ static int __prci_register_clocks(struct device *dev,
> struct __prci_data *pd,
>                          return r;
>                  }
> 
> -               r = clk_hw_register_clkdev(&pic->hw, pic->name,
> dev_name(dev));
> +               r = clk_hw_register_clkdev(&pic->hw, pic->name, "prci");

How about just changing this to:

		r = clk_hw_register(dev, &pic->hw);

?

Since, if the device name is over-sized and thus truncated in the clk
lookup array that clkdev maintains, *nothing* will be able to match
the entry. Hence, I suspect all those clkdev registrations are
completely redundant for this driver (and do nothing other than
waste memory!)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

