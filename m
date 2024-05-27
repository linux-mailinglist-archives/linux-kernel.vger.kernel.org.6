Return-Path: <linux-kernel+bounces-190699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ECC8D017D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2F028BC76
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49615ECFD;
	Mon, 27 May 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cirjdWAI"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8613A3E4;
	Mon, 27 May 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816610; cv=none; b=cls5GPV9llZloz2Rlo2mKLSWzwuWDhN5CBi8I/9CJ/WVUXgHqnTX1jv2dapu9mPZby/G405pAb8IZ8Cg5Djl797lTCswC8WVi8JxITpwroUZjkpYpGKrZeUVwQpljB2T1mWt0nYei30O8M/3+CpXh/L9uG4YboqKdk53uYbl95E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816610; c=relaxed/simple;
	bh=YmojrlRDzHa9eeRvE+hFdRHXFKUIo3HD3FBR9dlhGEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh9Nrh4lBye+HWTeD8Cg2bZkaTr/R/YNUupjjC5sEt+k5Cv3LdrpvOgM/ygDZ6xB9F0rGOCDqUOQyi1iZMe2sIlE/tZa+T+Ec447KUgpocLX/8K9+3qn+FdVvDrtwcu/OyjIY5utyJAzZExO0ZgqbS0Kfbu5EdmRA4C3tuuZ6tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cirjdWAI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gaotFr9Z3qhj+JKsAg1inJzMtusA7qZ6jQmUAEHIia4=; b=cirjdWAIYaq+0jwGFEqDYqDnfy
	QAK1s0Vqmyf4wwn38WG/QltTYuX6Bse9wkkpj2GLCEhfD+QV7VYyE5KjJSJSKpxtSHv+uJlt6+EmR
	QK5UvYTClcMBaEmf/Js1VzcmKXIuUHP73aNRsOiQszbikKKLL92AJZCao8abKZl76o9qxj0oqNqL+
	tbySwWOQnbA66/XtuEuWxRH7atcz1nzKjwm5YUKMIw/6YVOtG9Yze9577aiOxRGyhKeU+FD8GRQp5
	PRaP6UvLFY81CKdtGTr7uNfhdUttJOea54yLzuO4pyVed0WXDNsjiWPP01dsfAQwtmMZE74wLWE11
	ysTlNN6Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33938)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBaQI-0003Zm-18;
	Mon, 27 May 2024 14:29:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBaQK-0002ME-KF; Mon, 27 May 2024 14:30:00 +0100
Date: Mon, 27 May 2024 14:30:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ron Economos <re@w6rz.net>
Cc: Guenter Roeck <linux@roeck-us.net>, regressions@lists.linux.dev,
	linux-clk@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
Message-ID: <ZlSK2CcbLaWFRpnR@shell.armlinux.org.uk>
References: <28114882-f8d7-21bf-4536-a186e8d7a22a@w6rz.net>
 <ZlSIH1/etwPQe+bQ@shell.armlinux.org.uk>
 <ZlSJkCtx6eYPCQwG@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZlSJkCtx6eYPCQwG@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 27, 2024 at 02:24:32PM +0100, Russell King (Oracle) wrote:
> On Mon, May 27, 2024 at 02:18:23PM +0100, Russell King (Oracle) wrote:
> > On Mon, May 27, 2024 at 03:45:15AM -0700, Ron Economos wrote:
> > > On Fri, May 17, 2024 at 03:09:14PM -0700, Guenter Roeck wrote:
> > > > Hi,
> > > >
> > > > On Fri, Mar 15, 2024 at 11:47:55AM +0000, Russell King (Oracle) wrote:
> > > > > Report an error when an attempt to register a clkdev entry results in a
> > > > > truncated string so the problem can be easily spotted.
> > > > >
> > > > > Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
> > > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > > >
> > > > With this patch in the mainline kernel, I get
> > > >
> > > > 10000000.clock-controller:corepll: device ID is greater than 24
> > > > sifive-clk-prci 10000000.clock-controller: Failed to register clkdev for
> > > corepll: -12
> > > > sifive-clk-prci 10000000.clock-controller: could not register clocks: -12
> > > > sifive-clk-prci 10000000.clock-controller: probe with driver
> > > sifive-clk-prci failed with error -12
> > > > ...
> > > > platform 10060000.gpio: deferred probe pending: platform: supplier
> > > 10000000.clock-controller not ready
> > > > platform 10010000.serial: deferred probe pending: platform: supplier
> > > 10000000.clock-controller not ready
> > > > platform 10011000.serial: deferred probe pending: platform: supplier
> > > 10000000.clock-controller not ready
> > > > platform 10040000.spi: deferred probe pending: platform: supplier
> > > 10000000.clock-controller not ready
> > > > platform 10050000.spi: deferred probe pending: platform: supplier
> > > 10000000.clock-controller not ready
> > > > platform 10090000.ethernet: deferred probe pending: platform: supplier
> > > 10000000.clock-controller not ready
> > > >
> > > > when trying to boot sifive_u in qemu.
> > > >
> > > > Apparently, "10000000.clock-controller" is too long. Any suggestion on
> > > > how to solve the problem ? I guess using dev_name(dev) as dev_id parameter
> > > > for clk_hw_register_clkdev() is not or no longer a good idea.
> > > > What else should be used instead ?
> > > 
> > > This issue causes a complete boot failure on real hardware (SiFive
> > > Unmatched). The boot only gets as far as "Starting kernel ..." with no other
> > > indication of what's going on.
> > > 
> > > Guenter's suggested patch solves the issue.
> > > 
> > > diff --git a/drivers/clk/sifive/sifive-prci.c
> > > b/drivers/clk/sifive/sifive-prci.c
> > > index 25b8e1a80ddc..20cc8f42d9eb 100644
> > > --- a/drivers/clk/sifive/sifive-prci.c
> > > +++ b/drivers/clk/sifive/sifive-prci.c
> > > @@ -537,7 +537,7 @@ static int __prci_register_clocks(struct device *dev,
> > > struct __prci_data *pd,
> > >                          return r;
> > >                  }
> > > 
> > > -               r = clk_hw_register_clkdev(&pic->hw, pic->name,
> > > dev_name(dev));
> > > +               r = clk_hw_register_clkdev(&pic->hw, pic->name, "prci");
> > 
> > How about just changing this to:
> > 
> > 		r = clk_hw_register(dev, &pic->hw);
> > 
> > ?
> > 
> > Since, if the device name is over-sized and thus truncated in the clk
> > lookup array that clkdev maintains, *nothing* will be able to match
> > the entry. Hence, I suspect all those clkdev registrations are
> > completely redundant for this driver (and do nothing other than
> > waste memory!)
> 
> Note that I mentioned *exactly* this point in my first reply to the
> report of the regression in:
> 
> https://lore.kernel.org/r/ZkfYqj+OcAxd9O2t@shell.armlinux.org.uk
> 
> "We need to think about (a) whether your use of clk_hw_register_clkdev()
> is still appropriate, and (b) whether we need to increase the size of
> the strings."

Note this will be my last reply on this today - it's Bank Holiday Monday
in the UK and I have the right to take this time off from working on the
kernel.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

