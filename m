Return-Path: <linux-kernel+bounces-331752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEEE97B0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2E11C23D74
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11EC18594F;
	Tue, 17 Sep 2024 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7SuayFw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE6187554
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580393; cv=none; b=uAJwCaxPBImGk4AexBBH8FfV4Vcw1/74DwbRGSe5FhnMnmKvr9OijdyTdBieP3TE4px7xQSx2sfIpgvvCtvTufT3quJPHp7+oW8MJWfxqhveBloBt7tPUKrgMaUGPuMshruku38/ZSI4hXuBNDyp0L41xe/UoYgLAIwUjUSsvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580393; c=relaxed/simple;
	bh=E2jL6cLWa/dHId5a1zJi/PEUZV+DMfih0OoHGyT3Ldw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jDs3GlBUML+hjuTlgnsTVi1sRRBgYujaVA6Ou/MWuY0NoMBiQ3lY35iCIHSaDnq5f7YoBGu67UpV1vpmJVLUF4PpgSDL8aY6z4VdQeFhJm6NV5MEn4TjoqNM/bRWhIrbDM9oJ7NtH4s4wAFWcRPsc7NQaOJ5h3P5gqiG4rfs1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7SuayFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFA0C4CEC5;
	Tue, 17 Sep 2024 13:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726580393;
	bh=E2jL6cLWa/dHId5a1zJi/PEUZV+DMfih0OoHGyT3Ldw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n7SuayFwPmSbgbBucuYJ/53EXr/gyWEI5aKBYUEBD3Ep5NDzRPm6/sYpCWuk1Db88
	 M3Y9BABHOiJtHE62Kc0bXLyyfBRT0xW0tvp1thRfHBFEsbcFM2Exf2m7bVdoe/2Jw9
	 ojT++NxIRjj54pTjRVjiHGX8QlySE06EIZTLUzIZrA0RZKCp96LgH2vXLemJ7z40Ue
	 pfUB/uZE4a4DpbuO5qMHk+VSdiEcdfAJgHZ7BJdgUPi1pODBBIpvMq/oWIIhe2U0RC
	 RdaMSd3/zpbO6g0iqsdj4wJW2uCIHaND4tS11EhiV62GIzgSd/kqiq6Rn/Dp1vkxcU
	 WVeuoiPhyXGJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF93809A80;
	Tue, 17 Sep 2024 13:39:55 +0000 (UTC)
Subject: Re: [GIT pull] x86/build for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172656198283.2471820.288980349418658549.tglx@xen13>
References: <172656198112.2471820.6226852046770294674.tglx@xen13> <172656198283.2471820.288980349418658549.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172656198283.2471820.288980349418658549.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2024-09-17
X-PR-Tracked-Commit-Id: ae94b263f5f69c180347e795fbefa051b65aacc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ba202a7c986fc58dd2fd1571c99667ab2699995
Message-Id: <172658039443.145065.9904615773465612797.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 13:39:54 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 10:54:05 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2024-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ba202a7c986fc58dd2fd1571c99667ab2699995

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

