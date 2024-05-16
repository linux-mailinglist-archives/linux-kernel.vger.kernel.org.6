Return-Path: <linux-kernel+bounces-180538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595AB8C6FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 03:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820B91C213B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 01:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E2E10E6;
	Thu, 16 May 2024 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHBlVOVs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91DC64F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715821814; cv=none; b=lzVcTY/VcS9r1CkqCu7JyEr0JHdGDuQxyDnRFR5FUy8SSv5cgsZ7zxCYxOG+0biYNUU6C/JlgypQpZXSkYTxJsDseqAR4KbKscih/QfW5+1Iw+WXTlWnKRveyCuY1aU7qRutxBTrHrQmV165AY/rmNadjnKgdwE01UMAgUD/mqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715821814; c=relaxed/simple;
	bh=eRylJm7fiqh2v3+nJW13DZ25GBMQQMPq53HQ6Xb+hSY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Os/neoglYxogohqtAa25Ngs6aw4qRCL8B8Zskda0vrf62XHY+VwViI2w9fPRVQVIUa+Ncj+h23C5WfiOVYjRVslE3jcI2GY2hA8vVFZelNWAaAe5MbruetDE4Bt0Pqpzo3MhNHOmGbOfS4rT39/YgeDCWpRvc+/M/C3gORhZ2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHBlVOVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FF31C116B1;
	Thu, 16 May 2024 01:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715821813;
	bh=eRylJm7fiqh2v3+nJW13DZ25GBMQQMPq53HQ6Xb+hSY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IHBlVOVs1B7Dx/5E/7yRX474M/Pc0p6DIL9ZZaSOmrueZx9J2Od3yRhSoGP5eU932
	 ckAsQi5IMbwaQ/BBUt+HMS9mpUgLnEPFO6TZOWwIZ7I1NsQ4VFOoG/AEeYpp5wRZgL
	 UUv0ZORxxsmrMlMjHbP9adGzi0XFmK8nVFiEjpmoaXbgRE6zBaoLcxrmUmE4JpX7NE
	 WJmiJ4rK40VlfthIKXrk1bQlCSCmcL73+0DkTKeLVKTTRIPSiHK6ktKxyvYyU2k4vr
	 ffYd28SIZ6F6qy/sf/8Z2XyHxhtG/tBuFUBpNf+oIvu65GAgCy0Lb0qPtfWc6Phlss
	 t1ZGq2NukmxPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A17AC43336;
	Thu, 16 May 2024 01:10:13 +0000 (UTC)
Subject: Re: [GIT PULL FIXED] workqueue: Changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkVZ7PtjmXr3Yrbg@slm.duckdns.org>
References: <ZkU2kmQxdZ3jRfyB@slm.duckdns.org> <ZkVZ7PtjmXr3Yrbg@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkVZ7PtjmXr3Yrbg@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.10
X-PR-Tracked-Commit-Id: 51da7f68edae38e81543d57fd71811f7481c0472
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2a58909cfb5fd5e9f7bb7d954eec0a32fee3f1f
Message-Id: <171582181324.3755.13598035555627141139.pr-tracker-bot@kernel.org>
Date: Thu, 16 May 2024 01:10:13 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 May 2024 14:57:16 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2a58909cfb5fd5e9f7bb7d954eec0a32fee3f1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

