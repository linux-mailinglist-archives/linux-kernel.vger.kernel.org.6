Return-Path: <linux-kernel+bounces-331338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D8297AB77
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CACD1C27B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202671591EA;
	Tue, 17 Sep 2024 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeyNyAU+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0475C155C97
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726554945; cv=none; b=QrjyRm5IfDO/d4wayXJe4LLiaZYKS4yKSQIVaZw1uhmqHRSJeeQyrFqYoHKXohc/0KifJ2ptg4SPGFDivN/xzCs7xr9nn++W/vRMYQ8X2Q2cmFiRyr0M5yRQM+6Mm7MdMBqXmRBL/4sZJapR2tB2GVqLGkL7tmK9WTTzVB5D1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726554945; c=relaxed/simple;
	bh=oaOzQykuFY8YISENDdBagzuojoMeLMCTwKMOCbsP/ag=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RWEQIBAsBYltV7X0jshMHqvOtrZh7DI6vMevLco5TBnKkFNcXcfuPmJY3GMXyL2zxWXDQBZq+UCn4ATrq2YHV3JS5lnnjDTGWC2C33/ZhSTBqDmG8tZqm5v/jAjElemsAx4jOpcsYrTKOs90iAPtPKCNU/tgNtxZlra6CjtVaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeyNyAU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3869C4CEC7;
	Tue, 17 Sep 2024 06:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726554944;
	bh=oaOzQykuFY8YISENDdBagzuojoMeLMCTwKMOCbsP/ag=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AeyNyAU+Mfzkt+vutAsm6lqW4ZuQhKuuT8iplEn0+FZSa4CJ38Um2BtYvmkV5gFmD
	 +P/f4/Rlvm0YqNjht7QOSOLRrj7hPQyazZUnpngsM2g3YLI825WK6GpuBX1O2QAr1x
	 Nyir47NiPXRk0XDGiqFZHLa5EXRmmZWG7SzA0uFYmW+ptNeumcIhCN/jchWyHfQ11S
	 apfSVakYagjekiioUs6/DZjp3dcyZvjMcrBU2tXFDMZFjqEzGyKMeBssCkcKHapnXG
	 9hhGnRIGwiqw/QMGYj2TREZBaortM5c4IS+HOc/f/iYqgYGBudRCmcLDJPaEm2YTSO
	 gOGcJh4W6/M0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2DD3809A80;
	Tue, 17 Sep 2024 06:35:47 +0000 (UTC)
Subject: Re: [GIT pull] smp/core for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172647589238.2450257.17734472985835252214.tglx@xen13>
References: <172647588843.2450257.3544233832195550173.tglx@xen13> <172647589238.2450257.17734472985835252214.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172647589238.2450257.17734472985835252214.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2024-09-16
X-PR-Tracked-Commit-Id: 1d07085402d122f223bda3f8b72bea37a46ee0c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97e17c08a428b17531894b59990d6b9ff3e95eab
Message-Id: <172655494636.13787.14423072036219778515.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 06:35:46 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 10:38:37 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2024-09-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97e17c08a428b17531894b59990d6b9ff3e95eab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

