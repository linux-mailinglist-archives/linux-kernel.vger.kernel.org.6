Return-Path: <linux-kernel+bounces-182749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633F18C8F46
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 03:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5FD283430
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FA71BC3C;
	Sat, 18 May 2024 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbkOlYIh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B10A13FFC
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715997260; cv=none; b=VPejHTHDLuEwNViePFv81lqnXYU86JUXclk1AyM9VahM6UCfPM2XgXLYm8avRQ0ApDauB2Y0jZ+2nExU8ng79G83XbVwdYsdbPfC9/U3TumtpHnASxHLRsTjMPRqxlO1yvy1+sDxljNs9EXmzIvMu654KTMjt4dDGfkCxLeetw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715997260; c=relaxed/simple;
	bh=2B+yx0CoABpHTCCoTx8g5BMc9AMcJ7kCLqo9ZvYe/xA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XMojRWJ0uGjp8xDRW/J6XpkpXwFGpSmxxg0lZkrnhUbeZRfFY3ZSlRdE1shYEP83ROucSRKRUohqzWuwtn3ygFG+47JuDCX8eNwORW8Ky5qRIOl89PrPiqROWKFeuhczrTbS3M3MEQJT6WfF1eQjTqYQk0EDDPOdbDbWLstX5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbkOlYIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E691C2BD10;
	Sat, 18 May 2024 01:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715997260;
	bh=2B+yx0CoABpHTCCoTx8g5BMc9AMcJ7kCLqo9ZvYe/xA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CbkOlYIhdosPB2dcasDx8OqYIM7g2xZzJSvVeKCHVouERtdTC3zUD5QD/UcjzjbYe
	 OIDs1kGfAGoxjwa4zkfWF0m5V/yU6vWG1Y0Se8t2tx9AT/iyUWaewx3bGKwPLb7Iuo
	 om94dz+VyrygHj7er51fZYqgKNLBFGSI15Tu2EDdLERla8Mu5cdTX7j+7F+uDAhhAr
	 6+g+4UxP7XWMCAlhZUe1aVj3IXqbKPc056O/ia0DaPxY4oXwWO/oIggP9WhSj0ZKAF
	 RUWnB+1UP9mFRzjOWa6NLlyiSkplS+gEYJ14q7fuaXfscpt8gkbCLWoSYASjmvpWtd
	 EpvlUIOzDp7lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27E94C1614E;
	Sat, 18 May 2024 01:54:20 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/tools: RTLA updates for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240517141247.0ec1242a@gandalf.local.home>
References: <20240517141247.0ec1242a@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240517141247.0ec1242a@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.10
X-PR-Tracked-Commit-Id: 59c22f70b2951d81de410d477ae536ba951b4f37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26aa834ff2eef00a863a64b1a94a5a88a94eb963
Message-Id: <171599726015.22868.4902334593735869635.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 01:54:20 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Daniel Bristot de Oliveira <bristot@kernel.org>, John Kacur <jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 May 2024 14:12:47 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26aa834ff2eef00a863a64b1a94a5a88a94eb963

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

