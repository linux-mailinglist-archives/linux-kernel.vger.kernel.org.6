Return-Path: <linux-kernel+bounces-540706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1972FA4B404
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AA23B1C0E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD0A1EBA07;
	Sun,  2 Mar 2025 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXGfugxk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8391ADC93
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740939538; cv=none; b=UajjV7KqhlSVAG3peHKpiztqbbu6EywMNfPaW1d8B5iu2Ru7/7pVleO7l3RkIpxqibYPoZ67An/Mw4IhMTS2lWf4HcJE1rPFFwccHFUDtxT4rDlQCCPbZ2zoQaYIEXcb4BhTFouRYfh44vxZkpF37PpqG7YntsHQcYXw3Dttvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740939538; c=relaxed/simple;
	bh=9xnIcI4xq2HxO1l4MCdaG7u6wZEc3NkHN3QqbchA7G0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZwvYN+rKvEu6O2LogVBy0Agb5FEam0xJFoGblZk9dMC9Wq6Q88Rc2QqkCcWGti7cKN4NDMu1RE2aALnT5x65MunPcyZ6Oy8KYnzLFjtc0ktECVqOJ3ZtaXZ5hF5+/67MQSqj/Cs5uuVUShteiaA5+4CdX1WGjlubVw9DHiDuee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXGfugxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF03C4CED6;
	Sun,  2 Mar 2025 18:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740939537;
	bh=9xnIcI4xq2HxO1l4MCdaG7u6wZEc3NkHN3QqbchA7G0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bXGfugxkuKtG6UtXvVjQ0BYeg2E9XXAMVg0oMWfkmX7mWOsq2bX5R9Hft1Hdkdamf
	 /NrpZuVQ1udx/xNY8cjLTSKaXnNQzpVolbkOzxG+OwZhp4ND1iIp4PfcufesRDrrgl
	 J8q73qb/6aosBhN8dRjEA5xevhTt023M/bSWkETqVZYE2a1feohru+Vb4kWlw0VQ4n
	 6WDSCCnWKCTFcfdh2nfABZMWe4jbfzvw2gxQsKunQIVYoFBmEuEwZeClrxmvYUoS52
	 6uID0NydEbKNcd6Mqexmld4EdLJ8ZxOMZ9QCotOaCdoz5jfhAH1IrM6YHiR0E2nTj3
	 JF8VjpLWaJAKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD6A380AACF;
	Sun,  2 Mar 2025 18:19:31 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy subsytem fixes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z8SVOYTISnuFWxKF@vaman>
References: <Z8SVOYTISnuFWxKF@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z8SVOYTISnuFWxKF@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.14
X-PR-Tracked-Commit-Id: 55f1a5f7c97c3c92ba469e16991a09274410ceb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a760b10147d96c642ff152eef85db0c3799c9f74
Message-Id: <174093957031.2675004.10314819708063060051.pr-tracker-bot@kernel.org>
Date: Sun, 02 Mar 2025 18:19:30 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 2 Mar 2025 22:58:25 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a760b10147d96c642ff152eef85db0c3799c9f74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

