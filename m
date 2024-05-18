Return-Path: <linux-kernel+bounces-182787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B4B8C8FDE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 09:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A831C2115F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 07:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEFDC152;
	Sat, 18 May 2024 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GvwBS/lG"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A452F4A;
	Sat, 18 May 2024 07:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716015703; cv=none; b=QKNdrd9yytREM7TELGBF9MGC6QSMQDnuKZv/7jnJY53/yNRUsCUsaqYWiWw9TnbqIfn4pxd7AvmGLjiE2LBxZXes5fWVer1GhWvI4lFcbsuVjM5L7Yq7HLvXRXDOa3mAKVfvFXyvGY4ZGyU0/5iG2W2e3EKNdScfogR5sKdQ1Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716015703; c=relaxed/simple;
	bh=7gJcAObcPbQw9XW+LduiP1Y3FVVW2Ym0ZJq4JI+/q94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmdkMdeFRdldLAQlEzT1MRjcQhQzw3O5o2jCqxSPzICC+Y9W1JFpJqp+t7vZ9WMM9iU4koWks40DVnm0KrgivTJN3Ur33edBJcNcSz/n3Nle4lg+6MunQkAEaTm3H9W7MZhnk/r+G9sbC7SVaM4BnFpmm/eWhQ1xGPoU9PA/2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GvwBS/lG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r277yi+Nyo+3nifP8z4BGCRO8hmMLsoW+s546ZKtUG0=; b=GvwBS/lGRWXZq4bL7YXwfpOBIR
	E0RJEWCEOPhfghLmzPhcIItXA8XtN9/0t1NpfWOKBKqp6j/9fgFMlAr0F7yIquJ2pLQhAEAVjIug5
	wtGsQtV5w6GCrv7tSRha7MnNRFCDXxN+Q2coKSOIrVLEfeU17RPmTiXxOpfqerDdBBtENgw1hCrIi
	BLwQawXSug27i/O+UwvZ7r82hzcNR8aj1pq91FiYflk2BQxXCVdC5qGOI477KbSmgZYLbSkvAAgLG
	TZVoEDe4VkaTUwFB/L09s/Mm1LNHMLEHJsoJvtn7/h7Fd0kyh3D7VMJMPIxWRBAomEzoshnDGNDpe
	zy96AYqw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57026)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s8E4F-0008BX-2v;
	Sat, 18 May 2024 08:01:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s8E4B-0002JK-0a; Sat, 18 May 2024 08:01:15 +0100
Date: Sat, 18 May 2024 08:01:14 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org,
	Duanqiang Wen <duanqiangwen@net-swift.com>, mturquette@baylibre.com,
	sboyd@kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
 entries
Message-ID: <ZkhSOvkaAwsTe7Dm@shell.armlinux.org.uk>
References: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>
 <7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net>
 <ZkfYqj+OcAxd9O2t@shell.armlinux.org.uk>
 <4ea9cc83-c7ca-47b8-8d43-dab16193108f@roeck-us.net>
 <ZkfqKMqkUc/Sr7U2@shell.armlinux.org.uk>
 <646bd149-f29a-4c91-ab00-4f6d2fce23fd@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <646bd149-f29a-4c91-ab00-4f6d2fce23fd@roeck-us.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 17, 2024 at 08:24:19PM -0700, Guenter Roeck wrote:
> On 5/17/24 16:37, Russell King (Oracle) wrote:
> > On Fri, May 17, 2024 at 04:34:06PM -0700, Guenter Roeck wrote:
> > > On 5/17/24 15:22, Russell King (Oracle) wrote:
> > > > On Fri, May 17, 2024 at 03:09:12PM -0700, Guenter Roeck wrote:
> > > > > Hi,
> > > > > 
> > > > > On Fri, Mar 15, 2024 at 11:47:55AM +0000, Russell King (Oracle) wrote:
> > > > > > Report an error when an attempt to register a clkdev entry results in a
> > > > > > truncated string so the problem can be easily spotted.
> > > > > > 
> > > > > > Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
> > > > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > > > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > > > > 
> > > > > With this patch in the mainline kernel, I get
> > > > > 
> > > > > 10000000.clock-controller:corepll: device ID is greater than 24
> > > > > sifive-clk-prci 10000000.clock-controller: Failed to register clkdev for corepll: -12
> > > > > sifive-clk-prci 10000000.clock-controller: could not register clocks: -12
> > > > > sifive-clk-prci 10000000.clock-controller: probe with driver sifive-clk-prci failed with error -12
> > > > > ...
> > > > > platform 10060000.gpio: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> > > > > platform 10010000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> > > > > platform 10011000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> > > > > platform 10040000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> > > > > platform 10050000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> > > > > platform 10090000.ethernet: deferred probe pending: platform: supplier 10000000.clock-controller not ready
> > > > > 
> > > > > when trying to boot sifive_u in qemu.
> > > > > 
> > > > > Apparently, "10000000.clock-controller" is too long. Any suggestion on
> > > > > how to solve the problem ? I guess using dev_name(dev) as dev_id parameter
> > > > > for clk_hw_register_clkdev() is not or no longer a good idea.
> > > > > What else should be used instead ?
> > > > 
> > > > It was *never* a good idea. clkdev uses a fixed buffer size of 20
> > > > characters including the NUL character, and "10000000.clock-controller"
> > > > would have been silently truncated to "10000000.clock-cont", and thus
> > > > 
> > > >                           if (!dev_id || strcmp(p->dev_id, dev_id))
> > > > 
> > > > would never have matched.
> > > > 
> > > > We need to think about (a) whether your use of clk_hw_register_clkdev()
> > > > is still appropriate, and (b) whether we need to increase the size of
> > > > the strings.
> > > > 
> > > 
> > > It isn't _my_ use, really. I only run a variety of boot tests with qemu.
> > > I expect we'll see reports from others trying to boot the mainline kernel
> > > on real sifive_u hardware or other hardware using the same driver or other
> > > drivers using dev_name() as dev_id parameter. Coccinelle finds the
> > > following callers:
> > 
> > Using dev_name() is not an issue. It's when dev_name() exceeds 19
> > characters that it becomes an issue (and always has been an issue
> > due to the truncation.) clk_get(dev, ...) uses dev_name(dev) to match
> > against its entry in the table.
> > 
> > As I say, dev_name() itself is not an issue. The length used for the
> > name is.
> > 
> 
> Maybe, but the existence of best_dev_name() suggests that this has been seen
> before and that, as you mentioned, it is not a good idea. Anyway, the patch
> below fixes the problem for me. I don't know if it is acceptable / correct,
> so it might serve as guidance for others when fixing the problem for real.

I get the impression that there's a communication problem here, so I'm
not going to continue replying. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

