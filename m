Return-Path: <linux-kernel+bounces-256828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 764389370F6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214071F2231A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DAC146A9D;
	Thu, 18 Jul 2024 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoHzmerQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95089146A77
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343975; cv=none; b=t6r5/c/c+OVTIPuMbGcFiOOb7C/QtzSyQNeYoV1a5awJ2vjSQUdsnNsYl0NmcSGjkjS2P/sC3xAhjAYgANd3i7xl3grNKBYR6XGRT53ygZE1DzMHoPRlS+fh8YhKhA939XECjPYr3h2tEZ5PcvaqMmmk43kwI6rgQirC5X12+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343975; c=relaxed/simple;
	bh=MyWdNR9RmGfI4qiUOIwLW0VMtyuNYVQJPBpLkQ5Dxbg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZVjMxCa/nws5/wm4rZe9W/2G3KZbkbOxbJrZmOQQWMaPZb4tiNNt8atntorSjDWcs2YZ6KYlNLLXu4/O45C1d+xb7J70iOaDggjFWJ7+3oXcF3ulLcAX8lIz/2Ib/07b4arsX6vG0uggBZr9T8ilYEd4htrH8CaYcH667qAK8qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoHzmerQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EE1DC4AF0C;
	Thu, 18 Jul 2024 23:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721343975;
	bh=MyWdNR9RmGfI4qiUOIwLW0VMtyuNYVQJPBpLkQ5Dxbg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CoHzmerQJCCeNSTt0ZwEyk2oN9TQXPaXzCYGsqVY1E+BERqNW6VJ8yyzFP4zBvrCV
	 bsOiZl2JoGeppOaVTPPoRuA3J9JjZA4NvrpiPZZA/fcXq+vy/SGJVj3lR7bydAUQGh
	 T4Z+KtRpQ3BMlsiIW1MooEoySRdab5q1GyxwOZOPqor4jMymN1edPJuBqRAUET5wKo
	 O3dTXdlbr3n8tOoVQVjJ7DNdUG9OMip+AFwZhDxtnqueC0IQjpoE4k7nQvrkUfMngX
	 ncTZ5ZDw0MQRJKv0t0nz9pDNGFN1AK06RfNdvyAVzeZDPeCfr3KZKrYN5yn3qxAU+w
	 Kr/oeXvGqpyZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F96CC43443;
	Thu, 18 Jul 2024 23:06:15 +0000 (UTC)
Subject: Re: [GIT PULL] slab updates for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <746087fd-993b-47b3-99e4-9bd4d3502e71@suse.cz>
References: <746087fd-993b-47b3-99e4-9bd4d3502e71@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <746087fd-993b-47b3-99e4-9bd4d3502e71@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.11
X-PR-Tracked-Commit-Id: 436381eaf2a423e60fc8340399f7d2458091b383
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76d9b92e68f2bb55890f935c5143f4fef97a935d
Message-Id: <172134397538.16085.14418182446287683289.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 23:06:15 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kees Cook <keescook@chromium.org>, Chengming Zhou <chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jul 2024 12:49:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76d9b92e68f2bb55890f935c5143f4fef97a935d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

