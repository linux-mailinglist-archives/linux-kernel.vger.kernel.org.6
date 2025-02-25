Return-Path: <linux-kernel+bounces-532258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96368A44ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705F83A908A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0226119E804;
	Tue, 25 Feb 2025 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="f19UWKbe"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F54189B9C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508754; cv=none; b=mv7BzNNHgPUZb2m/d19/G/NtMtsddY1dd5HWNrpob96UHL/s1FwN0Y1v+VpqgmzmqHMtqFnkMArE3ET7Hm9Bgl0cq9LsHAbWCipFSOkS+L0mpj464HfTRpEpBov4JCOimbDU99/99IBhyXWIAmn5p3orUxYEGlOJI4620cVtNOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508754; c=relaxed/simple;
	bh=d6qIhS338zcyXStTSr2X5+ACE58ddF0bUqI2XW853WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQfMKFIho6b3o+yNTvKvPEvtkDHeL8gcEA6rhzaIVVzzS916vdBTjXZTQm0g4xC1vNvsxL7Uv9qUrKMY3SgTjXqsJa3/TitawboP0T52llGtYiE2KXQ2MggdRLlqa8nNkoE1aQuAk1H5Co17Ye0gx2S9ER79QmNCS+lw4uxnAQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=f19UWKbe; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=FUtkPzcmdbz+C1QDeT+fCSeX9HpnwFcnl8w9BxaCO64=; b=f19UWKbeqHv5rG/Y
	/P9MDu/UpgGjUqMoYGNbahazrRYJdI1Su+nkXafrwNRle6N2u/XdcL+ULNoeYOlOXeDzXD/t/y5s5
	qY3h8PEbWn9bxJ8Rv3o/PxTnTcstND/Oe8Su6626zy0wYFdN52qOPBggTUot7pewIZZV73M9PCJX3
	SaDB3pdMrXVGqyYSTA08u9/mMjjx7MbiMgh5UFydBPp6QZrxAV0HR4Y4VcrUP/EHcCfoGqOdEM80x
	plUFg9eO2/dcHBXnnJ4DEnxyP1jkJ2AluemJfzbXnrrHS8vXecEOM5wQlOGd7zi8tZxamWX3cx2DT
	iyj/zSIZXto7jTkWsQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tmzpi-000nnb-0Y;
	Tue, 25 Feb 2025 18:39:06 +0000
Date: Tue, 25 Feb 2025 18:39:06 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, david@rowetel.com
Subject: Re: users of drivers/misc/echo ?
Message-ID: <Z74OSsZqeboJml9c@gallifrey>
References: <Z7tZhYET41DAoHVf@gallifrey>
 <07afd3cb-3ab1-4dc9-b0c1-3fef2d52f60b@app.fastmail.com>
 <Z724l3DFJbGevtPF@nataraja>
 <Z72_EnXyHoDACRk5@gallifrey>
 <Z73MevharqkC5dt8@nataraja>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Z73MevharqkC5dt8@nataraja>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 18:33:29 up 293 days,  5:47,  1 user,  load average: 0.02, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Harald Welte (laforge@gnumonks.org) wrote:
> Hi Dave, Arnd, Greg,
> 
> On Tue, Feb 25, 2025 at 01:01:06PM +0000, Dr. David Alan Gilbert wrote:
> > > However, those DAHDI-using deployments that I personally am familiar
> > > with do not use the software echo canceller discussed here.  On the
> > > other hand, I'm quite certain that there are many PBX/IVR related
> > > systems out there (unrelated to my area of cellular or trunked radio)
> > > that would still use the echo canceller discussed here.
> 
> I have to correct myself here:  "that would still use software echo cancellation".
> 
> As I stated before, in "my" deployments, the echo canceller is not used
> and hence I'm not super familiar with it.  My use cases either don't
> need echo cancellation, or use hardware echo cancellation.
> 
> Revisiting the DAHDI source code as a result of this thread: There are
> actually several different software echo cancellation implementations,
> only one of which (oslec) is using the drivers/misc/echo.
> 
> > Some questions:
> > 
> > 1) I see drivers/dahdi/dahdi_echocan_oslec.c
> > 
> > /* Fix this if OSLEC is elsewhere */
> > #include "../staging/echo/oslec.h"
> > //#include <linux/oslec.h>
> > 
> > now that moved to drivers/misc in 2014 by Greg's
> > 6e2055a9e56e ("staging: echo: move to drivers/misc/")
> > 
> > So is most of this on ancient kernels or do people
> > actually use modern stuff?
> 
> Actually, looking at DAHDI, I really don't think anyone is still using
> the dahdi_echocan_oslec code.  It is disabled by default and only built
> if explicitly enabled by the user, and indeed if anyone did that it
> would fail to build for any kernels that have moved it out of staging.

It looks like Debian is including and enabling it in it's DKMS build:

# apt install dahdi-dkms
...
dahdi_echocan_oslec.ko:
Running module version sanity check.
 - Original module
   - No original module exists within this kernel
 - Installation
   - Installing to /lib/modules/6.1.0-31-amd64/updates/dkms/
...
# nm /lib/modules/6.1.0-31-amd64/updates/dkms/dahdi_echocan_oslec.ko
...
                 U oslec_create
                 U oslec_free
                 U oslec_update
...

> > 2) I see there is a fir.h that's different from the kernels
> > drivers/misc/echo/fir.h  doesn't that cause problems?
> > Should one get updated from the other somehow?
> 
> I'll not investigate that given the above determination.
> 
> > 3) Any idea why it's never been upstreamed?
> 
> I can only speculate, but I guess it was never a strong priority for the authors,
> and indeed likely the code would have had to undergo quite some changes.
> 
> DAHDI is clearly well beyond its peak user base these days, and I would
> expect the amount of effort into mainlining it, together with the
> associated risk of introducing bugs during required refactoring simply
> doesn't make it an attractive proposition.  Also, given that userspace
> applications for it have been around for decades, it would be impossible
> to address any upstreaming related change requests without rendering
> those applications incompatible.
> 
> So I'd really not bother at this point anymore.  The few adjustments
> I/we had to make to keep it building + working with recent kernels over
> the past few years are minimal, and mostly trivial stuff like minor
> kernel API changes.  In the end, DAHDI doesn't interact with a lot of
> other kernel.  It talks to the hardware via its own device drivers, and
> it talks to userspace programs via character devices.  So unless some
> core kernel memory allocator, or PCI or USB device drive APIs or
> character device API changes, we're mostly good.

OK.

Dave

> -- 
> - Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
> ============================================================================
> "Privacy in residential applications is a desirable marketing option."
>                                                   (ETSI EN 300 175-7 Ch. A6)
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

