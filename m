Return-Path: <linux-kernel+bounces-253310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C50C6931F64
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770E71F228B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634FF1C6A4;
	Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPkzYp84"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A918918029
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101299; cv=none; b=CUGxOF5alXSqA8FBlpucQRDg8QJuF3jDxxSmGBs/yVIRmmMrd2lqG7i4YrMRnU1X78RoBELoiHdUlkoB1tFFaOd9n9UGE8/Va1G9Sa4W4duFAjKLinA8v2O50gbmhDN1X/KzVOtpTbS6EGnh+R1Nv5ujtG9r4yF0hzUpse+IIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101299; c=relaxed/simple;
	bh=QUxV/AiusXiubkRh30UOnWN128GZ6uLy5c+0NMm8aKU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E5H3axqDWJ6G0FT7jAhc8sPz78WLHYlYug+aYo0hCK9N8/SW9BLfu3XD5w/b0EMWdJpsskudP2FZsLZJK7ww51+0b8DRLz+AFwubnnx/Z3A0qb1HM/2QXxzIYnhqrHnMCxHh6PGqfZP+XmFYI1LxnelYACHCqhShWkLNyTTIxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPkzYp84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82D6EC4AF0B;
	Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721101299;
	bh=QUxV/AiusXiubkRh30UOnWN128GZ6uLy5c+0NMm8aKU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dPkzYp846FY/nUQag821pGp19WfwYB4GQYieFeZowYV25bSjFc5AyURIgTelLLq5R
	 uv3fhUBHRfxCiT7RBR+HtZWcZglcmw/So8Q32qTjWyPc+1EvpcpTWIzTd5NXmcPekw
	 AY3HhOxTPN50fCZV/xLj6Xc40m9SOeKahiCb8yUwO0iVqP1SMRq+QoEFT91bpRFL8w
	 f3iY4d6w2wxIxmrelNCPAX1sbehA31MFZ1o1TtFE80kzw0dOW7dSFnCTc6NWToF2eH
	 ii0BygjEj4LQiwJ2Wa4h8JRuegDTLwciFrCbqlkMx5U7CixMls15+BaS+uGof1T9Hr
	 Diyr7XpRbfxnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AA17C433E9;
	Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
Subject: Re: [GIT PULL] x86/boot for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715110417.GAZpUCMQZXlXomdlGU@fat_crate.local>
References: <20240715110417.GAZpUCMQZXlXomdlGU@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715110417.GAZpUCMQZXlXomdlGU@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_boot_for_v6.11_rc1
X-PR-Tracked-Commit-Id: 0c40b1c7a897bd9733e72aca2396fd3a62f1db17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4578d072fa8f840d2492e1bba30871dbe1e9609a
Message-Id: <172110129949.18508.14206199687698481527.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 03:41:39 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 13:04:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_boot_for_v6.11_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4578d072fa8f840d2492e1bba30871dbe1e9609a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

