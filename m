Return-Path: <linux-kernel+bounces-179068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BE68C5B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5971E1C21553
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD57180A85;
	Tue, 14 May 2024 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGPZl12A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8553E15
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712114; cv=none; b=JgYQL6Rc+H0UGRM47KZ84eyy7OPtC6qVvEPXtd27z7Lz1uV1ssBRzPygEisNWc4O9Rlm7+ZIgk4r+62IGEV/UjnV5UBh+diMAGOFm+SPX2EOuO3gmNPLcbVsEY2glItTThXU7DPHo4reQdL1YH7IJ84ZUHD+vj8RDkxnUNYCKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712114; c=relaxed/simple;
	bh=IGXKKg0gm+pLLpxJqZLJdmW0GHpPlV0BBnZwuPBsrKk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ODHVg+MoR9GFNUUprGqg0NQZh0DbMROzZSEK/30xcSt2DnEaljNqMEszQ/H3ayMiLRuVa055casF3vsT/LwN4fT31VJviG8vLY5B60XjoMrGp68XXx/Lyoa8eXsjd8R/Y6RsDwm9zZi53f/dGtqRWCexFImck+Ov9PT35MMIXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGPZl12A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4E23C2BD10;
	Tue, 14 May 2024 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715712113;
	bh=IGXKKg0gm+pLLpxJqZLJdmW0GHpPlV0BBnZwuPBsrKk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PGPZl12AKSJQCiUak5MPSyaVIehCgXTcrlSudIceCbHJI1CFbZBaIBOIB8PY6qfd5
	 2TPI4kqGLWsGRBg3xm7axbbYU5CK/kgsO0eFxHzMXwteaek6sVvIdUHKeEnN822Xxb
	 HFGKqfffwo7fQ9pNnkV+HLUDONU2DneJkSx00xlBuQKuDDVLCyOl3dRB778pIOh010
	 BJ+R4Pth5cgLZSjMs5qzK3q/QoWw8JFgFVUHIM02nCBeBUx21NaOyii8GTDIMhYqUC
	 yBCKIjvH8PwA3BBI6CTkETTmHYaaPj7H3dX3IacZJsavRldOr0tmlXzGqC6Xxm7vL4
	 QVpyfR9+Sm62Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CECE5C43339;
	Tue, 14 May 2024 18:41:53 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240513111843.2039350-1-geert@linux-m68k.org>
References: <20240513111843.2039350-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240513111843.2039350-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.10-tag1
X-PR-Tracked-Commit-Id: ec8c8266373f6283a3e99b036aea7b9428480625
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1338acfe629ddd955fd524fc01e26bca4f1bb22b
Message-Id: <171571211384.4202.8418472773044722609.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 18:41:53 +0000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 13:18:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.10-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1338acfe629ddd955fd524fc01e26bca4f1bb22b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

