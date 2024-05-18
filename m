Return-Path: <linux-kernel+bounces-182896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE678C9174
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 16:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557501F21947
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351C14502C;
	Sat, 18 May 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnhtibUk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DF645014
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716043109; cv=none; b=Wlj31DMND1QUYyzb2xUguZQ1my9nFpZQPTChwsfYatSmobipIRCvRmW/Szd5IqFAGyO5/aZZVaoZNpQZ30sq16Eybci2qpcEnYyLRPmu1HB8kWzVxuqvmn7c2CunBAVE8EQuVL7IxfDaoU8BCMkdXyHVLxCySAVdfmW/K5IRRG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716043109; c=relaxed/simple;
	bh=cnj/7U6zgoQWAj8/IxfbO4M9Q619934oePW9MUg1IyQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=feC5EtI++zvmyuTqTqkZ7YGGm03Tvk0jhL2msi/i1/b5ZE/ZOMX+0X8cwz+0IRlfrMs4ibpZAFK2nwn9wEJQiPrHJ7SfuMjQCpMxE4uygZ4xDasFcyssGx0TJtqRjuBrYBqJBfkhG/uQKouIBMwa9hZvKrRosb8WL6G71U9vNik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnhtibUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96312C113CC;
	Sat, 18 May 2024 14:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716043109;
	bh=cnj/7U6zgoQWAj8/IxfbO4M9Q619934oePW9MUg1IyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fnhtibUk9ZFi9eJ3owVxvDca8KLdIdoEHJlvKktuCf5nO2VFl3iy6FvddacZuDAM4
	 T79iFyvPLWWTqtYbwLqgLtEjI9k80rClUNB68sNbVzknJ4qCb/KBcZH+fBI5ipDHFD
	 aHgsDFAY22IXMI9CbeMlZqCkXajn0BGawm1CKjdSzoco5FHXwbAlLmL1B+6UAbuCpc
	 2sZNwf6QBylxojeWdnmVG8Y/gag5ZzAEHmgrTW2jvSYkcsbnCnHbjEs7vbuLob0Y6i
	 fTweaALPovSAyTDjyvwcSu7+b82t1c1KCFy4yPfQtjWc6umJUzi6dOK5XfrGnfHsfy
	 35SJeBmlDtohw==
Date: Sat, 18 May 2024 23:38:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Jonathan Haslam <jonathan.haslam@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, Ye
 Bin <yebin10@huawei.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] probes updates for v6.10
Message-Id: <20240518233824.360de206ba709473495f89d7@kernel.org>
In-Reply-To: <CAHk-=wgQ_MNipb2fOSDmXJ9tYko8OhzA0fPueR-kh6eYT_MbDg@mail.gmail.com>
References: <20240516095216.ac9a0fd13357450cc5f2e491@kernel.org>
	<CAHk-=wgQ_MNipb2fOSDmXJ9tYko8OhzA0fPueR-kh6eYT_MbDg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 May 2024 19:12:04 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 15 May 2024 at 17:52, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Probes updates for v6.10:
> 
> Grr,
> 
> This doesn't even build right.
> 
> Yes, it builds cleanly in an allmoconfig build, which is what I did
> before I pushed out.
> 
> But after pushing out, I notice that it doesn't build in more limited
> configurations and with clang, because:
> 
> > Stephen Brennan (1):
> >       kprobe/ftrace: bail out if ftrace was killed
> 
> This is no longer valid C code, and hasn't been for a long long while:
> 
>     void kprobe_ftrace_kill()
>     {
>         kprobe_ftrace_disabled = true;
>     }
> 
> we require proper prototypes, not some ancient per-ANSI K&R syntax.
> 
> It turns out that gcc apparently still accepts these things, but it
> really shouldn't. But with a clang build, you get a big error:
> 
>     kernel/kprobes.c:1140:24: error: a function declaration without a
> prototype is deprecated in all versions of C
> [-Werror,-Wstrict-prototypes]
> 
> and the reason it didn't get noticed in -next is that this commit had
> apparently not *been* in linux-next.
> 
> Dammit, that's now how any of this is supposed to work.
> 
> Why was this untested crap sent to me?

Oops, sorry, I missed when I built it in local.
Ah, and I missed to build it with W=1.

I appologies that and built in W=1 build test.



> 
>               Linus


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

