Return-Path: <linux-kernel+bounces-417485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1099D54A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B821E1F2208E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480261D932F;
	Thu, 21 Nov 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPBuUD/X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6941199FC9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224030; cv=none; b=EIDv1WFYr9OwVlmRraiq5RNXntDip9SrNWAEVfQxUG/14b8fg0NEB/j/omtKrUk0tuykdUYhwbf+jGMPG/al09yOH8J1jZOFP0JOvrPLozd97V/AmUUV/MsnagOoaCSbVxzb6whErIhfPOjJHdo3+yi9Zc1QQM23jCNqsHVofN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224030; c=relaxed/simple;
	bh=hjB7hGiRI1B3zgRH/cJj75oU8tUs/C5k/s1NO6Yj3g4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IIpYPAi2/lkegy4pz5VBHKs8DqGBBuopp7QMd6y6OfykTubL4TZlZaLHPA5SyvmbWHbR+dTSH6RGrD+sj+onmyzDFU7ocM2M7ORacZ4VJconk6wskM/nrbSeXYW1de2s3JuIDVsn5PbxcMX0ZlZJEcYFaYcTfsyjjJFrJNpKC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPBuUD/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA42C4CED1;
	Thu, 21 Nov 2024 21:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732224030;
	bh=hjB7hGiRI1B3zgRH/cJj75oU8tUs/C5k/s1NO6Yj3g4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FPBuUD/Xkxkv+iEwW185FJ9ZjxVomoPW5LwTjfdS3Cx78bp6FP+syw/by4CVXDVJ6
	 SbWr9Lj4QwApX3ndht51q8/8EFzOpGbF0D4lByP+u4UI+2hKh5s6cbmUeUPVlWwDWO
	 ZijNi1eDxL1Dqb5muNSFccsw05p+zsaIkU10BWEL7OiHilezaJyUA6Y4CpErxxvqMX
	 lWojdXfXaaw+oc0oyZSaTYe8Xb2vc3YVUgMMVXQkquGrsVlAmUfoiagLVazyahuZsZ
	 pAAIdd6wrfXP/asiK+RQy7ZLPc1yQSYlH6HqR0sWNKV+3BbJAKwzF1Y9h2VCzAgEIR
	 DCsTVFrK6r+Dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF6443809A01;
	Thu, 21 Nov 2024 21:20:43 +0000 (UTC)
Subject: Re: [GIT PULL] configfs updates for Linux 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzzETmfaH0rI6keT@infradead.org>
References: <ZzzETmfaH0rI6keT@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzzETmfaH0rI6keT@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git tags/configfs-6.13-2024-11-19
X-PR-Tracked-Commit-Id: 84147f4e84c4f4822006161c5ad43612ac906407
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40f48f82a1390709207ee6b06939dfae5521316e
Message-Id: <173222404225.2113184.14555608909895963416.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 21:20:42 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Nov 2024 18:01:02 +0100:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-6.13-2024-11-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40f48f82a1390709207ee6b06939dfae5521316e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

