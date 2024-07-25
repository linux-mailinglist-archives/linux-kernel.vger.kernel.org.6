Return-Path: <linux-kernel+bounces-262619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FADE93C9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77B32812E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51739143C5A;
	Thu, 25 Jul 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT4I1gcd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916AB142904;
	Thu, 25 Jul 2024 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939825; cv=none; b=nGvrP2zHMLdqV5AVEMEdmch8IRLm8knnMmCpcf4OvH1rHCd1dD1HR6YbjNJyG92JhNDWQ6amDvTq/4Vy24vidmC+hm8lvnH63qkCUJoR7pNlYChCyBYAJ4+A+FPwRscWtUjmtEwHl9xLIOoaZRSvkFcLfzJP1iKS+YIpfVT/4Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939825; c=relaxed/simple;
	bh=XsCPJNgVlLC8Wq1KstWYWqNOgyv6QbagTa5lsRmN194=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SVeVvSgNzWsD8HEMsIPLFtU9H6a0VQBG8FR2HI5d8W3dnOtXyGyeTS13aCcL3mu3vQExGYUjaMAT6z3XDPsRYAK0DCXWfD6OhNXlBfoJpfVJfDv6b8QOtUbQsOIkrnPIm63YWF0VCXtZNTaZ4y2KCppbPgKXqWldHc1ocn0VLEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT4I1gcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 760AFC4AF0B;
	Thu, 25 Jul 2024 20:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721939825;
	bh=XsCPJNgVlLC8Wq1KstWYWqNOgyv6QbagTa5lsRmN194=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aT4I1gcdlcuXxMlYZgIOCFpNglO80vhf12c9mWiDbPociCy3ISdd3TgFmoVyn+7a0
	 JvkD4V7yOmscO0aQSsQ/7hyDThNnz1CQ4tq0/kbBU1bfeQBHN7OaWAARLEtweiDACm
	 74ClqOMD+rS90DxJ+UmwUEy5fsJIeFNwVIt49SPpbRLEmlDiGCsV+A8zAar6YHwcPx
	 hVToChgzlsiIcs2VTiPC1n8IkrNRwshqQobtF6wEtHnI2qNPSVrYZmuNCVrOk35RM5
	 ttjQJ+Vd9Qm3GTmLGPVrMKsCnRhBRFyOKtkC1+QIMB838PLSmzQSJmUv5+n9evT/j1
	 fQxFtta/8BVbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DBE7C4332C;
	Thu, 25 Jul 2024 20:37:05 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZqFhAi7HqWJxwhFD@p100>
References: <ZqFhAi7HqWJxwhFD@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZqFhAi7HqWJxwhFD@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.11-rc1
X-PR-Tracked-Commit-Id: cbade823342cd013f1fbd46f6e3b74825fecbc16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6464295247dd04b2070e110f0d5659577e393b9
Message-Id: <172193982544.17931.3325438373686147349.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jul 2024 20:37:05 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, John David Anglin <dave.anglin@bell.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jul 2024 22:16:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6464295247dd04b2070e110f0d5659577e393b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

