Return-Path: <linux-kernel+bounces-257784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E302937EE4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 06:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A12B212CD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 04:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E0AC147;
	Sat, 20 Jul 2024 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1Ky+EPc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FE3D6D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 04:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721448375; cv=none; b=QqV3cF10oQwnT1BcWQ6XMs7B2c6HKLaTZYttCd9g2ZY6atFlu/kFb827nAqn0Oc7dfXXDOBzXBJ/2b+eiJie4Plj+3zeE8QMM1oVTXs/v9AkLNIsn/bphnSO9QJJUVb/xSTcVfyuE9ec2nZBZN8pwUB6WJP/PJ3Dgv2u1xkvU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721448375; c=relaxed/simple;
	bh=dePqgPJklE6B+tcqbhCdwhuy7pE8RF7XDTTIGqN3qTo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K44FJjHLUPXM4nQoe8bveZ9a+tFCoEVnG/oG+UbsWEvef4Bj+FAGM67ojRiYnG69lePqwdEjhb63AEzdJd5kaM2/WLxJSSKrWDg1voNWvoApwAJKeJMdG7+q5e8x0Afb7JjnYg2fyCoXg26d+QrWuMrJEWAzzK1gOlg6YYk17pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1Ky+EPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08EEEC4AF0C;
	Sat, 20 Jul 2024 04:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721448375;
	bh=dePqgPJklE6B+tcqbhCdwhuy7pE8RF7XDTTIGqN3qTo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u1Ky+EPcWmMYIT5gwoOalj1K4PtX/DDl1NNG3sAcM04Ng/on1srPnoIG1QmqFwnhK
	 laW9jD3JgqcBeKOGeogC9BAOvRTAkr5h7nrrfdmirPtfuO5cn7zpYs6EHwrPbPkKkD
	 qCadDU3YcRbfqwpDWcz4sQzl2iY3sVR1bz4YeYaKbS+EHla6ajh7vIbwNr8Vx6093G
	 MAB7imCmd+Szp3tAvvEJvAKj8tlJ2UX484/nS8UUshMpQPZK70/BP1enO8v8mYDQcU
	 xTd7uVwaVub51bGM2EbhCn9eRTEMmTj7pe0w/sya9l8gysx6WAinQ9330ptXOHWDl+
	 3q+JPX6+13I3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDBA7C43335;
	Sat, 20 Jul 2024 04:06:14 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.11-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87h6clwnc1.fsf@mail.lhotse>
References: <87h6clwnc1.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87h6clwnc1.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.11-1
X-PR-Tracked-Commit-Id: 9ff0251b2eb54d17fbe4f6aff50f6edfd837adb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c3ff7be9729959699eb6cbc7fd7303566d74069
Message-Id: <172144837495.29552.14084356407244348768.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jul 2024 04:06:14 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, sbhat@linux.ibm.com, anjalik@linux.ibm.com, coelacanthushex@gmail.com, robh@kernel.org, gautam@linux.ibm.com, nilay@linux.ibm.com, haren@linux.ibm.com, christophe.leroy@csgroup.eu, nbowler@draconx.ca, krishnak@linux.ibm.com, nathanl@linux.ibm.com, naveen@kernel.org, u.kleine-koenig@baylibre.com, bhelgaas@google.com, hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, asavkov@redhat.com, linux-kernel@vger.kernel.org, sourabhjain@linux.ibm.com, gbatra@linux.ibm.com, quic_jjohnson@quicinc.com, esben@geanix.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jul 2024 22:58:06 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c3ff7be9729959699eb6cbc7fd7303566d74069

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

