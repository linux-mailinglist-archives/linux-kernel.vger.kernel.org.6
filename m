Return-Path: <linux-kernel+bounces-343067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0233A98966B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19DA0B234BD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F1F183CD5;
	Sun, 29 Sep 2024 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5Wascwg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68568183CA5
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629502; cv=none; b=rhcJufVGS76uOC1S7NXWh9MyekqzZ1h45WeIF4ViQp+ZrXDnpy8tqWlfI1kxyY0SmEvBTsaNoqvuP5YsonlRfsX2d+JlY7wc8pprN067Pmw9BSX0vlY16PM/pmHkj60yKk4+iinXB/kni57NVitgcRLPNHQqAIj3G3EjyRg/1Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629502; c=relaxed/simple;
	bh=UbBwZnZgcghyGboxlOMhqNLsmCn5HAPb6FC2MB3jyzo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UvJjvdtRPz6a0ICAGKVY1OoFHs8m18MCYskXsOG+v3atixEbPVltLgFzskxcW9xyinLfyjQcriffe6rrYX41CBfrXk++TP9bN2U9Xa96VHWbfjFAcX91EmmGShreeeBJnXGqj7W39ttlNoTU4DZXIuRJQ2GkKsE9YFP+6Lz/tqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5Wascwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C03C4CEC5;
	Sun, 29 Sep 2024 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727629501;
	bh=UbBwZnZgcghyGboxlOMhqNLsmCn5HAPb6FC2MB3jyzo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f5WascwgBtPXhFzuGsLyIYT9oJ/gdjAv7RHCyJOemEFm2U6dF85LwxGk79Df7xUSz
	 MrX2huLcaa33bkVx1W49j9n+Gc2GJQp+v8uTwVdJhpnduA/GR5vbLSI2kZgCsspOYH
	 tuB7EDlgE4TVWpw9fUZwQq1DxDmb2E6849Kz8IcVR2H7YVI00GHRbx5AyMZg99aWYA
	 Nv9f9rPVMkGeCHAjuiO+qaX3aiqF/zry+1A+wuTUVxV3xoPZTEsA+rqj/nEBDho3lb
	 TZDCsqLfJ1uSlKJtxiM+T/oYnaGOUfCeaHa73hT6cs8jIb+U0tr0n+15ipwzw5Kv3h
	 Vb8yo3jdLtD1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE6A3809A80;
	Sun, 29 Sep 2024 17:05:05 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zvj9aYsNdWNGJbed@gmail.com>
References: <Zvj9aYsNdWNGJbed@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zvj9aYsNdWNGJbed@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2024-09-29
X-PR-Tracked-Commit-Id: ae39e0bd150bd2739582f72ad70b5a0b15e74576
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec03de73b1e11e5b0c30d3c35e09dffe7496bb06
Message-Id: <172762950458.2558104.12505387906908036738.pr-tracker-bot@kernel.org>
Date: Sun, 29 Sep 2024 17:05:04 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 29 Sep 2024 09:10:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2024-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec03de73b1e11e5b0c30d3c35e09dffe7496bb06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

