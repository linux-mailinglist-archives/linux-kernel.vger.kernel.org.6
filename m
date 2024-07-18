Return-Path: <linux-kernel+bounces-256823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E979E9370E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B551F22271
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25365146594;
	Thu, 18 Jul 2024 22:55:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29291442E8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343343; cv=none; b=brk6UZhOeJ7ccrMK3ivoV1i+buxjb1exGTiTAkSo7q8ozwbWpvune75qHlHVPWqJMyBA+0JyDsdv2MDViTQ0tLEVD/vJaT4+0c05OPzPWOhbKaqYnEGlcCluTChf1yGhXxsBC3LPsxGOFBxCWAgTwo9qFCCeV9zogDPSC374sOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343343; c=relaxed/simple;
	bh=l39FF6CU5jwG2dZsgjW4xFDRke+JWxvat+LRb8W7zfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JflFjRCqF8nCNeQfKnJ3PoO+C1tzJn5NOf0Ojo+VgqPGhZWBtGgl/TsOjJ4ArB5RIUKxQWDBQOGAs7Ipn8Na+tfPZFn/h3nrVOb8IKBPRYQiPWLybvQCAqrzDEIvvCkG5mcgKGGOs5vxp+ceSlr/V+5QWJ74XZ0Nw354aUS/gEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD01AC116B1;
	Thu, 18 Jul 2024 22:55:42 +0000 (UTC)
Date: Thu, 18 Jul 2024 18:55:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>
Subject: Re: [GIT PULL] ftrace: Rewrite of function graph to allow multiple
 users
Message-ID: <20240718185547.551f7dc8@gandalf.local.home>
In-Reply-To: <CAHk-=wgQx-BiPQLe0rHLpvn1j89B8EgYPLvw0hGC-AUvF-uE1w@mail.gmail.com>
References: <20240716162714.48febeaf@rorschach.local.home>
	<CAHk-=wiJwzMR6mZ8=Mc4bhCA3qRdwo_7NEHU80mSWoaMLTFjqw@mail.gmail.com>
	<20240718172937.2fb3e91c@rorschach.local.home>
	<CAHk-=wgQx-BiPQLe0rHLpvn1j89B8EgYPLvw0hGC-AUvF-uE1w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 14:54:11 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 18 Jul 2024 at 14:29, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Basically, it's just to show who owns the copyright.  
> 
> .. but since basically nobody else does that, it's worthless.
> 
> You'd have to go back to the email address and date range *anyway* for
> everybody else, so you doing it adds no value - and everybody doing it
> would be just hugely annoying.
> 
> End result: unless there's some actual company policy, please just
> don't do this. Because your "copyright" excuse is clearly just empty
> words.

It was also a way to give credit to the ones that pay me. But whatever.
I've been doing this since 2013, not sure why it is now such an annoyance.
Was it just because patches that have been living in my repo since I was at
VMware finally made it forward so that both companies showed up in one pull
request? Or has this always been an annoyance?

I'll remove it, but it just feels wrong to me, as I'm no longer giving
credit to the one funding my work, and I have no plans on switching to my
google email.

Note, I have commits with it already, so this change will only happen for
new code.

-- Steve

