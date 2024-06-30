Return-Path: <linux-kernel+bounces-235260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579D991D282
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141932818D5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3842154C0C;
	Sun, 30 Jun 2024 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/t3Fwmt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EBB153BD9
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719762363; cv=none; b=Kur9wJ/w/16G3FkSALmWnA5VKspfwCOTMsjmdY2EECJCaMXPdgNW7MBtaoxu/FHaq5+EFrdnBoWCgz6m/ArWlTa1QZs3QWpa8wpSGXQ5mgVmtny7d6LaMd667VN3eSz0M1RPUCTO55MTO81Xp5pChDmRN7OiHZlFUdrgrS6waZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719762363; c=relaxed/simple;
	bh=ZHUWPJXtkIa2i0g/1tAnd1sxPapRUZrxCeGT1zxZD8E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SkGMakaPQcor3R/NHbshkIsmZQ8OoEayF2QKAxJUqyPxYSfvNWNh6i+PNE/tuKWwDpN0ttCzJoK4GYPOs5yw5z4c2McqOc+Z/QnWEd6UOtrE05nZo2CaPOmG0QDtngSI6mwYP4Jxqc6pfbd5cXBTFMQHB+tXO1oBWsCkJc2GT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/t3Fwmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15677C32786;
	Sun, 30 Jun 2024 15:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719762363;
	bh=ZHUWPJXtkIa2i0g/1tAnd1sxPapRUZrxCeGT1zxZD8E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t/t3Fwmt07/prjhttATTWgUDVCOPPq5vZ0m51u1AjUPoLSJ0aXH7UYYU2GI0gaj7z
	 9bwrdGyhGk4fre++I1KjG9C1ccU0KQfE+3MAQg0Xl1KazlaGMCbjtPzD0LeHQfqgVW
	 mqZRUc1cNpXScTAohyTdRTM4+RI7hFgRizov5phEQgYIlmOCKzL44G+kFNNaa8taF3
	 Fxaa+IyZFZvQDmk9eCS2yJoxxUpbOyvOv3HSkypej/mtIisVehDBZvpeqlYgf6y25r
	 u12YFgJuCy936nSkvMgnIW8a5BTJ9VK37sEIYpuOwErYeCO0GMitQKtfobPHiooE4x
	 ieu3p9SSHlrbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A002C433E9;
	Sun, 30 Jun 2024 15:46:03 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240630081706.GAZoEUguWzfEsXgB3n@fat_crate.local>
References: <20240630081706.GAZoEUguWzfEsXgB3n@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240630081706.GAZoEUguWzfEsXgB3n@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.10_rc6
X-PR-Tracked-Commit-Id: 5a830bbce3af16833fe0092dec47b6dd30279825
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03c8b0bd46bcdce3b221fc9f87418c76fd36b28e
Message-Id: <171976236303.1786.5312515046096523044.pr-tracker-bot@kernel.org>
Date: Sun, 30 Jun 2024 15:46:03 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 30 Jun 2024 10:17:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.10_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03c8b0bd46bcdce3b221fc9f87418c76fd36b28e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

