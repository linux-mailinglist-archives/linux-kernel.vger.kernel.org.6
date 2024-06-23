Return-Path: <linux-kernel+bounces-226245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5999A913C03
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46AE283340
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B33D1836D8;
	Sun, 23 Jun 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVIlrP4T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF68C18309B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155600; cv=none; b=etwjwuQgzkEuWG/Jw0Xlaf9ESu+id+YhTi2TlJ/w9PGt5ggXWQgmVRyIIsZBIdFWokeaK89sqfxPuB3Q5/HjeF39+urLv35DJixuls8f8SxC5qdAgQPoXHMZ1lB0yEN5rWszkQdXrZLap7sts7ka4tenspvN52LL/khmKjiudvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155600; c=relaxed/simple;
	bh=BZzHYWiW8LDRisIqCxPJ68tUiv6wq1sCjihyJWrjdu8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sbjsPg0D7J1GpVB82wn4fH9nzGCMu5giuSDnYm1C7ThbXB9hGDWCFUqofbqVs9jicuk9CrgtzrtqQd3ultn9yFcB6Au+6Zwrxi7s0ncGksoFm4MzLRyXG2N+FjUXAqu0OFK2reEJVKqxkhnGWHWi+wBOVurcNmDHFG8uxWbUdkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVIlrP4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90C86C4AF09;
	Sun, 23 Jun 2024 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719155600;
	bh=BZzHYWiW8LDRisIqCxPJ68tUiv6wq1sCjihyJWrjdu8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MVIlrP4TV0OYE8mZJWyMmojgZfWBZDIbLEn4svWZ62FTEbpxussjDVvcv1rkCpc3B
	 VtQmRe5KfNb596GRGeDFddqotG6BUZWJLc/NYo+V8tCc5iylgbHOycngtrCjL4FEfT
	 td4uq8uWKmWerhvp1icZXosqf81wwSSDDpHVKV8H6LLyocog1forawdnuDxrj2ZBxk
	 N8mbCgxpc0ObMDFMfwcaiIVMiSAfjwmZCz4y3v3q7WnGr6aB6eUrBds/IX+eLKkTAK
	 oVtJEQDlwifkBR5M9h06DCQNWiMog0FmUqmD8oEQJDWZG8Usu0con99MlHHENHRl4N
	 t6HzK24Mdk5Og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 857C0E7C4CA;
	Sun, 23 Jun 2024 15:13:20 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: fix fragility in checks for unset node ID
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZnfADPCiONdn1F8d@kernel.org>
References: <ZnfADPCiONdn1F8d@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <ZnfADPCiONdn1F8d@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2024-06-23
X-PR-Tracked-Commit-Id: 8043832e2a123fd9372007a29192f2f3ba328cd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0971e82ea34c5e01cd3e68d231caa81780e8cafb
Message-Id: <171915560054.3671.5565171205249497796.pr-tracker-bot@kernel.org>
Date: Sun, 23 Jun 2024 15:13:20 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Jun 2024 09:26:20 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2024-06-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0971e82ea34c5e01cd3e68d231caa81780e8cafb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

