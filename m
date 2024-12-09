Return-Path: <linux-kernel+bounces-438203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41039E9E2F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049941887E97
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B34197556;
	Mon,  9 Dec 2024 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUm/JaMk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512D0194C6A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769504; cv=none; b=o5YQ/Rd05qiGmHfmoxpH7ubclFormJcsiUtHDFlcU7iHOR0y4e96yWpfDBXM8HTn/IAqSGNkkn8VPZrSJ+uUEEMw+TV5uKwce/f68MepnOZZbOxq1417Ew64BOktbOlGenJRh3afaBwTszGYeKGz28Jy4HJWQE6Jfo+Z7aIszo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769504; c=relaxed/simple;
	bh=q6wlSIzKnkSCayKKtLUnusbOVEVhrHqxP69kIEeNpBc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r/B5eK2fjd+bJxvJ1YUV1XZcmwKYEvxrou8NLwLHw7C53E1drnkNo40XDtugEvqsmcVylwrjvoAi+UUcLBRu6axU5A6E7VMr/mv1OzksPeGlyXGAaXbXCbrKn7UE84a/4AC3xFJ9aPf9w6k3cvQB+bDd5x4BibCYG7hhSElQneQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUm/JaMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD69C4CEE0;
	Mon,  9 Dec 2024 18:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733769503;
	bh=q6wlSIzKnkSCayKKtLUnusbOVEVhrHqxP69kIEeNpBc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qUm/JaMknZP4Yb5Vn1/YsxV1eKuW4Im9FKPzjSHbGv77L5NY6ufsIrknMZG1OEy9e
	 c05guPCBX/QXm/1gx5VCxh0jo9blTO2sM850Uf252hLMMxMla8N7fR7517z5TIHh3L
	 0dAwunTh60vRtaOBnO5546kBPlKEVMkXD8G2Zb0i9OGDDZUn/TEzBi5NdUH79sNJJq
	 e2AjFVEvQ67NYyBEkJap7Bpy50RGa5s3fQPJbtQqyJj8r52f+pMyGf4RhxmuMmnZ4Z
	 IBgTsW4ygEo0Z0+6ffZP8wQqmzGg6V2TEYO6lPvJ3JIMb1WNXePgSdB+nREnvcQ02h
	 mUYepEAWDcFRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4DE380A95E;
	Mon,  9 Dec 2024 18:38:40 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for v6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241209101747.GAZ1bDy7XMTKoRqs1g@fat_crate.local>
References: <20241209101747.GAZ1bDy7XMTKoRqs1g@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241209101747.GAZ1bDy7XMTKoRqs1g@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/locking_urgent_for_v6.13_rc3
X-PR-Tracked-Commit-Id: b4d83c8323b0c4a899a996fed919cfe10720d289
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cb1b466315004af98f6ba6c2546bb713ca3c237
Message-Id: <173376951920.149590.14636386507291323990.pr-tracker-bot@kernel.org>
Date: Mon, 09 Dec 2024 18:38:39 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 9 Dec 2024 11:17:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/locking_urgent_for_v6.13_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cb1b466315004af98f6ba6c2546bb713ca3c237

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

