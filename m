Return-Path: <linux-kernel+bounces-337522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F06984B48
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1F51C22FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F94D1ACE1C;
	Tue, 24 Sep 2024 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR+zGteG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68301ACDFC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203542; cv=none; b=MKcrBo4GGN834oqManBnf/az35na4+Ne3vD4DW5GtlwvxitxfSZmQPKJ2Unf+KICc4sIK86M/f8/vfIe9vXYVvBAT2GreZGKjBEZL4YfmcIooJvip4F0TeiIBKO9cNC5GSQ2f74sU+Lm874zpSU2At+0Hpj3ztfP7Yt3qOayO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203542; c=relaxed/simple;
	bh=VYH/35VB62IpnFDDktLIJXu+4malnaVW0OOnU+bDmd4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X2LRzuzpXZ9nv0C6/NI3Pe1RS4wLhP2KaWfqn28gMrqSRlVZ4aC4FIUXAyCo9psQUVytXWw9VV34XV9rSq9MxU0KY8BmdmTpah9prV/W9/NvvgIj/cfNGecc08SgwAgNDPx4SxTbpY2O7Lb68+bxpc0Vjp5PPd3coZYG8IItRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR+zGteG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50033C4CEC4;
	Tue, 24 Sep 2024 18:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727203542;
	bh=VYH/35VB62IpnFDDktLIJXu+4malnaVW0OOnU+bDmd4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UR+zGteGQiHIxTEOZ+UCRN7zQmoUIaWa5CoqyqDH3zGKqu8FkuVfUUs0D9NErt6W7
	 1u9mqccP+sWPN7QhYt9vtnBGxtuYCvEJZNKLHEbV8muubKrqQx4yhUgg9r6yMYf6N+
	 Cwcim+KydtyjvVmltc1W3X0F59nzC2Gx5vmOSknx02idmjkuXH/jltq5kLnQclHzBY
	 v4FydS3pfqW7zwfiA9DN/gruocdY6BnVEjTmKMs0kts/njDYbJzubm+nNVkotAVosK
	 YsD2dXwY36qFLHdXGLk77HDdondXCEye8uoDWjwAjOKumwFTx43nvJaezVvzINe5qS
	 s5/tQtERuGsWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1F43806656;
	Tue, 24 Sep 2024 18:45:45 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZvGfmIJt-5gg9EwU@slm.duckdns.org>
References: <ZvGfmIJt-5gg9EwU@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZvGfmIJt-5gg9EwU@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc1-fixes
X-PR-Tracked-Commit-Id: 431844b65f4c1b988ccd886f2ed29c138f7bb262
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fa6588e5964473356f0e2a02093ea42a5b3fd56
Message-Id: <172720354460.4158342.16632264201338944304.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 18:45:44 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com, David Vernet <void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Sep 2024 07:04:24 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fa6588e5964473356f0e2a02093ea42a5b3fd56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

