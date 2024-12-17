Return-Path: <linux-kernel+bounces-449656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371A29F5365
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0029E1892948
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577621F890C;
	Tue, 17 Dec 2024 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t99FsCUW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ABE1F8901
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456286; cv=none; b=RW2e/H4lIy5pJK2K2WV5OwqHjQtvIfS1hPIw2MTUik8A7IMi/8/D9NtHLUe5SomqopfWV1iF0mQL+EgqUD0Ym89t1KlKMu1XQlCmhCB7ymenPuY9By2t58DwBJY8d+1+I3S69Mg2gVntFkDbMchsXP7OciXQbBu7A9LKwAkhLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456286; c=relaxed/simple;
	bh=4ziRd2iQOLilowhUX3cp42/nEahcRy6ChBBUEockPuM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OBjHFC2ZP7rQdiUHbThbrlnIuRJEq0om3HzaX4D/TjZ3sQot+1TJB/D2I8UzilAPcnl+ZaQZ5iRleOG9XH3oB/5WytS3T6NtG0/t8kgyHWzlS3erzgiAj92ayk/icOrwHKUXood5kivll2wj64deEvcqxZJ2oOzZ9t7rAPWtu6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t99FsCUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80957C4CEE2;
	Tue, 17 Dec 2024 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734456286;
	bh=4ziRd2iQOLilowhUX3cp42/nEahcRy6ChBBUEockPuM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t99FsCUWsAv027HxcBzEBJvmUjcGtF2+JI3YTAYBNUkwPuC7mFvsKFrfTeuojh2zS
	 TDKdAqpkV5/W+muQ5AFi199fotsr82foyFGHsGx/cCaqTA9TJg3k+xz3OPpAbPbCru
	 EETpH0Qp41S0paTUcVcVtofbMayYv9QRwRS54gi9pPD3fepFOlRWFfGnQFMTmMigzm
	 kuzoZjdO5Wy8kUg8+z5YEZUcPXEIvYWZEAgmn6fuJFRrdZ9IYgvMFn/8kqBGZZTCt2
	 ivCGP+eMs+9aAJ1K6rfwcxGXbfQmKASQ2jbbANk3pcRHg+NL5hILPoCVGwsOyHd+wc
	 QuAWuQTrv8UEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFDB3806656;
	Tue, 17 Dec 2024 17:25:04 +0000 (UTC)
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241217113921.7254325e@gandalf.local.home>
References: <20241217113921.7254325e@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241217113921.7254325e@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git ftrace-v6.13-rc3
X-PR-Tracked-Commit-Id: 166438a432d76c68d3f0da60667248f3c2303d6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5529876063e110ea49326138149fdf2a28a484dd
Message-Id: <173445630358.974395.8190501260310878409.pr-tracker-bot@kernel.org>
Date: Tue, 17 Dec 2024 17:25:03 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro <viro@ZenIV.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Dec 2024 11:39:21 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git ftrace-v6.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5529876063e110ea49326138149fdf2a28a484dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

