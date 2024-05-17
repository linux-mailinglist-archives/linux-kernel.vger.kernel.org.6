Return-Path: <linux-kernel+bounces-182697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2861E8C8E90
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81AA281C40
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BA11411EA;
	Fri, 17 May 2024 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k5JZn+N9"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16DA21373;
	Fri, 17 May 2024 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715989053; cv=none; b=D2ToQ6t9vhEVjSG/RxzYEGPaa3BdPyRy3BNXiwCRsqiQVDgOOLv/McWe8Glxx4xDB+Z4HmFmvc0GufQMhyNmS+SQZLWgjj4xbR0V3BKSTywt3KmNvrJTWOcb0G4jnXz5OkR+xO/WAplwR6dgAfLQZtM8rYsRIJkQUNVEfdhgiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715989053; c=relaxed/simple;
	bh=9f9zI+W/kOF9PQZyMuQ7fwuoXF6DvwzLPEBJGtN6o78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V936Sxlg4Mq7nGgBBVDq45VwqFplLKtLJCpwzOBz2eH5Q6FXpA5lfysNPHafgBARdsUR++KbsJ2emsAiDF9SKWE7IaG4W4mc/kp1H6qu0MouxkEYbpT5bsiow5l63/oLO1uaWEslPhp0R1LUj4BoS7VTVcYCU3grobCXO5133R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=k5JZn+N9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5hkFzFH0WqUDtk5tfXiCLXCsPkv9Y87d71GcppOkIUw=; b=k5JZn+N986SzxpVXNYZ2p7sV7Q
	KBwEmkOAIS4f0ylyAq+HRz5JJLnH61ww4Mx8yEMJw+a/psuslX5V+5QineAEqXfqDOEZEcS2ycBtP
	D6XSxjH+n5/Aznak+65Ev8XjTvxYoeHsHkdehxV1mabRi77NHlm5VMJVkYYpFT99sMNw66J+mPSQ1
	hMyN/CS3i4bFQabZzMhXKMMKWuapyFdSt5ROvjJky6olJiRzX89oYpMzrkUIfCIYuoV/9D9XYV91b
	PX5b5EjXOyXrr9SqrFziBGwtpnZOb1r1yMGKwTihda/k4BHPQAPZGVAQ+zNXAqbVSDymcxRVrTvFY
	ATsADIGw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51660)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s878T-0007B7-0z;
	Sat, 18 May 2024 00:37:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s878S-0001x4-9e; Sat, 18 May 2024 00:37:12 +0100
Date: Sat, 18 May 2024 00:37:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org,
	Duanqiang Wen <duanqiangwen@net-swift.com>, mturquette@baylibre.com,
	sboyd@kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
 entries
Message-ID: <ZkfqKMqkUc/Sr7U2@shell.armlinux.org.uk>
References: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>
 <7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net>
 <ZkfYqj+OcAxd9O2t@shell.armlinux.org.uk>
 <4ea9cc83-c7ca-47b8-8d43-dab16193108f@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea9cc83-c7ca-47b8-8d43-dab16193108f@roeck-us.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 17, 2024 at 04:34:06PM -0700, Guenter Roeck wrote:
> On 5/17/24 15:22, Russell King (Oracle) wrote:
> > On Fri, May 17, 2024 at 03:09:12PM -0700, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > On Fri, Mar 15, 2024 at 11:47:55AM +0000, Russell King (Oracle) wrote:
> > > > Report an error when an attempt to register a clkdev entry results in a
> > > > truncated string so the problem can be easily spotted.
> > > > 
> > > > Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > > 
> > > With this patch in the mainline kernel, I get
> > > 
> > > 10000000.clock-controller:corepll: device ID is greater than 24
> > > sifive-clk-prci 10000000.clock-controller: Failed to register clkdev for corepll: -12
> > > sifive-clk-prci 10000000.clock-controller: could not register clocks: -12
> > > sifive-clk-prci 10000000.clock-controller: probe with driver sifive-clk-prci failed with error -12
> > > ...
> > > platform 10060000.gpio: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> > > platform 10010000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> > > platform 10011000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> > > platform 10040000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> > > platform 10050000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> > > platform 10090000.ethernet: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> > > 
> > > when trying to boot sifive_u in qemu.
> > > 
> > > Apparently, "10000000.clock-controller" is too long. Any suggestion on
> > > how to solve the problem ? I guess using dev_name(dev) as dev_id parameter
> > > for clk_hw_register_clkdev() is not or no longer a good idea.
> > > What else should be used instead ?
> > 
> > It was *never* a good idea. clkdev uses a fixed buffer size of 20
> > characters including the NUL character, and "10000000.clock-controller"
> > would have been silently truncated to "10000000.clock-cont", and thus
> > 
> >                          if (!dev_id || strcmp(p->dev_id, dev_id))
> > 
> > would never have matched.
> > 
> > We need to think about (a) whether your use of clk_hw_register_clkdev()
> > is still appropriate, and (b) whether we need to increase the size of
> > the strings.
> > 
> 
> It isn't _my_ use, really. I only run a variety of boot tests with qemu.
> I expect we'll see reports from others trying to boot the mainline kernel
> on real sifive_u hardware or other hardware using the same driver or other
> drivers using dev_name() as dev_id parameter. Coccinelle finds the
> following callers:

Using dev_name() is not an issue. It's when dev_name() exceeds 19
characters that it becomes an issue (and always has been an issue
due to the truncation.) clk_get(dev, ...) uses dev_name(dev) to match
against its entry in the table.

As I say, dev_name() itself is not an issue. The length used for the
name is.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

