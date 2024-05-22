Return-Path: <linux-kernel+bounces-185996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA82D8CBDEC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60443B21DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409BA811F8;
	Wed, 22 May 2024 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MYIjKcnn"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8750954720;
	Wed, 22 May 2024 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716370670; cv=none; b=Y3BIFws9rPOWmwb0jV3aAQCpCnU6j6kunh2QtfZ41MvELD/diOqpKcxoyDNby7atq4yp2gjVvEA2uRDmGc+QopQV/20JIezc0bKhfsd6XkJ2Fe5BA4qR2OcUktFTc9ZXuR6uXNrxCAuj8MWo7bGO+8JTNLgDOiPOVFv3Jeq3EvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716370670; c=relaxed/simple;
	bh=/NSNw0SGsW7avos3Y5ilgwDOFERvnsvy3H/2l8y6M3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhLIx+/Lpj9vsjnS8mFt+Uk9BMRIuaXq++Hts8+DQZNBeCVt4OeDeL+Va8Kb/3ICsGNn0FppEZhcC1qmVaVv0kPXUzbTTh9zCIxjJ4lB5yl5SbE4LXbZfJTudjdWLKsfkxY/PHP6mV4F5S/nK+31ANRnzyXzRPk82aO2p525nps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MYIjKcnn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FPV/MYHZk/dqJlDve20g25zBG2H8Z0c6edLJw8v0DIA=; b=MYIjKcnnnH/FEHu/DO0+PdW264
	ArXQVtPQMOiQ8y6Jj4T3/GRb2ZVMksn20N8xhZ/SogvmFLdh3EQNwwjiSqm23TnkR4OgFKvWPRIjI
	0qdVRSkWKOGWf5vhSDWOgloIJZ5E9OTTuYy6jowwFKbPZ21xC6OG+ARL3O2mTF3eyCLlCpQauwbMV
	+YY5CrNL5Su0Fr7fixAlEXnlnm+Ud3G1IfzaFHXgtKbjEkcXLo3WK+m3Jy1xAi+g6CHiHEvG/ctdc
	AdOpMYMKM+aLo2cKC689b5ub7RhPY6GQmn1gNQBD3S0z27rvK5Y+TbAfpUQ/cBhz4QGa6oDfzE5kJ
	+MVZo2yQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37892)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s9iPe-0004oN-2d;
	Wed, 22 May 2024 10:37:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s9iPg-00062j-PU; Wed, 22 May 2024 10:37:36 +0100
Date: Wed, 22 May 2024 10:37:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org,
	Duanqiang Wen <duanqiangwen@net-swift.com>, mturquette@baylibre.com,
	sboyd@kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
 entries
Message-ID: <Zk284JRvzy45kUnJ@shell.armlinux.org.uk>
References: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>
 <7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net>
 <ZkfYqj+OcAxd9O2t@shell.armlinux.org.uk>
 <4ea9cc83-c7ca-47b8-8d43-dab16193108f@roeck-us.net>
 <ZkfqKMqkUc/Sr7U2@shell.armlinux.org.uk>
 <646bd149-f29a-4c91-ab00-4f6d2fce23fd@roeck-us.net>
 <ZkhSOvkaAwsTe7Dm@shell.armlinux.org.uk>
 <44151fe7-1822-4b95-8981-9a1f1884d662@leemhuis.info>
 <Zk28HtN30TJvnZan@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk28HtN30TJvnZan@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 22, 2024 at 10:34:22AM +0100, Russell King (Oracle) wrote:
> On Wed, May 22, 2024 at 08:53:18AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > Hmmm. Communication problem aside, this in the end seems to be a
> > regression that is caused by a change of yours. Maybe not a major one
> > that is making a fuzz about, but still one that would be good to get
> > fixed. So who will take care of that?
> 
> I have suggested several approaches to fixing it, and each time I'm
> being ignored by Guenter, who seems to have some other agenda -
> because he seems to believe that using dev_name() when registering
> the clk with clkdev is wrong... despite the fact that clkdev uses
> dev_name().
> 
> What I am uncertain about is:
> 1) whether clkdev is even necessary here, or whether it is pure noise.
>    I think it's pure noise.  Why? The dev_name() that is being used#
>    to register the clk seems to be the _source_ device of the clock,
>    whereas the name given should be the _consumer_ of the clock (when
>    clk_get(dev, con_id) is called, dev is the _consumer_ device, and
>    this is the device that dev_name() is used internally with.) Thus,
>    if _that_ device is not the same as the struct device that is being
>    passed to dev_name() when registering the clk, the entry in clkdev
>    is utterly useless.
> 
> 2) why someone would think that using best_dev_name() to work around
>    this would be a good idea. One might as well pass the string
>    "hahaha" when registering the clk - because if the device name is
>    truncated, clk_get() is not going to find it. So, by registering
>    it with clkdev, we're just eating memory for no reason.
> 
> Therefore, this change is finding bugs elsewhere. Should it cause a
> boot failure? No, and I'm happy to make clkdev just warn about it.
> However, reverting the change means we're not going to find these
> issues.
> 
> Why was the change originally proposed (by Duanqiang Wen) ? The reason
> was because of this truncation causing clk_get() to fail unexpectedly.
> 
> I am all for a _sensible_ discussion over this - not one that seems to
> have an agenda about "should dev_name() be used when registering a
> clk" that seems to be Guenter's approach because _that_ is not the root
> cause of the issue and I've already explained that _that_ is not the
> issue here. Yet, Guenter insists on that.

.. and I'll also add that I'm up to my eyeballs with an issue at
Oracle, and thus have very very little time to deal with mainline
kernel issues right now, so if people appear to be intentionally
obtuse and difficult, I will end the discussion as I did here
_purely_ because I _do_ _not_ _have_ _the_ _time_ to waste my time
with them.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

