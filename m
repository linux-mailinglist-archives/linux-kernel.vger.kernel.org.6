Return-Path: <linux-kernel+bounces-418905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570379D670C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1E72819CA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1824A17ADE1;
	Sat, 23 Nov 2024 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+ordxF9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AE6176251;
	Sat, 23 Nov 2024 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732325456; cv=none; b=g9RQoFHdXCIRtMXX6QCOPuh2kB9lNL15rPTQaNuzTG57ggSVyQdVHwXqXUV1Uux57NMIHKn4aqfxdMR090TRMRhArSP+xfNEK4aQKtnmtBpJvLiRp0f7KJuJw4XY3xM26oy9dbiybvqIyVjlmY+CfYqrOvEiTkLPbpgccDvIluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732325456; c=relaxed/simple;
	bh=8T969XIIcDFf/7BVrCRMGt6fjJCAqzP0CkuHDz2awL8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RnMPN0i4ilpndGJhXym8SBpJJnMNGzIPF8uPG6lOTdIHVmu72AcH1KPYBUWCJtETbivBZxWTBnf7f7+4tIAfOmKADNB3iuVH6AJCRzzuEP2QPjmv9LbH2Tbb17OmXF3rIcWKQ98B3zLQ+dwmsTBnzJItRM1Otm9b4Wo3owK/Zbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+ordxF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C3DC4CED6;
	Sat, 23 Nov 2024 01:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732325456;
	bh=8T969XIIcDFf/7BVrCRMGt6fjJCAqzP0CkuHDz2awL8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O+ordxF9s3mFsD+lmF3L1huZ+htjhZ3leae2mnpTn+Mho5BFELFXWqx9IuRLn+m9O
	 3KZ1jw8Ty7J2+1ZkX6sgvxeRDHzLY6E8b75VLeXPN4RLt3WiMlXi1H0l4h9+5bPC9H
	 Qg9Sc25QJn8KfKd225rjXnAynR4pGN3415jcpTyfWQ0CyQyV8TxwLa3W2jS8fjhJzS
	 AFNwn/ARb2Tob5e+oD/a/uajsbmXlRK9SUZlJ0gudnPDhsoxsFkzBSaYsiRxeCVOax
	 vE7+6tULhxvzlJVOQO3Dir+NdBvCIuAKczlGsrBoGjz/PqZsloLAH49gBcONcgAdzj
	 uuV056Cu367wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBFC3809A00;
	Sat, 23 Nov 2024 01:31:09 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241121224532.2065186-1-sboyd@kernel.org>
References: <20241121224532.2065186-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241121224532.2065186-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 21a5352dc702d8e6dc874e0eb6ba6d81291a788a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f3a2ba62c7226a6604b8aaeb92b5ff906fa4e6b
Message-Id: <173232546830.2863978.6700356092747446684.pr-tracker-bot@kernel.org>
Date: Sat, 23 Nov 2024 01:31:08 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 14:45:31 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f3a2ba62c7226a6604b8aaeb92b5ff906fa4e6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

