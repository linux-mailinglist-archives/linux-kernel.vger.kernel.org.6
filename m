Return-Path: <linux-kernel+bounces-273939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C391C946FE7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 18:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A99B1F21395
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6367A13B2B0;
	Sun,  4 Aug 2024 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gx6vXjSS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9F13AA46
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722790465; cv=none; b=MKj5MbYFPkkvDEERMBRHAbMjJJcTNsW9fKUkvZXxS4QoB7LZRH45M0Wa9lR1O8i6Myw6aAvkHqPB2PDmRjbSttuzAuRM0vo1PMMz+/R7BLBGBDkQsX/dn9GK2gHpqWt2QmOX7w/mFfxJLSfYc7dIRCWSq+xQs037HFJoDj3cXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722790465; c=relaxed/simple;
	bh=06q7j1J2aIfwvRDutJV0IcjULLi/2SDPDWj3oraSII0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ri5JnWlSCm998SQlIC1E+3mpJOPQGv1b3YPie9VUtY4BX2EVWuqd3J1tBfZspfB24a4YKapWz8Jj87FEPYeKztDCLMjBlCpaAbdecEKyd/xdju/ZNndWcZs8JNKZJeZxNi0bzUUnmy8v5iqLmY6uQO5w1T/neV9KqzWKcl+ii2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gx6vXjSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53AF6C32786;
	Sun,  4 Aug 2024 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722790465;
	bh=06q7j1J2aIfwvRDutJV0IcjULLi/2SDPDWj3oraSII0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gx6vXjSSWYp4cF8jyrPd45IhGlElxS0RsmStpgLgYXYUqUIUSRwtyq2XAAfGOPZDm
	 /ahCXAQPMyVMSeXWbnNGh6T2OFBEce3m5aOqrLJq9aj7JPvXa/ZkinfMM3JN7njyiM
	 CYoMmKZFo7NnI7jtFIbw1cBR95p0+CqJq5zfITeVhS0FPR+vMaV21EiPFlZ/6OiFE5
	 oD+jNhfEqCk9wQw19Avn37txM/H7irltvsYYnKdMUZoYDoopyfsP1RURLQY7rEy4fK
	 LJzv8r3LUCa+iMMvH3JARJCUJKKddXRwPX3sbkMWJPxPEPDWACbtSINbxAeRkM0f1h
	 CaRZL+bMWxn9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45E60C433F2;
	Sun,  4 Aug 2024 16:54:25 +0000 (UTC)
Subject: Re: [GIT pull] sched/urgent for v6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <172277654633.866296.14995229844387120847.tglx@xen13>
References: <172277654174.866296.10517632866315552419.tglx@xen13> <172277654633.866296.14995229844387120847.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172277654633.866296.14995229844387120847.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-08-04
X-PR-Tracked-Commit-Id: fe7a11c78d2a9bdb8b50afc278a31ac177000948
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cc82dc2bd1196141ffd5ebc99ecb52f9537443b
Message-Id: <172279046528.9825.14115883629486242534.pr-tracker-bot@kernel.org>
Date: Sun, 04 Aug 2024 16:54:25 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  4 Aug 2024 15:02:57 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cc82dc2bd1196141ffd5ebc99ecb52f9537443b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

