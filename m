Return-Path: <linux-kernel+bounces-290057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5B8954EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AC1288A78
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C441C232D;
	Fri, 16 Aug 2024 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvMFH7ku"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7BA1C2315;
	Fri, 16 Aug 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825961; cv=none; b=JbRV9eUyzbzzfHXFej9Sw6yJ0WwwM7wGjg7jY02Hs2J1yzJxMhpI8MKOc53QQyjcpIegGGMWuzDpqx1nHiUPsK+3FwjB+vgMn2fAyfM7fIzzIaSeAvcHdOTnq6Cz78DGmoZOtP1MD/C8643OhGcJp1EtdyoelE2pQjgc1eOxchI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825961; c=relaxed/simple;
	bh=EyaKVt8Rq1vby01DDZlsf9sxr84aXhphW9EMKl3I6gE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DbI8iz2juMOIrRzaH6sARIBOCpRA8Kx7XHksCbpvh60xqc0/Ghe9GLPlQX6t14jDF1zJ+FhqdzmTI+Qypo0yzq0PEphBQLCzuB1tchf4rxB76GTKuGuJnwEwOCMPSTTtaIvwH7/PKgsSBvXIrpCGzi11uHyl07tHLY8nctBX3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvMFH7ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C80AC4AF13;
	Fri, 16 Aug 2024 16:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723825961;
	bh=EyaKVt8Rq1vby01DDZlsf9sxr84aXhphW9EMKl3I6gE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XvMFH7kuQ9B4HkyD0D10mR12je/GWOlNgDRt/imYBhxsV6gAEJlbK2X7ag6g/XVFz
	 Yittaf8OiIXbGIF9MvhhZiKdoLoEh7fmvtE5nFWQnrCmahIVDnFv1LCaqTujNWCX+E
	 Fsnq1b7/3ASTe1U7b4eiL5U0ORwk9HeEx3hJDr0JNK7Z3dOxfYAgb0xBAvKF4c7eo2
	 432QxlKC19ACz2Md8GC+5FnDfil4OUfTOfJyjw3PbmMAnmRCbZsxB78m5ypoiXQFhc
	 y4rJsngOlRI/BaZKdICZCkHz3HsObEngKU6yJ0v34DxYOE6c9a8/0JWZaRcV/CWchL
	 znLTtOsEyGNwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE82C38231F8;
	Fri, 16 Aug 2024 16:32:41 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <87sev43lh1.wl-tiwai@suse.de>
References: <87sev43lh1.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sev43lh1.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc4
X-PR-Tracked-Commit-Id: 829e2a23121fb36ee30ea5145c2a85199f68e2c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d58c542a33e719029ae3fc1343b4cb09c125cb09
Message-Id: <172382596015.3569819.16954797403646488041.pr-tracker-bot@kernel.org>
Date: Fri, 16 Aug 2024 16:32:40 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Aug 2024 10:44:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d58c542a33e719029ae3fc1343b4cb09c125cb09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

