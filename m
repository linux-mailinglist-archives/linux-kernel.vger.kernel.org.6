Return-Path: <linux-kernel+bounces-253316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FED931F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D020B223F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899D94315F;
	Tue, 16 Jul 2024 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urliAJd2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6AD1C2A8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101300; cv=none; b=Ki4DW4qlZzrqMCT4oKWw/BsHz0ueKWwCnwvr4gPAsyynPVNjqCo8WdhT4sO/dwM3u2Fs/f18bsjejYID6cAsAqsYpeNm2bLIGbHKdqFmAdTeI9ykVFOklSlSJ+7DNwz0q2MrywZCzGr9kvUm69i6RI9NWAHZm0pbYzUm57vymmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101300; c=relaxed/simple;
	bh=IN+DbzTQ0DGYuftmIVFQU/rA13g+C8GcSDcnZTrrR+c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aDXgCcw3ESN04529VCfehZxui1iHYZvbyWCT92Sbgh97L9c+fBtjyR4w5Zjt0///wpfV/aA79cUIbsLZOPdz+hEDZmd7kcfqE+8tNq2JIO8rVwyA0sA4b8lgtNVnytu8RRkOXBdwUV+OI2XfDYb7I5jCWtLrnkfNXyV9xqFx/vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urliAJd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E170C4AF17;
	Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721101300;
	bh=IN+DbzTQ0DGYuftmIVFQU/rA13g+C8GcSDcnZTrrR+c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=urliAJd2/mMEKTTViIquaxUO1hyASrvppmcWTw67PLszLKgW5BG+SsOST3whD96Bz
	 z85ng/i1vnNA0/mviVN8hREENZhfaiI91zCLLqpuO/cvAlE2vHvBl7tzX5dIjozYvD
	 fa/znFCira9n4J4qB7ZMnuhF/0GI8K1r3CEOD3Q3fmslzDt/CliAip08/syaNuwvD/
	 S83L8iYTOsymWfSAINpjlAG/F4KFkjfTlzEOglaokUmIUwa/7SX1CUh5GQ0U7ioCqN
	 L9yRC0GFCF2paaWNtE02nNeGLfEWXlkmmwJl90kpnJOoWFKl5ntOHiWR6BUmsVoKaU
	 teU/e2wz9p9Sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 216D1C43443;
	Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
Subject: Re: [GIT PULL] x86/vmware for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715151025.GAZpU74ZeeCqqMZpWw@fat_crate.local>
References: <20240715151025.GAZpU74ZeeCqqMZpWw@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715151025.GAZpU74ZeeCqqMZpWw@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_vmware_for_v6.11_rc1
X-PR-Tracked-Commit-Id: 57b7b6acb41b51087ceb40c562efe392ec8c9677
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f998678baf3c143fec4c66e7f3a84bae3b25ff12
Message-Id: <172110130013.18508.15825421568808151917.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 03:41:40 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 17:10:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_vmware_for_v6.11_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f998678baf3c143fec4c66e7f3a84bae3b25ff12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

