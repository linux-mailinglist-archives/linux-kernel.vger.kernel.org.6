Return-Path: <linux-kernel+bounces-422823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098239D9EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA99B22304
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFB51DF253;
	Tue, 26 Nov 2024 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnjvQ8Ny"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04341DD0E1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732655098; cv=none; b=cli9bX1VmNtMtt5LobUP4iD8BVqtjMerERUEuWjj4vaEwHGAIeYUQ1ZolI2IHBLmud7HpYo+xdfyX6DqfC4yvmCY3WP7ZTbFoTZBFfuvjELSkDh2XXAfD8Z8Bf2oiYUoPIdXpOhuDEHkaXpeUZW0v+Z2HIGHmdqmKVCzivBO+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732655098; c=relaxed/simple;
	bh=YPmXuQPcvXDeOU6wdX0I3xds4LdcmSU6DSZ03NIy33g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E+qkWln34lhJOFqSdS30vlHwdUpDcQDnKdWi5hKrr/DsxeE47xKOnopCUGPvKH4m3ovgHUGk71qVLB9TDUCaLkyhX/XxejC9STpT0UMRInoAoeKmzxNUb58uG2MttB9Y6SBuPwBuR8qVEiamo8N/EP3WUWxT6FSY2YIxOybHN9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnjvQ8Ny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694BDC4CECF;
	Tue, 26 Nov 2024 21:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732655097;
	bh=YPmXuQPcvXDeOU6wdX0I3xds4LdcmSU6DSZ03NIy33g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VnjvQ8NyXU096Iil5A087LwqVPlILJelfnjfxil8E8A8NYDNX0ddYrCM+hTPlgfCh
	 EbnRUsURyD64kuO/nvZYKsruYU1YGkJqeND4vOH0AM4juBJzT1vmC1LsIcw8WfaLy6
	 rAsyEQmAbnbLBzZbcyLNpyp0GUN6Q62SLRVhgXLNdoCDjg1qXOQHIOlTLuT173CT8b
	 RMJVcrdwPlv6Djtx3BXHGCjLNSAVCH6JUn0EuC/viZ0aZrlXvourAQIC0RYZDCEy4C
	 isVqSF/Nr871GP9mIv9qtQwW55tWilnN4V2VN+hHD3EhYr37jjz4z8P6eduNC4CXOk
	 tl4xNEwRQWlTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7E57C3809A00;
	Tue, 26 Nov 2024 21:05:11 +0000 (UTC)
Subject: Re: [GIT PULL] f2fs for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0SdunZ61-OMaH1o@google.com>
References: <Z0SdunZ61-OMaH1o@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z0SdunZ61-OMaH1o@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.13-rc1
X-PR-Tracked-Commit-Id: bc8aeb04fd80cb8cfae3058445c84410fd0beb5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44b4d13b70f682a86fee356786cc3e17987fae4d
Message-Id: <173265511031.539328.15285927195255109686.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 21:05:10 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 25 Nov 2024 15:54:34 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44b4d13b70f682a86fee356786cc3e17987fae4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

