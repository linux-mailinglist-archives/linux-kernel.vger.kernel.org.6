Return-Path: <linux-kernel+bounces-425031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A82D9DBCB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9301644F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824E81C1F37;
	Thu, 28 Nov 2024 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHj4fyGd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97F7A13A;
	Thu, 28 Nov 2024 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732823616; cv=none; b=hIsp2Dsy79A+ENuE367/8TYg6hjQz5bPyAfBPDDDRDcL6XzoK3VCECpgexFggkRY3VfHH2WQ3vmjFA+9GSwxQsG9CeOtY2k23BTRjrK4GdZDLOEIGgk2Ok7AgbekLWLR/8WNa4Ww/VQwoAq0h8xQikA5Sx1vQKhV6FBCitk2PR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732823616; c=relaxed/simple;
	bh=Qmt/nz98+rqHsEMS5gbyPXP+PsTIJLimH0d+6aVGy8o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WVhnwk8TZ6Yfe5ZttbEE1St+15mHZ0CErvlNSsiWDE3Q8mastdNRbwYf2TihCh4xw5TS1mGKBRlzknbsjioRKFqVFg7ioCCtH5Mb+agHnotaAe7/M0qz9AfXiO1ffB9NH/AlJubhQThQTTA3BULzmUyD2XhGVeqfaUg2DCYW3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHj4fyGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4513C4CED2;
	Thu, 28 Nov 2024 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732823615;
	bh=Qmt/nz98+rqHsEMS5gbyPXP+PsTIJLimH0d+6aVGy8o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZHj4fyGdqWSLw1UCJSYdRdX0bRttHjuVEjev9ju/CcTi82dbr4tubHfoaI/Kr7s8s
	 sTmW2PJvacyuTwAhiHxJm8fpZXpqfYpR1UzUTxxhOMbecUaWRICIzVgq1yeER/pP1I
	 yBvqyASqvLEqHtb/dtNgGXtvCmjRo58Vt9aFOfrUfWNSPerPry+N4QSdEuUaTBNss9
	 1pYJCDaZppRZ5+bVawa1XQQsIvnfaxcKynMcqt3IV9A6ZyuRzW4C1geLNfdZJThvmC
	 KMjsqn9Nw91oeaNArcqwitC8t3u81ICKr9/QI2i6jzr95DSLeKBEodBnszcf6VK+H+
	 sEUfhm3tgaDKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FC0380A944;
	Thu, 28 Nov 2024 19:53:50 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: More updates for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241127131941.3444fbd9@gandalf.local.home>
References: <20241127131941.3444fbd9@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241127131941.3444fbd9@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.13-2
X-PR-Tracked-Commit-Id: 2bd9b57d04df417f31ef54448477c212fcdd14fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7af08b57bcb9ebf78675c50069c54125c0a8b795
Message-Id: <173282362871.1836333.15239035598735973943.pr-tracker-bot@kernel.org>
Date: Thu, 28 Nov 2024 19:53:48 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Nov 2024 13:19:41 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.13-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7af08b57bcb9ebf78675c50069c54125c0a8b795

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

