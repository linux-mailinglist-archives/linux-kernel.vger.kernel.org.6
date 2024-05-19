Return-Path: <linux-kernel+bounces-183227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B1F8C9615
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 21:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB851F21229
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5C16F525;
	Sun, 19 May 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLci2Jq+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2EF487AE
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716147417; cv=none; b=jEji/HwbManp7D8IfxmD9ejgqMNzZpYG2AHA86qa7IMMPuWRQed6pzOIKhAdo6KiqLpFqRIa72hqSjSmdL+3BDxXVApVCRX0fAaDrSbO/dWeMRpzBOLmHgbnYbGaPeo/uW8hOXMWXdvjbnOcT1brQ0oMgwsr9tSQSU41+EexQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716147417; c=relaxed/simple;
	bh=EApefsxSWnxafiutLQdWj39+mEqWyHXUQTxecUldJ+E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ed+AJ+mjHg4w+rwdV17ZmXXMj9ir4S+Ll6qGt1QyWa2xoHw9mjoOlGreb6Pbxfv0MjihQNLF+GKmfXri1EwZ7AJxfQ/w51rgH6ZJdu8YvxNeRDMdK5ridYOo9owOEdtWw1+3Z4q/SEJAt1DqlmREdfiVPRFSDVO8iXkxDKZOAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLci2Jq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FBFFC32786;
	Sun, 19 May 2024 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716147417;
	bh=EApefsxSWnxafiutLQdWj39+mEqWyHXUQTxecUldJ+E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rLci2Jq+OF0/3ZNULXT/uxFscleLI0/ggOHk/YTTGym3WKzUHMsHrnB6hWZ3kgvn0
	 xjfOXxM7biblXP0Edm1S5lMLIiPQkXF5lemDhvQtkgq/JMr+oWWPg9KZlozpngf/G1
	 5DAPeM+ZmN3CMnUHwZepsiiySFoq4sBctadKT1a5XEgcb7nP0T0UVRYxYgoC/ryxGo
	 8qBAi+JqWD9sH3M3fPvkr8oKwqINbEU9xABzqZRPOhq6qGMGmUfe+At5zlBDxCYJET
	 QrKSfCHN4gXelMoJ/BCS2qIBnsmglNEm7AYNylgt49VAqhMaIRL1TXHllG8EE+K3K1
	 XAE6KSQoWUzYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0260EC54BB7;
	Sun, 19 May 2024 19:36:57 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zkhu7l+25+vIOJd4@gmail.com>
References: <Zkhu7l+25+vIOJd4@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zkhu7l+25+vIOJd4@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-05-18
X-PR-Tracked-Commit-Id: 49217ea147df7647cb89161b805c797487783fc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8dde191aabba42e9c16c8d9c853a72a062db27ee
Message-Id: <171614741700.6582.9256213543966570770.pr-tracker-bot@kernel.org>
Date: Sun, 19 May 2024 19:36:57 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 May 2024 11:03:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-05-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8dde191aabba42e9c16c8d9c853a72a062db27ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

