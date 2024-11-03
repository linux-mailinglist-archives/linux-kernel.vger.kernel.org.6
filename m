Return-Path: <linux-kernel+bounces-393928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DCA9BA78C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 20:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318602815A9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530218A6C4;
	Sun,  3 Nov 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LesLuJ+w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C618A6AA
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730660539; cv=none; b=oKmHQbM/OzQyxcnieKeg6qSTwpFWQaSOAzf+t+1j5jCUk07aALA8iwTFSBoXxvZ8CS8jXc2oMFejk4cCsSLjI5uYYd/e6WqfZ6ekV1/gxU4iQaT5DP20Om1J69UaH3frQfo2KUrp8C/MxxDm+zDqcC0EtqnuQbDRESc9uccSRP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730660539; c=relaxed/simple;
	bh=cB7Ecy3F5SowKhjdiJf69jIwGhWclOCMpjUMEGWGHTI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nz8IAGKV3Z/Rm/Z43EO9/hLRh8qYC6Yn1o0Y/rRuoZru90a7mP+KFbpzsW2Z2w5lklOTD2Y9vfcCyOpwJE5mV1zcuMWktH6U6+dbq3kGpDEUPKs5YQVcIGoDEU0QwNm3No2TKPARr+n6olODH1qcrfBEf6CPpm3thdBKgLlisGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LesLuJ+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F06C4CECD;
	Sun,  3 Nov 2024 19:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730660539;
	bh=cB7Ecy3F5SowKhjdiJf69jIwGhWclOCMpjUMEGWGHTI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LesLuJ+wdjCLTYHIN7T4Jg8vl0SU4ubbBV5HRjHaqRyn1G11/B2NsupaH+XJkAVq6
	 21SYkxTpix7m0pPii+2+H2xl3RtRcWxmUzk2ewLgEKV83snmra7y02+eShmMEnLYL7
	 WROTSqoHTjAJYmFeQrPIo/vyNDWR0wvc2NCnVRWrh+DwlPJ95jki3xhhw+2jlsNKv1
	 +ncRDW4odF0VW66mZT64dfkPivkLSULXD1TQguPGSfS7mOEJagN1qAyS90AIznDr53
	 CdSk1+xGbRA0AaOZA1A6fKFcTtTtUHualZAnXhBdDR+AC/pJ8SIlxdj/uOFqWWVX+5
	 L2xYFHImNHRlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACBB38363C3;
	Sun,  3 Nov 2024 19:02:28 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core revert fix for 6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZydmMMof02Mb1kNT@kroah.com>
References: <ZydmMMof02Mb1kNT@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZydmMMof02Mb1kNT@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.12-rc6
X-PR-Tracked-Commit-Id: 9a71892cbcdb9d1459c84f5a4c722b14354158a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 886b7e80ab19841f640cafd8b5ab053409b9b931
Message-Id: <173066054741.3233701.14034210814043075226.pr-tracker-bot@kernel.org>
Date: Sun, 03 Nov 2024 19:02:27 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Saravana Kannan <saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 3 Nov 2024 13:01:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/886b7e80ab19841f640cafd8b5ab053409b9b931

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

