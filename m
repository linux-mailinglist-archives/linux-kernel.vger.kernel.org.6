Return-Path: <linux-kernel+bounces-333958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7196397D080
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CDA1C23B16
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 04:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE614D8B9;
	Fri, 20 Sep 2024 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrwXC462"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1204D9FB
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726805414; cv=none; b=ADCOnr95Sb4VPWl5bW4flVwEylUb6zJTf3Xw18fNMhOnRh1vpT2TVcQqLqIHic64aWOssZlMBcwT4Qvx1pDPO4UAp8/L0Smg2L91ctVOwOMj8vkWgQDPpL+dRHxv7Oh7UhBZtCzQii7F8nTI0g1DovZIJ/Qz7Plj8sz5Wx6/hqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726805414; c=relaxed/simple;
	bh=egRYx/Q3qMtK2NtnTN856lV4OSOLecg/VK8NDIIZdEk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DSILxkfbhznDt6QUBeX+nHjtf5P8pZ955C7oqJxFg+tkojGithLy6T2zsgv2c+tvekyZxIZel2sYCry159ejcHuz3BEkEa5azFrHrIHOdFIMWBBxfeFwrTM9uF7/16feJffSkfC+4XsahxqCyF8mElFD9PXM5X3VAp0RDC+NoXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrwXC462; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29F6C4CEC7;
	Fri, 20 Sep 2024 04:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726805413;
	bh=egRYx/Q3qMtK2NtnTN856lV4OSOLecg/VK8NDIIZdEk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OrwXC4625p1FUd7mPlq4dyqnfSfF+pUTfrb6wHJDGF3fqn/KwhODhVUd82Quk6syb
	 Q6WgBr7PhOTdmjs3yygoRHJlMOrpFxbAGgkwtadGQCH4/0+HsmQPEwP4UFFQJ/pAJ4
	 S1buWIm9ay/h3iLJ6Kzsr7y4EDYJZCg+wtGWQ7Xbqo2TV/IAFhS3aT4BQ+RbFha5nu
	 CQzLHui/qN26LmqH2vDpMoOsmITCwJKERL9sXFQ/QXIdWrLA/FHeOFxC1udsnU/pxo
	 6W1g4H7PlQp4LwqPTXGnWtXcZM4FG7OopqZ5vQtb4AaWzmyOtnNTeD+yJ2Gnv1HRs1
	 dk7TSso3Pq5Pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 03D453809A81;
	Fri, 20 Sep 2024 04:10:17 +0000 (UTC)
Subject: Re: [GIT pull] sched/rt for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172656429254.2474571.1051331842339040765.tglx@xen13>
References: <172656429254.2474571.1051331842339040765.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172656429254.2474571.1051331842339040765.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-rt-2024-09-17
X-PR-Tracked-Commit-Id: 2638e4e6b18233d7ec54edb953f253ae9515bac2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: baeb9a7d8b60b021d907127509c44507539c15e5
Message-Id: <172680541587.1755164.1057608569329343617.pr-tracker-bot@kernel.org>
Date: Fri, 20 Sep 2024 04:10:15 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Sep 2024 02:39:14 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-rt-2024-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/baeb9a7d8b60b021d907127509c44507539c15e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

