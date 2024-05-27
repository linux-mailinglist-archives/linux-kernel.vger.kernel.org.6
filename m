Return-Path: <linux-kernel+bounces-190643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDBD8D00DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722281F21E68
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392F615EFCE;
	Mon, 27 May 2024 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BYiyBB3X"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3615EFBE;
	Mon, 27 May 2024 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814678; cv=none; b=BI/hVZK3BqCb0wnPygEbAUODEBrj//6yIxCoqv4bWyR/Ht2fwHQaKgJzEe1fbf0T6AGdgjLfymX81oNHJs7MWFAVVN7RCAuCJqFV/wiorfG1j79+p7MPpuGplnNdpPg2QdnyJTE/aXB33gTK4QP9/zfXNZzMqHPRlBakpjqv/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814678; c=relaxed/simple;
	bh=8GCzunIMdlubOTXf0pyUHn8KPY2JZDD1cESnN8SAnis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxpEq9+pD+Vvv8J0BsDaSuUjY8F4cRa1A1fQX1AJdWDy/50DjjD8E0BFRA3g6KysSw/W1pNnLY85dBsB35NkTN9RQup986H8SqvQ7ESdatDq+ptozqEyx5jerM3t+2n+gcdUaV5CoFtZ9BQn+G3Kw45ZUNjNPJQXwGlQmZskniI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BYiyBB3X; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rMFfpqCc+bc4O8mDHjvAEFD1eHUpLSCJjFslGtJ4svo=; b=BYiyBB3X8G1QiZKbh5RNNixyhN
	/txB0NYAWfPSURQCARY+CvzFQfrT9NuzVsc6O7U0HqVcm7UzH5eeQa7BX0hQknfK1GBb//KsRn9Fl
	I9q7M2N2KzZq/dv9EwvUhztgslecsFMmh69szcGzBA6ttSYVdu/OUF+hj/uHYrH5cvWhwKs7TYLke
	3ztvLiZZVLuW8GeZfFpX7xYGM0faF2NtfNL/6U4Pr3Ncib88OQC7uA86dF8Om4ZBHGvhFcUxtqMRL
	lWMyKoi5fgnxHG4p2Mf6qtHUsw1ksvbHxm1CrbiFAxIpsnEMzU0AmZCPEU/SVtk7kAiK70l0PPZkb
	w66XC4Bw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37854)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBZuz-0003Wh-1b;
	Mon, 27 May 2024 13:57:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBZv0-0002Kk-8F; Mon, 27 May 2024 13:57:38 +0100
Date: Mon, 27 May 2024 13:57:38 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: Ron Economos <re@w6rz.net>, Guenter Roeck <linux@roeck-us.net>,
	regressions@lists.linux.dev, linux-clk@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
Message-ID: <ZlSDQssA9I4LRjwM@shell.armlinux.org.uk>
References: <28114882-f8d7-21bf-4536-a186e8d7a22a@w6rz.net>
 <d7f0c16a-0d83-4060-8d95-95b293d95dfd@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f0c16a-0d83-4060-8d95-95b293d95dfd@leemhuis.info>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 27, 2024 at 01:16:06PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 27.05.24 12:45, Ron Economos wrote:
> > On Fri, May 17, 2024 at 03:09:14PM -0700, Guenter Roeck wrote:
> >>
> >> On Fri, Mar 15, 2024 at 11:47:55AM +0000, Russell King (Oracle) wrote:
> >> > Report an error when an attempt to register a clkdev entry results in a
> >> > truncated string so the problem can be easily spotted.
> >> >
> >> > Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
> >> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> >> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> >>
> >> With this patch in the mainline kernel, I get
> >> [...]
> >> when trying to boot sifive_u in qemu.
> >>
> >> Apparently, "10000000.clock-controller" is too long. Any suggestion on
> >> how to solve the problem ? I guess using dev_name(dev) as dev_id
> > parameter
> >> for clk_hw_register_clkdev() is not or no longer a good idea.
> >> What else should be used instead ?
> > 
> > This issue causes a complete boot failure on real hardware (SiFive
> > Unmatched).
> 
> Hmmm. That and because nobody afaics has time/motivation to fix this
> anytime soon (or am I mistaken there?) makes me wonder if we should
> revert this change for now (and remerge it later once the problem this
> change exposed was fixed). Or is another solution in sight somewhere?

I'm sorry, but clearly I should tell my employer that I can't do work
for them because there's been a mainline kernel regression, and of
course I should be working on this bank holiday Monday...

No, please wait a bit longer.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

