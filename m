Return-Path: <linux-kernel+bounces-183228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EE98C9616
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 21:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043151F2121E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 19:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188867172F;
	Sun, 19 May 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvgbqMd7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586FC51C50
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716147417; cv=none; b=qzMqAzR80VM56ySyP8U6O93oICMDNsl1RrLPI0le2zkSxb0CK80ES2zdfwpXkw0hYPxAM12tp7zpPuk5EN17Mz14xwnQxQUdrkJewnLo+f7QyRa8BQBmE/HCxJN+2R50Qve7If7t9gCSE+rmCL5FTCCwmf9Ra/KDARHRasXMAAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716147417; c=relaxed/simple;
	bh=JVOaTfryxjfJNTEyLs4hSpPOk+QUxZUVwQDguABhlEo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ecHOibtGh1Sm2+eAT+VT5STFGuYR32Oo58G5TJ2tAuU3f7JGI3xba6L9k44bVkSB3nq9mK+iLkHvAxN68Ly9muz5Kg02N1tQAFWNje8XP7c/fILB/cIBuOO5ue8SJzIq7J26T3QWu/qBqH4DJzmWNQ9ckUqf8tPezCmE85w+A3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvgbqMd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DD3DC4AF0B;
	Sun, 19 May 2024 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716147417;
	bh=JVOaTfryxjfJNTEyLs4hSpPOk+QUxZUVwQDguABhlEo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fvgbqMd7z0RbRRA2Ryexa/+nC7+kPeqTrCrh8LKb0oHqRv7bG4iWLJWVOiLpixtpQ
	 VN7s1R0q+J1DjOGPYSlryUYKu1yL4QsV7suVMG3lMiNMaJHGPfA5QyOpjnROyBDtEg
	 KUuTczIOqSI35z8Z4/v/3LR/v7x8uKQ4FhIWJ4GSsfv6IbMxjYbD41mYu1TB0wPC0e
	 kfUE0eSMpjVMFoqPZuH18pf+2LJLBDk1jaBPI6CuqWmYMtkQF+Y2GwkzPoFkMWZaaZ
	 ioJdgZPlA/Z/j9hXex+MvLqI07RmlERVkPMwZvrurv+Vwzr7PZID7Y9DlXtaaMnHBS
	 OQ3OWmlMJOFOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 230FAC54BB2;
	Sun, 19 May 2024 19:36:57 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkhwaJk7MwLXbtqF@gmail.com>
References: <ZkhwaJk7MwLXbtqF@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkhwaJk7MwLXbtqF@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-05-18
X-PR-Tracked-Commit-Id: 9dba9c67e52dbe0978c0e86c994891eba480adf0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41c14f1ac82cdb1e009d635ffd5ae5dc4cc3f036
Message-Id: <171614741713.6582.2029564511336561644.pr-tracker-bot@kernel.org>
Date: Sun, 19 May 2024 19:36:57 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 May 2024 11:10:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-05-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41c14f1ac82cdb1e009d635ffd5ae5dc4cc3f036

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

