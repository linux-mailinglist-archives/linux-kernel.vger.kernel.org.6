Return-Path: <linux-kernel+bounces-426029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F009DEDFB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D2C281AD0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811662AEE1;
	Sat, 30 Nov 2024 01:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+PRZ18E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6242F3B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732929640; cv=none; b=SPVXte3vY8bJVmjwWoq7vHsrI3jo1ytvXGNM3Rmclo8kNZj2jZ6v4ol89fbtfLcRYwqb56qxuaiN1+NnoZDXSnqQOnjUUhwzmvFp0cWd70ZP1XN3lbQAaGLwrkb7u6xUMgmRtYVJwmJD+miDeTe2TPyyGn7lXNDVEzu6i/Bxsk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732929640; c=relaxed/simple;
	bh=ON6GKp1lr+sWntY4xxqUbiXewL4yIj79OBVvD1kqhR0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ri7oYGM1NZTcObMHpeSOHPV1Qj2AzluoDsDUcr1A4WZiZNUjcdYlKhxmR1NI8Q4HSOmXHXuxsHLXgFrJYai4WlqbJqq5BZ0cBNU8kv2Zmpt2FVRQF9X4fJCmxXMR8dNhKDAS3Z7B3/MuDoCOt4cav9zBVAFDZ3s+JE+I/nTiJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+PRZ18E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D55FC4CECF;
	Sat, 30 Nov 2024 01:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732929640;
	bh=ON6GKp1lr+sWntY4xxqUbiXewL4yIj79OBVvD1kqhR0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N+PRZ18EPz+fD5aw3a35QrmHvex5YXPUPIO1FQluHnFbVztaSF6dxg4kF61iGaYSf
	 h6Qc4P3nZydDmCO75y8H10IXxRUqAS8OKFUDE+WqtjXg+DqXX94HGG91ppMg6WMvP4
	 6QSA56yyhY2+aEpEWApEEA3q/qM+ItG9D8AsN5DMtWnfMSnqZtR0siW6rrZgd9ocCX
	 gVeCBZqrLYDfn57lZQtkIkOKAA9+r1J1kNsEmoNLr3SKxcvgIG4K1RGKL/P0XO8GSX
	 p/WkMnhgfiusAIAzHZGTIp0GaTT4Zj9mCIiPoIu/1IOuYm94RYcGcDDBRMV4J0+Mpd
	 M0t+1zo+RpISg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EFCCB380A944;
	Sat, 30 Nov 2024 01:20:54 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.13-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <47937a7e-5303-4372-9975-df4ab545a3d3@linux.ibm.com>
References: <47937a7e-5303-4372-9975-df4ab545a3d3@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <47937a7e-5303-4372-9975-df4ab545a3d3@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.13-2
X-PR-Tracked-Commit-Id: cf89c9434af122f28a3552e6f9cc5158c33ce50a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f15167014a15324f1439ea5ca375468e23c77633
Message-Id: <173292965344.2234000.5363125444999432431.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2024 01:20:53 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, yang.lee@linux.alibaba.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu, npiggin@gmail.com, naveen@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Nov 2024 06:40:18 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.13-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f15167014a15324f1439ea5ca375468e23c77633

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

