Return-Path: <linux-kernel+bounces-255861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4109345C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC31DB2250F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE13943ABD;
	Thu, 18 Jul 2024 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQz36o20"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C0374FA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266039; cv=none; b=uoz4XcWqkrsLXAKDZfLzdcDUTx9ABiX1GYQCYbWSiQoOQPyDDrqClZh9WiP3O9vj6Rel4KQQCspLQ/PFopmEwl2h6yLL2xSYN+PnhO+NebWJOWr/e1EGv60hXan/zet39m44rIOAeihzSkXN9NSGPOp700s1hvZ95HKHvaXu+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266039; c=relaxed/simple;
	bh=rwTGul894Dmx2nMT5sRbuO0GYKfa09y3khTKEwFf3TY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iZo4bTiPj0Ujo8+eu3SNMNrg+BCldRQgDBruJuQBMikkvZecqgDopqjvw72EyPO9kUcSrLYbLS3nkeUttswjW0F40XSxN455fnIpYh+OeWK5ewb/byyZmB3r1za5gKArwMYKU+w0xTn0ywMNlQ3SdicmDYOkujkDj6v0sZ48KTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQz36o20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2538BC4AF0B;
	Thu, 18 Jul 2024 01:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721266039;
	bh=rwTGul894Dmx2nMT5sRbuO0GYKfa09y3khTKEwFf3TY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fQz36o20bjwBD6cB/3XeDpd7WlpHlMn7X0FCWbidEK+BWDF6KeVNjSVyy98gQC0N+
	 et5tt4vgGK4kQxudsC94jtjTC+XvcEzqUsdwprBMVF80Lc1ORZ5cZh7st3XIsosZFU
	 AioFXR4iaILi4V8zZYwI48jBc9PdQMji+4gsIgEWaGhhHQ/MhQvZJGh+N8tOP/pQxF
	 x1uWaezwV6rHUsQKe34/Ex2qscWR9Hfq9rgKfPUzVP0hdMrH4LydVt1HWdIn5oUsOE
	 qe0PHtLyc4xVM/Ervdww+nOdaI2skl2YZK1jMH45ouRQQ2mTY4tRaZV4E8dfbKmOpE
	 j8o0eOLVodINg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17E30C4332D;
	Thu, 18 Jul 2024 01:27:19 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716141404.GU501857@google.com>
References: <20240716141404.GU501857@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240716141404.GU501857@google.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.11
X-PR-Tracked-Commit-Id: c298391abf6505c4040632b310a14f6bd9b7afff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1200af3ac16489d9f0b86000362a044ed7521cf6
Message-Id: <172126603909.24030.18395236869110946279.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 01:27:19 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 15:14:04 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1200af3ac16489d9f0b86000362a044ed7521cf6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

