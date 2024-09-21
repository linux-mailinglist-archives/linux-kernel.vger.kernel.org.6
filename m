Return-Path: <linux-kernel+bounces-334895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9987C97DE09
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B161AB214D1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C13C175D2F;
	Sat, 21 Sep 2024 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ2cQS/7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE2219F3
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726938825; cv=none; b=MoQyvX77cTgK2Gx5es2v5FyyvUKH2QGH195z3Gg1hAEzDZU2wAZDVUA8a2h13BxpMFtYdPTl+aGmQZphTik6kxuGiLt8yruzyqeNUom1wGdHnvTZfilWUh0RowcWk8Lq4JAhcD7FjfN6Uw/FvJhRV7tlq6quvTFpFM133fbthsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726938825; c=relaxed/simple;
	bh=ZRU+zZVOMIhxT8nfk4ydFoMi3Yr6y198NVau5ef9Zyw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OGFzcYg2lryO7lRfwrBsq/5tEAqYe4WTvwEoPK8/6mwBBSPWgegdLJb8tR8+oJSBgzpExhRn2nwpeiPgy+dF2rJT2XUPvpigufvW2z8Po5S6F6lEOFiBg0HkKE1jMcVT//hqY8PP9k/5oPMXHOzBJTJ2LkyyAgjR82P/vvG323E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ2cQS/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5590C4CEC2;
	Sat, 21 Sep 2024 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726938824;
	bh=ZRU+zZVOMIhxT8nfk4ydFoMi3Yr6y198NVau5ef9Zyw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MJ2cQS/7hmR1Z5qyE1Ol4UOD52J/D+6cHEQSPOSqf1c4KGAJZX8tPr+NrpAofA0+f
	 Ol5fhmICvayj6lB5z6V5r8SQG9OgsJJv+KnnMSOOh782haPyXoktrppBhCRvHy0PDh
	 iKw0mz+DPZWu7r3brfc5xlPH239AtTA2Ktv2x0ngTVXhpEELooNwdgASYs3Jlr7Wfv
	 9786E/RBbWvDuNbjT7YhzbGytaHIZXFmTax8oScCQcxUTFe6s+KVoWJQUESaJMBx6h
	 6WJ4pp64oRhcnI+uC9ryF3V1dptNC49GyG8xsdIdkHllSUME91vjCrqoxO8ZxuvdcR
	 lYO2VqcUhfARw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 345E73806655;
	Sat, 21 Sep 2024 17:13:48 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZuOULxlZmbvY1skN@slm.duckdns.org>
References: <ZuOULxlZmbvY1skN@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZuOULxlZmbvY1skN@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12
X-PR-Tracked-Commit-Id: 902d67a2d40f5b0815f4f627b26d91f96cc51fb3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88264981f2082248e892a706b2c5004650faac54
Message-Id: <172693882678.2537618.10044551650165201426.pr-tracker-bot@kernel.org>
Date: Sat, 21 Sep 2024 17:13:46 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 15:23:59 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88264981f2082248e892a706b2c5004650faac54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

