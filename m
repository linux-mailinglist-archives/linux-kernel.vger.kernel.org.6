Return-Path: <linux-kernel+bounces-260525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A8793AA8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386621C21F61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAAAA95E;
	Wed, 24 Jul 2024 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlfmRMLr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB745258
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721784079; cv=none; b=radR9kFlmpZan91hgXJKPMbKn7uLzvZeA1yq64jJEpf593xKgA9BWj2iJQPQdaBjRjhCa5UjoVQ/Zha7rfwvCqEQsr64MYwEhin0kyxwwFkUHgHqDvKYTio8PpooYxiwVS6lQosvhjBzQ8oCfvMSFxhD3Qmr7sCRSgHac2NTwFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721784079; c=relaxed/simple;
	bh=1YQd4pb2OwInruewDWYeBIUyuZQvjv2zyrqd7DJdZRQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N3+A+Q105t0zzCcaAfeJ/HKTpJZeWpDuCZUwWonLMZupMoxJmb4gGuPOgc3cfVNSSrsGyRYWrUvqEKVa4DYiH9ymWREL3iWr8NfjWfxf/G+rWVGqDGfn2EtU6t8b20N2LHuAb39q3J6222ENFLhbyCXR7qHhWoA02o4AN0pMv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlfmRMLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F2CEC4AF09;
	Wed, 24 Jul 2024 01:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721784079;
	bh=1YQd4pb2OwInruewDWYeBIUyuZQvjv2zyrqd7DJdZRQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RlfmRMLr/sFBfy/lKbnjOp1jLNTumM7aUTQwHQl4XFozbHtnigFDCBuOQTE7N4dGq
	 /2ZVRboGfLUp+SsGCBFte1TTqNwSubaUe48Dyb5wpr5yBZWs8UoRfcV8hy0dm2Aeie
	 gskzFRbvJj2lq4+jutC+SkchG6S+nhM+dLzVQLMtK1QOFLQwncuCZizs+oJCu0ZMNp
	 SL6LI9F/YnorlXON3qa248gl0DsJkmzYUqsO7Ekz00iSPq2q3KstTDgX1e6H9lCmYd
	 LLYckeMtcXS5IxtSSpd28ljRfCZ3a+zbXm2hdGO5BqvFiip0DGGK+T1crLvVJp1cWW
	 ZjtfewvMMjMeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9512BC43443;
	Wed, 24 Jul 2024 01:21:19 +0000 (UTC)
Subject: Re: [GIT PULL] execve update for v6.11-rc1-fix1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202407231304.04FE50257@keescook>
References: <202407231304.04FE50257@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202407231304.04FE50257@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.11-rc1-fix1
X-PR-Tracked-Commit-Id: b6f5ee4d53019443fb99dd23bc08680b1244ccfa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9e969797bae359fd463f7617ad875bca2771586
Message-Id: <172178407960.1898.10016250644442560357.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jul 2024 01:21:19 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, David Gow <davidgow@google.com>, Kees Cook <kees@kernel.org>, SeongJae Park <sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 23 Jul 2024 13:05:45 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.11-rc1-fix1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9e969797bae359fd463f7617ad875bca2771586

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

