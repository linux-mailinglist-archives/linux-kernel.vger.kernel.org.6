Return-Path: <linux-kernel+bounces-406490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266189C5FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D161F2771C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0713B215C4A;
	Tue, 12 Nov 2024 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfIq1f09"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FF9215C5A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434856; cv=none; b=XXxt1x6IHOSo8M+BeUpj1LjLaCud9pcEwDDu4zl27IWEfDTsdnUcaJHKwUD5UhMLg0VNe+da7raxRgSGKCeflXA+HsnOSIkHBmhnhr28/2Tv4+zPb6oyML44sgx3o1n00ewTevYqUEQsrPsYqS9Mau6j8Gz0hUeAcIDI9L1mMqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434856; c=relaxed/simple;
	bh=FTG0ns5h0qyNMVteAlsiBhSXzU6lOp3pYkmuRa5PWYU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o0+MMy+FwAYziw9obiL0Zw4zdlPA4M4KnVvNSxQ0VNf3uNayFma7QtZ7Qy6kh02Nz4iTTvjsYPzKVH2k6ajJAb8XtCwojKeNVoDZn+RWBO4qIDTE8ZV2Uub06/oRDrElnQ4T1LteoLysoMwd+skzOJrwZeclMREeSF2VQAs6jFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfIq1f09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402B0C4CECD;
	Tue, 12 Nov 2024 18:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731434856;
	bh=FTG0ns5h0qyNMVteAlsiBhSXzU6lOp3pYkmuRa5PWYU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nfIq1f09O0lHGDAFni5pyVziQzdj7tx20TuIX2SVK4oT6aZhdefZxlQN+AAmS7zVy
	 0lFKmjuuqzxtPMxiQio5sIn+KCHB/hULLHEYEo3G9a8V9Dldi+FXmMiSvV+u3YikK0
	 xDIADzPAte6dveNS6ymFeAa7tOcu8yx3FCgyhbZAr1q9JBQ1JFMnqXjTpf3ZokLMZf
	 v90jNu2d5xKH1XVYCvFF54nXbBuhH8Bb+Bc7iBL8okhoz2MxzMgdN9N11H/sibYBCq
	 se76vfuuXVIoCiHYgSZePt0VQyoVHo1taaJ+aMpYyqE8vuTTN8vnG+MfXTwzKspwVC
	 j1Vl95RScw1Pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3E63809A80;
	Tue, 12 Nov 2024 18:07:47 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzI9qJ_LLdELWhQX@slm.duckdns.org>
References: <ZzI9qJ_LLdELWhQX@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzI9qJ_LLdELWhQX@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc7-fixes
X-PR-Tracked-Commit-Id: a6250aa251eacaf3ebfcfe152a96a727fd483ecd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3022e9d00ebec31ed435ae0844e3f235dba998a9
Message-Id: <173143486633.621786.9060907867993573426.pr-tracker-bot@kernel.org>
Date: Tue, 12 Nov 2024 18:07:46 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com, Peter Zijlstra <peterz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Nov 2024 07:23:52 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3022e9d00ebec31ed435ae0844e3f235dba998a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

