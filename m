Return-Path: <linux-kernel+bounces-319445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB7D96FCAB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707A0B24630
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C06F1D7E50;
	Fri,  6 Sep 2024 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scCGqj3W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAB1D6792
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654487; cv=none; b=HLa3C2a2oN8Li2Zg8V5u9G3S+psmOcztLr5P2v7d26u/SUArva486WHdSwzORTHwECkwSrMCAcqzFCFWrlqLNJBCAFUN0ChEOe8HjfTaECUw5fk46GgK87uK/4sggsclAFNHRlPEJvwbH0gfIaMxtGTvUKS/EYdH0S1vqlH7/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654487; c=relaxed/simple;
	bh=E4z2YDollzOZnMKJ5VGZxb6GlDKsbqFPKwROtxnAzk0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=B49XOMYiXYNYIXH65smj3Sco9+/HENhTeqTppGOQuMlkIBGa0iH3ARXGVVFfTbK9k+nk6YLfmZLzX7FMeKcjUsxv3iY2qbsPqvwyqr01s5jv5U9B6A4lTh0DwynSPbyn9GOUkuagws5nEh81KpIHp5NP8/abOOfyzreAi3VmLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scCGqj3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD83C4CEC4;
	Fri,  6 Sep 2024 20:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725654487;
	bh=E4z2YDollzOZnMKJ5VGZxb6GlDKsbqFPKwROtxnAzk0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=scCGqj3W15mjP5OuI+seuQ8TlTKfFPdxAewpBotSo7IltZsowESH/N4tmwXBaEnfZ
	 JoiGbyMn69LAwzsfoQonC61lnKq0Db+kqpyGm9qPP+nY9qGXytWD0QpAQ+FW45L2z0
	 vXq8vgvu2hmv6MMNM8pnynEz/mavu9k5axhMpQFs+w4QevNEqbxWXJs3p9YZCEZL1k
	 CTK2uJjUomSZESx5RWjq/tGhH/jYACf3FfcQbEKfa2Xh/H6NPOwwwFFuKYFegkNIiS
	 K3cRrBXc9zoPCYGv3PiIgFkgex6ReEZT3aHXfRjQo4f5Oz5PIP0P+DvuHImpnwO0SV
	 pXlFJmWSKVkCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F3C3806644;
	Fri,  6 Sep 2024 20:28:09 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-43509d97-4d3a-449f-b4d7-74f1041daefc@palmer-ri-x1c9>
References: <mhng-43509d97-4d3a-449f-b4d7-74f1041daefc@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-43509d97-4d3a-449f-b4d7-74f1041daefc@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc7
X-PR-Tracked-Commit-Id: 1ff95eb2bebda50c4c5406caaf201e0fcb24cc8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 890daedec4f483bcb5cea0a4ce290830d12d78b2
Message-Id: <172565448800.2515438.1514750402355599836.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 20:28:08 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 06 Sep 2024 09:21:30 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/890daedec4f483bcb5cea0a4ce290830d12d78b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

