Return-Path: <linux-kernel+bounces-527419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793AFA40B0E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC833BFFF7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1217E1E7C24;
	Sat, 22 Feb 2025 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gjVPkBt9"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D635961
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740250014; cv=none; b=rNDVt8KrwEaPz/ZIYRW0aPlwa5yW6HWm9wwnRspSfY4B4yo2g8rp8mMeNzVbc6MDl9PY7bTDy7LndlK8xcVS1dm8A1MwXe/kOAu79lJ8Y1VIaLBm5o6z8Yer22lmfmnhNRmbrb+Xk5FfwoLIySsLccbmELzjCK/mcG+KOnqRxjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740250014; c=relaxed/simple;
	bh=7sIwnY6/3gZT+k1BZR3Ol1zXU2KSCV3hVwQK1y2xfNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4MtOXpfD4CT1c9Fl2NfuZ2/oF7ckziOe5fjVhy8+XrcBavjOJILVgzJ0oRy6VQoVXmoM1LhHipmezGbxnnUnEzD90nBuMjqlRpTG4k/k+9MokmfbiiWFRCWoO7mKQuhtwYg8/iFzFD/HH0aAZTEIWJDYQJkn/cQKfNnEav8e+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gjVPkBt9; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 13:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740250000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3f/0VAaSYr2M8Qek1+ROCrWl7o/8nq+xAmZ5OglDyZs=;
	b=gjVPkBt9Hn/WFy+N8kKxgmv7+wVzaqQqMlyI0BAJA4G4GmnJZcii6Be39bx5Xg+EUPv43C
	stBErpVS63lWVaWZcQWnIkoAMQ0UE46oOK7hPUKJR2+d7wsYYZ59udRpJelUgnrQEy3vFD
	VRUeCwXPsRC5suVr12pNonWGDD8kUC4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Airlie <airlied@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <nuxose4hzqvrmuvtbzio4x4n3y7tzbxmtwtwipafz7mhqd7zin@zvm6khg4mtrn>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <CAPM=9twZYgp4skmHCcpRr4z8pne-3LN=J=Dan-sEAwJEpttXSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPM=9twZYgp4skmHCcpRr4z8pne-3LN=J=Dan-sEAwJEpttXSA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 19, 2025 at 03:59:27PM +1000, Dave Airlie wrote:
> On Wed, 19 Feb 2025 at 11:00, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > On 2/18/25 14:54, Miguel Ojeda wrote:
> > > On Tue, Feb 18, 2025 at 10:49 PM H. Peter Anvin <hpa@zytor.com> wrote:
> > >>
> > >> I have a few issues with Rust in the kernel:
> > >>
> > >> 1. It seems to be held to a *completely* different and much lower standard than the C code as far as stability. For C code we typically require that it can compile with a 10-year-old version of gcc, but from what I have seen there have been cases where Rust level code required not the latest bleeding edge compiler, not even a release version.
> > >
> > > Our minimum version is 1.78.0, as you can check in the documentation.
> > > That is a very much released version of Rust, last May. This Thursday
> > > Rust 1.85.0 will be released.
> > >
> > > You can already build the kernel with the toolchains provided by some
> > > distributions, too.
> > >
> >
> > So at this point Rust-only kernel code (other than experimental/staging)
> > should be deferred to 2034 -- or later if the distributions not included
> > in the "same" are considered important -- if Rust is being held to the
> > same standard as C.
> 
> Rust is currently planned for non-core kernel things first, binder,
> drivers, maybe a filesystem,
> There will be production kernel drivers for new hardware shipping in
> the next few years, not 2034 that will require rust to work.

If we can ever get the bindings merged, I want to start using Rust in
bcachefs yesterday. I'm already using it in userspace, and already have
Rust bindings for the core btree API.

Initially it'll just be for the debugfs code so that we can test things
out on a non critical component (make sure the toolchain works, make
sure the distros aren't screaming too much).

But the sooner I can switch to writing new code in Rust, the better.

Re: compiler requirements, all this stuff is driven by practical
considerations. No one is shipping a 10 year old Rust compiler, and as
distros have become more modern and better at shipping updates there
won't ever be any reason to.

Rewriting some ancient driver that people use on ancient machines with
ancient distros would be a problem, so we won't do that.

What the actual toolchain stability requirements end up looking like in
10 years is anyone's guess (Will gcc-rs become mainstream? Will llvm
start supporting the necessary architectures? Will we just not care as
much about niche architectures? How will distros be at shipping
updates?) - so we can't say with any degree of certainty what the long
term policy will be.

But I'm sure we'll be talking to all the relevant users and stakeholders
and coming up with something reasonable.

