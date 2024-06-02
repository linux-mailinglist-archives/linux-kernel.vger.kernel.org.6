Return-Path: <linux-kernel+bounces-198364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3023C8D772F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 18:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA361F214CB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459A75674A;
	Sun,  2 Jun 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADz9ozz7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595E4176E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717346474; cv=none; b=lKQSsF/dsGJxExLBw0HWnBDLox6SiOGcToQRtYB3zy8wHQZ+mBMzEv25sCQ9te5Jybnkzo6eRZTha2SSl13OcgPbbKBnLDSryhVZzR9pA4P1vEr9IOazltKUrIgZ1Gp/wHgcEnnxVL47kENw3QGXH7Z35/gQVKP+ALXlYL1eHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717346474; c=relaxed/simple;
	bh=CioFMCzDs2fHy+u+/6O6hOPg9dCrcvs0t/vl2L7WBlU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IckMdtknI/OyAnKZY27ZDk2TT1ywbqHqtyMNKFySF7T+V+9f5IDgya8PEFdTCNn7kYVsXQwQoYlxq9fNa5OXsO2qw9w/AWK25lrOwa9Nfmu82Thp90B5smtzd2LHCAB0mv7Pqb4Rnnk2bWtRy/trGuyrLG+oEh13+UiPryXo1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADz9ozz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2949EC2BBFC;
	Sun,  2 Jun 2024 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717346474;
	bh=CioFMCzDs2fHy+u+/6O6hOPg9dCrcvs0t/vl2L7WBlU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ADz9ozz7/2e/AE9E1T/fBpt1nlMJ0kg13kAsBj19m9HmD7w4llvLRqK1u+V45fGwi
	 UeuF2S7x1T2Vrjjpmr75KujCxz63/UO9B2VrrT9tFr6ezhKPbM0EcEsbPx62Bwd3c2
	 +lCTZsUrcS/TylR+3P7nIOLsGSSiCOl2GKV0oBduNaVJLpIyX0tC12PjFC48aJgxwR
	 w9wTt12GoNtkSVT2fsv4xmTqz6Oa0k0W/7mBKsF7A0P9WtlD4M4tbQQMlro2V4Ct90
	 NmVJcGtUXwEaE+gjaNLXXT144cBGj9cGWY+WjvIv1ni7zQRXR0HvhfDaFv7WydG0U1
	 xRnLWG7oRrMZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 146BADEA712;
	Sun,  2 Jun 2024 16:41:14 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <202405311350.388C0A398@keescook>
References: <202405311350.388C0A398@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202405311350.388C0A398@keescook>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.10-rc2
X-PR-Tracked-Commit-Id: 99a6087dfdc65303d26ab5fba2dacd8931b82b08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00a8c352dd7581961fd0f284c6fc1a17b370d0f4
Message-Id: <171734647407.21593.5801160929839546040.pr-tracker-bot@kernel.org>
Date: Sun, 02 Jun 2024 16:41:14 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>, Kees Cook <kees@kernel.org>, Marco Patalano <mpatalan@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 May 2024 13:51:36 -0700:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00a8c352dd7581961fd0f284c6fc1a17b370d0f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

