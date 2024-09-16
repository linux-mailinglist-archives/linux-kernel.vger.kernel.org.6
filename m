Return-Path: <linux-kernel+bounces-330161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15236979A80
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3371283B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FCE5647F;
	Mon, 16 Sep 2024 04:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSQMurzX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A8733991
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726462517; cv=none; b=l0JRjOMtAZSmIIV36NKBXWDcfZBPwuCKXRAumstQZqraKfarNIdrKqCvkxd/F6RrrE3wfrp8oXjUN+cceLyjAMje1raFixfLX0KN8wRFn0a1alKv6kgdtaW0p4jFC/9V1lso04S1D5rOeSzEq3O/Hc0e85lI1QDie4Y1SGniPlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726462517; c=relaxed/simple;
	bh=gzlrRYutnqYZDXEcaWjwr7fiur2jW+Aoudj2icF/GmI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ccIhMpHauJ1cB38Af7yCIEaGnkwPvUfYjOqOZ/owNFkCaF//Kvn9WCus3lMprUZ83VglSHyyDhwBkQxrOerOUWcHIchCQY+QMZ692VvoJbI0JxXgTIXLazfvo9dXKpRPeSn33DM281+p5tEvtNkbZf4gW78OD3UKQ9wuBETKsfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSQMurzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B57C4CEC4;
	Mon, 16 Sep 2024 04:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726462517;
	bh=gzlrRYutnqYZDXEcaWjwr7fiur2jW+Aoudj2icF/GmI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gSQMurzXeot5OZQk60TxH60CqOqJa2Xmf0s5t1t36kIQIhY/sPA3se2n3mdc61YG2
	 CiZrI4yayD5Py2R7DYVDnCR8yjJUQ4rHJ7BVvxQG8zZUy1Adsbi8tq5Y2A0apqrxQ2
	 xv2zRBLjWt59Jy+EcSVYtdiwoF4tZGSS+UznhQo8YPU9Hm8hg14xvthYNOISrF4vI6
	 fh4sB1e/yiRyazB3jcyeI0bRqdg2QoExDV51G8AktCNraO6lUObjEMMWbiMcCOUAuI
	 IAsYYSqriSIzbEvVFLImlErQAszuR6SMeQW8ZYeIc2HW5d7cACj3K/3tf8Hx1Az9hI
	 ukFr2pVbzkkPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B093809A80;
	Mon, 16 Sep 2024 04:55:20 +0000 (UTC)
Subject: Re: [GIT PULL] x86/bugs for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240909151344.GAZt8QqEDhZCMVYQbY@fat_crate.local>
References: <20240909151344.GAZt8QqEDhZCMVYQbY@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240909151344.GAZt8QqEDhZCMVYQbY@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.12_rc1
X-PR-Tracked-Commit-Id: 1dbb6b1495d472806fef1f4c94f5b3e4c89a3c1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 963d0d60d690ce2525a8fbcc0a63c4ae22f4670c
Message-Id: <172646251882.3235832.12098357476937418224.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 04:55:18 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 9 Sep 2024 17:13:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.12_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/963d0d60d690ce2525a8fbcc0a63c4ae22f4670c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

