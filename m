Return-Path: <linux-kernel+bounces-180946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AD38C754B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A465284E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60A6145A02;
	Thu, 16 May 2024 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kH78TWg9"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2171459E2;
	Thu, 16 May 2024 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715859185; cv=none; b=rZtBQObEIrAOav40qN9t4Bkfr82s493RvawncDV1dNc4rWvfCyQPO0dpNT13ipZd7RbHRDbyOeNHy4u3AQN1lJAO50pc+99Z5H98VTNEAj6fkQe3FGaXQNUkk7yBMRgY6BgJwkjy8r5FNOEV9+sYY8h5FTMhfEMGx9M+1qEqmWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715859185; c=relaxed/simple;
	bh=vJ1dXf3D1QyoUryoyq2MHmEWi0/eC/n822cq45EZbpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSSwFru/DTpwcJYMviCSRgWDHD3MTXYncM1QtgWEIxZQhKdlUhJcg94L2uZaGqyne9P3y6Kr0DBnjnwVI36B+UUa+/PgqJfHzJ08icQGs+wx8telgUxHIK9Je5m60ZeJ5nvBkrSxtX1uMvWhCfP0AHSuHXwGEd4F9CVGNBbTgNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kH78TWg9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FtaIYOu5+dNz/ZMQJk5S85cXvl1SZa5DjNYpIAT6Axw=; b=kH78TWg9Y1Ej/jEYMWiGgnfT9u
	WyeiZ2z2GnV/cDp4x8JK9qV2JTnPaAagZhVm0UuMdRRNWlAIyL8Jr+TH4u+rpxc84MZNaKu0LVBXE
	s4iHSmQ0L6UwB2YzpmMaHiVqs1RkgEF+gi1V8h4hq74ZaU+NhlkIQjyr8WIUTs0+ug2FdhnpCd0Xo
	Ft1whsCDOYeIlDnXYUkPTYgFRBydZ/ed4eD/MSDUfKKO0TLkHfUjS6pRpDu6LwgCxZ9iJHj0KerwY
	0rMIZDkWi8iRwgU+qiHy+aBqEvK8qP90M1835ifzfO0m1RTGoy0nN3djybw+rWr08uheH8NILZ8FQ
	FEfsz3yg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55876)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s7ZLp-0004ls-0M;
	Thu, 16 May 2024 12:32:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s7ZLp-0000Zk-5j; Thu, 16 May 2024 12:32:45 +0100
Date: Thu, 16 May 2024 12:32:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org,
	open list <linux-kernel@vger.kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: clkdev: report over-sized strings when creating clkdev entries
Message-ID: <ZkXu3XNVLhTuRRNt@shell.armlinux.org.uk>
References: <CA+G9fYuZd_ur56H8fwDSvUywopvn_b7ogprGkjEatQ7EPTLwYQ@mail.gmail.com>
 <11be44d3-0f32-49c6-b4ae-ba97a9f97763@app.fastmail.com>
 <820ddc2ec70780ae1ecd3af864dc8bd6.sboyd@kernel.org>
 <ZkUgqzUn1EmjrPdl@shell.armlinux.org.uk>
 <CA+G9fYurPNaW=u2E+h+segnXhY3cfWo3BJpfYDJxKRFPY4epsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYurPNaW=u2E+h+segnXhY3cfWo3BJpfYDJxKRFPY4epsQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 16, 2024 at 12:27:20PM +0200, Naresh Kamboju wrote:
> On Wed, 15 May 2024 at 22:53, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, May 07, 2024 at 01:26:17PM -0700, Stephen Boyd wrote:
> > > Quoting Arnd Bergmann (2024-05-07 00:44:15)
> > > > On Tue, May 7, 2024, at 09:20, Naresh Kamboju wrote:
> > > > > The WinLink E850-96 board boot failed with Linux next-20240506 but there
> > > > > is no kernel crash log on the serial [1].
> > > > >
> > > > > Anders bisection results pointing to this commit,
> > > > > # first bad commit:
> > > > >   [4d11c62ca8d77cb1f79054844b598e0f4e92dabe]
> > > > >   clkdev: report over-sized strings when creating clkdev entrie
> > > > >
> > > > > After reverting the above patch the boot test passed [2].
> > > > >
> > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > >
> > >
> > > There are two fixes on the list: [1] and [2]. Perhaps one of those
> > > resolves this?
> > >
> > > [1] https://lore.kernel.org/r/20240507065317.3214186-1-m.szyprowski@samsung.com
> >
> > This one has (I think) ended up in the patch system last week, but it's
> > not clkdev, it's only related. I'm also not Cc'd on its posting, and
> > it's not posted to any mailing list that I'm a part of. So I've not
> > been following any discussion on it.
> >
> > Digging in to the discussion, I see various attributations, and a final
> > message reporting an unused variable, and a promise to send v2. So,
> > I'm guessing that
> > http://www.home.armlinux.org.uk/developer/patches/viewpatch.php?id=9397/1
> 
> I do not have access to this link ^.

Sorry, that's my internal link, the external one is:

http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9397/1

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

