Return-Path: <linux-kernel+bounces-343068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED9F98966C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E2D1F20F3D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2344F186602;
	Sun, 29 Sep 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZsQiwuZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838A8184520
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629503; cv=none; b=DE/4kYajlmb2aItQ6mMsnLDgJ3GP8KN3ZJFIdXeGDSuaaYZzSmn7J6jFMS5g+DN2HdlBQ0fWrCL5SE0eTS77QSNZj6xGhDSrj0FYjaHVxtSpoVO1cpEo+EB+bf7g0B2wwC26IVg6uOy+rr3x52PHwQWBgCd9TQty7AdMg69bO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629503; c=relaxed/simple;
	bh=IO3uF+QUgvCwY6RtTsicA8FLoBQutF89cScx2bGPDNs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H1FO3bRFRxexUzED0/+SZ/Uf2AVsv64fx8H9x3VZgfN54t2e3ES+P/iNknJrlk80YZlkou2froJItxa/jmbf5rfWzQXVBHh7+nNE/ycINVKVkXiAsiS8sf7oLhjMV6GIESQFYxEKEirqfI9Q9jiFvf4rWNFbDngsSKeAAJcycNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZsQiwuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B090C4CEC5;
	Sun, 29 Sep 2024 17:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727629503;
	bh=IO3uF+QUgvCwY6RtTsicA8FLoBQutF89cScx2bGPDNs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HZsQiwuZLXon592uo3Z8dh/m6jXnM5HpiVNiVKHAy92P+Q9g0SNw6L7qzFkVnLYAU
	 iJb5sqciCQUSyrWJSYhplc1NITQ1HrEyX0zvp5r7Mm6Yv1LDL+wnT/c0EKBhW1ODKn
	 09PkV0ZTmRRxMActzUlk3J4BS6GeMAe3pr5Fx21N40g1aw90x9Rf954xLK+ACwUcUo
	 eTAAkg4RD0GclaOlNGcIkBGGdZHX2uJXfWyYQqZ9qIzyQctukULO5OmUfQpvpZ0CZ1
	 sx09KNmrO0CAKvJJF253d3aoJSN5dGZoNJyLldtgP3fihmCEUJM+K83MVy9PgRUF3x
	 LiZpDMnjI16vQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DEC3809A80;
	Sun, 29 Sep 2024 17:05:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zvj-zvhfI81nB2s5@gmail.com>
References: <Zm1NIOnj0NR3U8om@gmail.com> <Zvj-zvhfI81nB2s5@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zvj-zvhfI81nB2s5@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-09-29
X-PR-Tracked-Commit-Id: d1fb034b75a8a96fcb4bf01a7c0e1421eef833a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d37421e655cec032084bba2601e46ea61e6f9044
Message-Id: <172762950608.2558104.637955019259848010.pr-tracker-bot@kernel.org>
Date: Sun, 29 Sep 2024 17:05:06 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 29 Sep 2024 09:16:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d37421e655cec032084bba2601e46ea61e6f9044

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

