Return-Path: <linux-kernel+bounces-562903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50228A63456
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620E23A53C3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9677D18B46C;
	Sun, 16 Mar 2025 06:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKgTwt6I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0931854;
	Sun, 16 Mar 2025 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742107401; cv=none; b=QpoxgWHT8eFnpdmxk/LcKOz6+Z1pVnob4LvehE70e3hYTpOba3v8/Ow3zNCyUs2CV6UP4ZmhEKzbvl4cQAByn1mtnRq3bkROadQ0S9czAxUq//GC2bT8N7Ad94ttuqL02ZZTdt0rpGjiTHzdKEHIv0fR55ii/WGTyJXel85A5V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742107401; c=relaxed/simple;
	bh=18uUDeYr9Ow0SFqw2K82QxXzIAoZLGL1KYTWMUZapO4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eyhLR2wUNNoaTkZV2o+KeVdqXpNG7nwd1iA4Ixw+EcBIqEFnD0ZUhkcmx+cjhjcPdi9Z1c3bDbnHe28hP7zUFm0l3P3dm9W4hTElxKiPvDpzKLd3Odr5neraQVUqdVJRlkuFwYUCwd5by9nlIym4vCW0/GwWOJzPzFsFkrCRJK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKgTwt6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3A8C4CEDD;
	Sun, 16 Mar 2025 06:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742107400;
	bh=18uUDeYr9Ow0SFqw2K82QxXzIAoZLGL1KYTWMUZapO4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CKgTwt6IZRZZFamS1ZFx1tqtNtyCmTVGrhwU0LIFG42UaJV1eerhC2LbwjeLzdcEJ
	 aURdXZURmHBxh7yLJbZNF0SOgCDPJV948TqXUeBmRXTb7xj+h1T9J16eaFK5Sm+ISe
	 cJzMgpjq3rnM+ce2YtlXTp97GCvZT5G4hUFOI30ir1KfIgBLczpgJRKvrhjFxe9+B3
	 mxHZmaUSmJE6YgBgPFEY4rbGnnAsI5/hMFg4ffGceG39etTGG/PCmm0Tinv+ShmbDO
	 QQmVS3RtCE56BYsUN0BmoBIW9eB/f9vzPA2g1LGm50aZk/txWc/Mc5JbE3lg9JXuHm
	 kmbruzYqbxgDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEDA380DBDE;
	Sun, 16 Mar 2025 06:43:56 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver fixes for 6.14-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z9ZwEQ1io5PjNaAc@kroah.com>
References: <Z9ZwEQ1io5PjNaAc@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z9ZwEQ1io5PjNaAc@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.14-rc7
X-PR-Tracked-Commit-Id: f2865c6300d75a9f187dd7918d248e010970fd44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb82ca153949c6204af793de24b18a04236e79fd
Message-Id: <174210743523.2742443.12002718936127421785.pr-tracker-bot@kernel.org>
Date: Sun, 16 Mar 2025 06:43:55 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Mar 2025 07:30:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb82ca153949c6204af793de24b18a04236e79fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

