Return-Path: <linux-kernel+bounces-325501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E55F975A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6827287C08
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89CD1B580E;
	Wed, 11 Sep 2024 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+HJP53X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1786017DFFC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726079480; cv=none; b=mQlFpKOWF5Xh0LjMv1vAMqupY5nQiH4ZLbbu5J4QhshU/Zwu0If94OxP8PC8JaClpZG+pEeN2r8RbmS/hVMCg/RSJ+/50M+ngydE6J+SrLDL2nDKLwuZDrESe9bQB6ArFFpEjnR88nsbxj/TkG9XnfoPSHI7DDoYtNIlkMLxo+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726079480; c=relaxed/simple;
	bh=wYdMPCBeM6pJtikS789C/Z7rTGYd+wA+3VtoQcCdyxg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=szSUMmtysNbzurSaGI87Cq+4MwlpTzJjZI6NCS969waOrPKT6TU0Jq5PSliBksE/R9aZu4lEFi9tEjT6xjcv1Ox+e24btS29bJMcEK9zp41TP8a6D8hfVxmXwUkuvmEWh51zFjSNu8KUbHDjW5mss7O93W7Q4ldxhWDNK+Sng5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+HJP53X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A440DC4CEC0;
	Wed, 11 Sep 2024 18:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726079479;
	bh=wYdMPCBeM6pJtikS789C/Z7rTGYd+wA+3VtoQcCdyxg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L+HJP53XyRpnmuiagPfzINxLkv7yp7JiDmxzkLcwFlWc9Kiw0sAj/ukKnNcVTc1aE
	 etTGFtmlsv6qV5ayaGRRR/3s/bICFTp9DOBT1MuinLkx0vJlB/EmSD5AEK+bVNTj+b
	 gcNZyIe8ibt7MfjtR9d9gcrFbK6G/G+TH5DIrA5MkdqEwpfQBrwDObyc3oSSXUxwGC
	 vNl65//MbaoTWvZkZ4+zbu5IkatOawbhAp11eo7V6xUXjYb2oanNTjOaWxJabVAx32
	 wOPYgrAMicJr8I5xowUSK8yyuDLQM2tPlmvJ3PnMuv6pf5RbO5RIGq5kXJFYhoSosd
	 gjYrXpB7NZ+jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3CD3806656;
	Wed, 11 Sep 2024 18:31:21 +0000 (UTC)
Subject: Re: [GIT PULL] printk build fixup for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZuFNuY0sGlrCgZpy@pathway.suse.cz>
References: <ZuFNuY0sGlrCgZpy@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZuFNuY0sGlrCgZpy@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.11-fixup
X-PR-Tracked-Commit-Id: 2c83ded8aeec85702571b7955c654278380b2b6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 914413e3eecbaca5124fcff6286e61182532e7b9
Message-Id: <172607948064.1012158.11927755246863273649.pr-tracker-bot@kernel.org>
Date: Wed, 11 Sep 2024 18:31:20 +0000
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, Tony Lindgren <tony.lindgren@linux.intel.com>, Yu Liao <liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 11 Sep 2024 09:58:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.11-fixup

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/914413e3eecbaca5124fcff6286e61182532e7b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

