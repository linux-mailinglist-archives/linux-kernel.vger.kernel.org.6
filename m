Return-Path: <linux-kernel+bounces-415097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9A69D3184
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DAC284304
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565073C47B;
	Wed, 20 Nov 2024 00:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9PV4Hso"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C53347C7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732063756; cv=none; b=Sdu5LTsGNMflAZS40IUoeRzb5BziFCC1zbEZZrzek8nel3MYJRdQpS6JX8g+E9z9uSWrjBS8+zwtrTkaQ2jW9GmXBiAgLBX0mJdjnpM1+4zwUEzI87vS/z1XK4I5tvLXSfhsei5+sShZUkcdDi3QbX1d5BdwhT4LnHZzsrvkNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732063756; c=relaxed/simple;
	bh=VSNsLpLieM4jpSkyH0r+ytskv1l9TCO/MtPtMx4e3Ng=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Pbyd1pOiNGlp6DzQls7AhhgBoqfWvSWqsW4V/A8GoG53h9TK6ijz9GNMvEqS4EKqtl4ymOltxWrTcWsqjt1ebON8xH33wTqFM+cOhIXrXbHjQmMiiroKad3+YS5LYiOkaIErkvyF6LSJR4lkMlfms6x0+5CW2FSZnyhgFSdg2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9PV4Hso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9857BC4CECF;
	Wed, 20 Nov 2024 00:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732063756;
	bh=VSNsLpLieM4jpSkyH0r+ytskv1l9TCO/MtPtMx4e3Ng=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y9PV4Hsod8ZDFIjxRHvAAmeLDJnhYtHxM0zhcKNQBOB4NyPTqoejTr4KxfKKMg9rN
	 4yeWXGRTPHpsk4ZQLKIpodfe58fWrPHv5BB2KJWlcpUGcIwlj6bdHjnztB/B+LC1Ax
	 md4po6NdJs8Sn4STPNqCaM2sJhMUrJLiAT1M5X3GINU9549AD2cPOghn6kA53YBt+g
	 l5TGwWL1lanN4PCqICBfZ+sMXUQ9q7MVdv4V0j3S2paFt/2/9LcLTvsQ5R2At2ZgDW
	 H7HM92NUJE7vNrH6Zj3FaokeNeFkcm6whS43JAANi0CofOGqFh68u4Bnrte/IsrCDo
	 bvvNf4u4/6ihA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B5B3809A80;
	Wed, 20 Nov 2024 00:49:29 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <173195758632.1896928.11371209657780930206.tglx@xen13>
References: <173195757899.1896928.6143737920583881655.tglx@xen13> <173195758632.1896928.11371209657780930206.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <173195758632.1896928.11371209657780930206.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-11-18
X-PR-Tracked-Commit-Id: cdc905d16b07981363e53a21853ba1cf6cd8e92a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf9aa14fc523d2763fc9a10672a709224e8fcaf4
Message-Id: <173206376798.738777.12194901087431003045.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 00:49:27 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 20:21:57 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-11-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf9aa14fc523d2763fc9a10672a709224e8fcaf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

