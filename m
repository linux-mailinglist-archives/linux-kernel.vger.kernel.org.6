Return-Path: <linux-kernel+bounces-436137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F309E81AE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 19:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E88281E32
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE34E14A09C;
	Sat,  7 Dec 2024 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQgcLVnl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63417E0
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733597648; cv=none; b=ZJihl+hxW4Frz3YkaXUU7snImBGSCZUDlSzzxAfw1MM7c18DGrOxvDgFSHUaXGnIm3w7YI/xCWkscPKVoFpi5kkOPHopMh8tK4ZUm5M3fTqq2XLyILJPzLs5zabhm0WXY+4n9Sx/mpWE6pl2OgMAWm498OWypKM3AWH/rb5xMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733597648; c=relaxed/simple;
	bh=9fcThNCGMeLPhb4ryZ9bUb3LapYxnmAk+VAwsL7lXZs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Aq6wAAPtbCjsjicTrjl8ph8DA6VRMrM9TM2xSCFj5oGK3iZBLjhureOn9gyzVOe9h/O5ypGvuVRgbBG1bpmS33iCOwCHCNhtbXDcCvH6XbaKgOqX+0l2RMftSawyTjYz2nIsAnKnqqGSE90Qdl2mApaszgI8VMcirFSPXcEtRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQgcLVnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C067C4CEDC;
	Sat,  7 Dec 2024 18:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733597648;
	bh=9fcThNCGMeLPhb4ryZ9bUb3LapYxnmAk+VAwsL7lXZs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kQgcLVnl6XJc/WY6GmV68a3h3CbCzvNpRbwwowii4WdWSfymNMoKbnO+aPBdUXpku
	 F683twI1u33sTnDKlNcPSi57OJMKDW2uvX2NjdNzrSIo2k3jv8mBexYtil/qhs3TK/
	 OG8JAfFwvTbjj6UxIVeus3s/RKBGh/GqwnQMlqz3AE/Zkds5OMH/5fWQp9SPFD+LXR
	 SZWRg5Gqd66yt0ZlwHeUZAteGfraMvhnTdcvHKsW/8le1hWx9KODL3hquJOcNMy4qP
	 NpGTZ4m+mM0jiAobWar6/YBaPgym7cW6oAmV1Hqyett6V+kqgqqocBOF0loM0dqQr8
	 S2mlu3IjqZQRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C35380A95D;
	Sat,  7 Dec 2024 18:54:24 +0000 (UTC)
Subject: Re: [GIT PUL] JFFS2 fixes for v6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <972877429.45679137.1733560825113.JavaMail.zimbra@nod.at>
References: <972877429.45679137.1733560825113.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <972877429.45679137.1733560825113.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.13-rc2
X-PR-Tracked-Commit-Id: b29bf7119d6bbfd04aabb8d82b060fe2a33ef890
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6db2a5d7df3e577c268ba7955eb48e913424599
Message-Id: <173359766300.3037814.10654157760992073225.pr-tracker-bot@kernel.org>
Date: Sat, 07 Dec 2024 18:54:23 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 7 Dec 2024 09:40:25 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6db2a5d7df3e577c268ba7955eb48e913424599

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

