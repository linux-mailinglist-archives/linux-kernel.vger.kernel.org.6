Return-Path: <linux-kernel+bounces-169074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878318BC2BB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86AE1C20E63
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBFD6E60F;
	Sun,  5 May 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCdyL183"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290E6CDB9
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714929180; cv=none; b=lAo5ZsxNj0uecLs0iJNH92KXZ16D+FPNv47kMnkMChOo0595Gqe6ZBISut8V3YvS51XchroxSkQQOGQikHLJQCo4/lsZDtq6WM6NYZXDUQxKe7jZ2hDpD2uzW11re6YmAcptPSrbU36XANrcxFqtS5cgnpbrIyPA6omZnXOrh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714929180; c=relaxed/simple;
	bh=f0dh1n26/BR5g/MNIz8tJQvXhGxMdA8jPtSnNisxh6U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=INzbeOOAoIn+oHnCCyg0vPuHC3se9ZDBHiAaO3XN5u52dpGUNxA+SMk42j4xCiR1vc2vRcyhymncv3V6QLo92Nw9K2neJ3x61tvpOt7HgIxdt5ct4SUD7HoJr8s52uoIYIrJKLvn/AlGV4t7Qme9YGUvpTy5vvchFltyUXoMexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCdyL183; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A073DC113CC;
	Sun,  5 May 2024 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714929180;
	bh=f0dh1n26/BR5g/MNIz8tJQvXhGxMdA8jPtSnNisxh6U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aCdyL183Eif/EMhObVeLhnaB1U0xzY2pfINpvT1Xwvd9aDPrT3RzF4020ZohPSiE6
	 54DEyyNEhZ8M/pcRjY28DQdZpS9uN5GwNafcx/2B88/82NhZYkGoiBOTcq7mQnA2dF
	 9NGQEfeOKm7eWgyjhMutMd6eIwU9oBqOXkjZ+bc2KPFD5X+0zzL4UnpZNBppg5OyI1
	 /3mYArhuHezR04dDWg8XA5VoEuioMWD/fnD+9gjn6GTqnxgxhR+h4SgWcjt3X/Sdew
	 SXXoCVl2xRsTxU25AdfpOF46LUXXh3McKrc2Jev0uh0JrzEZMJVWZhBhxeNJ5cbYyc
	 nCXGFeXbWZgDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92FFFC433A2;
	Sun,  5 May 2024 17:13:00 +0000 (UTC)
Subject: Re: [GIT PULL v2] tracing/tracefs: Fixes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240504043801.2ca43b92@rorschach.local.home>
References: <20240504043801.2ca43b92@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240504043801.2ca43b92@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.9-rc6-2
X-PR-Tracked-Commit-Id: d57cf30c4c07837799edec949102b0adf58bae79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e92b99ae8216dec2566711dae0a9b7b47591e315
Message-Id: <171492918059.31500.9576885964803490249.pr-tracker-bot@kernel.org>
Date: Sun, 05 May 2024 17:13:00 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Beau Belgrave <beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 4 May 2024 04:38:01 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.9-rc6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e92b99ae8216dec2566711dae0a9b7b47591e315

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

