Return-Path: <linux-kernel+bounces-527450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830DCA40B69
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A058C3B014C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0DA212B0E;
	Sat, 22 Feb 2025 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6IushUw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3FD211A19
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740252164; cv=none; b=oumRRIyzyQtGUOOOk1w/+iWPCyKYsurxqMV12pxaeSuiOFVSuKEE0GY4fXiayT1nZzBxF/eXnOS1BlMAaTWG2c9GuTJVpHaEm5LQyLd9yNiCOxQ2OSAmtHBscV9yispDk24i7blcKHY3snSiAarMxnpSKj/vkQasxb5JyEB/74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740252164; c=relaxed/simple;
	bh=uWEwaxsz2WjvPm8Sv6Hxt/do/y0LLBJsP1uxLNFCEAk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FRAOOeBnrHbK6VSpK6wAchbzA/kU0NYqvzkAFzVBbfO1Qor1+alOyW62jMD5Ao6cE0H1E6XNYWK+RAH12tz5sWPrGaATgEqPziq0k9g1vgwPJu5zieQftD0xTYuQTQlC610aPo+jqYgK4DUF9xDSXJIMHfeYTQumTy1weMxLzPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6IushUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8828C4CED1;
	Sat, 22 Feb 2025 19:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740252163;
	bh=uWEwaxsz2WjvPm8Sv6Hxt/do/y0LLBJsP1uxLNFCEAk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X6IushUwmDUUQxuZACH7NvzVNWIYGLlCGO5FCTNb8jRkxuW8E2yx1vMcl9F30LFPO
	 sL6AP1Gd50Pg/9pmfi8NKgO9546GMD255/m7/oEdsAOHPZHCjrCQeNevE0tW+qFxJc
	 Rf6OlyoEWEKyFc0QDL7elpAM6YgT0dEcB4fkYCUjja2GYY0YUfufGCnyXxr9DmS6Od
	 4D4gtyVF9GpR8sPfG79c0T5s5YDiebXMau0X9KusyIvnNYnp2D8bbu4cY3BOXqT/I8
	 njU2mZq9Y4PcsU2lDoRSCxsGPBKIIctn7CdIJcA4bSPXz/KvrFiHcF3sq6L10MDq7o
	 W+qL6/pzipnvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DE7380CEF9;
	Sat, 22 Feb 2025 19:23:16 +0000 (UTC)
Subject: Re: [GIT PULL] ftrace: Fixes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250221174250.31f75672@gandalf.local.home>
References: <20250221174250.31f75672@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250221174250.31f75672@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git ftrace-v6.14-rc3
X-PR-Tracked-Commit-Id: 2fa6a01345b538faa7b0fae8f723bb6977312428
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8c8c1414f6d585d40f5432f36a75509737c8a07
Message-Id: <174025219469.2429034.10303011806459780990.pr-tracker-bot@kernel.org>
Date: Sat, 22 Feb 2025 19:23:14 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Adrian Huang <ahuang12@lenovo.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Heiko Carstens <hca@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Feb 2025 17:42:50 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git ftrace-v6.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8c8c1414f6d585d40f5432f36a75509737c8a07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

