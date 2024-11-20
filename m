Return-Path: <linux-kernel+bounces-415094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 183E39D3181
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF241F239AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2991AA933;
	Wed, 20 Nov 2024 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFWacGtF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8D517F7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732063751; cv=none; b=djJrP3x4jk33VcgJu1ch3/B1LdDabaPfCUZYpYd41rulfpfA0qxmaVIMNSLZhDolK+hO2hVvh4LXlyqpVqsIvAk8CACy24r0sZJQTrHqS/lutjFjTwtBOuXd6etr0AL2PX2dwI8XyUdZlPCDbFZ5ckkl9gVAqIM25FKteqj94bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732063751; c=relaxed/simple;
	bh=ssmeOgePNtiH5uCK0h/zTeRdgVZskt/QM2nMzEloOX0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FTCt6dbccdFd+r6j+eHe6NouCCY5vdeWHqmO14SKEW1w1Xwflss/y9sreisfZW66CEwx5yg8mgdPWddhOfnt6T9cgPuok24OGV3dI9PO4JvwREqHj38m5TZSHgY2SivRdmHR2HWppCJQFTBr7uPNXMD7yY5dbuPhFDWcBcsQqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFWacGtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5CEC4CECF;
	Wed, 20 Nov 2024 00:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732063751;
	bh=ssmeOgePNtiH5uCK0h/zTeRdgVZskt/QM2nMzEloOX0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PFWacGtFwLKr43RA4MCap9tiikzAUwfHsFXEAfNGEbgvGJlWndiygSa1fMUM2Ttjd
	 IkPT13wWfN7DyMQeJ3N2afiSpSun7qAenXjjVUvQOZRJPLqpystaKDgpEpYfJQhCNX
	 skNJHnPlnYrzohjH2KYPX6UvZZBRFiLArbYzYWfJgyamvOSkJVj6x2SJMcO29RgTkv
	 cAFhzYHMKjQlDlXjvEuEG1daKB5ZOdURsklbL/GN0dT16LDQuNuEWF5FFdGTFKABBo
	 +W1WqPrbhSCkazLidP4/NjCAUcTkqbryIzvl338+5BOfLaPkVBvuvVeGFAqrlF0xm9
	 JD628kGoP7nFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340C33809A80;
	Wed, 20 Nov 2024 00:49:24 +0000 (UTC)
Subject: Re: [GIT pull] core/debugobjects for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <173195757899.1896928.6143737920583881655.tglx@xen13>
References: <173195757899.1896928.6143737920583881655.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <173195757899.1896928.6143737920583881655.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2024-11-18
X-PR-Tracked-Commit-Id: ff8d523cc4520a5ce86cde0fd57c304e2b4f61b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb1dd1403c7b2219b8c1524c909938bd4b3f401f
Message-Id: <173206376286.738777.3087233553429159352.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 00:49:22 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 20:21:47 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2024-11-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb1dd1403c7b2219b8c1524c909938bd4b3f401f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

