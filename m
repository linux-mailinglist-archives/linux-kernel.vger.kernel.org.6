Return-Path: <linux-kernel+bounces-576169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF32EA70BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C9E178B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AD4265CD4;
	Tue, 25 Mar 2025 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spjQaexr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D3025290C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742937475; cv=none; b=GTJKxWsYvRinljI1exOj7K9HWwkWwGOmtgjRVKBok67xcFZpyC4IYGAebNRa2cKOdhzTgA9daHZunRxHQ1BxMERI/eWVWcXP285hd8LW01wMRgLxj2ZZZwUl/dGO9F6sdS5kkyDi/SzzuuAg60+q9y017+WgobAuagR3Rla5x+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742937475; c=relaxed/simple;
	bh=xCm15CGw/DJ7XvYVHYoFVZKXXYAjJ3F+WRf40T3u4BY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XJtZpTQgCqNGSjxigdp/YiHyBpAhMQencLA1QzhIBVkOKKInYAKxQi+jA+AVLPz+C3NAfe2+mKNxUxVBc/4ml5Ct0I8vDO1Y7irEXNwuLY6qSibUhl6dadxaiJcBF08OJgLDIcgIp+n7cMPpvspvlH/Wmwug3wz7bwaCqLwwhoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spjQaexr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E130C4CEED;
	Tue, 25 Mar 2025 21:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742937475;
	bh=xCm15CGw/DJ7XvYVHYoFVZKXXYAjJ3F+WRf40T3u4BY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=spjQaexr1r3uRGhna/d0TLVon0zcDedicuAwtpLEXkPMtVv7XOuvkbaaoGR60RiV1
	 rolmhuXaUb4wDjgnSIeGvnlnGJ0tWuEIf1m7GmnN2I0nqdl+ARLrY8zLi+eVm1jZ8Y
	 rFhwVCMH9a+LKQUbWMcwqxtCnnIDkNsrlCqZ2Ft4uauUt9ROzk/zDkA1T1uSwgnb/M
	 EQJ4nMNy0Y3yRRUSiQgFdImzOCdXhPWg7VJ5uGSfX1fT0wZxhnhsj2DZM6BHBpLDUj
	 nTEOq8SSIjBn/ZtvsEaSR2QOeRgBiXlJGzyKh9wvilDv5g2WEb/6vW13RavvFKOzSB
	 78DcccCN4u+Tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BAB97380DBFC;
	Tue, 25 Mar 2025 21:18:32 +0000 (UTC)
Subject: Re: [GIT PULL] ras/core for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250325150001.GAZ-LE8Zk2JIGck0qW@fat_crate.local>
References: <20250325150001.GAZ-LE8Zk2JIGck0qW@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250325150001.GAZ-LE8Zk2JIGck0qW@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/ras_core_for_v6.15
X-PR-Tracked-Commit-Id: 6447828875b7d768e4ef0f58765b4bd4e16bcf18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d86c2395390efd61d111698ec120b5a79303b99
Message-Id: <174293751152.732113.5119438726236996139.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 21:18:31 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Mar 2025 16:00:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/ras_core_for_v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d86c2395390efd61d111698ec120b5a79303b99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

