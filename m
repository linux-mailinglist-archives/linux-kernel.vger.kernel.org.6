Return-Path: <linux-kernel+bounces-253314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CDA931F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1052822E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC7B42ABB;
	Tue, 16 Jul 2024 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxmnIKY1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347981B812
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101300; cv=none; b=ERaTseDc41/UvrVNr7J5Bw4jNtHTdmbIPOxcBv5pRuICynfH5t03fwox7eCDJMkhASca8hJ30HmyAWcDOKGP9fAeL6HgkOpgQEB7zVc+Dvoe0JG8TIZGiL1GmKG0y1Eb3/K3rdkF8s35QO82y8mgWpbPkgxOqUu6ZkqBLuKjDzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101300; c=relaxed/simple;
	bh=8GVuXoCMl5PAKSBlbTsZKyzKQhoh9SVp4CG98qSCLls=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SgYj38dtRfWTI3IkEHm1YdBkCIfZhCcNmBoJ5adWh7iMyG7CPl/sDEZcHtY5VH6C9xeV1kT+veAE0PhqTVg6Men9a5I1eBUdN8gWpNlYH5VE05cmtUAmml/yLcbX0Br2aYvIMxexvSLXc8tAFGDhezGg3CVo0jYO3LJVjQxFmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxmnIKY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16CB7C4AF10;
	Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721101300;
	bh=8GVuXoCMl5PAKSBlbTsZKyzKQhoh9SVp4CG98qSCLls=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BxmnIKY1foK3eYZ/Yy3frBQdInIit3H+GWxJCk5sNXDUN9SGhdaIlJkbSbG8epENc
	 UwVmJSViYjUUjx71n+reLfoxappeXukuy85ki4Y4EI7OnV0s6D+KcUhiNkZAE4saHk
	 0tcgK6FlNxvI5oKyrWheB+zxQGVd3hgTM8HB99uJi9sLzZ8sPWAJcV9wQe8BWt37Xe
	 E7wqaMc3jIikt9nCXUZ3A6/Opr0WW4W1g0zY4KpLRlNI4vD3VAm95tL0uWetttUuAu
	 +7nbTZj2du5WGb/qiZ9t14qzgcpUZArEu092J+mH0NzPlWINlnMgZg8ljFrzvQUyWf
	 nmwl2IuXKoq5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A00EC433E9;
	Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715150055.GAZpU5p9TOAJSyW3gQ@fat_crate.local>
References: <20240715150055.GAZpU5p9TOAJSyW3gQ@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715150055.GAZpU5p9TOAJSyW3gQ@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_misc_for_v6.11_rc1
X-PR-Tracked-Commit-Id: bf6ab33d8487f5e2a0998ce75286eae65bb0a6d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 222dfb8326dcdc3181832d80331d2d4956cab42e
Message-Id: <172110130003.18508.1169596176338876865.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 03:41:40 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 17:00:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_misc_for_v6.11_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/222dfb8326dcdc3181832d80331d2d4956cab42e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

