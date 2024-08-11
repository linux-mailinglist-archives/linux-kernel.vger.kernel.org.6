Return-Path: <linux-kernel+bounces-282351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFF694E2A9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 20:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E301C2092A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3001B158539;
	Sun, 11 Aug 2024 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLdHi+nC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73988157E87
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723400561; cv=none; b=ViIiJ+/MgfQ9FR0rdltoWxTVSiYFev6BsZNq1eMQCHlfn36eQoj/BgyeZZvdVt1I9fELoogSkUC+F5tI1u58U3KCY1TOSQXCvrkjwDmlQGZYCyLcDcGCjzMzHNP7Q3mgasplPJwWpZ5q9MMEYTCFGf8J/OaQZs6cPbWNS4GvljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723400561; c=relaxed/simple;
	bh=V0O3E+/+q7yf3MWTKAihteNczdcerHyQNILka3QvJ1o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P7RM0oTlPo9WWiYi0tTglJh9pv8R0gm7XIAdHQRFCt/irayLSlKhKEW/aJEv2ssvchqcJ63zvu1p5FHViLEsDo0M2wjBb3JvD/k5hXGHtE0wBo4/E99PEuv6aNM6qhQETzGKcCpfDVMq17YcFK+m7hCxazOXGvpw+9QcmB7jHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLdHi+nC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581C7C4AF0F;
	Sun, 11 Aug 2024 18:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723400561;
	bh=V0O3E+/+q7yf3MWTKAihteNczdcerHyQNILka3QvJ1o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DLdHi+nCXmSUmNJxIYI/HIUz+7LoE8KjA1F+ZofTzuSUf2nqzL6c0sTMDiItMfUmB
	 op+ri7HfKXRx/6SJoFcreEs5fuDKQxWtTsgvTKYF0PFwpUSuxpIzIba2vojt+dHORR
	 qI//IE2JNKaDx5kujaxcUbkGtAmMs+3CtEEZpSgxWZpixAB18chS/j9cY5vy4M898o
	 2cOENxyoQf57qnLqbBTWC8RaiXN6LD+i2mO88jWIMli5As5l48opAphdv53gqRei+0
	 2b8niKPvLiRKrhNWVmXWvT4+HFruxchUb4SgkIZgZUwYDF9B8BpZjzrC4NZ43sotjD
	 DVx/96bWZyGxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 870603823359;
	Sun, 11 Aug 2024 18:22:41 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: 
 <172338466622.1168419.14975326329561608062.tglx@xen13.tec.linutronix.de>
References: 
 <172338466501.1168419.15927287413698158262.tglx@xen13.tec.linutronix.de>
 <172338466622.1168419.14975326329561608062.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: 
 <172338466622.1168419.14975326329561608062.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-08-11
X-PR-Tracked-Commit-Id: 5916be8a53de6401871bdd953f6c60237b47d6d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7270e931b53025c1070c2dda30a0ba7f1b2c072c
Message-Id: <172340056019.238940.4672236863527608561.pr-tracker-bot@kernel.org>
Date: Sun, 11 Aug 2024 18:22:40 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 11 Aug 2024 15:58:06 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-08-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7270e931b53025c1070c2dda30a0ba7f1b2c072c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

