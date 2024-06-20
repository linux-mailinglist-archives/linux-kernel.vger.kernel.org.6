Return-Path: <linux-kernel+bounces-223414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9191128A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649811F2266A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C29E1BA89A;
	Thu, 20 Jun 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sG1hCZJp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C661BA86F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913010; cv=none; b=IJZIvOcU+CrvM4RqvL1gdKnGjNIwT9Oa9vLxOp7GBULf38RzAtc41Wt+f6MfK4cN21PkPpfcjXxFUBpK6qurFxrR4bp547GGhSz/A2lLh0dkGxLsgySXL/3X9n5tbs4zzgnKOlP5tJVB15ZgKWhmyoi+yOW0ng/JbLKqnkYNs9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913010; c=relaxed/simple;
	bh=1lQHrG718T7vMkVyokOHrbmi03nKM3TCSMmzoYw04ao=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GJsXG3YxjKfDnJpJPl+F8LMDhwTfs/Jvie6HHt+/7YFZDwbeUGH6/5jZX6vxE7omPg8oNgSvjAkHEGghZWZmhsMrkjM9fbUu5GvAy9mLOUzfKThi+yzfwfRL8f9lmUAiEEG4tuB02PD3/gFFMfeS9lu5PVZY5IZSjYn4jSP+5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sG1hCZJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28432C2BD10;
	Thu, 20 Jun 2024 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718913010;
	bh=1lQHrG718T7vMkVyokOHrbmi03nKM3TCSMmzoYw04ao=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sG1hCZJpTkbQJVx7w6/9axoKxUlNtzsfHrmcafZGD92OWZSabFe76jEE7WiU3oV5r
	 e+h8ARnUgIPEzyP+qp6eFzgFAflCoDylIJIbLmlvVQSoQUdV6YrWj45lpo9dskTD1o
	 DcbU3Frh91HqgE4YnpCadzUfYVRd58jMbq43Y3XaMKBmrFa6EgMRMC3ylyC19n1PLW
	 KM6OR1eSAA40u7ync6oHWIZLBk5kngGL8djWIFPqOKAinV6ADVAjaKptRSYmWjoDfs
	 nXxMbUqQs5p/gMyFD5/wcnJ1NEXJ3kqDvFUvFaSHvThEP+i5URrovY9UZznjB3IW6K
	 WC/HNKkAGPrBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E41BCF3B99;
	Thu, 20 Jun 2024 19:50:10 +0000 (UTC)
Subject: Re: [GIT PULL] MFD fixes for v6.10 
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240620092719.GF3029315@google.com>
References: <20240620092719.GF3029315@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240620092719.GF3029315@google.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/mfd tags/mfd-fixes-6.10
X-PR-Tracked-Commit-Id: 68f860426d500cfb697b505799244c7dfff604b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a7b3836bbaa25d3ee3d6c1d336991fbec8d8ed8
Message-Id: <171891301011.2247.7728237739770207792.pr-tracker-bot@kernel.org>
Date: Thu, 20 Jun 2024 19:50:10 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Jun 2024 10:27:19 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/mfd tags/mfd-fixes-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a7b3836bbaa25d3ee3d6c1d336991fbec8d8ed8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

