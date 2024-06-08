Return-Path: <linux-kernel+bounces-207142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0DE9012D6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 18:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554ED1F21E71
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE05C17B512;
	Sat,  8 Jun 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2wzYB1x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B62E417
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717865423; cv=none; b=nRQaRRNAyG/k4f3WJnYUdE9RnkdD8HxywiF41en4/G9x0/JCVu0eq/9SrTzOTPkY527d6beS5K2ezdbxFYsp06SL4X9JEFThi3o1ToeIVBr8cFZzgBj2X1tTaGs+kr9E621jeH3dQ1AC6GaOyF1AnB9B4zc9JIymD8hJdoLv8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717865423; c=relaxed/simple;
	bh=Jtx4OORU7ae5qvbo4ocmN31PMw1QQ17rRotBL4WhYzQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cL5fq3IspW9tA+hEUuHiO+wqmlo0+2iqzmiQ1rWnHv6CKU/QB7/SF7AECPmRPgW0y2ZplPWgJhiaS/oSMrCF+cYLPNOfk87Dwc6WdNGlk7G+nB2xjeN1xe/b2M/7bbDKkb0aP12RMZfxrgkEhX7067dqrneuiCvFW24yLHFvEsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2wzYB1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8B9CC4AF07;
	Sat,  8 Jun 2024 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717865423;
	bh=Jtx4OORU7ae5qvbo4ocmN31PMw1QQ17rRotBL4WhYzQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O2wzYB1xYSQYQuzm0449vQzWh6FUyf8/f6Tw/2tW7sDwzEEZMrI7wT/bvWSizeFDM
	 X+InstCRrT5+2Vgzg3pmAcxNXrNzT7UFndZuYXpC45jW0p7zm5WILmUgyHX89BFEqm
	 fsd4SgG1FRGmY3m0wIbfuznWcO/4Ow2z+zqz8LpYjGdyN15kUvXJ5bU8VrHL6i8Qi0
	 DSAOoieLbEucBZLD58sEGdrHgtkY26Od2pVtvU/NBXgNqDPsb9zsoER72MfarReE7Q
	 OawMpiA0K3cW6/x7Ac92lvq4rGZgEeC/Fi7cnfuWV5L1oWJMb/fCAL7raaiLBbJgjM
	 Vzivl0e9K41Fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9492CF3BA4;
	Sat,  8 Jun 2024 16:50:22 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZmQK-WsCPwR_DB0n@gmail.com>
References: <ZmQK-WsCPwR_DB0n@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZmQK-WsCPwR_DB0n@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-06-08
X-PR-Tracked-Commit-Id: 74751ef5c1912ebd3e65c3b65f45587e05ce5d36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cec2e16cb62ed597791fb2d266e5ddd5818f1b3
Message-Id: <171786542288.29675.2315431749908288208.pr-tracker-bot@kernel.org>
Date: Sat, 08 Jun 2024 16:50:22 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 8 Jun 2024 09:40:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-06-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cec2e16cb62ed597791fb2d266e5ddd5818f1b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

