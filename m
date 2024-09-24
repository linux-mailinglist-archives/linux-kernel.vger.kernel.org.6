Return-Path: <linux-kernel+bounces-337735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D42984E21
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E065285F91
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4793717ADF1;
	Tue, 24 Sep 2024 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPIRLJoE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE4176FCF
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218216; cv=none; b=cR7KJwWOci3m6JAURKiAxCODNjvHe0JgqQ3DzDL0BlQksq7dajo1P26y21/vfd3KczHdoI62/4fysqPka4tN46GzIGGnrwv9RB+IRxnykH6uOyM6+cXFKyyg5F/UnAfwlbX3LK++yrpkEMY60gLFdDqyU6m7lMhhnYWYj+pWuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218216; c=relaxed/simple;
	bh=qkMkr0ApyqQAu30cC3Pg77vlyo7ZToman0ybIaWHkUM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M6HguD4zuh92ITn/tK3/mpWJXmNxJI8LJq3sDxWuB65/PzdahuR7I+I2ZbadUAlo+caymQWE8+tArpVDaryG2Ztfigl+wqiE5U4hYCMTZGJAlZ5h2CynPK2RukCBnQgWtwt1fzN+q3Vmfpkx3AI+y56z5E0YyVwAM/8gF6s4vqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPIRLJoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDC0C4CEC4;
	Tue, 24 Sep 2024 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727218216;
	bh=qkMkr0ApyqQAu30cC3Pg77vlyo7ZToman0ybIaWHkUM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lPIRLJoEoBy6PFfCV3pQ+5PRd2XYfZ7YWy1GV9zApX44C7r4K9WQGImTDLiJ3E9CK
	 3ljPO1IacAWKgHZXp+XtxFXzeLyh2kLspL4JbH5oo+wO6y/lX3f26txLt0Pg5N38Ig
	 THXi4Taf4JT0ZrBmg4cWOMzz4FvK2ue4ta23+gKiF+3AuryLIRsXq9MZoUnNYnxOEW
	 kS3xmmXwrUnkuK/yBR1Th850cGFFdNFT8ynzYhmnh204KbCaBaTZRudpHC6YWof069
	 Pg9rHso64Q+RjEJOP8ixew+c5mU54JvSWERlYjSh7zNfQXihOZh5LOhE7bZwjW7Vjp
	 5Ub2hZwKetJZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3497D3806656;
	Tue, 24 Sep 2024 22:50:20 +0000 (UTC)
Subject: Re: [GIT PULL] f2fs for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZvInHczHWvWeXEoF@google.com>
References: <ZvInHczHWvWeXEoF@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZvInHczHWvWeXEoF@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.12-rc1
X-PR-Tracked-Commit-Id: ae87b9c2dc9800e6ab52febd09341140599ff8e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79952bdcbcea53e57c2ca97e7448f8a6bdb6106a
Message-Id: <172721821882.30034.5554297247733064420.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 22:50:18 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 24 Sep 2024 02:42:37 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79952bdcbcea53e57c2ca97e7448f8a6bdb6106a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

