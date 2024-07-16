Return-Path: <linux-kernel+bounces-253311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE63931F66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F221F2218D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDE21CAA2;
	Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntJPOWTi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD294182B5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101299; cv=none; b=CpfqRiYSUcpiqakQ+eysA1Fn+NW4MGbSxgk5VzO8KuKQvTEt9YjDC+WTfP6wTS6vf2Kxf934KYqLvCOVy3z7rI2GFiPhbPUdO5PhjG2eaMvzvW2bRQWqeKpDYT4GA2Atll16G1YlAnRnac5g5J2L2rIiM5S8v0Yzc+5zMseLLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101299; c=relaxed/simple;
	bh=YbGKBe/JmsnNXeDumEtilaI640AaHQIBDQvHlVEspe4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MD7AuawO0tepy3yXItNECMcECaBz12iCFF58NWcSUDmtpABV2dMlGV25jI1tJiSExOej8s4VUXWO3CwvTap83KRE3hYqikEhc6ayVYjUc18tXUp8rRsX1pk0mWo7zg6+TlGbBNOBpi0ikLmXKBkCb+CQWzaQLBkUUIY3WuYW/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntJPOWTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F25AC4AF09;
	Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721101299;
	bh=YbGKBe/JmsnNXeDumEtilaI640AaHQIBDQvHlVEspe4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ntJPOWTivIaQUCLU5Hod63e5z9CdFAnS8s8h7rrrVa1VtIXS2JWKJPqqtHVu2eJmq
	 eayrhboME+VrNWzltsc9+nvwJT8ZWXIrXBADvf5cNkknB4AlqRx8Vz68nP68TSFLmL
	 iDyStvBAyTHDLqRbY5OTdaKbkpjZYsiXNch1dSb33cyUSsUg44+xPVkUyR5d6Su7Bv
	 DtrU9vAYirvDZRVDZ6LfA3y9n9ksmBMaP7JuS905NfXj6LlAYyLyEjTyPw/iHBkjiQ
	 Cfd4odMPFQrFaY2xVdwI7nkoBgd05Y8M1E4IavFjEyw4MOA7YeKSKWL6zlTOHuMn0Y
	 yL9VMfCMkvVhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90DE0C43443;
	Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715112329.GAZpUGseCodLDRBpET@fat_crate.local>
References: <20240715112329.GAZpUGseCodLDRBpET@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715112329.GAZpUGseCodLDRBpET@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_cleanups_for_v6.11_rc1
X-PR-Tracked-Commit-Id: 71315037cb7d40cdb2f4fbefad31927f6e6caba5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 181a984b7d8d98e5997bcd8e2ebe6ade1b36978e
Message-Id: <172110129958.18508.2837234593624570039.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 03:41:39 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 13:23:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_cleanups_for_v6.11_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/181a984b7d8d98e5997bcd8e2ebe6ade1b36978e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

