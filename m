Return-Path: <linux-kernel+bounces-539705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773CDA4A795
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95CF53A997A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B6D1A8408;
	Sat,  1 Mar 2025 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwC03ySm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88821531E3
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793233; cv=none; b=tnNeMQyWtqHG1NcHZKJYjjV6Ym/21Q8Xk8dUza3iEqutixBOgIenudm/Re0NVJZnav7tsiz8PDmIuGSwFx3XHdNGXV3ybBAIe33em9G/VMBX2i0gu6UBsksxIRrVgn4iPsdQfE0OqLwrtHlWp5Rs/7Ee3+hX/i9tShBpmtBYjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793233; c=relaxed/simple;
	bh=tRHVrJ+d9xQTMqoG9SHADh6jtUzQQL54pikw1KdJ2FQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uoWOklMAWhphkhLsiayk3FCVtwgYKGMLKp0/675PA360f9EhxEmBe74NDsk1Ix1SqtM0OEfthVLggVbHAIA/53TWT5XmLdRLvlObSCk2oFg5cGKdWYcoSLsqAVZq/WgUMSyJJciAzsPBKD2vqrlZkT6NyR0QISbGN4ECwsVoqkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwC03ySm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33175C4CEE7;
	Sat,  1 Mar 2025 01:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740793233;
	bh=tRHVrJ+d9xQTMqoG9SHADh6jtUzQQL54pikw1KdJ2FQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UwC03ySmUjLXYvI1UjHZyjH/4soIMwNTVGmR2nc/zlazsdKWlq3BWTfDfGsd79Bye
	 FoCZ6cJFjOsdpOpk5P2NHYX06q4rqJ3NOLCiE5L9eihhhS93l8pVuDAsfdUnRKw1Es
	 jnUwLjD9y1LeFs2TbvC5p9g9+sVKiO6m7l4cGu7BNayz8wOsppIq+bb/wIzVlD6Dfe
	 JQK/7fr02ccMyCWCyadtRqczV1Ml/w0cKpQym29XA29XInLWzQhYmoLvOuSYv7K5Bf
	 7iSnSt+yGwNFY9WcWlkk+3gvrI3QPXHHBm2I5ohJCCNlUhVqJM/A9ea9+vx4pYFR7C
	 MrvhpUA9lW1iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF11380CFF1;
	Sat,  1 Mar 2025 01:41:06 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z8INmgpEYAFPMef_@gmail.com>
References: <Z8INmgpEYAFPMef_@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z8INmgpEYAFPMef_@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-02-28
X-PR-Tracked-Commit-Id: 0f6750b15ffdf274668b12824b09bd49ea854e18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a5668899f54f6c9fe8619ecec23fb682d463f4a
Message-Id: <174079326531.2333772.8647408624638665491.pr-tracker-bot@kernel.org>
Date: Sat, 01 Mar 2025 01:41:05 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Feb 2025 20:25:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-02-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a5668899f54f6c9fe8619ecec23fb682d463f4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

