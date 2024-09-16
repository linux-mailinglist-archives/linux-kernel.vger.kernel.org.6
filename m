Return-Path: <linux-kernel+bounces-330159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB45979A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D1C1F23642
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740B4446DC;
	Mon, 16 Sep 2024 04:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/FKB0Tx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8924C62A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726462514; cv=none; b=W9OzFH3F8wtLVWGiYdsOFo8iBO2s3r4vQxQVko/vt4ugUBDTIi4f98QiHovT45e1EngKBsTOW9a0Wa6UTURGewB+foRFlFaGGh0QToS7xNNko480L/D6An9iVPBO21M+SnniWrzF9wk0sORBDqnJfs+2Fz2r1DQ6+FcNTwrVOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726462514; c=relaxed/simple;
	bh=BS9FcewmJ2THJ2mwZpAcoBH9E4PKHsy4DSx001vMucY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nIrcmO2XJJ+tB53uGsn6s86iRbhV5lYtOVBsV06/qanx1YN1aBLEW6FH5CLnDP2dzr+0FS9rXkmsDa4v4ugTEvVfqpEdpdtW9Yb6b+XGU9mnmZmjaXxFpZfb7/nEEuDvTsaH5vKfIg0OgwZoCJcS0OpmkS+anyhs8+ynOhhwVDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/FKB0Tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694D1C4CEC5;
	Mon, 16 Sep 2024 04:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726462514;
	bh=BS9FcewmJ2THJ2mwZpAcoBH9E4PKHsy4DSx001vMucY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N/FKB0TxqUh+fDLebjSatB39xd+hS+IddPaPFQypYC9Hw1C1zlujmD0rkp5TW0hOo
	 F6Rqf1iunh7A+ME6F9c8LL/u1xibTfwmD9Rfz+OdvPT707b6FCiRApOXGPtvKeu575
	 fnli0QtU2MAyrkZcRkVvO1pKvpmxM3NjNfiTF6fCwahINMUa88Xh8T4TJhLxmDQmHk
	 naWUaGc14UrSQAqn9+hbFtisQreL+dg55+cWz4TXHa68MetRE1xv47qFPlbYmRPtOd
	 Mtk0S+W+5xf56TxX+JU8nMxyGv/4y7nvPxeSX+YvY+jxRwFM2XYoeLYrUSFgg+cxpm
	 Ui/b419NtVIvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DD43809A80;
	Mon, 16 Sep 2024 04:55:17 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240909125800.GAZt7w2DcMRPncqQ1w@fat_crate.local>
References: <20240909125800.GAZt7w2DcMRPncqQ1w@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240909125800.GAZt7w2DcMRPncqQ1w@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_sev_for_v6.12_rc1
X-PR-Tracked-Commit-Id: 2b9ac0b84c2cae91bbaceab62df4de6d503421ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b56dff267d1246a6cd4a6ae1f850e12893dadf94
Message-Id: <172646251585.3235832.13161739378315238532.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 04:55:15 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 9 Sep 2024 14:58:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_sev_for_v6.12_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b56dff267d1246a6cd4a6ae1f850e12893dadf94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

