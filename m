Return-Path: <linux-kernel+bounces-257688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C035F937D83
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E491C21478
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF4148837;
	Fri, 19 Jul 2024 21:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSWo4BE1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305601448F6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 21:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721425186; cv=none; b=d77+Inl+kRpKO8xCHfFCY0CWswa4HIDrqbv7Sp3DBymV0h7ja1uhbXLYx/pJVS8pcsThPE4DN0X4zZfO6W+l0QwJQMvrERClVtPi5qQSj7ojQ/lFhye7LxFbuwqfvFK7h6zrp7u++58XaRgydK1B5yEfoG2GfOjbHc0UMQPn16s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721425186; c=relaxed/simple;
	bh=BPBtUPhafp1IWkuobsT2iC4GTV9BBKtyDHlLLR7mHRg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U+POgbj4QWxW1Ym05rqJ3srjfBAhkAGWVS/8eaKPXMNN19nPqIQUL4vDa+P/fT09WQ0SMI+4pYzOtJrty1FTGlaeJzbQBpJxvRbYu0jTX90/2jYfKKNKQmNc6XRs3C/YEEu0qIdP7I2/ZzSyt8R3cHh0y4VnUQuo+bzeRFc6KFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSWo4BE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05D11C32782;
	Fri, 19 Jul 2024 21:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721425186;
	bh=BPBtUPhafp1IWkuobsT2iC4GTV9BBKtyDHlLLR7mHRg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uSWo4BE10V2mstkqJbitaFWVnJFR0gqlcR9++UWn/BngAMocpU3zLXnbDXm75Rl/V
	 +UbqpQ3Huf4h9fJvQkiSU4ddZ31CMkfOj7gJtvgaaN65LeOhEt23EOeaA4DWfevowS
	 KHCngZJ/h5WEefa8rhGSaiLUOLaAQA9ZrfDg1i0zYQJzBQDWuDf8J1FZ7bd41s4Z+W
	 aoPXd9lk6d4xetnQOFyvcDXBGEF9Xwf6hvlb/bI4GOD3lJ0NAO2KV3feOD/KXB6K4r
	 ilEqqeBNGzPL9WHwuoMsHkabDUp+nBIZf3BEqS/pmndNinv8fIc1jD8XBZwl56euGX
	 5u1nhfejvF3aQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED11EC4332D;
	Fri, 19 Jul 2024 21:39:45 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fix for v6.11 pre-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240719192238.96266f98f6b96cccfe3fb038@kernel.org>
References: <20240719192238.96266f98f6b96cccfe3fb038@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240719192238.96266f98f6b96cccfe3fb038@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.11-pre-rc
X-PR-Tracked-Commit-Id: 5c28424e9a348f95e3c634fe2ed6da8af29cc870
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33cf098770930a9b782d3983e1b0127bdc203216
Message-Id: <172142518596.30667.597252804388031939.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 21:39:45 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jul 2024 19:22:38 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.11-pre-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33cf098770930a9b782d3983e1b0127bdc203216

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

