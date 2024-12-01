Return-Path: <linux-kernel+bounces-426733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B259DF718
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96026B2153C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 20:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0751D958E;
	Sun,  1 Dec 2024 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRqhLCUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516D71D9341
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733086207; cv=none; b=dV97DoYYkLQWqjKuIFv+zqKCgLtqf5wiIHfvXmmZ1c5fmQ/WT6Eo42rNsnQ1iEZ/8zArxV5wPB0k+4vIybJtX1yt2Y8zYfyzy4Ujh60LP+8d0JE644x9pTVMlw5Gzai+BZvgaapqiuy+WmSHlgLOG4lRlAg/ki0PhmUmRMWAnUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733086207; c=relaxed/simple;
	bh=d4WB+q3JL3tvcD3iIU2spJ6gN+XIR8hAlQcL05nHyvo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mVeF42OR/B1FQAupBp/9Ln9FMS+sCXC46lbU/TMborKdmbUj3MQ5hx0pVWST4PKTmNnUKXI/2TuEtrENmYYj9uz69hFVcPIyp6mFXxxue7pr+kWAlxeJ0ySZNwLHHkool80zPfFxu8LVvzm0Y+Xvw/GQTIkIrC0HQv1kcpVZ6z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRqhLCUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A96C4CECF;
	Sun,  1 Dec 2024 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733086207;
	bh=d4WB+q3JL3tvcD3iIU2spJ6gN+XIR8hAlQcL05nHyvo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mRqhLCUv8adpJFOGPVRSsGjlAJnxG92fWhgCsxYoOy2o7dV3e/T6IVZRYwNvtbByQ
	 ZG+H4jRdrBlscGQxBeyKk3a9AmFl4L47DFVNFo3yJDf8JA35J6/y5FVQiagK87Vx6i
	 zDANz8yzHy6b5fwba+A9zTuibc+o5UnsYYyER4JxDA6giv2hrBlp0ws1R08RwQM0GC
	 q4yCtJOm581WceDPXGXu0qNoSRStVJTFD3prN0iqeEAaQ0OFLS3GTIUJfGwVgo5Ccu
	 INJVNSNtprP4uWGBmWQsQMEd0dzJmdrniayZPF2kltl6XOJySk6ifUu74PFSJQ9nbn
	 4p+rgfrS6AxZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EAF3806656;
	Sun,  1 Dec 2024 20:50:22 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241201105802.GAZ0xBOqZH001RiV4D@fat_crate.local>
References: <20241201105802.GAZ0xBOqZH001RiV4D@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241201105802.GAZ0xBOqZH001RiV4D@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.13_rc1
X-PR-Tracked-Commit-Id: cc47268cb4841c84d54f0ac73858986bcd515eb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63f4993b792efe9ccde7302184d0184d2c52a9b7
Message-Id: <173308622068.2752601.16784975281602795780.pr-tracker-bot@kernel.org>
Date: Sun, 01 Dec 2024 20:50:20 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 1 Dec 2024 11:58:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.13_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63f4993b792efe9ccde7302184d0184d2c52a9b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

