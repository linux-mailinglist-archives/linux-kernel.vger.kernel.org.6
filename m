Return-Path: <linux-kernel+bounces-576139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A7FA70B84
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9B43BF8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA2726657A;
	Tue, 25 Mar 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdJw4SQ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592E6266568
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934650; cv=none; b=Px58feaUUKiflpbi6xD7/1greQjh7yWwr0Cr34QUC6blKbHGTfF20vVy8iIBxibZsS6Tm96JCccjPVzwdnNRjSCcv2oekS/qePa+TNnPGbv/QKadGtK432NCkjvIOtNP33Pz2zX2N/G9bLLBRU9FlnJJwNHe97GcBFjjp9Le2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934650; c=relaxed/simple;
	bh=wxYgWmLIOjcYtrEHvxVJCMJFQmjzCGhFfxQaqBAlqkY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Xiee6VRr0zQBskNpR5k8Vw6DszK6J6jOau81bvZMEEvmDt6YzE0WbuTBc3Da99W73KHaKOyH2h+s3WeNpX6mUjyTDKKrlBGKSKcvq2wEyfJcVpbDsYAEtC60t4Xy2sr1yB0niDAIed62z4Ycvwn0dvxBQxJmAKrP2WdZ2nIr5P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdJw4SQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B5EC4CEE9;
	Tue, 25 Mar 2025 20:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742934650;
	bh=wxYgWmLIOjcYtrEHvxVJCMJFQmjzCGhFfxQaqBAlqkY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rdJw4SQ8xHb3EWz9SvoC103m8sMPrb4T6X3y0JVf12mHDAvAu1KsdJRHNLGBVvC82
	 ACkot7GCQwl5fVBrnzUAPR0q1uK5mlfriAGF+TAlQ1a5bTZuUx/lDmLC1Gq+THGZe9
	 2ZORxCFoPF0+LtIl4qxVX5MbHtmz8er9BpO+jQJhkXpftFgFZ+1kxv3ElV3smwZxfI
	 tJITUXBLfgxaDDhevHF9g9ahzAV0zmZN9K/PlxBd8via49q6anvmsp1sHt1F+cM0/j
	 qHXbrOlzkAzxI6ik/gqRdmDE/e47w/uGevAEujngr8AieuSxHCEFy+Wbht90vMT0OQ
	 4sRa6XxFPfeDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE989380DBFB;
	Tue, 25 Mar 2025 20:31:27 +0000 (UTC)
Subject: Re: [GIT pull] locking/futex for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <174275226072.1561082.5650620916174411892.tglx@xen13>
References: <174275225552.1561082.4969731002775597670.tglx@xen13> <174275226072.1561082.5650620916174411892.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <174275226072.1561082.5650620916174411892.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-futex-2025-03-23
X-PR-Tracked-Commit-Id: e3924279e5164d821fa2cbcf0c15e7345cb3508e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ae2062ee3ebf11981f9bdb6198fa734d8c0f46c
Message-Id: <174293468636.715410.17898250003805743695.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 20:31:26 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Mar 2025 18:51:38 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-futex-2025-03-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ae2062ee3ebf11981f9bdb6198fa734d8c0f46c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

