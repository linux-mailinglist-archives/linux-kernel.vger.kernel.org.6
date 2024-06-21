Return-Path: <linux-kernel+bounces-225170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FEE912D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7D61F254DC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8B17B416;
	Fri, 21 Jun 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enQs479R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEABF17920E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993447; cv=none; b=iz9Dr8nczFLXvTdHxMbJP3lTeMqsmvaNZbeH0W4ScWCzk3u+rcyYlJVABDNmZVjGQXh3UYblGow8rKs8f9uOzgGxjEUeaL2L21sEJGN5feNAM0ySfyetsY/wk0YvWphn8qFO3PRHn4EhhV1YfoAOhf+0A4JBunmamIhw1XPYqLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993447; c=relaxed/simple;
	bh=O3Kc71FtZM8Tdr0A4m8RjCdJtg3sUZS8NTOcQTcy4Qc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UYD4lnwwbPHNz/IGpqthcklDwgkTU8b1YJZ7Kf4KmXaxtrbOO6EeWe+NNqtVbjkNaQ6rnqwE+c0dD2bcgY+DqWTL1G3VSRXPKlajmrdwcbHuJjJI53ZnmGZLVKEaeVY9AVYGhwCnr43eBuVewvDYZLAYb3svU3obskTIrMfPbwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enQs479R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B790C4AF08;
	Fri, 21 Jun 2024 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718993447;
	bh=O3Kc71FtZM8Tdr0A4m8RjCdJtg3sUZS8NTOcQTcy4Qc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=enQs479RW/gF64y3my+3dxRvngb3BrLMyBIiqgqQwHfftL59s5nWzDdEX81t2KMGy
	 beZ/UowJ191D1wcOveUCcBJOYCRLtNTrTGschagIoFtFw38BLBQ7SXZAfURYruqoTD
	 jDdYsr19+wRj88zp30BdCqX8goC3Lm3BVzmOJvbgDxb4o2GZzzjoPoWEongT9gRFLD
	 jZSek8uq9eGf3AFpJwg6kJlIclES/B6Wz5UbqJX5F9Fvi+6EC2IonBR5ZH9uRrt3/h
	 1+BGgBJeRhMQNiFOn8/VlZa61OCanZC2/Spp7hCPZMdRipj3u2Rr4PYuYAl92OkY9F
	 BDjBDdzztMO5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68D10C4332D;
	Fri, 21 Jun 2024 18:10:47 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy fixes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZnVNCogeCFcQH1jH@matsya>
References: <ZnVNCogeCFcQH1jH@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZnVNCogeCFcQH1jH@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.10
X-PR-Tracked-Commit-Id: 163c1a356a847ab4767200fd4a45b3f8e4ddc900
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a21b52aa6e98187a82956e296efde5f2521789bb
Message-Id: <171899344742.17423.6080265678268549994.pr-tracker-bot@kernel.org>
Date: Fri, 21 Jun 2024 18:10:47 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Jun 2024 15:21:06 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a21b52aa6e98187a82956e296efde5f2521789bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

