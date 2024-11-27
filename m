Return-Path: <linux-kernel+bounces-423985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD869DAF0C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50FD165861
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EF5204F69;
	Wed, 27 Nov 2024 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAMFceF6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051AD203707
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743701; cv=none; b=MCBMchcPvPbdj5UZedUISSLQUn9z++oApiJGOhzm2ubCZ/R3D+PPXxVvjdYABGkrwW9rAqyu0xVqPy7VNpGhyshgFWSVObP1bP1oPcWL0fW3izWBupR3u3+erKkd35U2VT2dm5ougWVzFjojDqiPIY55XUtweAxnsrR1Z9Kp0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743701; c=relaxed/simple;
	bh=jOqsBc+RrcfK/6UXPNIvCF8KocUfII6vdQdoOJ0wxZ8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QAqcF/TJvYGwXb7guS0Dqg7ORcJK5F+4tosGezyyWVoFTDtzh30OjGokZ9QIhcgf8Uk9yrlAG9t1bq+T7VJ1ZRW+a909LLSL0yyRHcs22MKhk6GUuT145KhwNWt3wjaghUu/7EmkrWoWPF/MYqqY3r2UE95TNykU2IK4s3dwjX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAMFceF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB11C4CECC;
	Wed, 27 Nov 2024 21:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732743700;
	bh=jOqsBc+RrcfK/6UXPNIvCF8KocUfII6vdQdoOJ0wxZ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lAMFceF6cNTRqbLK7sWXaeo+1yDgHQt9V9kAk+kBxLeESpQtKJYi+H3ptvIQCmrkC
	 dC/eK8eLZ2quQ8Ca9a0q7SsCwerEbPC6Wln/9FIJjyO+UqrL0F09SDx3mC5QowP0cb
	 g8VqEpvrs/HMQ5kE77NC1fDmBe9TKRy9JqyBn+H2DdCRSp1iWRk4lYIZmno3jZezxN
	 23/Uldn5mvl+IuhIUuKcgNzFVLIif1KM6wFCrFLB7qb0jSm1HjzIcfqD4FbmyDNtwG
	 XEt6f3gYnpvGhPTS3kJhal75lg8Y4IyjXAVP5ex4CRLHP9EZzXgtJ1FviCYWQWBpeD
	 /WgwiLol4gOXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3458D380A944;
	Wed, 27 Nov 2024 21:41:55 +0000 (UTC)
Subject: Re: [GIT PULL]: Soundwire subsystem updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0cMfSejvRoYihYJ@vaman>
References: <Z0cMfSejvRoYihYJ@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z0cMfSejvRoYihYJ@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.13-rc1
X-PR-Tracked-Commit-Id: dd690b31de0ed46adc5856698880560b900386ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ad55a67a788c0806b0fe23be36fae6dbfbc3fc5
Message-Id: <173274371367.1220377.339796815775939280.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 21:41:53 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Nov 2024 17:41:41 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ad55a67a788c0806b0fe23be36fae6dbfbc3fc5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

