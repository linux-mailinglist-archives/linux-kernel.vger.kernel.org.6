Return-Path: <linux-kernel+bounces-527868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36186A410A6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FE3188992D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A7415747C;
	Sun, 23 Feb 2025 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eHGwCXnx"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB70D7081A;
	Sun, 23 Feb 2025 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740333830; cv=none; b=gq6OLWdahS1qpS8ZSGbe+0AZIexM5G4MywIOB66+KK0SyNmxk1PHYn4DhtYcA6D0TsNR5zjr3KngMTjkX7DQDqoQn/23SZ14APlB7GpAw8WLyzMvkgiMwZPAbz81BgrdM22wIH7YVoqHvtAK11TsQoaNiMICOsdHeQkwBpDy0RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740333830; c=relaxed/simple;
	bh=vHoTYqH5kYLdCvoAFtXVHET6Lr3U8dENcUD3HaYCcZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flQ8VSf2KEBAkuDXTNU36XkrkVviaOxD764pT9lmP0XxEi8eRbA0sEG8m3sOYaLMjABU6dUPCSX3acR9Vwy1PeLoTFeVzIFlLcfH7RJbd6mQcLYLJQ1bGE1gUjyJ7UhmE60oAJ373Qfl33RUWOVC09viDKHeLP2T0x2AEXjbW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=eHGwCXnx; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 56592496;
	Sun, 23 Feb 2025 19:02:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1740333741;
	bh=vHoTYqH5kYLdCvoAFtXVHET6Lr3U8dENcUD3HaYCcZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHGwCXnxIBw6QRhY2zd1Ly9pL5XvMggWiB/ic03NPfxDJk0V4Lb/Md/lW6Arekk6p
	 mlDk9Msq7eM41N7Px1H5K0NcWrYHD4RIpvHaXg1aixW2v3uE7kf91/ESk16VfaF39Y
	 yHilU8aQvTSzkpIq46v2pa/EnC1kDRXfvjRWm+Y0=
Date: Sun, 23 Feb 2025 20:03:30 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250223180330.GC15078@pendragon.ideasonboard.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <Z7bO1jT2onZFZwgH@infradead.org>
 <CAHk-=wgLbz1Bm8QhmJ4dJGSmTuV5w_R0Gwvg5kHrYr4Ko9dUHQ@mail.gmail.com>
 <Z7hulnJ4fwslRILy@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7hulnJ4fwslRILy@pollux>

On Fri, Feb 21, 2025 at 01:16:22PM +0100, Danilo Krummrich wrote:
> On Thu, Feb 20, 2025 at 04:39:58PM -0800, Linus Torvalds wrote:
> > Honestly, what you have been doing is basically saying "as a DMA
> > maintainer I control what the DMA code is used for".
> > 
> > And that is not how *any* of this works.
> > 
> > What's next? Saying that particular drivers can't do DMA, because you
> > don't like that device, and as a DMA maintainer you control who can
> > use the DMA code?
> 
> [...]
> 
> > So let me be very clear: if you as a maintainer feel that you control
> > who or what can use your code, YOU ARE WRONG.
> 
> When I added you to the original thread [1], it was exactly to get some
> clarification on this specific point.
> 
> In my perception, a lot (if not all) of the subsequent discussions evolved
> around different aspects, while this specific one is not even limited to Rust in
> the kernel.
> 
> Hence, I'm happy to see this clarified from your side; it was still a remaining
> concern from my side, regardless of whether the PR in question will make it or
> not.
> 
> However, I also want to clarify that I think that maintainers *do* have a veto
> when it comes to how the API they maintain is used in the kernel. For instance,
> when an API is abused for things it has not been designed for, which may hurt
> the kernel as a whole.

I've been thinking this through over the weekend, and I see an elephant
in the room that makes me feel uncomfortable.

Three important statements have been made on the topic of rust for
Linux. I'm going to include some quotes below, alongside with how I
understand them. My understanding may be wrong, please let me know when
that's the case.

- No maintainer is forced to deal with rust code at the time being.

  This was mentioned multiple times in different forms, for instance by
  Miguel in [1] as

  "Some subsystems may decide they do not want to have Rust code for the
  time being, typically for bandwidth reasons. This is fine and
  expected."

  or by Linus in [2] as

  > You don't have to like Rust. You don't have to care about it. That's
  > been made clear pretty much from the very beginning, that nobody is
  > forced to suddenly have to learn a new language, and that people who
  > want to work purely on the C side can very much continue to do so.

- No maintainer can (ab)use their power by nacking rust abstractions for
  the API their maintains.

  This was made clear by Linus in [2]:

  > So let me be very clear: if you as a maintainer feel that you
  > control who or what can use your code, YOU ARE WRONG.

- Breaking compilation of rust code in a released kernel is not allowed.

  This statement is less clear in my opinion. It's made by Miguel in [1]:

  "The usual kernel policy applies. So, by default, changes should not
  be introduced if they are known to break the build, including Rust.

  However, exceptionally, for Rust, a subsystem may allow to temporarily
  break Rust code. The intention is to facilitate friendly adoption of
  Rust in a subsystem without introducing a burden to existing
  maintainers who may be working on urgent fixes for the C side. The
  breakage should nevertheless be fixed as soon as possible, ideally
  before the breakage reaches Linus."

  The "ideally" in the last sentence is a subtle but important detail.

  Then we had some patches that broke the -next rust build and were
  dropped from v6.14, as mentionned in [3]. Greg

  > > Regardless of holidays, you seem to be saying that Linus should
  > > have accepted Andrew's PR and left rust with build failures?
  >
  > I can't answer for Linus, sorry.  But a generic "hey, this broke our
  > working toolchain builds" is something that is much much much
  > different than "an api changed so I now have to turn off this driver
  > in my build" issue.

  I haven't found a clear statement from Linus on this topic.

Those three statements can't all be true together, we can at best have
two. I would like to understand which one we will drop first, and I
believe many other developers and maintainers are wondering the same.

[1] https://rust-for-linux.com/rust-kernel-policy
[2] https://lore.kernel.org/all/CAHk-=wgLbz1Bm8QhmJ4dJGSmTuV5w_R0Gwvg5kHrYr4Ko9dUHQ@mail.gmail.com/
[3] https://lore.kernel.org/all/2025013148-reversal-pessimism-1515@gregkh/

> But as mentioned previously, I do not think that this veto can be justified with
> personal preference, etc.
> 
> - Danilo
> 
> [1] https://lore.kernel.org/lkml/Z5qeoqRZKjiR1YAD@pollux/

-- 
Regards,

Laurent Pinchart

