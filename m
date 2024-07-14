Return-Path: <linux-kernel+bounces-251941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B91930BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 00:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3971F211AD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 22:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E2513D530;
	Sun, 14 Jul 2024 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XldzbQWq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F1BC15B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720996964; cv=none; b=XRKLK5l7M5gOqWKQ8/SdXV54czwYNUFnlfbICd1CJo4I6o5g741G2yYQVqPayk1sZVBfav9x9T6h5Aw4din0rTY2OnFVlbsABkirH+gEWsms2l/w45bMLNwZ5HjcAfVPCNqqPImpqv+RNLob6YtBtyOpXUONyjaU06ua0A7cJ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720996964; c=relaxed/simple;
	bh=U05QVkSPrR4JJa6WfY3gOllK23XBzYrjo15lAU+Fh38=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=I24EfC6X7GCbR3PTuiSIG63lptZK6Y7PxybgxWcw5jkSJWuvxDyn0XOt6iWqU+XUYOjQ6eXJ0tMOMT420QpslTC25s4ktIaWueE7urqJhB/AX/kNVtiR8zaRJOQpeQLjuXlUr0JHV1DWs7HpsMJvEbwzSC74igBiE8yCW7t20qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XldzbQWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51125C116B1;
	Sun, 14 Jul 2024 22:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720996964;
	bh=U05QVkSPrR4JJa6WfY3gOllK23XBzYrjo15lAU+Fh38=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XldzbQWqs/0HcNjqfTT/rLzZwMOWl/CL8sSSWojCu9l5Z6PCAh4XYTFcLNaE6V3Gl
	 qA08tTgSSiDxt8RM3ABwLFyNpJoNEZn2JG9ARxPCA6dx+jgGQVkAG1Qj//2FLh8Iro
	 JrV3UiJiEfEFwRj8ABlZXMocQ4FhqjlmE3aCEHD3Xx/6MTk5PlBjh5ELxGCVVf0SYl
	 jPq7DMA5Fmit30lFBood9ECjRcdId9TjfmWHWESEt/qa1p4C0YGQiMgZdCGvbYB4lP
	 4g2GNNuj7Tv2unR0vamJehrLHRPtHevFkXcbNjZfrUqb7cuYt8kHL9crfqkwRsdzGi
	 0g+yv66U0M1fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 462A6C43153;
	Sun, 14 Jul 2024 22:42:44 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240714091706.GAZpOXkrEq7nE6-Tue@fat_crate.local>
References: <20240714091706.GAZpOXkrEq7nE6-Tue@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240714091706.GAZpOXkrEq7nE6-Tue@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.10
X-PR-Tracked-Commit-Id: ac8b270b61d48fcc61f052097777e3b5e11591e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35ce46324556ba2dbc66a88013870d8bec8a99ef
Message-Id: <172099696427.4566.3663776394721229378.pr-tracker-bot@kernel.org>
Date: Sun, 14 Jul 2024 22:42:44 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jul 2024 11:17:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35ce46324556ba2dbc66a88013870d8bec8a99ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

