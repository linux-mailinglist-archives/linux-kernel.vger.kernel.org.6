Return-Path: <linux-kernel+bounces-418904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBAE9D670A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9245A281BC1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819E716C854;
	Sat, 23 Nov 2024 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZ8DE4cw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE2165F1A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732325453; cv=none; b=EuraAVaiyyd+U6UJNzJPNpqwMKNajW+sXM5BzTThpvY0Qe77sxid98xVn9Hrfe1iyK8NPP33MGJpQ96bzgG1RpormX0YAxFOBIgiSZ9lvA5QMg96JW+SyA1fYy4whcqMG6MM9SB+RX88KexbJDUwmT52OqiCHwPjhUsvs+mW+UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732325453; c=relaxed/simple;
	bh=y6KN8MK3ka2lHfxAKenBo09toDpETnKr6NfGIhj5a9U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NEJJABcZiljBsU99vKI0T5t12NKYTLcKKIzXI1b5eJteHb86ZGV4jqEz0g5aqkqPBzTsxLwkfukosSgg1aqhAt9bJcig7IfCkkoHM765CPdsUv1KaAgDAjK63np7pGdUX3gtNsHFDXUbMDgToAfLlsv0wZt66zy2Oixb7JskbrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZ8DE4cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09F5C4CECE;
	Sat, 23 Nov 2024 01:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732325453;
	bh=y6KN8MK3ka2lHfxAKenBo09toDpETnKr6NfGIhj5a9U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jZ8DE4cwyLUoiSqvwXDbT3/3pN4w1MSOAXyyRmgSe2l6XXO0zZ1VTXl2qdhs/fTdO
	 xpbn64A7E3DNQfWYMo/ED9i6id7SMDZ2iL56Y7v8ow9icQIe9kIeg49LjsJZWrrrUh
	 7Z0MQkiPKIgNcdSCBt25cDkTo/HD9n52hEmryzrbBXXLYkNNagmHZ9+0J36EsPy/lq
	 LVlQGOjbWtS+YsoU/tECJCaJ1IipZzjPaSvGilX6Fd8MxnAW5KWTqkL51CNjp716QL
	 wIE1e0n9UvQVzscZ3kOr3fBH4w2LFqAI+lTdVX5pmKV2zMdPIShTb3N895hB525pSr
	 ELt0rSJZ0Zt7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B023809A00;
	Sat, 23 Nov 2024 01:31:07 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241121124358.GC7052@google.com>
References: <20241121124358.GC7052@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241121124358.GC7052@google.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.13
X-PR-Tracked-Commit-Id: 3adec6f907b698b32ab62f70da31b41abed00c59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fb7eb3d7e8c5c0375c726c7d5c443e6f7e53741
Message-Id: <173232546583.2863978.3445493807987127193.pr-tracker-bot@kernel.org>
Date: Sat, 23 Nov 2024 01:31:05 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Thompson <danielt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 12:43:58 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fb7eb3d7e8c5c0375c726c7d5c443e6f7e53741

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

