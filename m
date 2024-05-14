Return-Path: <linux-kernel+bounces-178276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF2C8C4B52
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF1B1F21C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CEA38390;
	Tue, 14 May 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbwBwGy9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAA325760
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655091; cv=none; b=nBelxNwfPbz0Tn3UL8LNYoijf9+APmY2TGsEvTZ20uzNJvTCd7n4uIs8f3lPEQvO03KBX57eTEXmkKrdn0QQnPwgrUnabR6lCSZSD5LCQCMkoDChxv/RdrhuGF4z7cFUqg5PVHffwgLriARh/cSKty1DNBxscq7kCrFlUncvmmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655091; c=relaxed/simple;
	bh=jHkF2LT6Wz0RaH2VSml7maGUuQ+02pFo2bqHNhrR7QI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=V6LW4+eWYf/1KHqMwQkSB5vvBAsP9IDEqdNGvqHdLYLevPlrojuGh4aRXnPS4q2UjUbSwk0FiacTI+LelMujYx8IFB/VhNUEq+ZM6ijHT7vSL0Xm+UBPsnH84KhQTELYsO9FaYFBjilIQnzfwQW8jrEKXnSsl7rbPZKqXZIDnAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbwBwGy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A777C4AF10;
	Tue, 14 May 2024 02:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655091;
	bh=jHkF2LT6Wz0RaH2VSml7maGUuQ+02pFo2bqHNhrR7QI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CbwBwGy9Nef4TbkLH1jZSJr+BxUG1uuhnf4LWkBvU4uOUV8wjz2N+pTwM/cWYOIlL
	 w1DNluMV8kmFZz1gILsyNHTyrCzx3LPTflwQeikKCusv3gx6NMqI+eMIhtUPuiXdw4
	 JQwZHlWZeSCoX1EbggGSuwaNhgLVOCzF2CwEmsDyU6POiEb4dgYg0s8ocw0H/T7E1B
	 8VbooED3Vppmn/52SBrhVCgeyKvRAEfcxS8hiomQb9chthMQ64vP9Td8UfCKTJw6l5
	 odoDVmrL00RttWvC368mq86d1H0aCHMv2BRvE86uLtZ83wXjoPrx5daasGhsEQgLiO
	 /tv3FSXACBC5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 633FFC433F2;
	Tue, 14 May 2024 02:51:31 +0000 (UTC)
Subject: Re: [GIT PULL] x86/shstk change for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkHLrqO1HdfQb71Z@gmail.com>
References: <ZkHLrqO1HdfQb71Z@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkHLrqO1HdfQb71Z@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-shstk-2024-05-13
X-PR-Tracked-Commit-Id: 2883f01ec37dd8668e7222dfdb5980c86fdfe277
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5131c3fdf2608f1c15f3809e201cf540eb28489
Message-Id: <171565509140.649.4710570877104112697.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:31 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 10:13:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-shstk-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5131c3fdf2608f1c15f3809e201cf540eb28489

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

