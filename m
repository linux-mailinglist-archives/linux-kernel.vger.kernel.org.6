Return-Path: <linux-kernel+bounces-177939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7268C467D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB068287B17
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268C138DE1;
	Mon, 13 May 2024 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+BCU7PB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6922E642;
	Mon, 13 May 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622651; cv=none; b=ngqSnNj7qH5dIqkZda7d3Rw5/ZcF0PbPAIsDlvn7fOQr867gF6y4TDUmt7HdWvrMB58tUz/b/zrm/NUFNoYZi/z6lMSDyl7D/soLldGLRj4pr9vL0OWU0v1/YbB1HsQ+Q38S6AJnV/ky7kgvXJtnBugocMZ539wp8P7QEzGzhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622651; c=relaxed/simple;
	bh=MQsDgv/bDJ2itXW8fmWKlniStzbAeTvvPJ9lNb9MCBc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Cl1x+/pXGdvTK5TMWv2dDKHqG/ylmn8G7sjTlKwCWXApXGUVd09Jrc+8XmEndkUjwr/LscLULYw/ZvMY3d+mhVAylEeM0E1p+r0eI6NgYusoSnsrYfFC/hb6WTJSHpfKx79LU4hxaW4z5BhQjz1wOQNBQ2GfjErc9zzD4IlR53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+BCU7PB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F9FBC2BD11;
	Mon, 13 May 2024 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715622651;
	bh=MQsDgv/bDJ2itXW8fmWKlniStzbAeTvvPJ9lNb9MCBc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=D+BCU7PB2JVFbzQts0/Bvh1ALJfHK5e7l//DuKVbkU00o4j1rdZrIrft3zUw4rbCE
	 gUUl0yB4UhXesmBaXYesGFlxVpZ2VNJdDWskQbcfM+gtpuMyHXemjDGbsj4sk+crDQ
	 8KMPxvbMgZ4clfvPJlUSRRMwCyg8CMuLPwU6XQKoA3FoFgGINpYuYHaKSrCGRUDlx6
	 EFTo7I02J6MGgML6vzessgm2mROXEBAZ8P704z+ScScYOAupSuiZ+7lRZWWGLuxz2M
	 6Jr9r7TVSQVL1b5iubaTqXqjq74vq1Wcjlx1KqalLKB3eT0o7WlUq0WnbeVWXsXXtG
	 jPaLhVEFbmUnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 311BEC43443;
	Mon, 13 May 2024 17:50:51 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <D15DSV117DQZ.3GJOTXCTGZHE9@kernel.org>
References: <D15DSV117DQZ.3GJOTXCTGZHE9@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <D15DSV117DQZ.3GJOTXCTGZHE9@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.10-rc1
X-PR-Tracked-Commit-Id: 1d479e3cd6520085832a6b432d521eeead2691ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b19239143e393d4b52b3b9a17c7ac07138f2cfd4
Message-Id: <171562265119.10937.5909896864002820245.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 17:50:51 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 09 May 2024 23:04:04 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b19239143e393d4b52b3b9a17c7ac07138f2cfd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

