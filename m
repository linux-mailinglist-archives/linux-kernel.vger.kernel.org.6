Return-Path: <linux-kernel+bounces-178977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3024C8C5A03
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA9C1F22BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A6317F39D;
	Tue, 14 May 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2sEVCzN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A0117EBBD
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706185; cv=none; b=CDZp1rLV16hY5jBYcT/d1o30MVDZnXnPRgjrxabeXEiaj62/q2RD7m48cGhsTl24ng8rsyWdkJJas3bcvYuSdHLeVa+jTWYiePq3q1nxDgBWbPhyfLHXhB0bhhzXFs+q+K7IwAvETmv1nu8jmMw8XgZbMPo9ODqH24ovz4Poedo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706185; c=relaxed/simple;
	bh=mUMXijVvzhvQTlxk8XXuKAm6l5Awr3XyYmTCyqlqUEQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C8CPrziMhQJMP2a2ItRxnrBzE0iz5GHeJIB6lTtZUSijWrsHwowa9ZR1FAwyguNDEsj+vYW3vRh1l4oOFuGvSBzvu1S64Zbz84hL1UhG8B/I2LkCUPpc1sIo78Te+4N0gF6lbq40SMtLVrF7BLs9Gx1KtVN759JJEWrzCoxhYAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2sEVCzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6009EC2BD10;
	Tue, 14 May 2024 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715706185;
	bh=mUMXijVvzhvQTlxk8XXuKAm6l5Awr3XyYmTCyqlqUEQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O2sEVCzNYgedl74O6QINDffmlnCepvPbYp7B+rowmlorrLB/Y692onmB1SnpU0cOM
	 Lwt64DjfVP8yTZ8Ic9GsF6jhy+LFbKYcpZgLYWEi++ko1xi+1YyZffYDxmBMdx2sNu
	 DMxAB7iZEGasaaynipxxZRimBjLdFJji0sKO+89sOeWjmTO0LvNyC1MI9CmyPdGKYk
	 JsU5z1DX7O9gkoDTY5ygBJ5paHZhlzMi7D5SX/ARGTUb65LJ+1oGRvPmiXFe9bV0IK
	 u8WMcygHIw8TuhQTBe0cVL7Rh/8uFR9YLPjcVjgtEB/VnLdO4KfXl8mPrIPZ7A52dD
	 gn0XeLz3o+tbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55AAFC43339;
	Tue, 14 May 2024 17:03:05 +0000 (UTC)
Subject: Re: [GIT PULL] RAS update for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240513112018.GAZkH3coU6jUY3LE0s@fat_crate.local>
References: <20240513112018.GAZkH3coU6jUY3LE0s@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240513112018.GAZkH3coU6jUY3LE0s@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip ras_core_for_v6.10_rc1
X-PR-Tracked-Commit-Id: 108c6494bdf1dfeaefc0a506e2f471aa92fafdd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4864f6565ab57d6418ec469330e320f77eeee95
Message-Id: <171570618533.7410.3893366416169586811.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 17:03:05 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 13:20:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip ras_core_for_v6.10_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4864f6565ab57d6418ec469330e320f77eeee95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

