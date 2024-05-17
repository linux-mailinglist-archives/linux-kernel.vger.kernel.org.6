Return-Path: <linux-kernel+bounces-182669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DB58C8E46
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E3F1C215A5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252031411F3;
	Fri, 17 May 2024 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nWTQ/HES"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8331A1A269;
	Fri, 17 May 2024 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715984592; cv=none; b=YGvmQSPJHE8GjpvkUkgWodB7R42e8URrPSLyObI3Kaf85wIyxpl2/6a9CceGzV5+IplMj+q4eScpgYcSAuRfWUJMtw+hHGwbMgeb+wlEt+xxFDNH2rkag07gOx90Ke9VnsCfBIvUB8icm2YAAT9kkcENmjyykLWL1q5llRelN4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715984592; c=relaxed/simple;
	bh=peOMcckPOuThrXKKoxXPtouBQ4FBuCyOXGedDzp0MeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZMi1D/fjDJwXqBqxFSyUJ2H4755olrhy7DgI/xJNq1iUYNXBQN8cL9UjUTaH+fs1EIOt2TYx2rFi9TDhzhOsyfCR9A+b9BSHx+5FXMotRgi0nIt8eSdMihrDs4gqgXLE/V5yDXDaFeiLrQQR6W6waJVb+tQvpIHEagk6Zje/qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nWTQ/HES; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tTBGrkJ1ioYRSBA0o2UNnAh4eAeMiGN5vWW0cAPnXaE=; b=nWTQ/HESmyK28sfHDl55URQNjI
	av4rF4wI1uudX6/xNWG5M8NYzHQFNlyielMtVKsWWOJvd5EBaoGT+oPkoPprbO4v1FfM/ZyNM+4I+
	n01PprvjZN6Jn95y0cWz7v/RJeVJd22kHJhwMev5SFUoOrK/LyXBvqUFy7TRLicXQUD2LBJfTU6Du
	1nJF1nea62bLgJV/sWLcPkc0Dd/3G++VrU4J3nlzEUdCAODddaJBtRjWdGGK61UQ/jHxjKbllHoNj
	aQSLrVOh4v4H5vBIMepaKt+0Mf1Qi2npNXK19du1HRqOHQcxYpirAVFVLSr+a42h9E2PSz0ForgY2
	CJpeKhRA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45664)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s85yI-00071b-1u;
	Fri, 17 May 2024 23:22:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s85yE-0001tQ-IB; Fri, 17 May 2024 23:22:34 +0100
Date: Fri, 17 May 2024 23:22:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org,
	Duanqiang Wen <duanqiangwen@net-swift.com>, mturquette@baylibre.com,
	sboyd@kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
 entries
Message-ID: <ZkfYqj+OcAxd9O2t@shell.armlinux.org.uk>
References: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>
 <7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 17, 2024 at 03:09:12PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Fri, Mar 15, 2024 at 11:47:55AM +0000, Russell King (Oracle) wrote:
> > Report an error when an attempt to register a clkdev entry results in a
> > truncated string so the problem can be easily spotted.
> > 
> > Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> 
> With this patch in the mainline kernel, I get
> 
> 10000000.clock-controller:corepll: device ID is greater than 24
> sifive-clk-prci 10000000.clock-controller: Failed to register clkdev for corepll: -12
> sifive-clk-prci 10000000.clock-controller: could not register clocks: -12
> sifive-clk-prci 10000000.clock-controller: probe with driver sifive-clk-prci failed with error -12
> ...
> platform 10060000.gpio: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> platform 10010000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> platform 10011000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> platform 10040000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> platform 10050000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> platform 10090000.ethernet: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> 
> when trying to boot sifive_u in qemu.
> 
> Apparently, "10000000.clock-controller" is too long. Any suggestion on
> how to solve the problem ? I guess using dev_name(dev) as dev_id parameter
> for clk_hw_register_clkdev() is not or no longer a good idea.
> What else should be used instead ?

It was *never* a good idea. clkdev uses a fixed buffer size of 20
characters including the NUL character, and "10000000.clock-controller"
would have been silently truncated to "10000000.clock-cont", and thus

                        if (!dev_id || strcmp(p->dev_id, dev_id))

would never have matched.

We need to think about (a) whether your use of clk_hw_register_clkdev()
is still appropriate, and (b) whether we need to increase the size of
the strings.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

