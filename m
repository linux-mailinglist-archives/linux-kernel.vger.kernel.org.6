Return-Path: <linux-kernel+bounces-572665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF802A6CCD8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 22:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309583ABBE7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354D622F3B8;
	Sat, 22 Mar 2025 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWLsatLB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944498BF8
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742679871; cv=none; b=sAWk4RMVAo31jNEL4n2VPjYe9D3o94zwR+SpiXWun+2BqgoUO1pGZJMvNENdfxqrxjRXlcItOQHV2Ot4EYl4Gzs2cVKYSqrZLCM6vJGROiB0T4cLp6ZN4+K7uWM1HPaXUzadblpC/MP3ljCIbfOMqxxNiFO8P+wdV2JPzOnh/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742679871; c=relaxed/simple;
	bh=IqCDR+WoJE/J/Ii0Qu/cbFlvNxftK5/UAKCyShsrdCM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r2J3mSsmHTfwrBjR3roa2SNmmyJzizqduK6GVKWJYOqZAGNkbp234dK2wzD/veB5Ic4py78Al5gSMPJrlqlTLRKeNsZUtpbPaxfy4VbmUhLU53KMf4FAYY22dn8JXkesM110WSF1O0YgKhuOou1gVtYnb8sIGTiiNnFSb/d1wC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWLsatLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A37C4CEDD;
	Sat, 22 Mar 2025 21:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742679871;
	bh=IqCDR+WoJE/J/Ii0Qu/cbFlvNxftK5/UAKCyShsrdCM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sWLsatLBjbnkOEPSK8RjhRGgqX9G6GXKqE/PL6TZ72vQMpnGqOLGZNIZNo3okQt3c
	 OZ8B3iTMCWmWGGcm79FBN7+PquuOun7SMFKnAkRdIKhlHdWp3kDPB5HcJgADAL2PKy
	 6qraXCgd8ddzpLvbzZLBQNmIRqbMlQ58UF8RSwV3cytWAuRf7Tutrmh3BURUvajBDV
	 3eiieyHEc2ctssGuzvOs7v6qg/hCBuP34jcEUK/Kens7ieGhNoa1PwGuMq9oA+C1KU
	 pgv4XTniO+al+v4dzEoOHycxY/o8z7GZiAz61nwLfRO0TvtS5Ko+lBvHcH0SRHWIlR
	 1+V71r917Z2oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71018380665A;
	Sat, 22 Mar 2025 21:45:08 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z98j9k843MxU7On4@gmail.com>
References: <Z98j9k843MxU7On4@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z98j9k843MxU7On4@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-03-22
X-PR-Tracked-Commit-Id: 50a53b60e141d7e31368a87e222e4dd5597bd4ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 183601b78a9b1c3da2b59f2bee915f97ba745c0b
Message-Id: <174267990696.2912834.18316421210472074261.pr-tracker-bot@kernel.org>
Date: Sat, 22 Mar 2025 21:45:06 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kan Liang <kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 21:56:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/183601b78a9b1c3da2b59f2bee915f97ba745c0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

