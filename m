Return-Path: <linux-kernel+bounces-516809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3242AA377A9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A624188FFFB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5991A3178;
	Sun, 16 Feb 2025 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6Sanss5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FEC19DFA2
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739739750; cv=none; b=HORb99UqERhM19chqPOyIHAaIbgHxTm9462WDVandU41//g6V5XI8di/AUra6vEZF8B+UIOePNVmZo3KrYUtKRGAEd632j1Cyy9Tm2ABKT2Dbl9Wy3zC16hDe/MsEesZ8lTaY21X7U9cy/QDoOm86ve99IRTx6Lg/MiTRCIUTII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739739750; c=relaxed/simple;
	bh=D1X1COA3z7rVRMESgK+v/dOvT3aHKlcA+fRFxgd/goI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OT6uEvJ02Lq9te6pPZoXC/G+SrmJ21lPOZmazy1Lt5zKMIiYJpaXebDIKKzN8AGHygVDbjMMazbD4J3KH5CvV2ohqAppoupZXAV7m0KIUPUBE15WvMpM2MmNZDIlg+TnNv1Hafok/mrjWvIWUj1DOvmWGSR1v+yYg1l/I6PbMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6Sanss5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4996CC4CEDD;
	Sun, 16 Feb 2025 21:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739739750;
	bh=D1X1COA3z7rVRMESgK+v/dOvT3aHKlcA+fRFxgd/goI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L6Sanss52tS0+o0rd2GDRtd/eCJ/eCRlZUspTopbZGVkwyZKqNg5YTON6taIzbHHa
	 FFnIm7Z5foZmlDRump6nprbqVANpFRTpghvsQRvP+zvkf5FimdL2V2Vf/jMRvGIPW3
	 9VjTuaszsRRjPKNmS9XuHAS1t6RHCxE29GgIwkd7pLCsFBu+LIN+h6erl7bLx3k73j
	 JXNaN6yvyHIMLWn44QGM2giyAimYDzc4H/FkIeNXCWgsl0etCzHswEuR/v8MSS90yE
	 /1INVugrclagyOkprTpZJ13/wXcSxsFGXvYZFYopnpNwH4H92qeIGP3ID3qkk4a6+W
	 iGAzqzeSBjckw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B67380AA7F;
	Sun, 16 Feb 2025 21:03:01 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core addition for 6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z7IAjdCB8Ly5GIjW@kroah.com>
References: <Z7IAjdCB8Ly5GIjW@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z7IAjdCB8Ly5GIjW@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.14-rc3
X-PR-Tracked-Commit-Id: 78418f300d3999f1cf8a9ac71065bf2eca61f4dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae5fa8ce7ef230be50ed63d16883bada29990293
Message-Id: <173973978013.2568330.3282156229769858460.pr-tracker-bot@kernel.org>
Date: Sun, 16 Feb 2025 21:03:00 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Feb 2025 16:13:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae5fa8ce7ef230be50ed63d16883bada29990293

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

