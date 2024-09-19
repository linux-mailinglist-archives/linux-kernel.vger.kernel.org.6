Return-Path: <linux-kernel+bounces-333613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F0C97CB60
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4568287426
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9EC1A072D;
	Thu, 19 Sep 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldW8H1fx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF661A4AC6
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758618; cv=none; b=BeItppqmxlE6r7Ulneb42Lp4y3dbvKHWwb1Y4DMRga2Z1BlC1K1TG5UGlTkKSfvuVCA4cR5eUNoFdC3yw/pT6gBhhCoV8QarjPRJKNRf8Mh/2mmNle7e30fcRCic0fkwiTSiRHsfgKN5vk1TM/r5vF28k0+d9lZIrOV6TZY4COo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758618; c=relaxed/simple;
	bh=QneIcnwySL0MhW8hrn3OKkQL+93MnXOJ2uUT2sznJYE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Cinu/nuVLtwoDdop2rGZ31EbcDuATeOGpmezrGxK1wOWsFQISymH3imvlDGe6pWf5hN/OvtS39cy9za7ua9QbSDa6k5YzNwk51UP5FyQmD9iQk0FI7xpu8SzYCYBN7xjOJ8D/3VA6PK/Sg7vOYLYamrfFpkAOhzCDWBLcziExCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldW8H1fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECBAC4CECE;
	Thu, 19 Sep 2024 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726758617;
	bh=QneIcnwySL0MhW8hrn3OKkQL+93MnXOJ2uUT2sznJYE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ldW8H1fxF8p8X9B8qxUAXfBX0K81vmN/9fQ8fiWQ0wz60Wufmv4P/BLdQ8CdgBoVc
	 hNoKjdx1cyg57N+1JZ42PeVg625qXpankoPdPHl3OcA7UpS8zy4Y2xEEPx+LJSbAz9
	 SaCbclOzYCJC6kPdCMAY3du1RibIHc3rMQ+/c+2uK9RrGU8nlfObWedV4tkLIfuCk4
	 3Q7jDbfuZagbikUk4oPobbOISwTwyF19FPG2JF3erut7QBrY6M0Okwv7B0yqA1ZLVu
	 OgpIeFHOYJy3vf54V7I9Zrtp+kxwzryZrXOlp+/Hu+HbVdb+dKLX8vX85fpa/pKQdf
	 69Jdk3MF/XU8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 92C3D3809A81;
	Thu, 19 Sep 2024 15:10:20 +0000 (UTC)
Subject: Re: [GIT PULL] Scheduler changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zuv2PZQ1GWpxhQB9@gmail.com>
References: <Zuv2PZQ1GWpxhQB9@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zuv2PZQ1GWpxhQB9@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-09-19
X-PR-Tracked-Commit-Id: bc9057da1a220ff2cb6c8885fd5352558aceba2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2004cef11ea072838f99bd95cefa5c8e45df0847
Message-Id: <172675861953.1588903.10426895231963532928.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 15:10:19 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Sep 2024 12:00:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-09-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2004cef11ea072838f99bd95cefa5c8e45df0847

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

