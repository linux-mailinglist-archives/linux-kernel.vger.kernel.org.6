Return-Path: <linux-kernel+bounces-433871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192DB9E5E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B65D16D38D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B58226EFB;
	Thu,  5 Dec 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6B9Avha"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188E229B32
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733422891; cv=none; b=ZH5IzU2S5FkDkME8VSbt3lBepeTB/VTv+CmPIoB10CXV9ij0Uq+x1inF8iWo+6QcWaNvnXEMjjFC8/yYo+rsVNsh0nD5dl0ABQVDlygm0DOnNG2hv2XTgmorBTSayaAWNcP/yCqM0e96ss+5ZcnoVXoqFe/B48JCC3RfwH6BBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733422891; c=relaxed/simple;
	bh=Gnjw7HLFw23A9H55ljiMkrdj2YpshsgK2OdVJz1ACQA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pps1ZNHcJD96DGg8UG+Duvu0tEoOflSXX3bWQGmLqRzeJuun/1RSMYx7LxKbGaXFAMdsm3TWU2rbsuNMc10GFK/hpmO7qcSE/vt3nK3dt0RiCVa3+4Jl6gBGgf6foMmTT9PCMf14YbMqTh3jj9dX7C4chabc08OmEWu4uWJrgHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6B9Avha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88751C4CEDE;
	Thu,  5 Dec 2024 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733422891;
	bh=Gnjw7HLFw23A9H55ljiMkrdj2YpshsgK2OdVJz1ACQA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h6B9AvhaCTAvMuzm1QDg3/FfDRQaPpC7F3yVuWsgZTv41hHKngozuHa7kTIm+tQU5
	 4xPERNvP8RFmJfwOR57X2BwXfUoWpOuqekiTLrUuhayQVwdYiuFtPndhEv3+2PK0EZ
	 M6kZYnl1KBTqDvb+UPscUH4dCFCcnaIIEcCkDtzjPGVJV45MjpprdWBOTaXe7HDFIM
	 oMgQaWpjL0mjoTEe3SAQ32QhBqNZPIt87UyKv3tw/2nBW2RPJtU9fK9XcN4Xmxg4TD
	 vjIFuivre3uWFoguaYRP8kPg9K/VOB7B7oaem6W0N6kRoY9bBO8FCnIDiAcwVKeSKd
	 mIMmR87iY60Iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 82092380A952;
	Thu,  5 Dec 2024 18:21:47 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241205093724.16c2a14d@gandalf.local.home>
References: <20241205093724.16c2a14d@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241205093724.16c2a14d@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.13-rc1
X-PR-Tracked-Commit-Id: dc1b157b828dfe412c776ac1dd8db158f6016b39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d6a414ad31e8eb296cd6f2c1834b2c6994960a0
Message-Id: <173342290636.2016621.1519670400793154942.pr-tracker-bot@kernel.org>
Date: Thu, 05 Dec 2024 18:21:46 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Paul E. McKenney" <paulmck@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Madhavan Srinivasan <maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 5 Dec 2024 09:37:24 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d6a414ad31e8eb296cd6f2c1834b2c6994960a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

