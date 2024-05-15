Return-Path: <linux-kernel+bounces-180358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D29E8C6D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FF41C212D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C1315B103;
	Wed, 15 May 2024 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mTAEJcnM"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA823BBEA;
	Wed, 15 May 2024 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715806403; cv=none; b=CLasLtahNo248DtJH7RsmLovSRvlqs3nnzBChGVZ5HgXKcIgLeadXOZ0HI4VIVGW0qhq4DkdwRZfm0FbzrlXj6SZ7l1QMWvV4ne/HjHo9sA+7WwpXJ8xlqmtnEM5Jl1XXRxzkGyD2lp5xoUZrDwM0r9b+RjYqd9x7q81LzQJG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715806403; c=relaxed/simple;
	bh=ArIJY0PdIwAd9N/wyTYbH/joRM5U0dn324MX2gXCrUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKX04Y4fgk/FyMwsgY6UHzXqHdNILKURcEjVh3XkN8ZeoQ6c+IO3968vEhN08XPhp3PNd4Ju48hFezvXmy0xXJStIAdifgQizvOASVLaeG/M7FMHiEP6qW3A/GafPszZeSi8EtoKhkfgCvKsFrC5nSrebGK6zc/aM1eTMX38mqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mTAEJcnM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RPi2wfoYgwnQfBqdIZisDR6we3jvqpfRYI0t5RGZguk=; b=mTAEJcnMqlDcereJqOzZIsfxqa
	pC1duS4eckALfT0mZxJbOy2QBEEhnWlX9obPjLNNmg/9Ztnj2RLJlENn18MNwF2vBmjT+kNLH1PJy
	fFMu6GHpWw36d5+utnwWU3wAHBnFmaAUTsXeQMZaTa3GHQczc7DTLV+49vw4wefBrWEBfRsP+rZW0
	Euc5nz7EngBB5hL8MWBrRoODUvbguH6wZ4+WFbgHN2KJbhJ3vsAdrvnNjOBAl4/AYvU+sfgufl8Y5
	+F337Ld4FoDKsYNwZOkO96EG/KBOd4GclaTEUdzzDNecLtC2bJlFImYGSLUY2JnBPOd7kSFqLSMHS
	ZZDWLkzA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52226)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s7LcT-0004Dy-2P;
	Wed, 15 May 2024 21:53:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s7LcR-0008HN-RL; Wed, 15 May 2024 21:52:59 +0100
Date: Wed, 15 May 2024 21:52:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org,
	open list <linux-kernel@vger.kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: clkdev: report over-sized strings when creating clkdev entries
Message-ID: <ZkUgqzUn1EmjrPdl@shell.armlinux.org.uk>
References: <CA+G9fYuZd_ur56H8fwDSvUywopvn_b7ogprGkjEatQ7EPTLwYQ@mail.gmail.com>
 <11be44d3-0f32-49c6-b4ae-ba97a9f97763@app.fastmail.com>
 <820ddc2ec70780ae1ecd3af864dc8bd6.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820ddc2ec70780ae1ecd3af864dc8bd6.sboyd@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 07, 2024 at 01:26:17PM -0700, Stephen Boyd wrote:
> Quoting Arnd Bergmann (2024-05-07 00:44:15)
> > On Tue, May 7, 2024, at 09:20, Naresh Kamboju wrote:
> > > The WinLink E850-96 board boot failed with Linux next-20240506 but there
> > > is no kernel crash log on the serial [1].
> > >
> > > Anders bisection results pointing to this commit,
> > > # first bad commit:
> > >   [4d11c62ca8d77cb1f79054844b598e0f4e92dabe]
> > >   clkdev: report over-sized strings when creating clkdev entrie
> > >
> > > After reverting the above patch the boot test passed [2].
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> 
> There are two fixes on the list: [1] and [2]. Perhaps one of those
> resolves this?
> 
> [1] https://lore.kernel.org/r/20240507065317.3214186-1-m.szyprowski@samsung.com

This one has (I think) ended up in the patch system last week, but it's
not clkdev, it's only related. I'm also not Cc'd on its posting, and
it's not posted to any mailing list that I'm a part of. So I've not
been following any discussion on it.

Digging in to the discussion, I see various attributations, and a final
message reporting an unused variable, and a promise to send v2. So,
I'm guessing that
http://www.home.armlinux.org.uk/developer/patches/viewpatch.php?id=9397/1
is now superseded in some way... I wouldn't have known without locating
this email and checking the links.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

