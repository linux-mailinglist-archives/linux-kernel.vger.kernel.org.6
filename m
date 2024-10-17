Return-Path: <linux-kernel+bounces-370318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 488689A2B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF202859DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EAA1E0086;
	Thu, 17 Oct 2024 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPbgcS84"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D1E1DF981;
	Thu, 17 Oct 2024 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186450; cv=none; b=M7ylYBqR3JCDWSCP09CumTbm0CLGInIiEbCR51yM2VrTmQdYbJ7Tf/wxs5fZ8e3prafUykqH3kPIZDb6Pc+JsogjYF2nyAwDmFLOLudlAkc1clk7PbhWqKOLjZH+t5bNV/1eMSlpHdF9TE2DRXnwPVSxs5WFYPMxY5+ZjGAzByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186450; c=relaxed/simple;
	bh=1qcOgGQuvXWqNYOOJfcVjxoFT1Sy4bXaH0oDRj/yM6U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mfDFiV9Frssp1L8s0TMFZh+YsVSPe/Xe3H4LoxNnMo8pYiINOC1CRvoO/snKKsP9PNWhzAtelsdEfgGMBeg+/e69f+RY0SGg1RVTqG71wEiGEv0heeAnhfDTBc/a/+ese/MtJ1dc54fgG8/B8jMwdPkY0NTIU9gQxmksZ8DAspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPbgcS84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772EDC4CECD;
	Thu, 17 Oct 2024 17:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729186450;
	bh=1qcOgGQuvXWqNYOOJfcVjxoFT1Sy4bXaH0oDRj/yM6U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sPbgcS84As5SqnwyQITjwP5QELXVpVnITYaw7eq7tD2NKpllqUarbOAWAO1IwJx3v
	 0GgLL/llf1snwLEZ211YN8kQV1D0a4h/7SHKofhRx5f/5rQNkiLlyONtMoX4RTWKsV
	 dppdi1CKANK/U7IWF9B/tA9+dzXGYbre5L0YR1LtudzHm8pO+llgbS3EYPdr7b50QI
	 4sI5lHWLUcOizdYAMsmNipR1R3ObsMQLSLHkLJeQmgMlKNIdOTdb5omjbzSw7g5EpO
	 6uzi0lsRVhuZZRsIwuACSGlLpeMjcT3aZmag/ZZqiOW3TEJudv4xNSP3H+5n/loOQn
	 T4WiepnutfTpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340C93809A8A;
	Thu, 17 Oct 2024 17:34:17 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <87o73ire87.wl-tiwai@suse.de>
References: <87o73ire87.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o73ire87.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc4
X-PR-Tracked-Commit-Id: 164cd0e077a18d6208523c82b102c98c77fdd51f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c94bdab3a32e6225b30df6650337ad21ac42551
Message-Id: <172918645586.2551340.7680388120042328452.pr-tracker-bot@kernel.org>
Date: Thu, 17 Oct 2024 17:34:15 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Oct 2024 16:33:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c94bdab3a32e6225b30df6650337ad21ac42551

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

