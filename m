Return-Path: <linux-kernel+bounces-192849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C588D230A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19DC1C22EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00DF16F278;
	Tue, 28 May 2024 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMkn9H34"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FC016C6A0
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919720; cv=none; b=hcRjTqFRWVGP5aDNBmIJS3REMRI2U7S3a87Mx+z49ohrkGGw/cD+0sZyIzGodQ+o6cJPWAJKSpbvUoVEZmYNtxNZV9mqI7vpq1SLjaW8WP4LYX1PdVlS42rYWLdOwW4KKKKBL7dtXt4FxcImJ8jDKZ1gMFQO6mUw4Cyk7elCNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919720; c=relaxed/simple;
	bh=rmjurXzbeNZNTtotMr3NUxcn+wStWLd/j6kZtSeTBpk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AFsdV0YM0gpvxpMuGAQp6TQ7tzWpM9R7IfIj/DjppMsUdIOjY8XiQySLFF+7BPoMab40K34lFOL2Az35vqIPhC02xsnf8zziRnTZ9lvhYzAJC98I27GZ/ZeNhlkIb3Y08q3hTTdxegTBWsYbWi7dDYCowieXKT8YmmrSj1Sn4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMkn9H34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58DD3C32782;
	Tue, 28 May 2024 18:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716919719;
	bh=rmjurXzbeNZNTtotMr3NUxcn+wStWLd/j6kZtSeTBpk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IMkn9H34t6b7E/YGUxDvYuOMe/A2Wh6z3k9AxN/Xf4Rm1NnSF4Tz2wHNF0akh4rWD
	 yoLxaBFPrdiliR0k19eXvPh+PPX8OL/1cGVh8UbhsjkfoZhyC6y2YFGQ9S/zzWOLxp
	 BAnOgGxXpTI6Ig4aAHjRCjrtK23XTbma9VsHM5exATrEZKNBKypngQ5cWeCJ2/X2uD
	 gFZIrzJJSUW24QPmIgZ+DIBavCYNUMHbw09kEIxU0rJHT7Uc4SMwYY4mj4vyaER3V5
	 +7ayyUwwvxIUrziwrhDKS8og5Ueruf+BZx0DaKxY3ReMitm+qOuna6SzHh33PhSHAQ
	 oDAGVBL8hdnUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F88EC4361C;
	Tue, 28 May 2024 18:08:39 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240528081044.aa2ad32fbec8e15e2144d5f4@kernel.org>
References: <20240528081044.aa2ad32fbec8e15e2144d5f4@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240528081044.aa2ad32fbec8e15e2144d5f4@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.10-rc1
X-PR-Tracked-Commit-Id: e569eb34970281438e2b48a3ef11c87459fcfbcb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d6bc6a2b1e15c64f670f93a472ad310953188b1
Message-Id: <171691971932.25401.14087089708161143976.pr-tracker-bot@kernel.org>
Date: Tue, 28 May 2024 18:08:39 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, Carlos =?UTF-8?B?TMOzcGV6?= <clopez@suse.de>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 28 May 2024 08:10:44 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d6bc6a2b1e15c64f670f93a472ad310953188b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

