Return-Path: <linux-kernel+bounces-336359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3EA983A47
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6481C21C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67F8128369;
	Mon, 23 Sep 2024 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S23i+tpa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D51514CE
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130884; cv=none; b=Y0RM8+4wrdaqjWVyYA353YAIGmPNrTbxlDFQF15wrEg9OXQwXxTQx9bR5zCi/L3v5Tsbxspt0oNcdp3cQtRNukrA9t3vaP0Lv1f3CjZM/C24aAzFoeGg3gdphgk0Nbr+9lW1tJhffPHnriulcXG1YzrrBqKVtqUlD2AokprPbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130884; c=relaxed/simple;
	bh=WUumE2lh2NNV740AKFyTPwMCU6paQrH0JYc3lYVFMiI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AaWybI5aHf+EpWVr/cdkWRLWZTyMXjGC56FQADtt5trpXeJiUtwmd2wYPg15C+nR7eIfB+NbvIlfpZJCd9gaq/Z+aGt7NC6BC6aYqTrDGKTX8P4CG8oLkHKUASkwT6yi/KWV7Flz/BPrQRk6jN4aQNZx+vB+Cj11LQZLcNJZl1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S23i+tpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2680EC4CEC4;
	Mon, 23 Sep 2024 22:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727130884;
	bh=WUumE2lh2NNV740AKFyTPwMCU6paQrH0JYc3lYVFMiI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S23i+tpaXoLJC2Ek3htq8Wt+4gexjCDIKIR1qg6nW0vrLMoUJhO0kbY9nzBMSrgZ7
	 mdCNxjy7NCamt6/2ZVzkBR+lmRZ2jADiAmyy9KBH/mh8aGEvqzyTT4rEfFUsVCsx3k
	 uvE2bG6DmmPXnRlT6SG/SdPRujszSJC22YOwNjT5krBgrwTOAolsy2VzWUy5tDKrH+
	 zd1GvqyaJwt3Hb8B6rKjZbsi1uO87oX84d49A6tGpn9Epm3dN7u+0OKj9QKPV3i6rb
	 39NxyvxXhri5XxTXQA/MKof53zVvDyjfRB/St/m6cAKS8xQwZbC8vDuCsMCbYGYbRF
	 JKiGErOKLe9uQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B24C43809A8F;
	Mon, 23 Sep 2024 22:34:47 +0000 (UTC)
Subject: Re: [GIT PULL]: Dmaengine subsystem updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zu//RAyNOZP1Zs+2@vaman>
References: <Zu//RAyNOZP1Zs+2@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zu//RAyNOZP1Zs+2@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.12-rc1
X-PR-Tracked-Commit-Id: e0bee4bcdc3238ebcae6e5960544b9e3d0a62abf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8874d92b579bf86f61f044ab43a4cd961d112269
Message-Id: <172713088660.3509221.6624294208614029052.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 22:34:46 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 22 Sep 2024 12:28:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8874d92b579bf86f61f044ab43a4cd961d112269

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

