Return-Path: <linux-kernel+bounces-256829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8852D9370F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C131C21935
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED10147C6E;
	Thu, 18 Jul 2024 23:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed/Q/ugT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3B1474A4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343996; cv=none; b=OeI1cmU1dbKdgjEo6jFr1CCC8kicmg10kFFtLQvkD1KdFzIUi594tGASW4V3xJq9eq26j4WxO3KWUOzqCOKnaJ8KiI3AnKNf1IJSuUjObvT0zdVyxKN6SI+4eYu9So3FAB5MZNMpqn78zWPWFVBrI8Mr024tEBYwuE1y8y0oSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343996; c=relaxed/simple;
	bh=55CbmcKodlyZWFwJQf4uQqbj3sdvuG+iDf22tpPlpvM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FCseGWc3G0L7hLH355P5nulM3+tBu3a5N0u+XrlPwqWheZxZXwH8ArQydIdpp0/qJDoVMYK5YntO8WOrioDkj4JGCIdbTLwIO3JIbtQSopoqAlg75agmjyVSId1vlkEQKvG6eKc1IJ0ENZV3tBD0zQCj7dRaId5CwSKo8IkLSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed/Q/ugT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 627F1C116B1;
	Thu, 18 Jul 2024 23:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721343996;
	bh=55CbmcKodlyZWFwJQf4uQqbj3sdvuG+iDf22tpPlpvM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ed/Q/ugT3UueospAZLrWsLaJ5XQ7kbunDwY9nAFpXdugpKv1SsGckQA+ZRn/z37Bg
	 uVqOs31WgS8Z25hcITdCO5v5U4cFbujdZ56eOAkExgjpnpfFHAVmjgHZkF6JqusPoQ
	 2z1aWUnXWPvK5jBskVGEFWFaaU2rJPIM7UBS6gLShoCapC4S2512HgNbqfuisl/AjZ
	 ppqDrralu+Bix+0Aee8sHZekzYJs6Qup2buWPGGW9gKdAcbT3v02DKzHU5/0xXV+Lr
	 2wBQisOKlwXItMWCZAb+EHX8i8I7JpYh3zcbh7jL+TiATwgGDDo/ofxrx/n5bB7ok/
	 CBShmGEHVhCYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5860AC43443;
	Thu, 18 Jul 2024 23:06:36 +0000 (UTC)
Subject: Re: [GIT PULL] x86/percpu changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpfSkENjiIL7HGJV@gmail.com>
References: <ZpfSkENjiIL7HGJV@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZpfSkENjiIL7HGJV@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-percpu-2024-07-17
X-PR-Tracked-Commit-Id: 47ff30cc1be7bf426c03ecc84371452109b416e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dde1a0e1625c08cf4f958348a83434b2ddecf449
Message-Id: <172134399635.16085.12763989131505755354.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 23:06:36 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jul 2024 16:17:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-percpu-2024-07-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dde1a0e1625c08cf4f958348a83434b2ddecf449

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

