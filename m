Return-Path: <linux-kernel+bounces-182745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 149968C8F42
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 03:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A521F216EA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACFB101DE;
	Sat, 18 May 2024 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uch8Dhvr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09562D53B
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715997259; cv=none; b=tqVme4lPA8gKWI4OFTATHxKCn9r9+Htz1bZCuuj2nOZ/wlYuguzGY3mx+ms8yx0HOYqwu7lH+Vzld8kkqS4TqQQvttsvmivHb0zcFo7phuGEgL7i6oJy/7QFMGkaynSPP4mZuB7oQMyKAz+G44KEQzMCoowgCTGXexORwuwAPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715997259; c=relaxed/simple;
	bh=AM8xrssYYVHXz7Jh+QeNqp8Jf6wYx/jl1TkBOm3nm/U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aL9uZldyHwuelEiU216gfhZBmqJWq2dQhUAjQ8tKTZyrksiAyKKCPX50R0Q+Xr+rnV6c7TzJTwI7yvd7mRS1aEvlKys9FaIe6GLkY2qI4DnGWv7VtmJjTrrG8b73GqHlZd7S+eB0OIWDHg75BrYmZ+9zC/0T60y3xyuIDuunPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uch8Dhvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF262C32781;
	Sat, 18 May 2024 01:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715997258;
	bh=AM8xrssYYVHXz7Jh+QeNqp8Jf6wYx/jl1TkBOm3nm/U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uch8DhvreD3Kdj7PWsM2lam68dyrAjKmXwE7VxjKMGw8E7qeDXsteR7AXqouGiJpf
	 0P4CUAClRa5wYYWjx83oFzjSktequl/peBFTmgJixBI0sz1idPLN+hzO/flqbt0KEL
	 sDT2go97tuiBhSBEaeJEPnDtRVS4rzJy1LXoR1IBOfCbSHd1K39iLhi0X6Fd/jTvy5
	 ZHRQhjd/GVbTB3MDtw7eX+QAnzQB6fkAymlA0zJbWaXWRKdYsUjkj+LRSHLDsLQYUA
	 4ITdDX2ECwlxkR0fe+0u4+bWYyV8qTrzsYrSiYIkUfD4xAymQUVmtzuOA8iwVWWMLI
	 WIXCc3QW/YMdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D74ACC1614E;
	Sat, 18 May 2024 01:54:18 +0000 (UTC)
Subject: Re: [GIT PULL] probes updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240516095216.ac9a0fd13357450cc5f2e491@kernel.org>
References: <20240516095216.ac9a0fd13357450cc5f2e491@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240516095216.ac9a0fd13357450cc5f2e491@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.10
X-PR-Tracked-Commit-Id: 1a7d0890dd4a502a202aaec792a6c04e6e049547
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70a663205d5085f1d82f7058e9419ff7612e9396
Message-Id: <171599725887.22868.13083359122159037498.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 01:54:18 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jonathan Haslam <jonathan.haslam@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, Ye Bin <yebin10@huawei.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 May 2024 09:52:16 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70a663205d5085f1d82f7058e9419ff7612e9396

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

