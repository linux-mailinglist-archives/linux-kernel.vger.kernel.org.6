Return-Path: <linux-kernel+bounces-282352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE8A94E2AA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 20:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1458B20CB1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 18:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEE4158D72;
	Sun, 11 Aug 2024 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJAGkKq5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8A1586E7
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723400563; cv=none; b=fBjcBsPWTCbaeBTCZDxPxGAh7kLliJbG1sUMZr8tC+Ioc7/sbW4w1wmRvcs84IQUToA1M+t8hNnAQlnDltVqvq0mCnN+S1YlLGd2PdUS4Z4jryEy8Jx+QiqAHc63WV69NFgJMjS+g0rWMo9xSXSB+/aVirmsSJdjNs2IV4nu8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723400563; c=relaxed/simple;
	bh=Mp0FY989ScrWSYuoA1CWC1YesHodi2eAPtrpnIV/exo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IG/p+0QomjV3x0IwzN/pidYUI0yZWRpRm6p2+Fa+x9gSroytI59sIOqE31zFqW4uPib54w6i1NDXkXXjeBBPht21ZEl3ElN6trpcqE1PvMzx292nhy+8P3KqlxD+Po69Xk42mAP6EweDiuXUiSKx78KbwBDReKCPeWWcQOehZdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJAGkKq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36260C32786;
	Sun, 11 Aug 2024 18:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723400563;
	bh=Mp0FY989ScrWSYuoA1CWC1YesHodi2eAPtrpnIV/exo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CJAGkKq5kagjCDSqGLmA38X62B5I3RVrH94GkdiDhTN06o/kDMRMmhPCtNZ3HhCg+
	 6BW/tWiOBuvg2FyuqYsXxexpvKOIY/NMHVSmr8SZqe7PMnDSFih/sb39ixXZxS/N6O
	 i8KJEXWCVegOXVrc2hVavcOnvP5yFQ8tXjc+pO0yXDCuEUZSRvytS6Fl78tAZWaIGF
	 n3IGuijpMAmysQnjAAZm/SpN8hQsEd1yBKO4NmIxepOiRlbB2pUkvqC9WlD6LG5wN0
	 ooPDC4Qnr2nV6I71k0JBqJx+ZbRSv0lnRDRURFrdaXCICwD5Pm8w5HbXN2oIlRuT6U
	 KpGZN+TitYVYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C203823358;
	Sun, 11 Aug 2024 18:22:43 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: 
 <172338466744.1168419.7654203284534630611.tglx@xen13.tec.linutronix.de>
References: 
 <172338466501.1168419.15927287413698158262.tglx@xen13.tec.linutronix.de>
 <172338466744.1168419.7654203284534630611.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: 
 <172338466744.1168419.7654203284534630611.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-08-11
X-PR-Tracked-Commit-Id: 919f18f961c03d6694aa726c514184f2311a4614
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7006fe2f7f781fc96c8bab9df0c0417fd670a8e1
Message-Id: <172340056190.238940.15408108809363426345.pr-tracker-bot@kernel.org>
Date: Sun, 11 Aug 2024 18:22:41 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 11 Aug 2024 15:58:08 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-08-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7006fe2f7f781fc96c8bab9df0c0417fd670a8e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

