Return-Path: <linux-kernel+bounces-243453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA163929649
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 03:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E17F281F79
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3714690;
	Sun,  7 Jul 2024 01:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lb7Wb9qI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D97187F
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 01:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720316296; cv=none; b=BpedBiDjfOfNfZGENrDHhDoaPlQ17qN05KlISSsQXP/xbAhFzMb0VDn2JL916XtiME2D/xHGDUOp5GBbhQez6P5ovKDKov4ThNcLT+dS1PKDyAAjctrGxrPJSgpVkcW6pTerGX1cfnXH33AjQfzIm3kD23wQCYnyie/nM3gpxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720316296; c=relaxed/simple;
	bh=DO4mjBeSv+rHa+N2vYm3ADbLYG0pH0vMnK2UvRXIXOY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hUbabeeVJsSnBBOmAHfVf/gRVDMsXd7YNQeOFI6WfUuVloACaplG751xwgkExjhzYayeeaU7GzI4+oxh8FyZo2R4LurG1sghQ0TjstH4HyZjhwGWCXIXuU17a82ReYu4Tez0cxzPJUcTAtKXeZ0MGq3Rq2bpozzxCWIWU1MUDbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lb7Wb9qI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EA67C2BD10;
	Sun,  7 Jul 2024 01:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720316296;
	bh=DO4mjBeSv+rHa+N2vYm3ADbLYG0pH0vMnK2UvRXIXOY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Lb7Wb9qIydSVlM7jLqmwxk3sYwvbGUXJoeXr397iHU55CQe3YSzXe27W4Z7zYke8c
	 AeRTQWlMEopXjrO5ca9OkoFR/K8gGOz3vQwCYpBRx5A7BP7MsRSeJ/tJ+KgTJ2r3vq
	 zbZ2957z2FU86BXnOeuurX5LhRzpbG0IFcq35pVGSYjYDj+DLru4B4ZVW/BacZgtZF
	 VWP34YYaunM8I2zpWnSD8fHHigpcKQhZFo41K3U6cC7/Z/PvZta4H1BpPjFlZaM9H6
	 wlwAhp/05nZYaFpaaecOO1N+OYHAiiH5eFh6lyGaFl/OJ3Usko3prrWIAwdT3MiBHI
	 4ht2DKVsa9KCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40985C43446;
	Sun,  7 Jul 2024 01:38:16 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.10-4 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87wmly2j7x.fsf@mail.lhotse>
References: <87wmly2j7x.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87wmly2j7x.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.10-4
X-PR-Tracked-Commit-Id: 8b7f59de92ac65aa21c7d779274dbfa577ae2d2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6653f49e4fd3b0d52c12a1fc814d6c5b234ea15
Message-Id: <172031629625.31798.10712226152561786260.pr-tracker-bot@kernel.org>
Date: Sun, 07 Jul 2024 01:38:16 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, anjalik@linux.ibm.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, ganeshgr@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, jinglin.wen@shingroup.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 07 Jul 2024 09:28:50 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.10-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6653f49e4fd3b0d52c12a1fc814d6c5b234ea15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

