Return-Path: <linux-kernel+bounces-310414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B84A4967C79
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 00:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA961F2127E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E811865E0;
	Sun,  1 Sep 2024 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHsk7xXJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383A3185E73
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725228298; cv=none; b=OQ/2J4sVsJGglHVyUTKljQO1eua96bYhDuqei9VJgNa8k/f5t6wCpaTaMPClysbItgOsQsn5k2myzbovKC9faKFr50ouzQGbc/JtWSdP/xAXWwyujdCwkiRX5dS8MSm77te50UWdILfF/u3bmFKFQ7XXsqqnxCgf4voh19vSiRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725228298; c=relaxed/simple;
	bh=E5mpdqsdiPRzyQjVE7oVTI9whrzLboApTU68XjFlyIU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q6y/gY5DR2WG+NVkEdgAhHlIU4ZplhcXXWeXNaWXr+u9GIdGWyvrM3yVI/7TR61IHxYuFskW9SFoX1BZ4k3czCmCLnel9hkzjqFSxHD8uBYSQHPANxoXnKEcjCGly8Zt2T0AvkhP56W/0dR8c2DVcmey2nc0yVpslgBSsh5Mu70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHsk7xXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C101C4CECA;
	Sun,  1 Sep 2024 22:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725228298;
	bh=E5mpdqsdiPRzyQjVE7oVTI9whrzLboApTU68XjFlyIU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VHsk7xXJGAST9jxB/j128N0eIwvxQL2hVVdwymgup2OXwFg5FOLPeUrRFUQ7yvsXo
	 qmaXCsobLeCJ7nI1pS6Zitc6nj2eok9ih4hROFHoaeYczCR5ldaTiMpr/z795ABrK0
	 +aXHfKyphahLMZusFe/xz+aT5sm28nRBAFq3dT8tWvU8ds3Lz7T2NIfy3fNJ9/9vve
	 3ccpcIsOlGMWsqqcOPRvn/7D5/7qmtH4omZVAgHVimkPwznGnih4NCmTLEkphsPbdU
	 9YNLtAna6xEkSEfh0FhSFfNW25eQdK7PR8izwn1FahFHSkcmbdVsowy2UtK4hxZNUQ
	 jJaHt6Fe5ut8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACCF3822C86;
	Sun,  1 Sep 2024 22:04:59 +0000 (UTC)
Subject: Re: [GIT pull] perf/urgent for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <172519097718.1871736.2200605429051036011.tglx@xen13>
References: <172519097408.1871736.16401401125691449823.tglx@xen13> <172519097718.1871736.2200605429051036011.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172519097718.1871736.2200605429051036011.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-09-01
X-PR-Tracked-Commit-Id: 25dfc9e357af8aed1ca79b318a73f2c59c1f0b2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3df9427f351a9cb8aee0eea13d185f0d78340a70
Message-Id: <172522829854.3406256.15727312712519044276.pr-tracker-bot@kernel.org>
Date: Sun, 01 Sep 2024 22:04:58 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  1 Sep 2024 13:44:02 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-09-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3df9427f351a9cb8aee0eea13d185f0d78340a70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

