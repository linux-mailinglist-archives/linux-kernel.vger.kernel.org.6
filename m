Return-Path: <linux-kernel+bounces-254184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BAF932FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFD9CB22128
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB6A1A0714;
	Tue, 16 Jul 2024 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn+XJk16"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66561A0702
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154620; cv=none; b=LM5iMFwP+nWH+t36U/CwSLKuvnD/4MJZYz7qYsB4BPj3Kyw7FjVG2ptLDFXaz/0drny4xAn+5v09mZSVg/+50axSG0Ny7BcnyFWiYJXPOMPOHcMBjTKmceD/lz2yRePX0MQhqcBrWvKA9k/e7XwkIKNX6P2ENShGrnQXO7O6JEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154620; c=relaxed/simple;
	bh=nJfAx9vqSqvm6w/41vXyFmij3+9nKbqd1cfuivXg0+k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pPdakrb6mvJniWrq9yHROJRdwDkkQ0ZlkJbWDUIVOPqiJDYOWsx7jYvCCUVd6eBZIqxvCsyJ/Ytp5xCHMjLgXL+LgaTHXxsG2q3qvR24w4Xh+fnK8EWnk4fnbkyg83pPTIsrRUyJ/eUjIz3PlyVbFlxjJgHEc1Y+rxoK5QTLM/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn+XJk16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2AE9C4AF0F;
	Tue, 16 Jul 2024 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154619;
	bh=nJfAx9vqSqvm6w/41vXyFmij3+9nKbqd1cfuivXg0+k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jn+XJk16qhzRNZE4nRMXU2N9Cl1z4QM9YQiRWipNw/MieN6eMedPXP+FHwsdAAes6
	 HjO2qIfZV3bHad5x7INkskfzt5YEMBpwnvJoqNtEtzw3539zB5+aYNBwptFk/H1xs5
	 LKkhY/wPNmf8I1s4wjBgSDosDFt52S184sSK00I7ImlB9myXzz+P7vXA686Q6zt0KL
	 vte6PN/VgcFR8+eNdoQ0EdMQJ5n1Py44w51ZkY2PvDw6Q7jmqr84fqEshxPz5WvJ2H
	 d6lqPCexbSILIPJiBE/F4Flz8JE+2jJyXNubc2Ejs09nt6vtwblSx4AendabZnvx8T
	 iHkIYH8U+4z8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0718C43336;
	Tue, 16 Jul 2024 18:30:19 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716095557.GAZpZDrdC3HA0Zilxr@fat_crate.local>
References: <20240716095557.GAZpZDrdC3HA0Zilxr@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240716095557.GAZpZDrdC3HA0Zilxr@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_sev_for_v6.11_rc1
X-PR-Tracked-Commit-Id: 5fa96c7ab3dc666c2904a35895635156c17a8f05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 408323581b722c9bd504dd296920f392049a7f52
Message-Id: <172115461971.31841.17750263413718145343.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 18:30:19 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 11:55:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_sev_for_v6.11_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/408323581b722c9bd504dd296920f392049a7f52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

