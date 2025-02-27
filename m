Return-Path: <linux-kernel+bounces-536354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED36A47E82
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171E3188DD3C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D264C22E3F0;
	Thu, 27 Feb 2025 13:05:32 +0000 (UTC)
Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD1C22D7B2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661532; cv=none; b=I2E3zcwenKw5umOUYquHgaVqWZzZ1jKOuO2TtCtQh8MItrQH1/7ZEEQZoYtWXV2bvu8jZnc/piYCqIKWgT7qW2tKk6JDKEygMlPMKSAnAN+YB3n7gYp67SeDNHIo0a2jMVfE7t7WKFw8X5rkf0cG26XJ5ZZ0vlpIbwRe16lj1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661532; c=relaxed/simple;
	bh=yMjWERQO7tb9dKxz8yG/jWDz2IVS11vV3vvewjuaCIs=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=bRsmlohpo86//WhIVhJoO3BZZImjHQMKDw0FHInZI5A019bJaZfwzeZuZ70hJdSjDsk68+VARswvmRlbNJS37jfT//vViVEbiRsiikyePTdszwLUQZ2LiWwGSCfS6mM6rQ+L9aTjegzlTIbmrGhFOItqeQBjD3tEaJEVCHPVpjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 52940 invoked by uid 3782); 27 Feb 2025 14:05:16 +0100
Received: from muc.de (pd953af25.dip0.t-ipconnect.de [217.83.175.37]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Thu, 27 Feb 2025 14:05:15 +0100
Received: (qmail 6065 invoked by uid 1000); 27 Feb 2025 13:05:15 -0000
Date: Thu, 27 Feb 2025 13:05:15 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: More than 256/512 glyphs on the Liinux console
Message-ID: <Z8BjC_TzuDVaFC_3@MAC.fritz.box>
References: <Z7idXzMcDhe_E5oN@MAC.fritz.box>
 <2025022243-street-joylessly-6dfa@gregkh>
 <Z7nu7HqKn4o2rMd5@MAC.fritz.box>
 <2025022355-peroxide-defacing-4fa4@gregkh>
 <Z7y4yHT0fNYYiPI8@MAC.fritz.box>
 <d5e05c61-d796-4e5c-9538-a1e068631bba@kernel.org>
 <Z73sqvjlbJ54FCtH@MAC.fritz.box>
 <2025022652-uptown-cheating-5df8@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022652-uptown-cheating-5df8@gregkh>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

Hello, Greg.

On Wed, Feb 26, 2025 at 11:09:57 +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 25, 2025 at 04:15:38PM +0000, Alan Mackenzie wrote:
> > On Mon, Feb 24, 2025 at 21:08:50 +0100, Jiri Slaby wrote:

[ .... ]

> > > I didn't read the thread, but are you looking e.g. for kmscon?

> > No, I wasn't.  I was looking for a drm replacement for the drivers/tty/vt
> > code inside the kernel.  I may have misunderstood Greg when he referred
> > to a replacement which uses drm.

> No, this is what I was referring to.  Also maybe we should be asking on
> the drm list?  The developers there were working to get rid of CONFIG_VT
> so I know they have plans for what they see replacing it.

Which list would that be?  There are over 100 occurrences of "DRM" in the
file MAINTAINERS.  I am also interested in this.  There is a very great
deal of functionality in drivers/tty/vt.  It will be quite a task to
replace it.

> > kmscon doesn't seem to be a suitable replacement for the Linux console.
> > According to Wikipedia, it stopped being maintained ~10 years ago.  Also,
> > it is a user level program, not a kernel level program, so will only become
> > active later in the boot process than the current console, which is not
> > a good thing.  It might well steal key sequences from application
> > programs, the way X and X window managers do, but maybe it doesn't.  On
> > Gentoo, kmscon is "masked", i.e. strongly recommended not to be
> > installed, and installable only after taking special measures.

> Yes, it will be "after" the boot console, but that should be it.

What would the boot console be?  Some console needs to be in place early
enough to be able to display "Kernel panic - unable to mount the root
partition".

> It shouldn't be stealing any keys away from anything, but rather going
> through the existing apis we have for input devices and the like.

Agreed.

> I don't know why distros seem to not be using it anymore, maybe there's
> something else?

Jiri pointed to some problems yesterday from his point of view as a SuSE
maintainer.  Perhaps kmscon just needs bringing back into maintenance.  I
haven't actually looked at it yet.

> thanks,

By the way, I'll be away from my email for a few days, so won't be able
to answer any posts in that time.

> greg k-h

-- 
Alan Mackenzie (Nuremberg, Germany).

