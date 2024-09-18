Return-Path: <linux-kernel+bounces-332375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 918ED97B903
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2241F246BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DD017B418;
	Wed, 18 Sep 2024 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vq6Q/sBZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C617A931
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647006; cv=none; b=Rgk/QpM/bLxsGMIpbkuIjCyKc20jH7jp+UXObgaITo3fUNkjFNaS1xE1ep5ocJPxmja3VNM+vQySq8dtr9iTcoxsMJ8yTRX7flGUtoJ18Xj+kV0zxL+fxuSqg+tpGLBsPw+nOxZxt0GD5/VSnSgHfF2hJO6oRRn3O260XWMXVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647006; c=relaxed/simple;
	bh=8GX5JjL/PU1JlOiy2t7X9riVHgE1vakPnXfQXi6Xy60=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BfcQBwtSzasJGTqDgEczdNTgapV5L/5gj1lQO9UWCu8BcNsh++ATi2T3mf/iH3xxgKB7+7109Ga/1zNa8TReBpaYUf4KBhU3cbH05R0V3j0DO4GSF6cdBrdZTCZoKrjS6PpeJsFpSU1tzuh1uGkBAKFCnbXVEGeAV003EY01HVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vq6Q/sBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54DFC4CECF;
	Wed, 18 Sep 2024 08:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647006;
	bh=8GX5JjL/PU1JlOiy2t7X9riVHgE1vakPnXfQXi6Xy60=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Vq6Q/sBZPzpjzV/AyBsaftxd937RAdF7EYCUCZpheeRJ1xbSNdyNXt/Wo+RKJ1nNo
	 VnzGOPkkH7YMQD1XYqXP+EmBFQkmTcbwDUuOsf2jF6pdb/WGKatHbHdfqpgBy68t8N
	 tP54BYJJnSzR2POMAu+4NtvtF1LWYZax3RQ+eBv0+ZJ4KvKcfaozGn0no4Jf0c88Q7
	 rsA2SoTW0a1nqlA/SbxjI7CvehXOP7zGg9u1AHmlWjUj8U2u+gbte6OHjJpkvw6SMl
	 6UjDf2aBiDqgi8VwfzTjGNejnotppLrNzibgjo0kdHqHF2rLIXpaCxDOycv7EjkA4G
	 uEElHks27zd3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBC693806657;
	Wed, 18 Sep 2024 08:10:08 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue: Changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZuN5UuqKk6q16EGl@slm.duckdns.org>
References: <ZuN5UuqKk6q16EGl@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZuN5UuqKk6q16EGl@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.12
X-PR-Tracked-Commit-Id: b4722b8593b8815785bbadf87f13c88e89a0ebef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85a77db95af4915b235b3cffb7eff9a1a2206d14
Message-Id: <172664700785.684502.2965380522351352773.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 08:10:07 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 13:29:22 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85a77db95af4915b235b3cffb7eff9a1a2206d14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

