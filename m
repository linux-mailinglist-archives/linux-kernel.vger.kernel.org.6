Return-Path: <linux-kernel+bounces-421782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5C79D9016
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F157289A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8768618039;
	Tue, 26 Nov 2024 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwTJYnB/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78AF179A3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585280; cv=none; b=ivf669x0G0H+7cq64ekbMeqPWVyzyTeUe4A6HcuqWD0bRHMbu6MSEuDqZBosJho9ho9MKkvl/KEAKRjb92853e6XMdJVPlKQFxzzbVTpaJOvF07vidxb4pNPLk80ZMQ51AJ1OxrjClSOMrJUr7ZOkgnkpn9lpdZZu+DVDsH+wME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585280; c=relaxed/simple;
	bh=C/lFpQ8Bh5jJGUtdmbzWkKDQ2RvBt42YgCeDkGPAphA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PfjtMA8/320V4Zt2evAHqNwKPupX4cqz3YvZQ3lqSVP2ksyh6YY9oRSFCcyw4i0LGeEbXsgDmt5r6LwoejHwgDOPMipzw7xQht8bUqZgrhBmTArl/SgqYXrbjYSGBrkZ7zOHD8uI4JBAmkuPyXp0cAFP6zqvYHKpXlxlSJShLmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwTJYnB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A96C4CED2;
	Tue, 26 Nov 2024 01:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732585279;
	bh=C/lFpQ8Bh5jJGUtdmbzWkKDQ2RvBt42YgCeDkGPAphA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GwTJYnB/6gscHCmKo1EeNsJWqqOWc/IoD+gBFmvGM8ERhWPysTso0YBkSUrC7awxH
	 x183cQEnQRXOwobL9yCXQqSI1+0V2wQOYmoYZ0c/oBtEBU+Pen9zYVguMNT2fAu9/u
	 SOKKmkDPM3sV8IbSKL3cNENna8iWjtbiSUerWCvD7V+Gebo28c+qmkj7evjyZcN40n
	 3Y5VPOVvkuUHnym7TdI1ZL5x7h0ycsfJdLy4/BHYMn3c7TmjAXFtERHpsAsqaB8QFD
	 Vc7JtWRNjQDqIUdVj2Oo9XtPv1gvmDbMzoZDs8zQYso5D80un91Zs7C8SyzlFwTRtI
	 4cK8BzXYvowzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEC8C3809A00;
	Tue, 26 Nov 2024 01:41:33 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Add Rust support to trace events for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241122151054.7e60cbb9@gandalf.local.home>
References: <20241122151054.7e60cbb9@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241122151054.7e60cbb9@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-rust-v6.13
X-PR-Tracked-Commit-Id: 8af7a50167833b6b22e30c008bbf95ab3ff1a5fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f4f3b14e8079ecde096bd734af10e30d40c27b7
Message-Id: <173258529236.4103683.9832252242652447107.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 01:41:32 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Nov 2024 15:10:54 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-rust-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f4f3b14e8079ecde096bd734af10e30d40c27b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

