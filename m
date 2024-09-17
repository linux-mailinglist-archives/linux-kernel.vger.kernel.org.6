Return-Path: <linux-kernel+bounces-331759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AEF97B0E0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 049F9B20628
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA851917C9;
	Tue, 17 Sep 2024 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WybwH7vs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472DB18E058
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580404; cv=none; b=r+iy9FSH0cV5Jc5WNVD1doVqeRXhaOTG3/2YkGMofd9B2kNt6zT+4LmG/g2bzEsNLuqN/mswYho/qeyDAwYst0/M0vu8NCLcNKueJyCMq4t+dflXceHqhgsb+6NWeyaDFqvu15e3W6tMGotF99VVF3orll43fGAqu9L1F8SPTGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580404; c=relaxed/simple;
	bh=EU5octwyaSDC9k/VvdlkBhMvc0+I3R8e9oopqJwuPNM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j7tZCYSIIc4iXxt3j5zje2JmSCbfVuLJQzbamRUygXEWHfcqiljimDVb24ZqixeW3/NNZ9cEcwdVDWVdjF2nS2/cvlMnq8h0qOyHy1mgXkzOlNNtrWveWZPhMsBhBaAKBqIVFHAtFig1+693IBMOTw/YAtwcd16lBb92LZltrHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WybwH7vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065ECC4CEC5;
	Tue, 17 Sep 2024 13:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726580404;
	bh=EU5octwyaSDC9k/VvdlkBhMvc0+I3R8e9oopqJwuPNM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WybwH7vssSwBj1V8DYqMckb12ukUcHkraAL7D4ImiKcIRv1inmKZW98NC+Hg8xbto
	 5F6rpI14iMFt5tgTOKmrzOC5iBiGcXXjMvwZmASd8pBpi+Bk7tDBXcQCCkTbBziGga
	 2bTE3Kk0XOtGO7fPq15SON1uSsyxzQAq8fdyRQ3v8JIaHXDvXZ+p2mbYoMFDS5K4nF
	 m2ThSbGosiXf6KAsv1VQVmPsuJO9OfJ+FgZV8o9VCRFAkaOQ4XvUob8oBQQShB8vMj
	 myKd7Rcbuoc2uX0aDgZXRRME2YTi5Qd8rpIEcL8eJVPhm5ti109jKGLBfU7KuLTUmj
	 DKG6DyIKN1W0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF063809A80;
	Tue, 17 Sep 2024 13:40:06 +0000 (UTC)
Subject: Re: [GIT pull] x86/apic for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172656198112.2471820.6226852046770294674.tglx@xen13>
References: <172656198112.2471820.6226852046770294674.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172656198112.2471820.6226852046770294674.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2024-09-17
X-PR-Tracked-Commit-Id: a1fab3e69d9d0e9b62aab4450cb97da432ac3ef2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61d1ea914b3556c44f9ca04277ab990a60afb44d
Message-Id: <172658040539.145065.5986299069716296883.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 13:40:05 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 10:54:04 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2024-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61d1ea914b3556c44f9ca04277ab990a60afb44d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

