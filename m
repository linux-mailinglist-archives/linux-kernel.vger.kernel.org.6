Return-Path: <linux-kernel+bounces-189539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2CA8CF165
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 23:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94311C2094A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 21:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C946A129A68;
	Sat, 25 May 2024 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9mKDJ4m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1553F12A151
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716671315; cv=none; b=tKqcOW6f2GEmTv4TAPSG+7PKV7kRcLLMGr6SYNvnzPngIHtI7yStFF/FJ/qG5yAHL9mOB2bp2yOt1J9U8eXNcYQc3lsnBmMib4U1mgt+cbcebjMs7SOnrcx4ZO/LVMRTt+G8fj8MLjLqQUYNVQ/2f+E9i6stmkPQwgK7rZfVlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716671315; c=relaxed/simple;
	bh=JDCFZ8HEb0NTJwxJbkUKLE+BhXBP8waLZLT+EsxImRQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mLHgw/Egox7TwB4XxKdC9UrTU+qleIfUBa45WgLc/ogTr1fUgbnxg4b5W/e9ygtTBgOloxvD9EcICnhQBgsndUIRSo6IBWPua0E+JcMBolJm37z0Dch6wPHJ+UJxYgYSjA8LhIIqjyVQvLjkPz5lezXyzeJ8JCJOnW1p4pIvxhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9mKDJ4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E315AC2BD11;
	Sat, 25 May 2024 21:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716671314;
	bh=JDCFZ8HEb0NTJwxJbkUKLE+BhXBP8waLZLT+EsxImRQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k9mKDJ4m5dNvrftAkU8WUPDzrvesUCnxQXwzjfUv9SSXT/CyevinobIPQmzFFQjxU
	 bVhEbkTLb2n4ZRXwB8cKoCl4LJb8ekvh0QRnvfQMFkd4yxdeaTvNUstFa7FEqhFV5T
	 0214zqUX09aj0W3Zhd3zaDH9cRX4Zbu5Gs9jL5wUDgbAZMQY6nc8B3ygEyRI5GhP28
	 8IHQJzV63aGjtLoVf0eNmnJ4FTaSVMpooabiiNOnUS93/zimG0ABuvZ/c+s+2s3lJn
	 6po1o2EXVOEsp9FtaKdhTF2XczvrXzPZStsuYPp58exfM4OF59zjysFdC2CVyk9onr
	 rDrEN9XQ+SvxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC46DC43617;
	Sat, 25 May 2024 21:08:34 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240525075217d90cc066@mail.local>
References: <20240525075217d90cc066@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240525075217d90cc066@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.10
X-PR-Tracked-Commit-Id: 1d08326020fba690cbb7b8f1b38ab4eab6745969
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4286e1fceb8c99f25332dc7e85f9879408caa45a
Message-Id: <171667131489.10959.15105780706399557618.pr-tracker-bot@kernel.org>
Date: Sat, 25 May 2024 21:08:34 +0000
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 25 May 2024 09:52:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4286e1fceb8c99f25332dc7e85f9879408caa45a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

