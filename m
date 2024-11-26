Return-Path: <linux-kernel+bounces-421777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AB49D900F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD68169A44
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F52F18052;
	Tue, 26 Nov 2024 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyg5gHsD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037117BA0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585233; cv=none; b=UCRI+R/lEimXZhyJoeOtEueKibCQU+AG/cBpWHspDZM7KqHh7HFhW3Rub+o1XAzMWg8wRVl2Zn9Ud9DqKhRy4QR62gzv/cMuKU9MP/GIKSL99Zkf8FA5ebj7Nkrmqj5ZXxynku4G07I/pONOIW9DT420wyo1w8MQ0JBbfgKi918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585233; c=relaxed/simple;
	bh=vJfWA6n4G80xSqB2iyajecyhNPovZUzCxSTks2j8bPo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iGVOQuD9Knn7UzWJjXIplWBpu1L+MxZLV9BmYqQVGSKl76d5XAHskQRmBnGudTu0z2/Hs78tP6GE7wYuzSyv4Pd+dUtWL3ncEBS4DfgvaiPKqYFwBRROaOodbhBPF8cupnUe3+kDoe8i7mJCeVWTkgCLg4n4poqmn91SlQ8zR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyg5gHsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B59C4CECE;
	Tue, 26 Nov 2024 01:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732585233;
	bh=vJfWA6n4G80xSqB2iyajecyhNPovZUzCxSTks2j8bPo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jyg5gHsDOBKkQzR22NG3Ooz2kNQQ0Fo+ug1F7DnD8o0NThy6cA9DTxbEPBd0zeXha
	 JXnLiIjl/WP+9blevkmsMiKArBbRbNinnfYM/37xSKjcsY6dTQW/Qb+6wPNhgW9Pvs
	 uoCGCDOdwuCqgDfET+W5+riXpAUh33SxcpGRtIMhB7FhhUrxphYhJYEu4t/KIhtG17
	 WHeRnWJaXNMFZr9dlkWWWLmLq3s8S3XZTmOGL1yZzEA32WCbzT7/Mq7u4UCZFb2bGu
	 H4ecFAGDBm87J6QmucVS1lH+i/+DCXLbbK2Tgj41LDJR451fE1vzF3BGqtpdHsdDk8
	 I77VNY2xiD2jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713B13809A00;
	Tue, 26 Nov 2024 01:40:47 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY33qnivK-PzqpSMgmtbFid4nS8wcNvP7wED9DXrYAyLKg@mail.gmail.com>
References: <CABb+yY33qnivK-PzqpSMgmtbFid4nS8wcNvP7wED9DXrYAyLKg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CABb+yY33qnivK-PzqpSMgmtbFid4nS8wcNvP7wED9DXrYAyLKg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.13
X-PR-Tracked-Commit-Id: 7f9e19f207be0c534d517d65e01417ba968cdd34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c22dc1ee3a1d1c50bee5f0f71ebffa86c33e172
Message-Id: <173258524588.4103683.11286245173894515706.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 01:40:45 +0000
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 24 Nov 2024 20:02:27 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c22dc1ee3a1d1c50bee5f0f71ebffa86c33e172

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

