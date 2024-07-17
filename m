Return-Path: <linux-kernel+bounces-254565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD56A9334CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A641C22447
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000858BF3;
	Wed, 17 Jul 2024 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx38u0Da"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FBB6FB6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721177351; cv=none; b=mWpBH3T5u+UgeC/CtKxqKWet1WLQyZ5GZcWIsSo/TQZStTmegTf1SLZ21K6YHKuXVZxaZiMzvaKU+prgOOIsu759e4hsDP/0X5qf36PSMTwJMQUtLsUir8N4lsuf8fWustOCjT7icwPs/1V45T42XpVZvnDDaCjM0hViCaexI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721177351; c=relaxed/simple;
	bh=cREXXYPulkO1cGThsxai4+GUX+gKKEd4KDC3/O4CBaI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JOsSWWBaeE7z6oPkLn4yetpbVqbVz8tcEqEw/Oq3wTJ5SCCgk+i+9qTq8ReY9MJ9ipzDOf4GlUw8b6j6b5/DsoItoA+u2nXGxsXUtlYLKH9+i5UpiM8RupFOD5TIiwLayt4Xo+7H+WxQ4qq98VuzUW4o/GqSweuAhjb63bBXE+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tx38u0Da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24E58C4AF0D;
	Wed, 17 Jul 2024 00:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721177351;
	bh=cREXXYPulkO1cGThsxai4+GUX+gKKEd4KDC3/O4CBaI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Tx38u0DaPRJ9YkosqMUNE4nS/NJ3rcygIA8YY9XmKx4L0CCp0zYl6Xxl1m8lfy3of
	 CPIFNx27XpHORnSvkyXSUhpMplvSZDzk3tdUYQXsLGhP7cY7BltTaJihj51lFXRdFF
	 Cu4oKgYgqPdhWph1iDankaTfOr3P5VsJrkZvGi8B4h8G5/48Ycn6RSAca0JxmjchHe
	 xXAAPoL1adEOAiU2yfi/OULc6KwuEtVRXyS5vOPztz5YTrwcBPiYpOXMENgQNHJOpR
	 VkzCMPFMiewbr4QmGmPXJ9BZX0MSDwALzkr57EVfj5cfcJ0OY6SxH5eAPd4q21qI3I
	 6Cz6r3Oy2RnjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B8AFC43445;
	Wed, 17 Jul 2024 00:49:11 +0000 (UTC)
Subject: Re: [GIT PULL] objtool changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpWzZC-UyVjMYjlY@gmail.com>
References: <ZpWzZC-UyVjMYjlY@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZpWzZC-UyVjMYjlY@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2024-07-16
X-PR-Tracked-Commit-Id: 8e366d83edce3065ff3372bedc281c5e217c0550
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c182ac2ebc5470a725632b08cee9a52065bbe71
Message-Id: <172117735110.30434.997727950177637043.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 00:49:11 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 01:40:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2024-07-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c182ac2ebc5470a725632b08cee9a52065bbe71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

