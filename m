Return-Path: <linux-kernel+bounces-331757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2049C97B0DE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE371F21D98
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CF418D64C;
	Tue, 17 Sep 2024 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMrE59v8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250CA18BC04
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580401; cv=none; b=uzcmCbbuHKn5Wc+PKx4lwsqKlNsHldwHcm/n46owG9dMykSPLjMmNga1SXoarfW0X5sysC7gHgNRC9InygyVE/PuYCJOCdxGZbMTl6DQQ8la5hZyYZNvQeR0uhaJ//AEoUIGlvg2l+3ubxiObYuGIzXA1i6mx7bKm9OpREzyG60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580401; c=relaxed/simple;
	bh=rxYbaMuaEVhJbvDfDmslcRQ5+o7jej6e2Oo/j9nBq1E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pdEV1G8Xy9YWTC8rV8xfSWfH8XQg5a/MU/42Z2JdwsanD6cGkLa+uuq6fqFqY9KRIvVcMtZ6bhZt5EOu/7eqxelQc3+nqUBM86thFRk+ONjyLyH+2NQm/N5zh0vyJPwiIZcg2VHn4r0+nMoPFw96+RRdYvTx7NjQLx5t5973FHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMrE59v8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16D7C4CEC5;
	Tue, 17 Sep 2024 13:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726580400;
	bh=rxYbaMuaEVhJbvDfDmslcRQ5+o7jej6e2Oo/j9nBq1E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XMrE59v8lId1UZnl2LlUv4ub/TJm7qXO/wlL15DwSMmg9lCeHTUck9kZPtyJd2U3i
	 gNi+xVZc/o4qCsAPl8IZf65MCSIYYTSZthncwFRecyq8mf6w6JHLs+vGE8fdDp+371
	 HkkmDLjQbGT3WxKL4LYFrxDusYZd4qzX33r8eknxSG5AAB5GFOR/M+mkGdPwBskEem
	 D6vg4hi4Cfj1e8Ihuce312zK5r0Y8rA3q5/nJjiHSWEfVwDtiNnbGSZdqQi53XQr7o
	 6jd2iTstmWZj+/oVOb/IquFDCMo3TPZTmTPhoYe7XuojnQ4cGHm7LsxbyWCZJwj8s/
	 9EZLi3DCPcgRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1623809A80;
	Tue, 17 Sep 2024 13:40:03 +0000 (UTC)
Subject: Re: [GIT pull] x86/timers for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172656199565.2471820.2194273071925899062.tglx@xen13>
References: <172656198112.2471820.6226852046770294674.tglx@xen13> <172656199565.2471820.2194273071925899062.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172656199565.2471820.2194273071925899062.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-2024-09-17
X-PR-Tracked-Commit-Id: e7ff4ebffe3bedf55560ef861d80f6500ff0d76f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc1dc0d50780a9b215322bcc315f07ad8e4c6c13
Message-Id: <172658040244.145065.14515208538982387765.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 13:40:02 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 10:54:19 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-2024-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc1dc0d50780a9b215322bcc315f07ad8e4c6c13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

