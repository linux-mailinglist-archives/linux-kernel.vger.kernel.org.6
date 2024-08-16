Return-Path: <linux-kernel+bounces-290216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585829550D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B87E2B22ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D80C1C37B3;
	Fri, 16 Aug 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDwWCvoh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45421BE258
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832902; cv=none; b=OtAbLQopSJ8bL0lZmbLtdARLyEs9FEY1OQEkmZFzrJM9wIL7j4/SAFBh6MtOEX60IIeva2AH8M7ovTUaWy4J1i4Nb4W2ji+ijaZO8G9gUZT5QMXzZQtaBZGcEuCrvn9pPysfYOi5RMWMh0JZSjdGG53RNOMiOlIcaE0gbR2JETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832902; c=relaxed/simple;
	bh=eOvgDUk0ca4xYcCVfjW9DBcJcoEOeGVeWZl1ibAwZMc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fmboMU3k7wiT4NAi8+BNLn5Wxk+Bzm1NYuD3Nv3SNCC/nxamrvXXqkTVuSy9TRU1t3MfQ0szD5V54RWDrWEnmFhx5WDG3xk6d6ID99KT8vb36O/4sbfhflvgDqILLrHTE1Un7u6HM+apVVXm1SoLAeLl1Y0xTsz+bCuHRiZOGpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDwWCvoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5D3C32782;
	Fri, 16 Aug 2024 18:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723832902;
	bh=eOvgDUk0ca4xYcCVfjW9DBcJcoEOeGVeWZl1ibAwZMc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LDwWCvoh457s6r/jBomfb0GzapVkCBSu48te2fIgx6172zpBiUWaaUZFsuc/yt0At
	 +IS42go1TN6enB9fqF8e1wWsrsZvtiagnfx/SH3hqXvDSsNOWHD5SFfe0NeYq2COhk
	 N2yOxio7UJ6n41qjiUYNhPwVN6WapTYEDcr+rmFamX1Ld772/ctzqykKPkgL3aqX//
	 fbPnAef81aiPXTGR4MtFFlOX2Gf8NXRSIZBjabl1y/wGSBVYgpaMh1+ToSrgHzzgkr
	 3or3nd5URikLhLPhh2Aa/9QMviKUex2n2B/j/45+YKLsMznuRsBZ6f1yReaSlyl1mg
	 FHCXjM8SmnQpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2A838232A9;
	Fri, 16 Aug 2024 18:28:22 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes in RTLA tool and reading the ring buffer
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240816102305.08d91865@gandalf.local.home>
References: <20240816102305.08d91865@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240816102305.08d91865@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.11-rc3
X-PR-Tracked-Commit-Id: 90574d2a675947858b47008df8d07f75ea50d0d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a621e291000c3756c353c5671ade4837ba68e3e
Message-Id: <172383290155.3597757.9836189254232002989.pr-tracker-bot@kernel.org>
Date: Fri, 16 Aug 2024 18:28:21 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, John Kacur <jkacur@redhat.com>, Juri Lelli <juri.lelli@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Aug 2024 10:23:05 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a621e291000c3756c353c5671ade4837ba68e3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

