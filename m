Return-Path: <linux-kernel+bounces-256772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5425D937011
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29101F2363B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E10146A69;
	Thu, 18 Jul 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRIaBZdJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B6C145FE8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721337986; cv=none; b=JdVcJpkw4sROve5WYtu+Iw40oQy1lwTRV0XoKdrbvXsCasx/+VX+EKtaxue8Fvk5iW0GjtDKRpw9kUAqxOhQa8wLqiG7Lx3wIB5lRAltTaTP8eonESCFrgimiwP8W8YDcjfxgDIXgIrcgo/gD96J/19YJ9waEqp71AADA6g2me4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721337986; c=relaxed/simple;
	bh=tjzEC8o6KvAWZUwiYd4DQG7kY0GfQWDrCxT97eevbUc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DxHL7Qx3H7KOtDAYrSS8zV1/SO3QVhdV8W4V3HbLMqOw3yToxPrkeGAoE3r6z4e2GhkrxRb/VKbyVcIAsTaPBTyUrC6bnSwn/uTuYd5GyS1/yWryMBvB6kqEBvtDdGK52BMWzlJf8VY4aUbiGrfwaSweH35wO5j+6C+RRuPfzNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRIaBZdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60273C4AF09;
	Thu, 18 Jul 2024 21:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721337986;
	bh=tjzEC8o6KvAWZUwiYd4DQG7kY0GfQWDrCxT97eevbUc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DRIaBZdJC/KBiUeVN1F0ndTzAstooEq3LekOXYpitfrrixAQrp5Py4yJ4U+rcnbeT
	 jn8r9euc0fvcwPkFDlMGzHtmh9q2Xh8tNMF+bMbg3g40X/HwnzsWfEXU5P1IqS0983
	 sWESOq8+oKdYwmLcH70JdcK5XzWZbiCWE1fY4vcssGx8dyOWgKrnWChbWOszMGOirn
	 k3pNbuG0Mo/eisptoi38eyUOUrMYOtJSRYB5dmnSpFLvLHMKlRicSZaQQ2i7ijl6ry
	 DUmXjJQUlFUdSjYbFSbb6wVpnl3ak4Wo5mVqvF58tsrikgKuBsbrDN8ylIDTVtmUpR
	 652KUlwofQWew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 562B5C433E9;
	Thu, 18 Jul 2024 21:26:26 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Update MAINTAINERS file
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240717124927.6b4c1bb1@rorschach.local.home>
References: <20240717124927.6b4c1bb1@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240717124927.6b4c1bb1@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.11-2
X-PR-Tracked-Commit-Id: 5f7c72df1ba6ba00ee163ba4049c785ac5930759
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f669aac34c5f76b58e6cad1fef0643e5ae16d413
Message-Id: <172133798634.21905.17844840344707788390.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 21:26:26 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Clark Williams <williams@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Kate Stewart <kstewart@linuxfoundation.org>, "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, John Kacur <jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jul 2024 12:49:27 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f669aac34c5f76b58e6cad1fef0643e5ae16d413

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

