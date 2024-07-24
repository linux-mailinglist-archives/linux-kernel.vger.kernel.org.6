Return-Path: <linux-kernel+bounces-261349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5438093B624
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B742DB22A87
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D769A15EFC9;
	Wed, 24 Jul 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKnEXjnM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DF6157E6C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843431; cv=none; b=B+x5UrenW3rJK8MtuVFiuq/REUwVxlvnQRc4tn3rlC2yDz05zVJD55cWYRlJ9yI4kvf8hr6VM0AcvVkX9ab5kMY09IyxzOxXfzG6WWS29voNwG8/TULSEQrnIQiRZbOTaFDhB3+60Y6hCvD05qfsSKOA/a9EVMOI+Ie6D45mChk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843431; c=relaxed/simple;
	bh=Y/8vZ8vyhO+i9kxeIAy3aBPOpWjBnc47ohH5bKs+R6k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qN6qLSAOEfc4UnZwwIQFCipEwQ/8u7ID6QGAydRG1PIg7g+L9I56t7AYpxxlMo5YL2Juj0b+bwwROG2BZeZAf8OeCVRrQ+w5FmtGc4wDrMLWuQITauuSW20ZPq8cbPw7g1MwtPX2ZSbfXC+jbLCE4hVrdQOB4Lp2GINXSuYg0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKnEXjnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B163CC4AF0B;
	Wed, 24 Jul 2024 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721843430;
	bh=Y/8vZ8vyhO+i9kxeIAy3aBPOpWjBnc47ohH5bKs+R6k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uKnEXjnMDlNWhRi3jbz+4214o+9PXyOvZUt4FRQAjh1Ymc0MhjTDicQMxEJ3Z0ymB
	 +TbIYXpm4KhcausQ9pa0BjXKhxeMkSFuevuG4yrQ+wyDYQWoDgNMCJMOGbzJ/vym6y
	 5VemrJo8qroFcxT0gnL2PrlaSAYhAwwde3rGsyrc4mqOr7DJdFmxXw+NsiuCziV3tZ
	 tswdmT0s49LZwEtHnf+VHQ7l37qggW3Uko3daTFG59XodhGVX2hI6LuJEWHFfkQvmR
	 4UI1Vi16Iuux2gfYw3N5t62nhZDrYdBgSHPsLUeb4+PpxQIi1EhxQEB0JZ1D90GAET
	 eW8P3O/zJHHPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9ECD6C43443;
	Wed, 24 Jul 2024 17:50:30 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator updates for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240719183308.1472668-1-Jason@zx2c4.com>
References: <ZpqwFK5hgU2gOA7y@zx2c4.com> <20240719183308.1472668-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240719183308.1472668-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.11-rc1-for-linus
X-PR-Tracked-Commit-Id: ad8070cb1b4bd40aa19a5e3f7c24d7f62c71b382
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a3fad30fd8b4b5e370906b3c554f64026f56c2f
Message-Id: <172184343063.12784.5867181967137681300.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jul 2024 17:50:30 +0000
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jul 2024 20:33:08 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.11-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a3fad30fd8b4b5e370906b3c554f64026f56c2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

