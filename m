Return-Path: <linux-kernel+bounces-522261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99B1A3C800
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836FB177B85
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABC121505F;
	Wed, 19 Feb 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJ1fUpIy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A6214A96;
	Wed, 19 Feb 2025 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739991162; cv=none; b=kAovoY4lHkEkgIh8KzTqW7hKJBYhKXRPYzWasT1Hn3T1BTXgoHaoZkF5UCmMakQj6NygkX0EddKTCDC/I7nS71zp6nJZXcBogKlriF/0ST5CULDNEibr/zAyGguf/XDGA/7rz9MzYmiS20uF4hFM8rjBY/0AaMugMlOHiWrekHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739991162; c=relaxed/simple;
	bh=pd8eYj7qdIAKcP7C9tkH6DAXDfKNqJQAKuWfeZC3ej0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lsd0IqZNebH5N8Matz2LFFzhsDqmk8/JWy7z/AR9ge3RTcLuhwps3SywXxZd6fF+ozedw1/haQDMpdtY1cDOP02lNwaD/gGxJuaovSteQ3S5Rica2p/+UbqXQ7VRzmj+uzFvPWpe6rslP26fJFsi5l8ClcvVCYdwwW9SegCq4es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJ1fUpIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93379C4CED1;
	Wed, 19 Feb 2025 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739991160;
	bh=pd8eYj7qdIAKcP7C9tkH6DAXDfKNqJQAKuWfeZC3ej0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJ1fUpIy4ggqx5v/P+L2InO+PSwNzHy1CYv/esZSmWe1keg1GNyBKsmXPVoiIUL4s
	 RkRKOVWwmHhKMO4m7gY2OpOwVdJRGNIH0qG4MChYN0yNEIAd/P46jSlrnTfcCjFyT3
	 xoQFmX337BqtS3oRjOhfIBf1DbfntGWRhT4jOekdQ4nJIGoibgqeI63q1I/Gv4iZjP
	 J+5n7PeIigJuDqhsYMVU+F7/t0/pSfk1jJLiF+gSnHvUi2VmVmPswxA6WqGLfsROtg
	 qJ6rCg9g7BZKWOFk2+3/E81LvZrC/6PwYtC64JE9BDnbMokL7h6KKWmZ8T8GkrTxcj
	 1bwkXHV/MCgTQ==
Date: Wed, 19 Feb 2025 10:52:37 -0800
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <202502191026.8B6FD47A1@keescook>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>

On Tue, Feb 18, 2025 at 07:46:29PM +0100, Miguel Ojeda wrote:
> On Tue, Feb 18, 2025 at 5:08 PM Christoph Hellwig <hch@infradead.org> wrote:
> > I'd like to understand what the goal of this Rust "experiment" is:  If
> > we want to fix existing issues with memory safety we need to do that for
> > existing code and find ways to retrofit it.  A lot of work went into that
> > recently and we need much more.  But that also shows how core maintainers
> > are put off by trivial things like checking for integer overflows or
> > compiler enforced synchronization (as in the clang thread sanitizer).
> 
> As I replied to you privately in the other thread, I agree we need to
> keep improving all the C code we have, and I support all those kinds
> of efforts (including the overflow checks).
> 
> But even if we do all that, the gap with Rust would still be big.
> 
> And, yes, if C (or at least GCC/Clang) gives us something close to
> Rust, great (I have supported doing something like that within the C
> committee for as long as I started Rust for Linux).
> 
> But even if that happened, we would still need to rework our existing
> code, convince everyone that all this extra stuff is worth it, have
> them learn it, and so on. Sounds familiar... And we wouldn't get the
> other advantages of Rust.

Speaking to the "what is the goal" question, I think Greg talks about it
a bit[1], but I see the goal as eliminating memory safety issues in new
drivers and subsystems. The pattern we've seen in Linux (via syzkaller,
researchers, in-the-wild exploits, etc) with security flaws is that
the majority appear in new code. Focusing on getting new code written
in Rust puts a stop to these kinds of flaws, and it has an exponential
impact, as Android and Usenix have found[2] (i.e. vulnerabilities decay
exponentially).

In other words, I don't see any reason to focus on replacing existing
code -- doing so would actually carry a lot of risk. But writing *new*
stuff in Rust is very effective. Old code is more stable and has fewer
bugs already, and yet, we're still going to continue the work of hardening
C, because we still need to shake those bugs out. But *new* code can be
written in Rust, and not have any of these classes of bugs at all from
day one.

The other driving force is increased speed of development, as most of
the common bug sources just vanish, so a developer has to spend much
less time debugging (i.e. the "90/90 rules" fades). Asahi Lina discussed
this a bit while writing the M1 GPU driver[3], "You end up reducing the
amount of possible bugs to worry about to a tiny number"

So I think the goal is simply "better code quality", which has two primary
outputs: exponentially fewer security flaws and faster development speed.

-Kees

[1] https://lore.kernel.org/all/2025021954-flaccid-pucker-f7d9@gregkh
[2] https://security.googleblog.com/2024/09/eliminating-memory-safety-vulnerabilities-Android.html
[3] https://asahilinux.org/2022/11/tales-of-the-m1-gpu/

-- 
Kees Cook

