Return-Path: <linux-kernel+bounces-176932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 221A18C3740
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 18:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2978B20D17
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 16:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B40B46436;
	Sun, 12 May 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfIMAQpj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E744C8F
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715530280; cv=none; b=dwkvAD+2WJgvh5yFTMcF/JGaCkKYH2Btp8oMWANSVS/3/An9+zKFXa8DK8rDUC2e3083xY0T5NPsD6brXHLvR8YbSzhhlor4DNV56UGa0n5LK9uqM+WGdRq9WRCgZdjiaha1lKxKvG1DPTuU2h63YP5KliKs+Gaz8PqJGKzJHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715530280; c=relaxed/simple;
	bh=9gw5SxrGmAiOO8hBXnG4Y1oLNi+qqBPBxTelhCKUUtw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F697DXqMk3W2OlISXkdx/KErDgQwSRbFiBvfNtRIgS8XPorLqMnj3NdeETJvPNljY8aF22FJahiMznTQE6BSDsves75ojnx6Rt0v9V8aiObKq7wSQ/pKzbJetblYpGD2xIY6cwOGNMN06g7pMnZoPB6TjgAqIb52xNBx6/Y4Dvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfIMAQpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65E7FC116B1;
	Sun, 12 May 2024 16:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715530280;
	bh=9gw5SxrGmAiOO8hBXnG4Y1oLNi+qqBPBxTelhCKUUtw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jfIMAQpjeIB9gNWQOIN+yQrgQQItaSzwLnCjCOaYOIkNIospOiYf8zBzotW9NihKn
	 daEhn8Dsp4OXEjFl3eDG4/eOAww4jvqRk+hGd68wYJ8aBamAQl4tF6IPOxd3BZlZLv
	 SbOza23yth+IE/fderOZqGxSz3x/vmqdanfL61f8RDQ4yc6D+ysmJyROP3aAyzdp9Y
	 ijO/v8fjZ1K8dfDxQQM1KxCI9sEFRPy16nZ9OzZ0Ma0MlOfXIqL4EVqWH9YDZv5ryE
	 uGpmM5TVfbI3ohRi8nRafpoCzyj6Y9zLkL6puuSwJhwf3thVgH8bDMV6LMBCKOKCek
	 tnDWZWJQKXMqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58E1DC43440;
	Sun, 12 May 2024 16:11:20 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240512073821.GAZkBx7VXlioXx6q6w@fat_crate.local>
References: <20240512073821.GAZkBx7VXlioXx6q6w@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240512073821.GAZkBx7VXlioXx6q6w@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.9
X-PR-Tracked-Commit-Id: 5754ace3c3199c162dcee1f3f87a538c46d1c832
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 775a0eca3357d79311c0225458f8fe90791a8857
Message-Id: <171553028035.9930.11644212437669685090.pr-tracker-bot@kernel.org>
Date: Sun, 12 May 2024 16:11:20 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 12 May 2024 09:38:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/775a0eca3357d79311c0225458f8fe90791a8857

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

