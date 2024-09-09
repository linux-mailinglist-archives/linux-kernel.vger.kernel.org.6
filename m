Return-Path: <linux-kernel+bounces-320612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63369970CC1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE71B21E65
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C168E1ACDE0;
	Mon,  9 Sep 2024 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nIkwNv1R"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBEC4C74
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 04:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725856610; cv=none; b=CHop8Bk/aA/gI4rRwr7P6t5RWh1Gxx0yNTzrF240xM7f+EINLniWY+/5K8u3M/7AELM2Yb63E7KYvKYkPgi8wAMWqqFRBhl/NvV37UQSltGj5WITCkVkbWh1GYRjD12+WOoB/bgXVg+ET50F+urOqa09NXDUCr1K/LHXZ938XbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725856610; c=relaxed/simple;
	bh=vYJvJhGEWyHNp8goIFnI/A3AIunBXCYrQhM4UbZWU+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx/xZnFoDXxcMXCtlhhWbKDd3ax8fLuZ//Ygcaa9FDPx/c+ne0WEJe1/ixhUuqq+y4zxxnRYP2+PNie44ILdKAAseD1H4g9teyApNfORtVotnjWz2hKEuanEbbfWn+AH+7tu4KUqMxRWi4+xCPM2vP7x522HCq7FWvSCIU363cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nIkwNv1R; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=0KaX5UkhVhO7tRPvfcw8j2/DtUCW8jlNJC/7+iJggQM=; b=nIkwNv1R7x+D5MsMJrBNPAuR/X
	eoTCSUdwlMg9DeJom3QFlwgXudXmgOPoQmCnMoG6pB7yoDo/q7eovXyUg9gH1T4e6HPiQItTSjPrS
	ieHe+FXHX403nL/s+YE27b8wfzKuLplIIcqTp5+ac3o+19eV3GWymkBdZGzAtZVLX77XZIk5qNuck
	9MV1OmvbXdUWjlTJlAkuzGTCUH3TJHuXnMoNlbKofLsEyEduX132bC5D/x43Nzpx87OHbQ1Xwt+Jt
	28fuWjYzMgB7d3SsIaQu55EaBty5W54lFQaU1robA9KfARDqatK5M01tdX0UndKu+66IMbzhCi1ro
	WnKGbrzQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1snW8r-0000000AC5h-1wVV;
	Mon, 09 Sep 2024 04:36:45 +0000
Date: Mon, 9 Sep 2024 05:36:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Bob Gill <gillb5@telus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can we get a bootable 6.11-rc kernel?
Message-ID: <20240909043645.GK1049718@ZenIV>
References: <96030dde-6c02-4308-b41b-48aeeba670f3@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96030dde-6c02-4308-b41b-48aeeba670f3@telus.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 08, 2024 at 10:04:27PM -0600, Bob Gill wrote:
> Hi.  It would be nice to have a 6.11-rc kernel that doesn't crash.  I have
> an AMD video card.  I can boot into recovery, but any time I try to run
> "service lightdm start" or startx, I get a nice black screen, and a within a
> second or 2 my keyboard doesn't even let me type the caps-lock key.

git bisect?  If it's a couple of minutes per test, should be doable within
reasonable time (depends upon your .config - if it's allmodconfig, each
build will take quite a while on early stages of bisection; if it's trimmed
down to your box, that's a couple of minutes per build).  In any case, there
shouldn't be all that many bisection steps; if 6.10 works and 6.11-rc1 doesn't,
you are looking at something under 15 builds, at a guess...

Clone the mainline tree, then
; git bisect start
status: waiting for both good and bad commits
; git bisect good v6.10
status: waiting for bad commit, 1 good commit known
; git bisect bad v6.11-rc1
Bisecting: 7446 revisions left to test after this (roughly 13 steps)
[280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guard
; 

then keep building the trees and testing them.  E.g.
; cp config-I-want .config
; yes ""|make oldconfig
; make -j8 bindeb-pkg
then install the resulting .deb - probably ought to work on ubuntu boxen same
as on debian ones; you might need to install some stuff, depending upon your
config, but something like apt build-dep linux would probably be a usable
starting point.

No matter how you build them, build and test, then say either
; git bisect bad
or
; git bisect good
depending upon the test result.  As long as the breakage is reliably
caught by your test, you should arrive at the commit that introduced it.
That would make things much easier to deal with - at least you'll know
who's the likely suspect.

Of course, if the breakage is _not_ reliably caught, you risk going in the
wrong direction and arriving at something that clearly has nothing to do
with your problem, but it sounds like the breakage is not of that sort...

