Return-Path: <linux-kernel+bounces-272874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73B494621A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623FF282B2F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F5D166F02;
	Fri,  2 Aug 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFKwu3KX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2915C151;
	Fri,  2 Aug 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617593; cv=none; b=rhtfiPhjot3FI21Bx6VmmNUs8fEwDygEaVLKW+iCu4oKw75ip7qV8HhoMRrYrVld1+RmjEOLrxpu/ot7MLDgsXuT4ZzcyoIGnKu7pUvTQ+nXNJn45KY3tAui3Zyv8+uL3r8nAoIdIj2kM3bYfwRB2tbJv03NHExx/AdNFlM70tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617593; c=relaxed/simple;
	bh=uGvHre6ZGVmg+y85Rk7IMv1KcF7y13Qe0obzgX6m3n0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SJ9BizHQDiy9JfWkMpKefGkckvXCfYr30MgURJf1MxvBKrDETPhbE67rDxE98GWkXBG0fDdoXUV55jKJvPv6q+zCNJGJwQkDNj/JbtGG6rGserDIOLxJYaUhotT/8FurIFrnA1Bq80ICB/9aOQSiUlaR0iXIwzvlz9NOlyHslYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFKwu3KX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E82B0C4AF09;
	Fri,  2 Aug 2024 16:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722617592;
	bh=uGvHre6ZGVmg+y85Rk7IMv1KcF7y13Qe0obzgX6m3n0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mFKwu3KXldAg1iAoAMQ8Z5eYNPfuKVaAUaGXAJqxH16xTMnKZ6qSdx7KBX4nH8/eK
	 rQe+Dwd39kNsPqvJkeWaJbj+39dJ7o4QC7OmSqG55JT/BCnq6on3qiCz5j+KkvFEz9
	 vylX9QL7rL8ZMG5HcQWlCBx+shhTDqxsuZueA2YY7KcF0pVLJBf0gGPLbkM3xBgF6g
	 I+h5UjAbvO83Cu3OgfnZaKLe33H/zCIgz1OZEzdBxK0phvV7NzMIVjA7wyk1bA/Op9
	 +fkwX2s9z7Nndh5o6GRVynK/FqB4eM9bT7XtjHXlLLCiXPZ1waxt33uTx/HWYZClK7
	 2owBZC2oTILnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E00F2D0C60C;
	Fri,  2 Aug 2024 16:53:12 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <87a5hvibm6.wl-tiwai@suse.de>
References: <87a5hvibm6.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a5hvibm6.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc2
X-PR-Tracked-Commit-Id: 478689b5990deb626a0b3f1ebf165979914d6be4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b779f8a8648848d74c24b07d0e2436c00211788
Message-Id: <172261759291.28369.6765747889777533296.pr-tracker-bot@kernel.org>
Date: Fri, 02 Aug 2024 16:53:12 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 02 Aug 2024 10:15:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b779f8a8648848d74c24b07d0e2436c00211788

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

