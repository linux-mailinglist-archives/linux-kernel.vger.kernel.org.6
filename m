Return-Path: <linux-kernel+bounces-533180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DBFA45686
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E7F174A59
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B616F26B95B;
	Wed, 26 Feb 2025 07:20:06 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1B318DB11
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740554406; cv=none; b=UtDmhkUEqdRGT1OnaKvZjPVq7JiTyq3g8Vnisw0Qsq91NSkg7GrLScsTxz//Qpu0azehu/gBg5VWGj9FC8JLHJbUw73kuJ7cktcTC7VxCkJVoHDGq0OB31SrMQ2PBXc/Of4W1y/m3WMJrDbJZJVoT5tl37F7qfgRw1ec5hd5yZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740554406; c=relaxed/simple;
	bh=zC5JXssWPYpS9SK9DWLWBz2AMT0TmxOYeJ7KFZBG0k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSUfA1QxyeLvJ+6XxuSgvbiPKdyw0FdKxkHf8zPULabxLPZvWl+TBGabLSOcV2vlRAtbMKBeGLvxBJJ3frVv1UQi4taHutcS9aMcdP+JqTDUlXXgvkISmDHQCt73jrT857W8bAPRnTEIGHRU+WKCf2+1WsOHdTRCWnVqDn6KB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.94.2)
	(envelope-from <laforge@gnumonks.org>)
	id 1tnBi2-00A4ao-CA; Wed, 26 Feb 2025 08:19:58 +0100
Received: from laforge by nataraja.fritz.box with local (Exim 4.98)
	(envelope-from <laforge@gnumonks.org>)
	id 1tnBaU-00000000m4J-0Bjp;
	Wed, 26 Feb 2025 08:12:10 +0100
Date: Wed, 26 Feb 2025 08:12:10 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, david@rowetel.com,
	Tzafrir Cohen <tzafrir@cohens.org.il>
Subject: Re: users of drivers/misc/echo ?
Message-ID: <Z76-ygNZfvrTAOhn@nataraja>
References: <Z7tZhYET41DAoHVf@gallifrey>
 <07afd3cb-3ab1-4dc9-b0c1-3fef2d52f60b@app.fastmail.com>
 <Z724l3DFJbGevtPF@nataraja>
 <Z72_EnXyHoDACRk5@gallifrey>
 <Z73MevharqkC5dt8@nataraja>
 <Z74OSsZqeboJml9c@gallifrey>
 <Z74VF1Uw5sRVbXhy@nataraja>
 <Z74-VwtwSa3k2E0m@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z74-VwtwSa3k2E0m@gallifrey>

Hi Dave,

On Tue, Feb 25, 2025 at 10:04:07PM +0000, Dr. David Alan Gilbert wrote:
> * Harald Welte (laforge@gnumonks.org) wrote:
> > Hi Dave,
> > 
> > On Tue, Feb 25, 2025 at 06:39:06PM +0000, Dr. David Alan Gilbert wrote:
> > > > Actually, looking at DAHDI, I really don't think anyone is still using
> > > > the dahdi_echocan_oslec code.  It is disabled by default and only built
> > > > if explicitly enabled by the user, and indeed if anyone did that it
> > > > would fail to build for any kernels that have moved it out of staging.
> > > 
> > > It looks like Debian is including and enabling it in it's DKMS build:
> > 
> > thanks, I didn't realize that.  You could reach out to the Debian maintainer of the package
> > if you'd want clarification.
> 
> Given that Debian build etc - what's your preference?   I'm happy to
> grind a patch to remove the kernel copy if Debian is using their own copy.
> Or do we leave it and fix up Debian to use it?

I've Cc'ed Tzafrir, the Debian maintainer of the DAHDI package.  Better to ask his
opinion directly rather than speculate about it.

Tzafrir: You can read this thread on lkml.org. The summary is that mainline Linux
is considering to remove drivers/misc/echo from the kernel source, as after removal
of mISDN there are no users of it left in mainline.

DAHDI doesn't build the dahdi_echocan_oslec by default, and the
Debian dahdi-linux DKMS seems to come with its own copy/version of the actual oslec
echo cancellation code rather than using the mainline one (which has migrated from
staging to misc a decade ago).

My opinion is that there's no reason mainline should keep drivers/misc/echo.

Regards,
	Harald

-- 
- Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

