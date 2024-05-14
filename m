Return-Path: <linux-kernel+bounces-178979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA218C5A06
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5C1B21C21
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D371802C4;
	Tue, 14 May 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu16U4PL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD3117F396
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706186; cv=none; b=KltL+SWiv9iflnYMuautbjdidiNem7P/eKk0ELmZ63PCMf7Pctl6k83tl5/L1LM0j5OOCD900ESybtuOHHvzpAmmihvkPIuRm86NzYcWM3GWK1+V72qal7Met/Z5xtrSQLjwizi1xht6O1ejKXGujHszbjOxjA6CDZhajxsdrEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706186; c=relaxed/simple;
	bh=0u0nc6kCG5M6Eipm0LEREpCfdMlyiOom1cVjcRE46R8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WUglWtAxTkbxI6ti8Vdg2BEnORwqrjTxHSPGj7sSGl3muZzaZp0aFsoWSyXWtAhWQMhc4FodSanf5t/6v8FsVqq02AI++2EXtXqfNi9jdHrWMZwZlyB/zjoSezpe6yjmSnA8L2NYnWzjt+vNMvIlsGJ6FpkXF0PT+tNKAfsZcO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu16U4PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04771C4AF0A;
	Tue, 14 May 2024 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715706186;
	bh=0u0nc6kCG5M6Eipm0LEREpCfdMlyiOom1cVjcRE46R8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Gu16U4PLihbdy3YBYDnnFGW3U0B/1eJy2Jk+C7I3l+2Ap4jUAbxAzYwFchzmgeHqJ
	 qYH8xTwPgs3TbHAI228Lb7YdOzFJpr8BCK5cN7JymIlWLygkgj0YqP8QipDcEVRyGP
	 FDpolvUOoujFq/Vk4aTtKNrm+STIKgoGIGVFYGutAaMiQyr4ff+tILWrG0QN8NSGcB
	 UBemKPzj5zGE2XlhJ3an+kmDhxB+3QiTe1/OKhTWvuAwkYcPuEFsik/nPJ3zLpIdE2
	 ZgRCZuoxM5KsOC4XyFTnsxCeISmq9N9aFc1Qfscvkem7LHRMppOZoGVjY4EZMluUcq
	 Orj084mHTYEuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF9E7C43339;
	Tue, 14 May 2024 17:03:05 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: 
 <171560454635.3871325.5773365584560034962.tglx@xen13.tec.linutronix.de>
References: 
 <171560454635.3871325.5773365584560034962.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: 
 <171560454635.3871325.5773365584560034962.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-05-12
X-PR-Tracked-Commit-Id: 382d2ffe86efb1e2fa803d2cf17e5bfc34e574f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bfd2d442af5c373042f196eef1915e1f6ac058a
Message-Id: <171570618597.7410.14309199481719088984.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 17:03:05 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 14:49:58 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-05-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bfd2d442af5c373042f196eef1915e1f6ac058a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

