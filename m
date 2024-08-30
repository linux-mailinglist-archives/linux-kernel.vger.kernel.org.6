Return-Path: <linux-kernel+bounces-309338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E23D9966908
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E191C23873
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835791BDABD;
	Fri, 30 Aug 2024 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF1CiU8V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7831BDA99
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043060; cv=none; b=POrWNK233LMBu/sLkUgOksATIaqGRPKnTGcBVWdnWK7f3EagQ0U6lW7HH5ddGTUoQiwxDqieSUJFQjW8nVXkdYrQRkbgu/XRjLQ4UCH1Y4vFinDskhOrHv8N/9ZWtqaLVYtUMH0cDAJKGzpxTQdVF9DakEkzKqy4booeemBucrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043060; c=relaxed/simple;
	bh=QAaLTDMi4Q9V3IMY6vxHRzdYowcMV7lkF9eJe6JwjvQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XLueuOcmNC+WoOVxDIwW+L/4sW8VQv24BESxZef3nNqP0Zaw7Shr70RPY3y77GpdlBreHn2aU10VD5B8P5/pylRZk9tfg4lhfmDtMMzTs8vEEKXX0ik99U/XON+AcCINnWZyW/RG8L28g2XfaiIk7a4eiKltPJIWZxqEdTv54Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF1CiU8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB448C4CECA;
	Fri, 30 Aug 2024 18:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725043060;
	bh=QAaLTDMi4Q9V3IMY6vxHRzdYowcMV7lkF9eJe6JwjvQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nF1CiU8VP8l/xf7YbZHjzDVDQqvF3d0vWfiuHCdKzkzSGtu22j3iqZonZTwakMmNa
	 7SimqYTeuj009LO+2IjD/38v8zJjnTTSEdsMQxXQP3j1tWd9L8WG7vwC+/k1HTxk2V
	 A6SwCx4q6WbOgKxW3a5UuV/Ix5Mucq0WcwsmPGjDgJxqhU0MvQ1uCn6DsBeyicGnva
	 HNABkwee2FJ53GuaCxEVG9y7049XasuvZ4Xb+N7T/r0wcFNynyMOK4qcNFZ/72TAog
	 MfGsvJlUaEWQjadoLH/4rP5dmantaG9m2jCYhZG1rBvx78r3SGOD9MTcFuREeUKGEx
	 ZQR15xTARAFMA==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5A8773809A82;
	Fri, 30 Aug 2024 18:37:42 +0000 (UTC)
Subject: Re: [GIT PULL]: dmanegine fixes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZtHBzmaZzRaluC74@vaman>
References: <ZtHBzmaZzRaluC74@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZtHBzmaZzRaluC74@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.11
X-PR-Tracked-Commit-Id: 9f646ff25c09c52cebe726601db27a60f876f15e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 922842a3bfbeff64dfebe7f01ce1f2ab01e4509d
Message-Id: <172504306236.2681732.11422468080007908933.pr-tracker-bot@kernel.org>
Date: Fri, 30 Aug 2024 18:37:42 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 Aug 2024 18:27:50 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/922842a3bfbeff64dfebe7f01ce1f2ab01e4509d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

