Return-Path: <linux-kernel+bounces-518208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E40CA38B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF053AC667
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82962235BF8;
	Mon, 17 Feb 2025 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFthJztF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3C22DFB4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817846; cv=none; b=fQNE2F97b1tOaT1eQKqkqml+NHsnFInS5b9HDe9dMwuETc51i5i4rtR1MpSV/BZbBkiIW2POkkXz9heL1FinWKrZPjhUjkwQbghvMjqplgqwZ0TZ6Nh5aHbslmghVjzZOt6gtonZVSLrJKrL5yqusB9tqZHjFkSkQjDKJhXRjHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817846; c=relaxed/simple;
	bh=dV93L79L/EJzP+RF+w+k3xJqs1D4NxYiFfOC+ntR1lQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hUVXlwMlSK3SG0Pm1T47CFr+EfosgE00a57GgMClo8p6YdhophGc1nFo/b2CJStg7oELmAe3xO187EnGV9Tdk5bJDRj+9JBDtUQF0nlzm/NkP+z0xv0hCPqqcJxA1nSrsCZC/7Gbkkcw3zNtmevpfFn9Tn4TPvR5moNZ05sgp2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFthJztF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570FCC4CED1;
	Mon, 17 Feb 2025 18:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739817845;
	bh=dV93L79L/EJzP+RF+w+k3xJqs1D4NxYiFfOC+ntR1lQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KFthJztFOonyf+7cJTSBqJ4kLkQ0nwXNiWa1gOYgGT+StO18jK5k+0UuuBuWllbwR
	 lLmwMC1/+12VMdA0LZLrqNXMHKrJfiOPjpzPF2NjqfXQsYqWdWzlAOUwBsQL0aowMG
	 uYMIwKOB26kEUWHFwBmuqucBFEbWTkk3IRDkVLqYcuciaSrgBbmOtjh38SCHomsp49
	 opyelrIIr9PbXNNzn/mIevCihve0jqyTDW4Vw0R+REALzqGCCETTAqNCg4j4a368e7
	 9Q8n7TpKi89X3JmcIeulOLok8lFJWr6PhVdCv6MLgmSoYuKlpsl7Ai69WQv9TcSR+E
	 yMgbj3l/VSDnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE691380AAD5;
	Mon, 17 Feb 2025 18:44:36 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.14-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <69e279d8-55f1-4196-b208-27487bb70dd4@linux.ibm.com>
References: <69e279d8-55f1-4196-b208-27487bb70dd4@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <69e279d8-55f1-4196-b208-27487bb70dd4@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.14-3
X-PR-Tracked-Commit-Id: d262a192d38e527faa5984629aabda2e0d1c4f54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6186bdd120eccf4ca44fcba8967fc59ea50b11b8
Message-Id: <173981787519.3511401.2200436694018059876.pr-tracker-bot@kernel.org>
Date: Mon, 17 Feb 2025 18:44:35 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Naveen N Rao <naveen@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Feb 2025 15:40:00 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.14-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6186bdd120eccf4ca44fcba8967fc59ea50b11b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

