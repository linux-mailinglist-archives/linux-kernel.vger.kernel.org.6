Return-Path: <linux-kernel+bounces-183002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F318C9313
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 01:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C6F1F21856
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0DE6CDC5;
	Sat, 18 May 2024 23:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyX7I3ir"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89E417555
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716075990; cv=none; b=S8hUwuK7rKNPk07Itas/czwfVTYc3I2EpIKMOlS9Ta8PQECicQYCjKhqRB/8XaO/uHLYcnk7fL/rA0Z0YECiE4b/ZfhcBun7QjO69iRSIFq2SFBSuBcFrPxuTAIN5/gw+YYtxToqhl57bmp+SX5AP80Bd4uJjBNTjjSuB2L8kK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716075990; c=relaxed/simple;
	bh=02oHHGYpX7gCVO4wWopmeOz4fGVeqAfovE7Q646SFgE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=al/mgT5H/3zoiDniOdkzDOc8LNFtB4lgDM8cY3jJxOXq2+pI/tuN3USd9uW1R+3JM9FHKODcuRFfwVlCFZiXO8vNd2aGxToJaOJFkRkBSxnP97Mh10PzJVxDO7pngW3i8sTNf9pExkCBwdbekVvXhhvfA2+oVvKp3Zc1VuYBU1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyX7I3ir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5028C113CC;
	Sat, 18 May 2024 23:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716075990;
	bh=02oHHGYpX7gCVO4wWopmeOz4fGVeqAfovE7Q646SFgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lyX7I3irqy+wnXesilHpXhLAYvqAdPdWO+ImTdEaP/Lxl/eRkIwvxG2bYfu/LBZpU
	 W7lR/dHO5f75fPCQVyqnrf7bd3F3oh4NoaCQbUxaCb5EdDjJtfAfKzKXS3RpeO9D7x
	 mJ/feqabiWrtUxXKFY7MbPuh/HceUfAjqKh4IlrH/EPYzXhPL2VZiyq3JmiVZvvyfp
	 d1Fyc17jMeMszwmb2ZYUpDu5n2GmqK5x9u7eLzsW62T/IechDt8PVX/hBZuqDWGz9K
	 Q9yT23nHcJUD6460YU3yII2bCoOVG/NJbAi2YL9RLH7VO5lGcn2g/M8BNa9ByKZuvL
	 W5qykkFm3y7eg==
Date: Sun, 19 May 2024 08:46:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Jonathan Haslam <jonathan.haslam@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, Ye
 Bin <yebin10@huawei.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] probes updates for v6.10
Message-Id: <20240519084624.dce1a405a42684189fb356fe@kernel.org>
In-Reply-To: <CAHk-=wiMwMviFKdSDyTDdgvapN0W9gFB-DH_1FDP3TDpkMOeGw@mail.gmail.com>
References: <20240516095216.ac9a0fd13357450cc5f2e491@kernel.org>
	<CAHk-=wgQ_MNipb2fOSDmXJ9tYko8OhzA0fPueR-kh6eYT_MbDg@mail.gmail.com>
	<20240518233824.360de206ba709473495f89d7@kernel.org>
	<CAHk-=wiMwMviFKdSDyTDdgvapN0W9gFB-DH_1FDP3TDpkMOeGw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 May 2024 08:55:55 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 18 May 2024 at 07:38, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Ah, and I missed to build it with W=1.
> 
> Note that I do *not* at all expect people to build with W=1. It gets
> very noisy depending on your compiler version etc, and a lot of the
> W=1 errors are not at all worth worrying about.
> 
> But what I do expect is for merge window pull  requests to have been
> in linux-next, which will give it at least reasonable build coverage
> from the bots,

This is completely my fault that I forgot to push my probes/for-next
and made a pull request to you. I will push the for-next before -rc6 and
if I forgot it I will defer it to next for-next.

> 
> I'm not sure whether it was because I built witch clang (which gives
> some warnings that gcc does not, and vice versa) or whether it was
> just that my clang build has a different Kconfig. Regardless, if this
> had been in linux-next, I'm pretty sure that it would have been found
> before I hit it.

Yes, I missed to build check with clang. I'll make sure to check with
both clang and gcc for release.

I'm sorry for causing you trouble and thanks for fixing the it.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

