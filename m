Return-Path: <linux-kernel+bounces-178978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F948C5A04
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF58C1F22CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6248D1802A1;
	Tue, 14 May 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+gT0P+J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92BD17F37C
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706185; cv=none; b=RbQqKtJHBZeNMFSPmAx87LHPAJ+RIIO878LcQrefocyzapX3AJchzppKpWs3RQODqMYeXaJ6KnL3WCLynf3Hbu/xJhwss1aGehxoxx09pvkyDaDScE8GfXwvqpjPoKSCtue0Tb/kFnqVAj5eqTzL2e5TrJNWdkqvg7poAiMHb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706185; c=relaxed/simple;
	bh=SRltZjWwbEW6nyDS2o4pTFYC6RLFGrviV4bHswuj2Q8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oMjBYjSpBJQMnw5/jbEStjBLceKMrg+tiEIa9TrSuOv9KxKKbGv1HgW29a1xQA9++nveDx9EYWxmse1f8LRlGeFxCBFZCU4W1MnoJ9M5cyKcyz4q53Sg6kmz63uuGjrngxAiUmDjyOqiWOu1ZkG9t72lmGoJOZyrVhB+1rVHTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+gT0P+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BA5CC32786;
	Tue, 14 May 2024 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715706185;
	bh=SRltZjWwbEW6nyDS2o4pTFYC6RLFGrviV4bHswuj2Q8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T+gT0P+JGTC4jYPk1vedSBQMwyS/rHli7OJ83w/PLqA2BZbJLHQgVk86TkV1UHWQ9
	 IQaPB/AovPWtkSwC4fA2n/65geV0E92+ioIlwLRALyqmXQAIEP1tFVL6zfWylk+qaV
	 Eq+RBhy15LJmDMG7w3vyt4nsMg4kEPi+XSiDVdF6J1GlsQYBxwGV1vgVv/NMf8pyyw
	 o6xBlUTXiO2j0kaRTVN2jJYccux6cyTYJs4j3wyy5yqgV4zOfzDsFFObBPu6GXBo0z
	 IMGQi3FAJ1blZaYleG5E5vRScz4aEjuPPlyvVWtV7E/O3keolSlt0ZFyTxFAik+2QP
	 mGEcjclWuEZ2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 835DBC43339;
	Tue, 14 May 2024 17:03:05 +0000 (UTC)
Subject: Re: [GIT pull] x86/timers for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: 
 <171560455005.3871325.1102142666677911813.tglx@xen13.tec.linutronix.de>
References: 
 <171560454635.3871325.5773365584560034962.tglx@xen13.tec.linutronix.de>
 <171560455005.3871325.1102142666677911813.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: 
 <171560455005.3871325.1102142666677911813.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-2024-05-13
X-PR-Tracked-Commit-Id: 455f9075f14484f358b3c1d6845b4a438de198a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9d9ce3fbc2761e69c5daeb99156a5d06eb79ae5
Message-Id: <171570618553.7410.9224880478610660930.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 17:03:05 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 14:50:02 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9d9ce3fbc2761e69c5daeb99156a5d06eb79ae5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

