Return-Path: <linux-kernel+bounces-393914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667039BA766
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A73B21DC7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 18:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8ED18A932;
	Sun,  3 Nov 2024 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMp6xRFQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201EA18A92A
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730658561; cv=none; b=FnKP/RG9LGRcMhedZXzPUhOQAUuvtuauHXHJu+wszcbdoqQ+41Wi3VC5gBWuLMn/o6qmujYNdgn1hrx9+z17WCYw1e/ll1iFWI1hP4JSm3aZJy5UlTXdMxbjANEI/GV/nYnJCaNQ8ruS0CzcNyAY1RsJd7zDWs1NNQC8XbM2Fwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730658561; c=relaxed/simple;
	bh=pnlo79rhuREXyArE9L2+CVs2uRlWkzkUNg6JASgZvA4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u1pgxd3oZ9URu0XaMeJc+aH+qemHatrRWutirQzkJeW4sZ8bb/fc/GIxDxZSRPZX1PXNijpNtwFcVU0k4xr4hcFOdTadd+ix/MhJ0tRf4V+qGxsO471Nr0tlqyqkMinV99MpOWpO9/XnA3yjrHdU1TygK/LHZNC2i5Yn3o8iztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMp6xRFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AF5C4CED4;
	Sun,  3 Nov 2024 18:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730658560;
	bh=pnlo79rhuREXyArE9L2+CVs2uRlWkzkUNg6JASgZvA4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TMp6xRFQYgRK2AO1nRbiLJRsMK6d40uLlHyQF6nFyoBWUSKeKFRuWN0AVuXWltbQ1
	 aJ6d9GXICG/hBntSJM6I7wk0JIxpZbBTiR2wRC1rgMdpnOTNZ845gmvlM6/Adr3phD
	 nW7KI9eQmraanctcOE1tejxRoCfGACH9cGz9h4ckCTsrQNLuBSPcltmiOV0MOYTlmO
	 JxVTNq7lk2FrfmxT+Yzw3+MegtmrGxbUa3ceJD4qwzpEeSErfLa8GZXmutoIGQzDmv
	 dkVywjn/mcPOSoAuBvuCaioaz++t2fexkrr+ZCHj41jmLlAYEtG8WXnHytcTchTriJ
	 DmwktDwe/afaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7938363C3;
	Sun,  3 Nov 2024 18:29:30 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <173062983343.1467946.18003860565104861128.tglx@xen13>
References: <173062982864.1467946.2540622433845043721.tglx@xen13> <173062983343.1467946.18003860565104861128.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <173062983343.1467946.18003860565104861128.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-11-03
X-PR-Tracked-Commit-Id: b5413156bad91dc2995a5c4eab1b05e56914638a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b019b4a6706f3ee133d68a29ae92cc6695e86d6e
Message-Id: <173065856897.3226528.6089060343330791997.pr-tracker-bot@kernel.org>
Date: Sun, 03 Nov 2024 18:29:28 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  3 Nov 2024 11:31:03 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-11-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b019b4a6706f3ee133d68a29ae92cc6695e86d6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

