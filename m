Return-Path: <linux-kernel+bounces-426407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30179DF2A1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 19:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266AC16303F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953181AA790;
	Sat, 30 Nov 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTNmtL87"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AFF8468
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732991976; cv=none; b=sCTpqRmOglE8s+W1smR1dqbVUFME0E1OFm4+C/zuLuvzLU+nCF7vlaSND3Wd8HM3DVj+zXxrpiAqD+gBqpc9VfXkESkeIcRi0JqVxunnmj2vfzQku8XN1RBRs0onjc0oCrFRGPNwBYEZYzCsYpGAxxoDVIl1abFAtwM2sSmzQMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732991976; c=relaxed/simple;
	bh=o8Pa1/XofAVAz7CWLTnk9GgmrFWNeKId2prKd793WKo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p0LGU6iC8RnJeH4XPIrU7OHBVOqL8cdtz5xYjRiIVdYrYGgwWClNOlW2rKRAOiHBJUBybIvAPVnEClj8Ou/ccjGopDDUAEG/lB7McnsfixfG9m2CKxH3ghzM8xAnLiVnBEng/jkHfXVVbOQmCBtelqWMyKjjq6IX3UEwJ2qa2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTNmtL87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814D4C4CED4;
	Sat, 30 Nov 2024 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732991975;
	bh=o8Pa1/XofAVAz7CWLTnk9GgmrFWNeKId2prKd793WKo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FTNmtL87VZaxv11Fi0zCeDAzd3umfcCv3cmNX7fQHScB22ijg/q7Hldidzj+9mh7p
	 XfYPuJhPyDPYIzBWx7hyyXHVEXT8vNSRCSNtqELgnN2F4mPw0qIXI5WBIiE8qXr6uq
	 t6ADWlOeMCB2ok8VZw16hloCvTfopOJadQ2i00B4zK37B4FZi3bXn2xtYP2nFN3kjz
	 21+rrqVfctvdyl6sBstMwWur1fY+Exin/MizP3u5lGsEim26oOQKldo5vfZTit7yOG
	 Pop/LEdzz8iH/a5rcXu6b7uHxmBUDFXAixvRbw4DKb+MKkrvLNQxErAPFAtefg9HwP
	 kOuy1FKYiOf3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D67380A944;
	Sat, 30 Nov 2024 18:39:50 +0000 (UTC)
Subject: Re: [GIT PULL] JFFS, UBI and UBIFS changes for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <1445196426.11806664.1732921599708.JavaMail.zimbra@nod.at>
References: <1445196426.11806664.1732921599708.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1445196426.11806664.1732921599708.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.13-rc1
X-PR-Tracked-Commit-Id: bcdcb115eaed5e988cf37cc9a1dd5f5dd200e927
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04b43ea325d21c4c98e831383a1b7d540721898a
Message-Id: <173299198902.2451487.14358841456698433239.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2024 18:39:49 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Nov 2024 00:06:39 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04b43ea325d21c4c98e831383a1b7d540721898a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

