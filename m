Return-Path: <linux-kernel+bounces-415034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8179D30F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD20B21786
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D191D0E07;
	Tue, 19 Nov 2024 23:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpBpbkuv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879DE1C3038
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059206; cv=none; b=YkQ4K5RcjARB6ym9f4T0AHQouGuql5UosK7qg90MBw5XprTCF7vwbop20n22k3E/TOTO79O57wwU+WnHUcZt0RLNcN8ennh1Xkw1QanxpvErIanwSnFTKhOZImNVDsyY11EmL0puwY+NKYsZVgWOsaKjJITNDud5T0MILRhIVig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059206; c=relaxed/simple;
	bh=ZLuQ8M8P8AU++rNEwkFSBzK8sgiGTtbj2gI9NIXGlsk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hR12B2fFQX6qQxShub4poktsnplhS1RA01j/B1Um9lP+ndOF+GMwOASSndPYj+c0uDjcqO8rmH4Pr6ozvqOOwrfL722y3ba761q1XWAaStaWuy7eRTJAJpkZFhQIbb+D5WNv78uRPq2p9C8hZ4j6ZCj3wZlI/uUZFzWg1mtjCdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpBpbkuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669CCC4CECF;
	Tue, 19 Nov 2024 23:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732059206;
	bh=ZLuQ8M8P8AU++rNEwkFSBzK8sgiGTtbj2gI9NIXGlsk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OpBpbkuvMh1uTojdfCIpjnJosbsVeRhRDDUHyCbfjfTuowEF5Gh4AyWT8YvMFm1sD
	 hAAR39Kipx5LBoMUblMuaLARmG631qA6M31qzz4Sj09edGNzIk2osl09xjhmaDXkCg
	 qHlTJz4sR3HKx0o93TFGMfmCymaxli+mqXQ+iQHkNMAXzLwFgD8tF+PG0jF0yOJ3me
	 AZpX+dHW2pOH1dbDOYlyTZl978uE0ydj7leSa8y/i75z8mZ1LKGDuh1T3v/5/45yNg
	 dDZILuMAUp26zT3fnE+s1+r1L3hkvTL/ln9zvm1wUgmkqxuvhL8suPaerbB0CfMiuY
	 dS1qDsXJMQ7vQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34A843809A80;
	Tue, 19 Nov 2024 23:33:39 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzsC7HOiJ8Mwk8D6@gmail.com>
References: <ZzsC7HOiJ8Mwk8D6@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzsC7HOiJ8Mwk8D6@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-11-18
X-PR-Tracked-Commit-Id: 3b49a347d751553b1d1be69c8619ae2e85fdc28d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 364eeb79a213fcf9164208b53764223ad522d6b3
Message-Id: <173205921777.720598.13004107819008580932.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 23:33:37 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 10:03:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-11-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/364eeb79a213fcf9164208b53764223ad522d6b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

