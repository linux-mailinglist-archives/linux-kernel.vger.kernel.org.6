Return-Path: <linux-kernel+bounces-234696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8561891C992
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74821C21CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D641824BD;
	Fri, 28 Jun 2024 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc03oh4M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636E26F30A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719616792; cv=none; b=NxDxNF7cdPVIdvplxT+L8n2jCQdjHAaPKrXSBPS8gRzU7pYBs5FURFRtEErPfNhGY4+MX8uKp6rM+GHuXtOYEUfEc4rWstIa33cWxI39LnLnYIkN3Fy1+f159D9XWR+NOL1n4mdv8RAGztrOBvlUqN+a8JLd3/QtelBbPl23EIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719616792; c=relaxed/simple;
	bh=xRIRlkFHs4ikdKeslTrYZRQeZl5a+QJWiQz4aKyrpuU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WY9LiDq8IQhBZlRY3bJP5jOIcPM+OMVoWZAML8tQe+irNMiyiZkmenZuclIwN+JxeHvGg1RO+BsS32k58tZmDhm72aN6/Fru5I24DtRuFa4fbSuQClHJzLcbne2rpBStUH1d8SQaX0XMQXa4NUWzpHc11HtuDYpPPYFrLRfEcC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc03oh4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18C02C116B1;
	Fri, 28 Jun 2024 23:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719616792;
	bh=xRIRlkFHs4ikdKeslTrYZRQeZl5a+QJWiQz4aKyrpuU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Zc03oh4MSCcLY5HlGvnJ0OmYb7QH6tfJAYfclBvjtV9/Xr81ZqxMu7LzXF+yn+sLM
	 3po1LGyNeQMCSOJPOo428uWlXn7aD5XUqR1iiy/uOtOJLUkXhk5pU93yoZde/h0ut9
	 WqacqKgk/LUw96Dt8L5H6hll1zpsCURAFQfNZmA6Btub8KBnS0+wsc11CWG6Cse0R3
	 1J/47aCJpWXoyLguI3vrhtslb5LUJ8n+Ptbibnbuz0bcecsba/nZEOiIBZ4e2+j6aJ
	 CvzXS1AEmqWZHzklcRZQHqdqUH3k1wUnrjJMGEXDMSczA1lgY7+VX69wfN3Z1Wo32C
	 Zlynpo2+/a52g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DC6CC433A2;
	Fri, 28 Jun 2024 23:19:52 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-e131a037-69c8-423a-929d-e2f03e979ed2@palmer-ri-x1c9a>
References: <mhng-e131a037-69c8-423a-929d-e2f03e979ed2@palmer-ri-x1c9a>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-e131a037-69c8-423a-929d-e2f03e979ed2@palmer-ri-x1c9a>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-rc6
X-PR-Tracked-Commit-Id: cc2c169e34b4215f73c66a34bd292e9e1fcaa3c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de0a9f4486337d0eabacc23bd67ff73146eacdc0
Message-Id: <171961679204.11498.10577613084862609780.pr-tracker-bot@kernel.org>
Date: Fri, 28 Jun 2024 23:19:52 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Jun 2024 09:26:56 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de0a9f4486337d0eabacc23bd67ff73146eacdc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

