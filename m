Return-Path: <linux-kernel+bounces-182746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226058C8F43
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 03:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18DE283407
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300B10A1E;
	Sat, 18 May 2024 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2f5YGt7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE6DDA9
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715997259; cv=none; b=kThjCIDYPJjZUn+u8S2h+RXifCpO0qXi1A86wZvJhKn4J4lM2AjDoFsfuHrLrm4Ltq5aCKewdfX8yFM9kxqIxHXEH4TJz66eeBYGbnED0gcXPmBj8OlbxW4cFbz/58r5xr/NKrHnQ01tNvsG6ZBO5+EM5I01qRhpLlkV/CU3AA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715997259; c=relaxed/simple;
	bh=iRBoLZYQ40jdgmtf/4yDIGES3WLAaTI2Xkf/jw8v9E0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L/4CxM5i/MRBeT5nzvE+m8VMfYo74psufpETczuTiyQ8ez1QAok2l8L6INPqIr7YMxD1NFYlrw38acjtZxOWZjC9i6qzHU6IRUeKBV+MTytHdo9wj4HVhBKlciBSRbZUclO3nvjhLxB8zJX+EdK4DKxAfiXaNI+hf5w7b/TwfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2f5YGt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 226BBC32789;
	Sat, 18 May 2024 01:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715997259;
	bh=iRBoLZYQ40jdgmtf/4yDIGES3WLAaTI2Xkf/jw8v9E0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=b2f5YGt7FnKcf5RpYOYWe/b4VYEfpYZCOT7qNWtN/aSMY6Yb/E20WfokqMrBIOQmy
	 kE5xxhq/8xVXJc7dM1uPjmepG0GaaotlJ8/z77OLOhWrWLuIYVtHK7HyTpW6xpGlBs
	 2ZnuhcDl4T8m6Sxj6zSh9HoEjC2f/gY/dAvixPyEJ9Lmrf7/JPZbhB0XZFtmbTJVm8
	 ZDc31aiMnSRbLI9U+EpzgxjFFTO86M4CanOM2kQodlr0AYdRrljrVwEzIqbVK2maVX
	 MH+lX9U+d1uKKvLnNn168U29Wkx0Ak5YIrQJosYuRiDJQIAbnL9ZvSK9XD78T1PSzd
	 CPwntPVG/1Hrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A8B8C54BB2;
	Sat, 18 May 2024 01:54:19 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Cleanups for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240516115449.32d6f2b0@rorschach.local.home>
References: <20240516115449.32d6f2b0@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240516115449.32d6f2b0@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.10
X-PR-Tracked-Commit-Id: d4e9a968738bf66d3bb852dd5588d4c7afd6d7f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 594d28157f2d55c4f17f2e18c778da098446e594
Message-Id: <171599725910.22868.243595810768526396.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 01:54:19 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Hao Ge <gehao@kylinos.cn>, "Paul E. McKenney" <paulmck@kernel.org>, Thorsten Blum <thorsten.blum@toblux.com>, Yuran Pereira <yuran.pereira@hotmail.com>, Zheng Yejian <zhengyejian1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 May 2024 11:54:49 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/594d28157f2d55c4f17f2e18c778da098446e594

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

