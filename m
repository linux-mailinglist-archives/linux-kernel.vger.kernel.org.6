Return-Path: <linux-kernel+bounces-189884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B2A8CF634
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 23:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F54B2113A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 21:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA1D13A25B;
	Sun, 26 May 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ndkMmUuf"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE44B139D18
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716760670; cv=none; b=cqMe2kaMJydq2ZaVjb//dMPOGpvahyrrEh2BY/3uFH4evfigp6J0AefLnoZw/MU94cVA+foVSs4IBQx35i3BICmKhdJyiahNgKpYYWmBqp5pD8nkJmFF6wsxp67OR5K4UKU9UKpqerkjjU4/BY9LbOYenJdC5tWUs2gsYQore54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716760670; c=relaxed/simple;
	bh=9wL/22quDYLNFYhnuRp0mH/tZ5p0xW200lbufDgduRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nyig+2EFi5rvOBSqk64YvC81oDxrWKg878pOTobmXoGyqne+OpTHFWW5YYq0EB5g1HPbuqGZrlFQyBzFVuCdTsZ6helBH8lVH1VhYHQp8EvYIHTg2EVe+v+NtvWAh0vBn1PwjTJ009es2Bjtq2QifscM5SxLznF+u5FRMgeqUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ndkMmUuf; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: torvalds@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716760665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43IgFxcGtIR014iSSMSUZhPtpCTI0j9chMuGbiquXxs=;
	b=ndkMmUufmdAAiOm6yTTzvJjV9SCnx1CL8Z/3FY7syS7c1ht9LhZ/9/yypRfozTyzrukrpl
	gEkIwOK3f24MatGq4+cCwT76vDu0ocqS93Yq/czO6u06toYEzLMwprQXP1hEkBZJlci403
	2kQ+gsm2MsI5/BEs2P+aIV7J3rrO8Xk=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: surenb@google.com
Date: Sun, 26 May 2024 17:57:41 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [GIT PULL] header fix for riscv build failure
Message-ID: <i4zl55yyhky74ouig4h6z2mleb3ruwp24xbt5wyb4eod6exja2@uwyxbll63j3v>
References: <h23suk5s4hhkf7prhkzxp6a4kmhpgqxyl6ioski5cg7ciihxmj@j4zif6l6dqxc>
 <CAHk-=whMS56xLhb7cAmTri2sXtGxK_zKWhZVX87YzjwAfVqTqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whMS56xLhb7cAmTri2sXtGxK_zKWhZVX87YzjwAfVqTqQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, May 26, 2024 at 02:46:04PM -0700, Linus Torvalds wrote:
> On Sun, 26 May 2024 at 10:03, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > Hi Linus, this fixes a riscv randconfig build failure from memory
> > allocation profiling...
> 
> This pull request is odd in multiple ways.
> 
>  (a) it's unsigned, and I really don't pull from unsigned sources any more

I thought it'd be fine since it's a one liner - I'll fix that

>  (b) the commit message is strange. It says "bcachefs", but I don't see why

blech, muscle memory...

>  (c) you say riscv randconfig in the pull request but then when I
> follow the links in the commit, it says "mips-randconfig". Maybe the
> same thing ends up happening elsewhere too - including riscv - but it
> sure is confusing and I suspect it was just a typo.

Yeah, another typo

>  (d) there's no "Fixes:" tag, so then I had to go and look up that
> this wasn't stable material (it doesn't seem to be, the "Fixes" tag
> would seem to be 24e44cc22aa3 ("mm: percpu: enable per-cpu allocation
> tagging") from the current merge window

yeah, I should have added that.

Sorry for the confusion...

