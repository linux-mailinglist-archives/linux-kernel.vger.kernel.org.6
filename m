Return-Path: <linux-kernel+bounces-179283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8378C5E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 02:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A452828DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42A711CA0;
	Wed, 15 May 2024 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rt8yHAJS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F694EEB2
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715734395; cv=none; b=AG+8Bfba7RMKBuebP4moUjdJkldojrWtq8pfo2lph5M9uNQNVq3HhpZlIye2tLuoS2U4NaDCrEHYZxv9cQRJLI+5wlXGIOydqE71EdTzrDdCiLHzwXKxkordrz1OF3bKeyjkgGtTANyLZta6XMF3TUm661xcbaLxmJZPEfLendE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715734395; c=relaxed/simple;
	bh=I03mcCPgdRUXLvpgTfzgvZ9T2eX5GqqDmNocK7lBxEY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BOvyhMDoa7KLaI/Cykotd45d27pZzd4/iQ69taBxIyIusTihL427skJM1Zp+hiZzfrXMNBLsIcJ+u1itNC0Jl2FYNcEobEG4CoQmct2avX8Wvvo5HQ9s496hK/lncOpdAMhS6KN10o12eDrPQGsFiTjrjpnQMgk95iy7U7JzSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rt8yHAJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2C88C2BD10;
	Wed, 15 May 2024 00:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715734394;
	bh=I03mcCPgdRUXLvpgTfzgvZ9T2eX5GqqDmNocK7lBxEY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Rt8yHAJSnMtYnovW8i2iwIoqoA5cMJoqGFhC853pyyOab9XTNxQ8VUFZGW9hJ3sx9
	 hWRjmwiYG8y6lLBpYoGgJbOPCE7Y8jQ6NEeybMSdu1AkrxZOQP1PG3E+t1lCPIMDJk
	 4luY3kMO+YZ91IzH4Wg6pILuefBlp0ElBjvcbIS3DlEe7JGOtnX3YVSe740whB0XH7
	 oXuKJod1N+PfQ3JofkGt8wU+qZzHHdial5KpJ+I//aryDai+tV+tJEG34ri+vftEct
	 fTCWDZGcDqj2kcxv7HSjxVikv8LZ2gRZD5nYWnM8STrVmfMJh1/kwZYoc1LCdeMdxc
	 B/GPYYORDWl6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2189C433A2;
	Wed, 15 May 2024 00:53:14 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkGuZ319TzAiLS+Z@debian>
References: <ZkGuZ319TzAiLS+Z@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkGuZ319TzAiLS+Z@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc1
X-PR-Tracked-Commit-Id: 7c35de4df1056a5a1fb4de042197b8f5b1033b61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47e9bff7fc042b28eb4cf375f0cf249ab708fdfa
Message-Id: <171573439485.24206.13430232406721811500.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 00:53:14 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Chunhai Guo <guochunhai@vivo.com>, Hongzhen Luo <hongzhen@linux.alibaba.com>, Chao Yu <chao@kernel.org>, Jingbo Xu <jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 14:08:39 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47e9bff7fc042b28eb4cf375f0cf249ab708fdfa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

