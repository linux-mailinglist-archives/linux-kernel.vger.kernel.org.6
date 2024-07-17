Return-Path: <linux-kernel+bounces-254566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DB39334CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4AC4B22D62
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DEDA94C;
	Wed, 17 Jul 2024 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdBT4RA9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338E7470
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721177351; cv=none; b=ESo/J46cJEev1d3C0TvOUGq6a56lEQ9pHbvfKRCt5TaTsC8omhQhoV7TZm2X1dMBlMEKnTePzTPPbPuyVjAAEvhuIlRpdmMgr5MRBNIotB6raUOHtUocwHL57ZarwKNQVqVLNPRrYKuSKTdgo+4hUilde+7rff5ibwTydZp+CGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721177351; c=relaxed/simple;
	bh=dNxnSKdpXqvfE8r9hVYVh8JagwGdSJ4M2f7GP3XBI4o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ODQmFP4fm7QIc3FNNb5FvcN3la/OyPDYEyhpxb1ZToHMnOel7LNhGDtcbmmRhNSluJyaOd9/1HH3cgtf+88bK+9Y3FWrxgMuAD8EI0BkICFia1OoIWGXdjYWTvJS+G/LI0vO8nso4hr2WxyvCd9Ulepfn/h4oT/8E/xN1zowF4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdBT4RA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 597F6C4AF11;
	Wed, 17 Jul 2024 00:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721177351;
	bh=dNxnSKdpXqvfE8r9hVYVh8JagwGdSJ4M2f7GP3XBI4o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZdBT4RA9hI/HYddZgzn09eoj798BBzOHext4bwrGZ8u5sic/Y4pLQy0UkyYUidQfB
	 9LcQKzyZcK3mPHrgT1iA7wJ32pRuaFq6vLPHgZ5D2D/UcGN2kOxvuVgPMIMVId2Tmn
	 e+egt0Bhg2Ny4UkHuJyWt9QBwgFe2iL2kFKI4qbZ20BFfB4ZSLYOsk6txP+yeq/uZj
	 FdQYJJWwoMGNK3WOnYpvwD4RWgW+ot8jaV8KtAFIEQnccRzS4cioM984xAQNWu3o1S
	 CXeQslehFDJNq87PFPaMXjF+z9V0FfbvY9BNgTt0Oz+acn2nEWnQ8HyXRe6d2tNAOQ
	 H7HQWx3czKc7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C068C43443;
	Wed, 17 Jul 2024 00:49:11 +0000 (UTC)
Subject: Re: [GIT PULL] Scheduler changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpW146UsrWo_leh0@gmail.com>
References: <ZpW146UsrWo_leh0@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZpW146UsrWo_leh0@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-07-16
X-PR-Tracked-Commit-Id: db43a609d01e8bf9b812d45dc2945c65b57dd793
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a996d90b9e046c6d59845acf00a54d464c34ff3
Message-Id: <172117735130.30434.11873846185042237747.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 00:49:11 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 01:50:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-07-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a996d90b9e046c6d59845acf00a54d464c34ff3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

