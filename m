Return-Path: <linux-kernel+bounces-251942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE8F930BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 00:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0961C20B5B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 22:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F4013D531;
	Sun, 14 Jul 2024 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPDvA5/r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A73FE4A
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720996964; cv=none; b=sqSLwMRDMyActiPP9RvT6qwT2DCyO7oUmJRFOgvSfphXUKai6f3hQNXCSQSvFuLK0m9DMZdKnqn71uInDZZfUrvZx4o83V/q6ZGjTUAW8whT6yRftc3cqA0LR/5eadJMVbHDU7MNjnR2hS0oL+nFP7MJKjcwi0Ww0Y03yvaevLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720996964; c=relaxed/simple;
	bh=Ff8Azd6f/nAhvg7ja7kmUdl2W6sPi5DsmnJSQ8WulYU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SeYct4OOIjmenKtCFRfDlaBAWb1AUGgeESCVXXTJagxbVfmII9tQONGAlO/jylolhsxnurVihj2kmXcsZa+A3hRKiGumRhnY4VMAQh0hPDA+qwgfboSMIMsZcYVynu37GH1xrC8yZCASBrg2rUvsWSJhP8n4Kgvpyy6yRI58pUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPDvA5/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62C36C4AF0D;
	Sun, 14 Jul 2024 22:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720996964;
	bh=Ff8Azd6f/nAhvg7ja7kmUdl2W6sPi5DsmnJSQ8WulYU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NPDvA5/rI9+rKTCwEVIMcqBtP7wYTLaPRQkJBcK4Kk8bAcQxzujcrghs6Qg/iq+re
	 W1cigMkZUzNg0VX/fvPc43cLCn6zQjT5geQ0SDWq8FGW4SsOMp/ubLgu95E2eWJAxv
	 yTlklm+BGA3rQs01xep9sxy6tVWw21wBURZpmHux9JbNA9gYQZGOkTo1OJcX5njm1w
	 CmLFuj/bU+kSXoj6iHSJvvWk66DCA9XT0wB7j8axC3oXQK3/AKRrNQQi6adGQWRE3J
	 UE0zHiRchzCLDl56jDElkUAK+ImNIiqbknMlYx+YQSYZKUOSSqD/HcbHycJCMW6fkf
	 HrJ3TUq3dYb3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 553C2C43468;
	Sun, 14 Jul 2024 22:42:44 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240714093130.GAZpOa8kG3Aq6nfwQi@fat_crate.local>
References: <20240714093130.GAZpOa8kG3Aq6nfwQi@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240714093130.GAZpOa8kG3Aq6nfwQi@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.10
X-PR-Tracked-Commit-Id: ddae0ca2a8fe12d0e24ab10ba759c3fbd755ada8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 365346980ee28e6792db08bc2faa80830c2878c4
Message-Id: <172099696434.4566.14981727623457006166.pr-tracker-bot@kernel.org>
Date: Sun, 14 Jul 2024 22:42:44 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jul 2024 11:31:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/365346980ee28e6792db08bc2faa80830c2878c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

