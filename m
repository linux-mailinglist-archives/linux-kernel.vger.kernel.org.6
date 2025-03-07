Return-Path: <linux-kernel+bounces-551946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5482A57349
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AA83A421B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965CC257AFC;
	Fri,  7 Mar 2025 21:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkBIS1N6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B2257AD7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381426; cv=none; b=UC/IlVTEFUwtSt7+fuCTXh6GG/vWHs6AL8z3nQO2JKuP16EEpX+tjSBZUFw7xI/polykSuVfWDwi+qAhNA7Z6J59MEPSC3jmHaR7/pMBtP0CEVM9djvH7E7REcvLV/ziGEstMX+IRLD3Ke3PE+S2KrnG0V0Qntq75OEBJwKqExc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381426; c=relaxed/simple;
	bh=DiW8am74WcbpORAGMz07PFbsC0JWsIMiTXQ4vV40cNo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CuXgHUGhyms2N5inc7aVRbCR35IE4aYfVHtIMivkvhSIGz/gsqHgJkoTwIyChi7e84Gzk9pnIcnVCfAx/taAyoUcmEg8mklcUPpWrlcoIFSE67Rw+cL1Ry7dz0CF5j1a94q8iQfxYLAMcU0eZkDcWWMFy1t6/hlmyw7RlCxdFYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkBIS1N6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A735C4CEE2;
	Fri,  7 Mar 2025 21:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741381425;
	bh=DiW8am74WcbpORAGMz07PFbsC0JWsIMiTXQ4vV40cNo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AkBIS1N68LsOtlYA0dM/Zv2l8RIxtHU6dvb/4zMNvwA+sD6I6od75xlTQpsJqhokL
	 iptNi8vbE16IobrV5ymRgMSZVrjvlqq/0fequUBSYf1W5j1cY35IpuqKsN8qMiK4O/
	 7d3yybM1/Z9vKPMkemLYDtpYhYb5TqLOBoRlKPD1//K598ymHPOtY7ihY46s6alz4Y
	 HlWx48slXZx5U1YjumTu/S8QW4TAr0gzktxJkYyvWt0N9ORV/ApHCasrU1aHd1q33H
	 GQSgrsWXDFWQ7mKGCjHvLVHhHmipXWCB0RyOuGi0AbgDex5K5ZdiPaS7k6mUHaDa4b
	 YQ8XN+0UBgPUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BFF380CFD7;
	Fri,  7 Mar 2025 21:04:20 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z8rk9Mv_arA31-c2@gmail.com>
References: <Z8rk9Mv_arA31-c2@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z8rk9Mv_arA31-c2@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-03-07
X-PR-Tracked-Commit-Id: 003659fec9f6d8c04738cb74b5384398ae8a7e88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab60bd57319cbfeeb4cff2337016c9fd72b51412
Message-Id: <174138145889.2483503.10331452957576264280.pr-tracker-bot@kernel.org>
Date: Fri, 07 Mar 2025 21:04:18 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kan Liang <kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Mar 2025 13:22:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-03-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab60bd57319cbfeeb4cff2337016c9fd72b51412

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

