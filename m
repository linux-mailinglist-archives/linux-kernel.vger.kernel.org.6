Return-Path: <linux-kernel+bounces-331753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EDD97B0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F0F288C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A9C188A31;
	Tue, 17 Sep 2024 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/teJCGJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36BA170A07
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580394; cv=none; b=lJMGYiRkHpb2ijOEwKKTakL2lcwfWwobEFqILpwhNSYEH7mWaoBBZWWD3kHTE9DBUixguTj1xOq1RkZW+kojcnqsAVVdsPsYnVPpd3xW4ZhU2glnZDyrIbLJOuLYI98XI6BwSncfMiDT+WlsMZOlIN36h8Zj5OOeRrgI2gopuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580394; c=relaxed/simple;
	bh=YT+/MQjhqWW1zEkg15JfUWjQcefJLgCvhbsG9IC3974=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Hh67Rv2oQOeZXGko1ePsMaL41iek9llmX8TtKryzia4WPmw1VVRNQaU7m3rVD4fYPDVtX6NOaEb8bOl5qZLPtp+1nRcSFkt6gMOeFWUkgeywn5JLcrTY389jNx5FRCVZmzCIs+RxRHjHK/9J7SN6NCN00rNvYjx5kYf/mQ9s5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/teJCGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAFFC4CECD;
	Tue, 17 Sep 2024 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726580394;
	bh=YT+/MQjhqWW1zEkg15JfUWjQcefJLgCvhbsG9IC3974=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L/teJCGJXsvxf/dBN8YbHZTglZ1LQar+D9K4HrbpYuDlgVXSZ3iBOQa6RaMFtQ4K1
	 Oo1OaSZpFkueMyvfewa7RE+zs5yoS9iTHzp7FTezJ8P6d7SpO01OnTsuydOljxrfOB
	 duf5gaht791hbYNEmIJXyuR9GF0JT+WaX7fFgwqiEAUz0AiYN9utL/XCdiigphULtE
	 d7LYE5bpUsMfHirowRFrHutmLI0UgxZC/E1Yy59if9iAYIuiv3sS/IijfGQQFxQyt6
	 ke7QRS8E0r8RnC1mdaWc2nRcP2VohZjz4wncIgQ8C2wVeUwYpDLIcZdelSFk7AWEsa
	 XxlU9u6njAhfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B503809A80;
	Tue, 17 Sep 2024 13:39:57 +0000 (UTC)
Subject: Re: [GIT pull] x86/core for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172656198591.2471820.16405077089777095536.tglx@xen13>
References: <172656198112.2471820.6226852046770294674.tglx@xen13> <172656198591.2471820.16405077089777095536.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172656198591.2471820.16405077089777095536.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2024-09-17
X-PR-Tracked-Commit-Id: 7424fc6b86c8980a87169e005f5cd4438d18efe6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dea435d397ab90d8e682e4162a5b9835d24b1e3a
Message-Id: <172658039612.145065.9349631986617459238.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 13:39:56 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 10:54:09 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2024-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dea435d397ab90d8e682e4162a5b9835d24b1e3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

