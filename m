Return-Path: <linux-kernel+bounces-560236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24553A60079
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597B788052C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C531F3BB6;
	Thu, 13 Mar 2025 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us1SZumw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936C01EEA51;
	Thu, 13 Mar 2025 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892647; cv=none; b=UrC205Hf8A6pZJC/x9cYRO3VZLx/ZzehuXXaxGQKb18V9C6XgNvCDx2DuSpO3hFcx40c+Ep53SyhhF/8pu7byoGy6ORpVFIr76HV3n6WuEIZpLWCqlSr/xpsXB+lC3dJ3SUextr5rDMVdnRsqap0/NspjSBYs1jo3/ypEOEqGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892647; c=relaxed/simple;
	bh=Ztf9vNFif09y/RfyC9fgjzGbnK1TescTBIegpKTDVgM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q/EjR1ChBuJq9O7Bbc113Bug5Kf7vLDPSjAoz+C5LHkd7OnhYZZVL0d8fiakmjF+kKv7Ny0fCZL3uIyinmkgs2ftiXCsYM3IhA5SihrfDhHUnNUjX+JNR1KANKgNx3+x76DSnnvvOyBckdNJU0Ix78C6xnSAjT0gBMnd6rXAHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us1SZumw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BA1C4CEDD;
	Thu, 13 Mar 2025 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741892647;
	bh=Ztf9vNFif09y/RfyC9fgjzGbnK1TescTBIegpKTDVgM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=us1SZumwkQaYCLZiWAKftOKj5oKO8Q5mOymG//NEIH1alNbE5NwDYxp/aVcv/O3y4
	 wr9v6bYJ1ojE85MCYB5ELiT3TagSEvuXUP/I2wjEtNLPB43Ck1mMEKqp3RIotr431g
	 J4ogZeOstmoHPYNKhzlqAv2Zy8ceh9lrmb8N/dM1zRjlkPJlqykFgVO1Jo+l4pfyiz
	 yk0WupDG7Z1T43vV3FJIGM2yvqTBuusmLnQLt7DJQc35XyQPStWAuFQLNkm++RNlwO
	 vupnrjCGhdc+nLJumL+XtO8tPghWORL6gnuPokOQIHrBFXVYjcjC4boXcuSVCHk+8k
	 VchFX2ze+Z26A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3421F3806651;
	Thu, 13 Mar 2025 19:04:43 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250313-vfs-fixes-a0e878b9a930@brauner>
References: <20250313-vfs-fixes-a0e878b9a930@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250313-vfs-fixes-a0e878b9a930@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc7.fixes
X-PR-Tracked-Commit-Id: 986a6f5eacb900ea0f6036ef724b26e76be40f65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f7617f4500900f39b604ca724a34a9cfd1fa63a
Message-Id: <174189268180.1632354.8919916520085745154.pr-tracker-bot@kernel.org>
Date: Thu, 13 Mar 2025 19:04:41 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Mar 2025 10:13:15 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc7.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f7617f4500900f39b604ca724a34a9cfd1fa63a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

