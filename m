Return-Path: <linux-kernel+bounces-296230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C89895A7F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E24B1C21CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0105D17D34D;
	Wed, 21 Aug 2024 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6BjnmTE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1ED168497
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724280939; cv=none; b=nLoJ8obccsQSx5/yjuyvNA+3IyDx9UBU6AmhEIJQT2JkeNikn84WbHQ4pF11BzKS8j4TllKfhr8GnH9/kuUIRHCtKLe2v64bVCd3l/meCYR5Bz7LuyEHyQtn5FTNLyHJw11L2NiRDPdvTxg8+ZEttqKx38dvhyxpk1K2ETT36fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724280939; c=relaxed/simple;
	bh=q7ktxr8tTsMhKc/w1B8gsiAP4VfjqPmzW/xIx2RxF+0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U+bi9Ys2QLpZxb6NKqwHOwuxEr/9F7aXFPx4Y2a6A7P9i3U5ey5DcCOa5ynclBU930Kyh0TXODdBHAruKvqXZ1qir//P3EJoKySOPlCMGFguo6w8FwxHWxItg//sts+QnMhC28LzGEwBCJwjIr4PbCBV3pEGehTDHLWKPJLiRTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6BjnmTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249D5C32781;
	Wed, 21 Aug 2024 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724280939;
	bh=q7ktxr8tTsMhKc/w1B8gsiAP4VfjqPmzW/xIx2RxF+0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X6BjnmTE3LUGfLCTiq2xL3qvM4zaBhwRhi3ojf+bXGqb8fqaU+5K7RFZf+pveEPkt
	 nbit6C/Q6pX+plsIDrrrydJ3EjglUv+VICF+G+U9VvHPviwVfPKhlKqiEC2DECTeiN
	 KpSmhupPThD1INySWpgwOBimR46r3YjhiJ9KQS9l/chjb9CDZT43tSWJkU1mYRl0Wz
	 ADKwehQ5tLXtSAE1BCPObKJE1do8EQTktDEV/mRMPqHqgxGLFrqNIVTxrvGrACJwhl
	 C8twrbGw4uDZEaWR4mN+xx3ygCnYeYYy1sd4jTlxlp0AsnDYl6kg3TYTi42AKoSSrI
	 qiLq/jh3w8Xqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF4B3804CAB;
	Wed, 21 Aug 2024 22:55:39 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZsXcfPaKq3X+Wa5h@debian>
References: <ZsXcfPaKq3X+Wa5h@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZsXcfPaKq3X+Wa5h@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc5-fixes
X-PR-Tracked-Commit-Id: 0005e01e1e875c5e27130c5e2ed0189749d1e08a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c6154ffd40c5bca1eb01f9bf5a4d2b6d18d55bd
Message-Id: <172428093863.1853724.3618790591899091014.pr-tracker-bot@kernel.org>
Date: Wed, 21 Aug 2024 22:55:38 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Hongzhen Luo <hongzhen@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, Chunhai Guo <guochunhai@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 21 Aug 2024 20:24:28 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c6154ffd40c5bca1eb01f9bf5a4d2b6d18d55bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

