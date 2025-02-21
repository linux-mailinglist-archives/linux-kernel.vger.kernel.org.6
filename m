Return-Path: <linux-kernel+bounces-525591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26BAA3F1CD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F71A7ACA85
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F12F204F90;
	Fri, 21 Feb 2025 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cykWH0xk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA01C1F2F;
	Fri, 21 Feb 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133171; cv=none; b=AnglqSbHkssa9boJPxgJbRYEPnhNHCTHdnB/0clbXreZRZllNje7BgLjY8FQGJJ0J8mp+VlNUppd0v3ihQvYZSzHgWZ/k8STfOQtbYNFAiBVgVSzJS4sdl68fbjVzrktjpdm7d2fyG50/ljIaocyBO83ucw8/Dh2K9x+8F45nIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133171; c=relaxed/simple;
	bh=YY8uYjHQDlkfjosJamgPP8wd1Y99KQMuAmgv78r48/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnstnLSCfouMTlHqUAAFOzvSd0PvbgG4PPEazyxkdZBVMI95Go2aYXP0EJ6sPFh6HJHBhkslDdQOyyZkOsJfJ8CHeT6lb1RRSxZFwkadP7c+/PlQgZWJk3ClO1HJ4dMNFM+Nu+VyIvS0N8hAnXcdIRdv++GIvsr3vi40UriyQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cykWH0xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58561C4CED6;
	Fri, 21 Feb 2025 10:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740133170;
	bh=YY8uYjHQDlkfjosJamgPP8wd1Y99KQMuAmgv78r48/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cykWH0xkjDnCEfX/X2aPcgUXmh+LveKiRjagk4LFrag9ucfi/bO5qM/5if28oA8ZD
	 ADSQ+n4JRFoaKaJhI+83pP41A+6c8zenohxQyrgFvXJqupw5Omxly5ZLRelgwlulzB
	 ygLzKrPvvhr2LSuQVPiaUUQ4CtLW7QpJFuHb0T4x/Y/dKjURRPfLm3hHgRqvTKyM/p
	 Jwx3+vHytb0wyzmKytQFFJE0BSjjrWcZrBrwlW06VmpW6JZVhd69hXoDZhm94RCw4r
	 HFJ3wz3rc+JxtVnzm2tKWaqhgDz4VO+C5fW1CkJwJgYEoQj4ZW5MYMzbtUk87/OBCI
	 B/p5MOqu7QNCQ==
Date: Fri, 21 Feb 2025 12:19:26 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Fiona Behrens <me@kloenk.dev>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Kees Cook <kees@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <Z7hTLsaqNU0rlpwV@kernel.org>
References: <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <202502191026.8B6FD47A1@keescook>
 <20250219140821.27fa1e8a@gandalf.local.home>
 <202502191117.8E1BCD4615@keescook>
 <20250219202751.GA42073@nvidia.com>
 <20250219154610.30dc6223@gandalf.local.home>
 <97841173-1de8-4221-8bf3-3470a5ac98a7@acm.org>
 <89f2547edcaaba53d9965cab9133d809607330ac.camel@kernel.org>
 <87pljc6d7s.fsf@kloenk.dev>
 <Z7c3PguDn-sEl3gm@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7c3PguDn-sEl3gm@kernel.org>

On Thu, Feb 20, 2025 at 04:07:58PM +0200, Jarkko Sakkinen wrote:
> > I do still have on my ToDo list to build and publish a better nix
> > development shell for kernel with rust enabled, and could also add a
> > section on how to build a NixOS iso in the same nix code.
> > But sadly time is a finite resource and so did not yet got to it.
> 
> Please do ping me if you move forward with this. IMHO, why wouldn't
> you contribute that straight to the kernel documentation? Right no
> there are exactly zero approaches in kernel documentation on how
> test all of this.

I initiated something that makes sense to me:

https://codeberg.org/jarkko/linux-tpmdd-nixos

I'll extend this to Rust shenanigans. The milestone zero was to
figure out mandatory hashes of NixOS. It uses a combination of
nix-prefetch-git and environment variable for that. I'm still
fixing some glitches but from it should be easy to extend
to Rust kernels.

Note that I'm using Fedora in my host and NixOS is only the
easiest route I've found so far to compile Rust-enabled kernel
with user space (for C I used BuildRoot) so I have a wild guess
that what you're looking into is something that makes sense
for NixOS users, right?

I compile this by podman-compose up --build :-)

BR, Jarkko

