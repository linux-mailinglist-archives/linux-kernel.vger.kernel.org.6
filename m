Return-Path: <linux-kernel+bounces-413752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F347B9D1E38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18CD1F227C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77D71E9069;
	Tue, 19 Nov 2024 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMju4Mnd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C95155C82
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983053; cv=none; b=AO1tXwc/1GFr/ohBp2zQq27qgovYEIXo24fqPiVFaJ9o7wHUw8RpDcUJuRSXjX/AduH4JvuSDAAe+QFU4IDKWfi025pVJNB0fDXjkPNs/qqi/2z07Rzk6/vklyhHgc0cQOiRHVcECLBZPaa9bgYmQdj0iaMBRbKfMRNC6qr50cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983053; c=relaxed/simple;
	bh=2LCm+Gv9jLMfZnu1AsE4d9eDlR1SWa6hzle0WXfv1jw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uKDyOwR/Tc5NqGUu8y24Bpc5JlKkARQTD8USmAPKaZpQ71sVzKcL6PSNFcD8jfHvridtexDv3Y5t/fqaccxVt8pzhul8AOqwMEFHnJKoMtEwu7m0aBKBuUu0pu9Ldl0cP+njClP+nUzP6SUVk/K4ZksLrJ7nLPObLxqDLVwzfpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMju4Mnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D7DC4CECC;
	Tue, 19 Nov 2024 02:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731983053;
	bh=2LCm+Gv9jLMfZnu1AsE4d9eDlR1SWa6hzle0WXfv1jw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CMju4MndrdymIMMbDLwc5LSWtLfn9q+UKNqu5W/Jo5/75cEGtOUyRUyyhsEMNHAht
	 ENUD5pz16WU60dT9fv8C2zIk094cny4NISHYe5IEzf5F7e8o57Eqx6f1IhpeZT6Ff8
	 EYOw2x56PtHuTHgKyzsvFhNX1cSHH6dBHav1CQrIFyCesG07XtrAmB1gQTVYkbe5Mh
	 LYCO43czBcEJ0n/pDMml6R0TS/6rHVkdV7q64FkYf3GPY5xEIrc8PwMrFXPCjTWH8I
	 f67iMsyPRg97fQqtp3kwq8/zB7o3jGQwFQtaMcS6120OMEAg8XVg3VS3BUrnEwvdIk
	 Xs2nS4DN0QBkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE10F3809A80;
	Tue, 19 Nov 2024 02:24:25 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118124720.3341025-1-geert@linux-m68k.org>
References: <20241118124720.3341025-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118124720.3341025-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.13-tag1
X-PR-Tracked-Commit-Id: 647619b6bd27d2b7c3c6055f3f0d996e61884202
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9aa4c37f71b9a0a4f51692fbb874888c139805ce
Message-Id: <173198306422.73657.16490470946970522059.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 02:24:24 +0000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 13:47:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.13-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9aa4c37f71b9a0a4f51692fbb874888c139805ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

