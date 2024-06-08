Return-Path: <linux-kernel+bounces-207143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FABA9012D7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 18:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE3B282A42
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0D617BB03;
	Sat,  8 Jun 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4+N0E6Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62717B4E2
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717865423; cv=none; b=jlNYYksRhD1OPoFmY26sJFXceloeREFEHWODJVhOtBbGfoN99o0qHgm6ACByHeIEmuWY6XSttPy6CxCnjVhwS7Yl5CiNe2zcncM98XbuTBpow9HSMoG5hK5Z+P0vTSH62SVVcptqyYoN24BGd0eYlpDGMsmRMw1eP9p204Qvk8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717865423; c=relaxed/simple;
	bh=tRXSDT8fFFVK99UPrqsXviTEHUP8KVlWYWIhc9EsHcc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WP5o5uidI/NSlefbSmbNB2Zr8o2IrSGpjt7WwVWyCBUfc41ZOM+kwMci0cSOYPR7Kb4YFdTr2oIF45cdBJ1AYpgGsM98Iw1uL8nijhy0lftSrgSmVQl4PFm6o0uwJ+en/c5cEu5y9GJmnk75x+ey3SfQVk6npCbe1Gdd5BngqUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4+N0E6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D233C4AF0E;
	Sat,  8 Jun 2024 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717865423;
	bh=tRXSDT8fFFVK99UPrqsXviTEHUP8KVlWYWIhc9EsHcc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s4+N0E6Z2YjddZWUZp1TQ5a2YtS2pvWI9VGTgEPZB+kwGDsVMRVJv+/b2ZGk9KUbb
	 Cnx+M9hhS3Zl0FQGbtc9EzdHQkScxj5D4wSZ6fHFl+zf7cRgEsEWv7kB6YD993Qaos
	 WC8IVcK3i7DTgS8J3rv0qRQg8Z5tASMgJkuwY/V7fPfxVyu4esOrOJbrH9OPr8kx+l
	 TqjiHGwDiwEjM4+wYHrKwCCbtZ82HGzjhgIC2yTZKf+chJfYk5FfPSTmlhMs0OFz08
	 CH/syybFOT22j3fhkovSp+Nifud/W5Rgdw58y7Jkc+lEQvNcj9fdv9GQXJ0aGHvNHZ
	 JYxSfi7r0hfyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28260CF3BA4;
	Sat,  8 Jun 2024 16:50:23 +0000 (UTC)
Subject: Re: [GIT PULL] IRQ fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZmQNrYML8WUnkBYv@gmail.com>
References: <ZmQNrYML8WUnkBYv@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZmQNrYML8WUnkBYv@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-06-08
X-PR-Tracked-Commit-Id: b97e8a2f7130a4b30d1502003095833d16c028b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36714d69b186ab38f2f9eb833a2dfa57878095c6
Message-Id: <171786542315.29675.4689508653973741512.pr-tracker-bot@kernel.org>
Date: Sat, 08 Jun 2024 16:50:23 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Marc Zyngier <maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 8 Jun 2024 09:52:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-06-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36714d69b186ab38f2f9eb833a2dfa57878095c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

