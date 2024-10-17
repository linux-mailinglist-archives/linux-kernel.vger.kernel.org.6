Return-Path: <linux-kernel+bounces-370315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D36A9A2B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 576D6B2352C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CE91DE4C1;
	Thu, 17 Oct 2024 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIUxrewH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C3415B12F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186442; cv=none; b=lzFgSeq6605Gzcb4qxc9DKCUn3I2x3CXcZDSi6ry0FL3RK03+qQIgD1leKdHTUjGot5qbTWZRZlCbaTuzT4lf0XZC1/IN05knYri4AZofb4D0h+OrrpsT+UT06+8sHVsfMR62gVL2sn8jtt991SaUOkUwVreJCzb6AACUBTL4oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186442; c=relaxed/simple;
	bh=MUFtgQfmZAuFlya8WjezSpmDNFj7iZFO5thag+for1o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=be4UlytBfPPGno//KxjTQZppkPyXvUtcT0McMuAQ6Jso743R1Ydjk9TyTwyxy9s49aYsmLlX/vxeQbTey9CHSaJjthc+3dDAtYg/yk917PGYrlJtstzMCLfhAtm77u+IdeffMYEcMtnTt971+c+1bOubN6EWYGZVWKfB/2hBOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIUxrewH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C71CC4CEC3;
	Thu, 17 Oct 2024 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729186442;
	bh=MUFtgQfmZAuFlya8WjezSpmDNFj7iZFO5thag+for1o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TIUxrewHqiIumnWpZ3+WzQOr1rAIpxAyUKjTKmnKtrOKKNq3KEx2kpXPiTF225vOl
	 4G8ol7Iar+cmnrA8sndira43yVW780xRmQLSR38oQjAmQseiK46FtoYMiLMX/d8llf
	 TKZiXXmZ0B7pJB97l+0qhwijc/djNoyH/Omke0HHERmlvm18p8W7Zqx4eUM5qwZ158
	 0SQ9jaFPyU1DE12Qypa2J56O4gftVcaDeDs4jRrRCAzevE0ZVE49jb34lqdmgoTEVd
	 h7hg9fZy6JDQfs+URgsx9s0SGWjnd5JDLmZS4MKZ+ua5ZfFBa/s6FWs1aWbx4+Tslr
	 aeqvAFa/bF5EQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341CF3809A8A;
	Thu, 17 Oct 2024 17:34:09 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241017153407.GA22230@willie-the-truck>
References: <20241017153407.GA22230@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20241017153407.GA22230@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 7aed6a2c51ffc97a126e0ea0c270fab7af97ae18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6efbea77b390604a7be7364583e19cd2d6a1291b
Message-Id: <172918644765.2551340.12290081451586761172.pr-tracker-bot@kernel.org>
Date: Thu, 17 Oct 2024 17:34:07 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Oct 2024 16:34:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6efbea77b390604a7be7364583e19cd2d6a1291b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

