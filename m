Return-Path: <linux-kernel+bounces-253179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D09E931DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1FD1F2251E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE871145B20;
	Mon, 15 Jul 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpHst9ce"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1DE1442E8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087784; cv=none; b=P8cFVl9LtlDf2JgPDsjQveLQGDg0rCG4Y6/k1wsO4t/TbyH64azxy9KHy69j4cQis/tQ8VRYyUupYYjSuefW6bYAZorza7Oad3t3O7LqncSpa6V9V4ALsjRcW2KuvK2imlxBzCpz4pthRw7h1+1a9JrS98uzh3X6YOs/g4cqBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087784; c=relaxed/simple;
	bh=dGQuqRH3j/kggUaIG5lQQD+V8tQkG+ssZHhHn8Shy50=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KCoaXmJ7SPknwNYZrQzvJh7RbmUFjBJX5U+/NClGwOSMQRoAHDnIQRV2SciN+stV+zSO31pzXRFM5HOEyzXn9lko4oa7iqdskKJTQpUQoMen/YLxEmOnk12czoC8NB/Zw5e7SUBXHLCIE++tscdiFNfJsgnmmEVktT1WO7zI+Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpHst9ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DD06C4AF1B;
	Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721087784;
	bh=dGQuqRH3j/kggUaIG5lQQD+V8tQkG+ssZHhHn8Shy50=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EpHst9ceJ+Mtziz1Ym0+nREJjgdjxY5vwun2Q3pxlfJfy1Dmb3K4PzkRuDH0rqcuU
	 OIL+P5j4t1bKK5WbPhU+OSazqpFChVjt/t/fvVCgsnet0iSm8yMyV2ZA7lKyfOgfHC
	 mvxSZnHR/DaRMxk8lzUgI2nNHEvIQBcAgRVAWn/h9rVolz+03WzTgSWjsqybXa5LGW
	 HVH291oTHJhAFnLkXEazyJyaeJ9A/Y7RzwVcFKhQE6jMbT6ZubOWez6f3N72C7GW5h
	 bXamjkgQPKYiDUVTC/6VL48LBftQJetpct7BMVdbuWDt6lfELhKPxtkuFnVtR3b4TM
	 50UB9Ql27Li6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15588C433E9;
	Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172099001980.1942258.17387914707489716419.tglx@xen13>
References: <172099001487.1942258.17671805941963584080.tglx@xen13> <172099001980.1942258.17387914707489716419.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172099001980.1942258.17387914707489716419.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-07-14
X-PR-Tracked-Commit-Id: b7625d67eb1a63d33b0a2a4518ce4897d27f7465
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fd9435641bb80c04863c9a35afafe4c3f953bbf
Message-Id: <172108778408.25181.5644831086543539312.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 23:56:24 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jul 2024 22:50:10 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-07-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fd9435641bb80c04863c9a35afafe4c3f953bbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

