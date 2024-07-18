Return-Path: <linux-kernel+bounces-256776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F5A937018
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C412827AA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7088978C9D;
	Thu, 18 Jul 2024 21:29:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A87B29A1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338194; cv=none; b=UYtXSLEzSqrknsuzOhO5Dq9NmeeypFTHHDDXZJdGHPNMwJy6KS+6Ln34jTb+yf9fSFRVNGq1GIAcTSndOPFNrJpgWfcSz5EDwW1pbnS1J2VrqwFmvb6i6tweBbMznr6mP9d/deRCzgZ6RIgY6z4EQFkLZB8EcPPoWcDC8rRxAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338194; c=relaxed/simple;
	bh=J4HMXc7R3TJKdzc+ugrKH2NOxrT3Q0AciJqOAjpa/2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKiDnHpb0V8oOnrqa0sEFaXAh/sSAQUF29jvnICDMWd4kt+Ii3X/xcYWEa+9xpCZBII1Zy4p0sS8n5MSwnWrXv8y7oiFJvIiFy1yiCKs9QrXjDggP/7tljvd36TxXO3KkhCQDIt1Hq3xDBXr1e+vYzvWK2L0E5sVO0lUFjzw6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F5DC116B1;
	Thu, 18 Jul 2024 21:29:52 +0000 (UTC)
Date: Thu, 18 Jul 2024 17:29:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>
Subject: Re: [GIT PULL] ftrace: Rewrite of function graph to allow multiple
 users
Message-ID: <20240718172937.2fb3e91c@rorschach.local.home>
In-Reply-To: <CAHk-=wiJwzMR6mZ8=Mc4bhCA3qRdwo_7NEHU80mSWoaMLTFjqw@mail.gmail.com>
References: <20240716162714.48febeaf@rorschach.local.home>
	<CAHk-=wiJwzMR6mZ8=Mc4bhCA3qRdwo_7NEHU80mSWoaMLTFjqw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 14:01:13 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 16 Jul 2024 at 13:27, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Masami Hiramatsu (Google) (3):
> > Steven Rostedt (Google) (27):
> > Steven Rostedt (VMware) (15):  
> 
> So this is getting annoying. Now the company name literally means that
> "git shortlog" shows you as two different people.
> 
> You're not the only one to do it, but the list of people who do it is
> not all that long, and it doesn't actually seem to be a company rule
> since (a) you've done it across companies and (b) other people at
> google don't do it.
> 
> The company you work at does not define you as a person. Really. Is
> there some reason why this is happening?
> 
> Can it be useful to see where people are working? Sure. But does it
> have to be in every commit and affect things like 'git shortlog"? No.
> 
> Is there a company rule that just most others are happily ignoring?

I started this when I was at Red Hat because there was pressure for me
to use my Red Hat email. I only use my "goodmis.org" email, and that's
the one I use for my upstream work no matter who I work for. But the
company is the one that pays me to do the work.

When I started at VMware, it was company policy to use the vmware
email. Dirk for his part was able to get an exception for me and
others, but we had to add that "(VMware)" to our commits. It's a way to
show who owns the code.

So no, I'm not different people, but I wrote that code while at
different companies, and the code with "(VMware)" is to be copyright
VMware, and the code with "(Google)" is copyright Google.

Basically, it's just to show who owns the copyright.

-- Steve

