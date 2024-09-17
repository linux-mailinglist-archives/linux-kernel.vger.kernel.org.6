Return-Path: <linux-kernel+bounces-331760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87A697B0E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBED288D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8940A191F84;
	Tue, 17 Sep 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdwIUxfK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D0176AD7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580406; cv=none; b=rFBwOpGSkt4BLhk3HnQSWVar2rLF/fadgpvQvm9RA307Fmq1+VZCXz0HnHN/jkLQNdigCDBPoLqcDFd7bzvyjdG6qYOJHC1Js+OmAcqe6XtBnYABD+ph0pa1MiniZNlJmLIjy23irUkrzrvvn6Bba94mFTxz1Dgv8AR9Vlg2zt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580406; c=relaxed/simple;
	bh=x4NpzGDlkh24ADVUZEIx03qMB6o+swEsegRrtuTB7Xo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HxapVGVWUGXz+JGxriTCDXwm0eQMgOPwiyDcINtRpRnBIO9jfM6Hrd2F4nQ8Dpcf9bNmzLIROjTJfRW2RYYXQbjRAYVd6NEF0d1z3NJTCH9tJQB9uuVna1DJZnaQTD9oZbOVhKLtaiZ9SwBYqcvmWtADo1OypoBoaIb83cWDcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdwIUxfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86369C4CED1;
	Tue, 17 Sep 2024 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726580405;
	bh=x4NpzGDlkh24ADVUZEIx03qMB6o+swEsegRrtuTB7Xo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DdwIUxfKM866F3ZrUvopft4UDpxqzhG1QsGkVB7UWcEBWq/m5kEDnUryRMn2XsrYC
	 wCFgiCI0N4k4N+/mYCXHcTzkuGjmTtYfN90OhuXwqYOvOmhUBVLGf9mvaUR37CiOxV
	 En3adHeWhZ8Zp0zVqEKd5/7euiZFAXU59P2LjLG7CSHLGVPXjbeUfc9BwbwB/FXTRj
	 suABHdHyBAMXnHQWRn0wT+Q1rfhZewe8FO1BAV99Cf5bvO96C4K7R5l1edOhav1MXk
	 uXF7QwshCS1TrJgUUL6qp28qZBc1OvnBhGZh2Je8eOtO6OrLsRISSZTEUHGzMJjpCv
	 KrxOrIJh2jTqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E763809A80;
	Tue, 17 Sep 2024 13:40:08 +0000 (UTC)
Subject: Re: [GIT pull] x86/misc for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172656199070.2471820.6570057005643160376.tglx@xen13>
References: <172656198112.2471820.6226852046770294674.tglx@xen13> <172656199070.2471820.6570057005643160376.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172656199070.2471820.6570057005643160376.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2024-09-17
X-PR-Tracked-Commit-Id: 4460e8538ef17c86eae46ccbe096eee8c740a7d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b50753547453613eb5d0fada99d55583852c42df
Message-Id: <172658040713.145065.4461280935899922348.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 13:40:07 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 10:54:14 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2024-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b50753547453613eb5d0fada99d55583852c42df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

