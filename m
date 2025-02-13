Return-Path: <linux-kernel+bounces-513675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E802CA34D57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D5D1882E21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCAF245014;
	Thu, 13 Feb 2025 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABDFLJyr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696424292A;
	Thu, 13 Feb 2025 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470577; cv=none; b=rhaRBPevkF5fjO2lnv4WNvUPVK4LSR7G8d51WF0MwiLP21XdO1CyQY3F1Mqg/lmdgzeVeQDtcwppSGoliky9FjRVVtfhZgpFu8Q7kxWohSj5OOn+scXMFmjMP3Blko11DTbRm+VLorIw2h9Ql4GKUviQboziWI8hGWVbjoy1u64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470577; c=relaxed/simple;
	bh=NgnYhzPLjHAblX4RWrXhkTc/2BOUz+B8L6B9K5pSNk8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kqSlLjIUvOq7KfgSLF0I7qQnWuD+fkehRQC7eLgqVQN8KoBPt9tfty7qmlMvMC+4wjCbhsy87fScghx+G+6qj/98vQ49F/DYJe2dbf+NOVjy9c/nWhiFe2+In+DtUtoSKQ0HbV8j2oMH67JDv7KVhX9IrVH0nazemP2kxiD1Ot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABDFLJyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F6BC4CED1;
	Thu, 13 Feb 2025 18:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739470577;
	bh=NgnYhzPLjHAblX4RWrXhkTc/2BOUz+B8L6B9K5pSNk8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ABDFLJyrx2AeUEZb7vkelqtyb0GlDOFzREGKmzHRpsjFOEc+fPVqKiJxa8It7EDti
	 muJ7gLrYnF7aFToUqsCwPowTCQdfp9jv4B4RTiwlSuqQpS4TGGznMfDPZOFiwMM8XP
	 2OdLh7YqchQvoL/6tQglcJPfDGfWnp5YDeWjAsKaF4Say6qQM/2hNR6cvhvhWuUcBP
	 AwfcALnIoIQbWWpz5az83tt/9+YjIY8ekwA60an9n/Q2bqrv1+ZqffDWu6BAipYTVq
	 9Fis+ys0gkIBjpry7QbhJ/SkGrix1iSwqk2MhU4YRYTwcMxWrbLzhfBA5lFSy3XOQ1
	 qaeCZVuSWFRyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71769380CEEF;
	Thu, 13 Feb 2025 18:16:47 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250213143148.1450556-1-chenhuacai@loongson.cn>
References: <20250213143148.1450556-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250213143148.1450556-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.14-1
X-PR-Tracked-Commit-Id: 3011b29ec5a33ec16502e687c4264d57416a8b1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab68d7eb7b1a64f3f4710da46cc5f93c6c154942
Message-Id: <173947060611.1325136.10750928122042653593.pr-tracker-bot@kernel.org>
Date: Thu, 13 Feb 2025 18:16:46 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Feb 2025 22:31:48 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab68d7eb7b1a64f3f4710da46cc5f93c6c154942

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

