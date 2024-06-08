Return-Path: <linux-kernel+bounces-207144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFCA9012D8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 18:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB350282971
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4946117BB0B;
	Sat,  8 Jun 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Alvp81lF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00917B501
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717865423; cv=none; b=H9usyByfFvSSO3N6Kuj8bwPjGz3ilGYLb5Mjf2TnoRf1HbDKCKI3AGaQEhaiSxhJHiRPdLXwISYineVOxRl2NEojkop8eHPoLuY2fgZSpf7lNj520fMbAf4tx1ePLho+WwI1t62wa00SUJfx2wf0m5Y1WHrmXzSfFtU1fJY9pos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717865423; c=relaxed/simple;
	bh=zdRAdI9nsnnEuapvSqeKQCQPh4Ap+d01vLqzhdf86Ek=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hJMg5ucR3NmW7nCZHCmLXW1OdOqBKdoXpLnCRz/P5YQjpxH8wtfzyjPLp49blX6syTV45nnNqZP7ZAoxtXuOsdyCXf974bDD9muw2XBPc+2Nha/GSpZjvwv1okf64j1Rgp03ATb6Msa0qmMT1mZXXxjGlZFudu4iagaT5uxMGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Alvp81lF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2908BC4AF0D;
	Sat,  8 Jun 2024 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717865423;
	bh=zdRAdI9nsnnEuapvSqeKQCQPh4Ap+d01vLqzhdf86Ek=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Alvp81lFYrWKKiuLrqiQp5+3TNNEXRj2/OVYdcPccGlU9f4SR8S23yB4Y1X3aII6w
	 0Q8EdytONAu8AF3+Q+504pz6GN0zzZVnn2YVXZXZBasnWTjG7k3IS23KHcqOKuUlhE
	 agD5XJXDYO3MpbLme/0CopUaUh9NStCWLivJzncoSuMpeplNH7lpTqjFXzrgyxZPiR
	 HmFCxhaiF2e1TTfHrYcq3dt2Y3O5TjpbG7PHqUyLX0QvcqWHZgP1SkNK2iJ83EpKC0
	 JVWoC25fGPl20E6pE/AnFanfmA65lmYAYZa2WR8C3vQbsRe6Nsy22Gx1uK2jPlT5A5
	 17YnMu6SeACCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09B08C43168;
	Sat,  8 Jun 2024 16:50:23 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZmQMczclwLdB9sEP@gmail.com>
References: <ZmQMczclwLdB9sEP@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZmQMczclwLdB9sEP@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-06-08
X-PR-Tracked-Commit-Id: c625dabbf1c4a8e77e4734014f2fde7aa9071a1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cedb020d537105acdc9e9311a0c30d110043491
Message-Id: <171786542303.29675.14665809719515426002.pr-tracker-bot@kernel.org>
Date: Sat, 08 Jun 2024 16:50:23 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 8 Jun 2024 09:46:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-06-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cedb020d537105acdc9e9311a0c30d110043491

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

