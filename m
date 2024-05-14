Return-Path: <linux-kernel+bounces-178267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D242B8C4B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C047284DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D728B2D60A;
	Tue, 14 May 2024 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx1Dckoc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B9E17BD9
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655089; cv=none; b=EcNDvzXjw2VDHraOIo4UNmjve+8FaiZPcLDF9Na1QeGKvwO01nyl3AzJaaZmZkYaEvOq5wm/U/zcsS1bLpyWwZJ/9LEns0BrT2UvJkV1R5ErAVCuUVJruGhMTw7zWTU3dnhzfxUsYERsTwB5XseuzJENX6YeDEFpbhiO8oWWvA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655089; c=relaxed/simple;
	bh=vKsGyWZaPFIvgVHLbnG2OsPy2qfGSFAnnsfTc8QnA0I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SOze8fRt0QUxoADibWD6ToG4iuBBAcVHTcLn6DsoBAUbyApP03H4loWU1rnXErEZmIJaxEzIFmnD22EBudOc0ePPlbuVDUM/lrOuHIghoN86D2NGZaU96TqTM5MW7YYM/JBk5ag+eItMikyyAKdQWZgU/J1aLPMKmZVfTRDAi3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx1Dckoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3115C4AF08;
	Tue, 14 May 2024 02:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655089;
	bh=vKsGyWZaPFIvgVHLbnG2OsPy2qfGSFAnnsfTc8QnA0I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bx1DckocX5eJJp8ofv7u1sJcdIXvjOxa3Hei3qqL0DvSSGKbuVbvZ0v6iHU3aJGcU
	 1yXoBbfUVShyuV8P1vEVCroMmzAGle09MfDnVM9hvyx5mpS2t0p2iuPCWyhzQYvsd5
	 sG8Jv+Ht0Aph19Ad/+czwOQgWnPz7xrcm1Dcr+1SBvLbJDTSmTQq8vnoGeq+jDc3XE
	 yx+HRcaSkE5UuseYhexwKn/MDj583nLSjo0L4y6iHUM7KJsy3+rhKiP3rlsR/ObECM
	 GWNGl0MqMn2JmJoBKCHiZLpS84kfeTBxf65Olf94f9a3x5fJ7wawOGL3JJ/iIELVtI
	 bh70PRRafEsaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B42BC433E9;
	Tue, 14 May 2024 02:51:29 +0000 (UTC)
Subject: Re: [GIT PULL] x86/bugs change for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkG5QsQkiVNojJU6@gmail.com>
References: <ZkG5QsQkiVNojJU6@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkG5QsQkiVNojJU6@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-bugs-2024-05-13
X-PR-Tracked-Commit-Id: f9f62a877da1e6f6e9d58bd779c1c77052eb04ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e3591453de3ce12e0d6d6d4e80ff3bb659e4d70
Message-Id: <171565508962.649.3943803054968069184.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:29 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 08:54:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-bugs-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e3591453de3ce12e0d6d6d4e80ff3bb659e4d70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

