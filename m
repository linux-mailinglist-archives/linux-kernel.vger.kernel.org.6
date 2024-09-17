Return-Path: <linux-kernel+bounces-331340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A331C97AB79
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1251F24BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010D415C137;
	Tue, 17 Sep 2024 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwIiCUiD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4378A158559
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726554948; cv=none; b=eIOCQB4KQfVo4ItEniXIR26cQT3bViHOfkKi6jSJqWc/X/x04EwUu356usSaDdoVpSbjM1n1CPxSCPNkts8VOXxtyGvHbaIMqeqaVL2nqAYtalpk9Ie/f6CLRxSvqwnK8wYFz3uiEoDx5J9mSf5OtXMgKvZkKNRSrDgAjmpGaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726554948; c=relaxed/simple;
	bh=pNtdGdXLVbsieXKbMuXrIjLocoNAqgMCQDwkg0o+Xus=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nFB0G5lohJvH59GiFFC+EYDCWraXXZFI/EeyC20A5Hazxd8V/eHhA+ERunCGU6VueDZpqK64K/VUHGxZa0JnZINz5fESo326oTe4WHBRFvUn3jjfZeIxMYLDGjXzmRjO8sEM/GGIeUUsWVydjckIp5ecc64d+EWJcsa5FHKP78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwIiCUiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D953C4CECE;
	Tue, 17 Sep 2024 06:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726554948;
	bh=pNtdGdXLVbsieXKbMuXrIjLocoNAqgMCQDwkg0o+Xus=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fwIiCUiDYxC7Z5OkYNmK9eelRNdVHscOzqueSOXpjVCpMj4NcptUfGMDguIlEi56W
	 Pw7ns9g0gcRxdnCG8GJHw3RxQMOgH9VM/elTguwj/QbX11P0L+wNuUR9mNzJkowQ4T
	 r9y2AAWhy6c2eBbnMjRBv51mHBJuVkPZjnos4i9oIIx2pTmz9Ov4vYVl4qlBUPD74C
	 7+sGDGx66oWxwKXXID58Eq1s0ZGSPjoNkUbkPdYmypMaou2EemlZ0mL8aik5xJD1cT
	 3NOou+NJJRYFTb9L9612sed5uF5nf91Hn4qPvuxGXnyp2ZVgoVEAltV9yWg+Kjfbo2
	 yDPlhdWGjcH0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADDF3809A80;
	Tue, 17 Sep 2024 06:35:50 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172647589572.2450257.7902245321154816798.tglx@xen13>
References: <172647588843.2450257.3544233832195550173.tglx@xen13> <172647589572.2450257.7902245321154816798.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172647589572.2450257.7902245321154816798.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-09-16
X-PR-Tracked-Commit-Id: 35b603f8a78b0bd51566db277c4f7b56b3ff6bac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ea925c806dbb8fee6797f59148daaf7f648832e
Message-Id: <172655494958.13787.3159183517330890489.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 06:35:49 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 10:38:41 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-09-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ea925c806dbb8fee6797f59148daaf7f648832e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

