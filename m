Return-Path: <linux-kernel+bounces-187953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E68CDB32
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 767A3B23644
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B6984D34;
	Thu, 23 May 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYkh0PFQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5453584A48
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494570; cv=none; b=uoH+4bznpBtEEWMzg7Vj7e2nMi/ljhEpqAVqCJn7r5pr74zeRQHPvuz+3U0ComhZHxo4v9lNRVi9LvYFU2HtlS63fCtdIHRh6YqAjI8zVcm1WNL5FCxdIWl9geRadWd4sVWm3ZN02Y1wLdG/5ItmIesXlUOl5vfy7Xf9Qv9EdCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494570; c=relaxed/simple;
	bh=q+ZBbTJifV/LLgZEiPvBP8bass4cqbesaOylCX4qpWI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PEsTSzPCnE3tYO7RHEMFYsTzMggfu4o+h4yDL7sr2eVeqwqawyc20/gqeq/mOZ6OVU5RWGAPIWRb3gSCOUOyamRuDP9DDnyIq4r0HFHRURYHV7ZvqYGgZFmRsQCU7GyKyDIy+BRqNyYzWW3rAYCmCnFur3CbuJatf1dwTyBdiBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYkh0PFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A175C4AF07;
	Thu, 23 May 2024 20:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716494570;
	bh=q+ZBbTJifV/LLgZEiPvBP8bass4cqbesaOylCX4qpWI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SYkh0PFQGcNjH8Evl8WM3etsF7jmjIoU2z5OlMtqcm9/B1BraXIej5uqoJ94/5rNy
	 k8K6f1okApxzsCI84pRIK3qvH1i4jkgybaRSHLbcpie9OX9TOxn+wI6yw2Eepffp/w
	 Lm7/7v7rQGgysIDvbuVd/sYBcEoo5RXKvCLM3UZpvI+k0mD4u81/ZGpofd4BPGYMvi
	 069Te15juOWl9l4ERkkQSuyUlxbBdNoWDCY7W3hPNbDlGkrcYE3ZRF/GvWO9PEDSzk
	 Q3ici6itK3qpukZ7Pyif4s+vSQHzXdyNIb4cl2Skq0TssBXJHKboh3/M6m9/25iZDU
	 nwokewg9N5NZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EAEDC43617;
	Thu, 23 May 2024 20:02:50 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Small last minute fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240523123640.0316a063@gandalf.local.home>
References: <20240523123640.0316a063@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240523123640.0316a063@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-fixes-v6.10
X-PR-Tracked-Commit-Id: 1e8b7b3dbb3103d577a586ca72bc329f7b67120b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 404001ddf3e40369510a08b8b7e895c2da692b79
Message-Id: <171649457012.26887.12610862740684296878.pr-tracker-bot@kernel.org>
Date: Thu, 23 May 2024 20:02:50 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, Petr Pavlu <petr.pavlu@suse.com>, Yang Li <yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 May 2024 12:36:40 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-fixes-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/404001ddf3e40369510a08b8b7e895c2da692b79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

