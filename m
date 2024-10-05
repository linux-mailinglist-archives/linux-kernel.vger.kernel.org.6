Return-Path: <linux-kernel+bounces-352028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D5D99193F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD86283069
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AF515C125;
	Sat,  5 Oct 2024 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGbhguPY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958DA15B57D
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151668; cv=none; b=jlSYl879DQu1Qe+j1XKjLL6JvqS1qu4qdIWRiaRUb/EwxouKaqpGpVYu/X2kT2yMovgPtD53YG1Op2BrMF8h3Ux5BkpoozWay6ccaS5avYgPklXSOR2zFk4fkbB2eH4ypItgffv7FScJrZORhDGdh8+f7G/XRtoyo2NYgsiMh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151668; c=relaxed/simple;
	bh=3DvQrgVH9hwd5ymFLUFtkXTVd+zNNmDOwc1GpFzMxBg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rOFQ5xmj2nF4DA2E03VSP07LNLAcQ/ymCGS75+TbDI0zOHKLUuS8b9jUkuWJvps8zofF8xPlDGagR3OXMO0ApNqrFtoTEw2RIPo3p4wNKN7JbKEun6laS0HZEdz5FIjv7tOaIMBzH5X9YEmVeplhroF1/EELgCgcNgOu0TqOgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGbhguPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B37DC4CEC2;
	Sat,  5 Oct 2024 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728151668;
	bh=3DvQrgVH9hwd5ymFLUFtkXTVd+zNNmDOwc1GpFzMxBg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oGbhguPYGzLpBqWJ/Rm5Jvj1nyKO03utvBzAEU2fGPREQhounrT0lbbTZrrtOo6by
	 Hsw+SFvz2EnxwVP0NZVHO2nwTB5QLulq8V2RCWnl6PIq4SFWM1286YuWak4+f+LYBG
	 cbM1lfyrCKb59d8sS+ilT0Uf6eOIlXliNDXkFO3JJr/Xi82LwWDD5FGYUPt7+VVeN/
	 4f7grJev7fO4HNVGArabNomBab2kd81h9tx2WjjDTZuNK7JxmPQ6Unb8M93vFFHhkf
	 UOoo/Dst6/9IBsHJCWAqefcwIrcAAGebVBoVtulBHYIHP2q9P+a439wB7etPmNN1sW
	 2eTmwzU3OIuRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D533806656;
	Sat,  5 Oct 2024 18:07:53 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <202410041733.20AD92E@keescook>
References: <202410041733.20AD92E@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202410041733.20AD92E@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.12-rc2
X-PR-Tracked-Commit-Id: 045244dd5d75c61ae37b7b96fe0a95805bd1842d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ec2236a0260f88362ab00510d19397c0e396587
Message-Id: <172815167178.3145223.8204839758921491265.pr-tracker-bot@kernel.org>
Date: Sat, 05 Oct 2024 18:07:51 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Oct 2024 17:33:43 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ec2236a0260f88362ab00510d19397c0e396587

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

