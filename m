Return-Path: <linux-kernel+bounces-213614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77519077AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F1128F72C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070D512F5BB;
	Thu, 13 Jun 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pxlq8b4G"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A73312F360
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294438; cv=none; b=d3DAfvFak2Pv+uljX5drCjzAW1dQuXLzdU3ZB3jl0zogNNveJqJL/wqepkovHlQaMZPhxgP9+RZMhrkHo+NFAMN2DukAM+caoxk9H65tsOE7mtSYw+z+SF89TYClWF4L7PWZ/soB+xwlnUdpttrUabl+LxlF0o6w3wbOI/DcRBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294438; c=relaxed/simple;
	bh=wHZSCUZTJakO7J7EJiM8gXNHiMdinFUtFvS0Jmjt+mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWoEe0+tm/lWG+eJR9RfJrXuEwBXu/aH+rBFFlvJU/hu2nWYpljnmo/fdeLGvZShs+GPQNPdm9xM/TOKDnGoT8NAz5mCKRa2u4ZErZVToP8DTcbL5usmzscc98m+vq1HdCukhA+khrJwfNAlb/8DRc+tKjpcYVgjXgsEKjAd8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pxlq8b4G; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GShcvdeoBkrDrM2l1dlhP3XhLowZrC48RJTWOeg0qDM=; b=pxlq8b4GwSOLi8c4ZIdjYH5Sgn
	nVLfetEwP8o+7/EnHoSV7HT7dvOfNpSAw9/a+yk+TsUd5ty2dhORBKwZ526+DtttRu5IuODoDswQd
	F8KjBxupZWjns+6Q/XaO1o2hLgHaZD5f04tBPkswySHofBmF4H5AZsginNErHWr3sZ2kG1s5+Kxq+
	6lFF+u8YmHXGYwwJhTJnSRYLDvxjcNQh6feRunGJakfapP/gOQpDQVywFL+Is6fcnAGyTpKUHTjmj
	pYtQuug3sg5ReIgzbBcb6twSPiHP3OtebKSV9BDY792KCT2r0hhRDn0wF9TwtVhn4Jl/p8kfnvfFw
	P5kzfvyA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51242)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sHmrh-0006nm-1z;
	Thu, 13 Jun 2024 16:59:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sHmrd-0001Ko-Ia; Thu, 13 Jun 2024 16:59:49 +0100
Date: Thu, 13 Jun 2024 16:59:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH v2 0/2] ARM: decompressor: support AUTO_ZRELADDR and
 appended DTB
Message-ID: <ZmsXdWWidNjXdbSa@shell.armlinux.org.uk>
References: <20240121203009.9257-1-ansuelsmth@gmail.com>
 <65d62b60.050a0220.c7b96.614e@mx.google.com>
 <666ad6e0.df0a0220.f8b16.4a5e@mx.google.com>
 <CACRpkdYJoNRpciyQE_A6dkb8f6Jsy4+qwb4w9K3bss2mkZpp1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYJoNRpciyQE_A6dkb8f6Jsy4+qwb4w9K3bss2mkZpp1A@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 13, 2024 at 03:50:58PM +0200, Linus Walleij wrote:
> On Thu, Jun 13, 2024 at 1:24 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > Sorry for asking again... but any news for this?
> >
> > I have also added the 2 patch here [1] [2].
> >
> > Been in incoming from a long time and I have seen other patch getting
> > accepted. Did I do something wrong in submitting the 2 patch?
> 
> Hm Russell must have had some concerns, Russell?

I've been snowed under for about the last six weeks - with only the
occasional day that isn't silly. It's that kind of frustrating snowed
under where each problem is a bit like a brick wall placed every 1m
and you're supposed to be doing a 100m sprint race - you can't see
the next brick wall until you've climbed over the first.

Whether I have time to read the mailing lists or not depends entirely
on what is happening on any particular day.

> If for nothing else I think some Tested-by:s would be appreciated,
> do we have some people who use this that can provide Tested-by
> tags?

Yes, tested-by's would be a really good idea, because my gut feeling
is that this change has moderate risk of causing regressions. I'm
not talking about "it works for me on the setup it's intended for"
I'm talking about other platforms.

I'm also wondering about distros, and what they're supposed to do
with the config option with their "universal" kernel that's
supposed to boot across as many platforms as possible, what they
should set the config option to, and what impact it has when enabled
on platforms that it isn't originally intended for.

I haven't really read much of the patch because I've been so busy,
so I may be being overly cautious. Given that I am quite busy, I
would appreciate a summary of the situation rather than being fed
with lots of results! In other words, the tested-bys, and "it works
on all the xyz platforms that we've testsed, nothing appears to have
regressed" would be ideal.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

