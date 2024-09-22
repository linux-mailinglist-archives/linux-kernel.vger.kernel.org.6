Return-Path: <linux-kernel+bounces-335209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C553997E294
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 18:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FCF2819FD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9B2BAF1;
	Sun, 22 Sep 2024 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhozVN3m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4082A1DF
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727024317; cv=none; b=hXHjyRSvh2Q1Y6BrgyLPvTtonoEwQgCjimMMJDJKjM1nQmUfLpXyNbK1AzU4ywpKHM6ooCRh3a7tV0+1D14DAUaXyxlgPnfizKnc/zft6hmyupL6328ewUeoQpG9lMVCcb2nkHXzgNl48akLkr/cTzJCBqlIgNSwxjhuC3vQRBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727024317; c=relaxed/simple;
	bh=8raR2pRH7PrgbB6PSaI1ZDMgrmD1o8+kZ1aumZ43+14=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aCzEO3724uBFQU9bwhOwQwI5I9bggpkGVlLO2mdDh2R0pIgtd52wPTeW8F2Try9bk49wbxp9dp7KXeMdgQDuoirFC2DoyrDKWTCvVeT6qBl8IkVF8muOD91mfoduzCYr35l93EfvzyZbAe7j4+pm3YomYBNgcuRDZZvwJQAxZrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhozVN3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAF0C4CEC3;
	Sun, 22 Sep 2024 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727024317;
	bh=8raR2pRH7PrgbB6PSaI1ZDMgrmD1o8+kZ1aumZ43+14=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lhozVN3mFqLK5sh1QTF1YsdBI6dlTV+5bm5YOvOwr5PCIZyex5+7yJm3/e0AtMt1s
	 lw15Fx0vcaM8p1ta8ZHH6O11j+dg1G21mLMyU5d3kx7Q9e9vd9Mtfey+lq/JozCeBX
	 LhWdhJxQa/lw9b6refY75bJT2dOIj+XAwQ7wNnyAD6enHOEW5QEUSEUyZ88GC6i7x1
	 2WZSKIMayxY2BQ+B42RzEbHECbGX4rAFSq5c9FS1QCSVEovvgDvWWS1fXIjwaML8ON
	 sCOUS07mXv9Df3lf7iPbrY5hWKZ/PgjWmaJvOxR1zZn/aVWJxxYIxaYNVDVgOuwX4Z
	 n5IkoKFV+Eayw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC993806655;
	Sun, 22 Sep 2024 16:58:40 +0000 (UTC)
Subject: Re: [GIT PULL] ktest.pl: Updates for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240922023805.044eba62@rorschach.local.home>
References: <20240922023805.044eba62@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240922023805.044eba62@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v6.12
X-PR-Tracked-Commit-Id: 2351e8c65404aabc433300b6bf90c7a37e8bbc4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd609b8a3a1fc087df1f136686df77ad42f79a7d
Message-Id: <172702431929.2797494.14793619001030376169.pr-tracker-bot@kernel.org>
Date: Sun, 22 Sep 2024 16:58:39 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, John 'Warthog9' Hawley <warthog9@kernel.org>, Daniel Jordan <daniel.m.jordan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 22 Sep 2024 02:38:05 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd609b8a3a1fc087df1f136686df77ad42f79a7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

