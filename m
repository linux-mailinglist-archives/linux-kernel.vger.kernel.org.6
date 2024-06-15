Return-Path: <linux-kernel+bounces-215985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F3590999C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 20:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA521C2141F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 18:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA3660263;
	Sat, 15 Jun 2024 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep03ziDl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D63EA72
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718476698; cv=none; b=MB0XUQx1yrWPhHVwYOr5V7ikCMNY9yIcNIMi1WE1QFBf0JBExTsYMe+4wLhFfI+KiVPH2XO8NknczjSHVHlYj+YM8VuKzjDXC995Ge08h319L0JRxS84rExyu2jOm7ZZDslfjRjZjmRmzh5J4t7ZE53bc2iY1+gzu05Q/Sdm4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718476698; c=relaxed/simple;
	bh=Njuf7DDMTFuXreCZQk0B1l5RNgz36Q24NPv/2Z+f8d8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IY0WfU6ooZnDAdePNhwh1c/Aa/GdgtojVo/sLP1oVoGek/L1zACYmra4pUewjj4SHU6kxkrGR4ZoFu7y0pzVhbs/O2OOyDZ327M39vEpEJmcLiS71DGx3KSMN4k0bhsElKfOYRhWTXxgxZdvacpmIBbvzKHJpSD5w3vJBi1RO6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep03ziDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E28C0C116B1;
	Sat, 15 Jun 2024 18:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718476698;
	bh=Njuf7DDMTFuXreCZQk0B1l5RNgz36Q24NPv/2Z+f8d8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ep03ziDlL19H9l+m/HK7a13ZRfV+RJVfnddiaLmdqPAX3bLxoQQcHk+9cts1r6ads
	 cdDquZ6qG/O02cuAPIZJTrZZfC8cCtijQyCHFSlrqzynpshaBLAWYC5Kb1N9ia+NDT
	 wse5KR8dZUVEPWvJ1iZ3wJKVuCam3h6/383ta9RdR5O/9J3xWRVOHgDHvKaYMSoj+V
	 7LQ2NyrleAEtpnZ7cJNi7UhPqPpJldon89lJ3nsMAaOMk18g/7ot/z9u8UD0YAOamm
	 YBjQCGyuZYF9BvJxp3tPeKSzXwbsJkhlrlYGo11g72ZogU1UvfWqbsoMkxXnTkewmT
	 KE5GqKn6WOawg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D57EDC43612;
	Sat, 15 Jun 2024 18:38:17 +0000 (UTC)
Subject: Re: [GIT PULL] timer fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zm1LHnqOv9SsW9EM@gmail.com>
References: <Zm1LHnqOv9SsW9EM@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zm1LHnqOv9SsW9EM@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-06-15
X-PR-Tracked-Commit-Id: 07c54cc5988f19c9642fd463c2dbdac7fc52f777
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41d707222e64118c0665dc9246a6d8fddae6c10c
Message-Id: <171847669786.27128.9729170173943991369.pr-tracker-bot@kernel.org>
Date: Sat, 15 Jun 2024 18:38:17 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Jun 2024 10:05:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-06-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41d707222e64118c0665dc9246a6d8fddae6c10c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

