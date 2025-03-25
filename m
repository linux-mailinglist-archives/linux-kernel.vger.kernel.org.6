Return-Path: <linux-kernel+bounces-576144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE62A70B85
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 256387A7299
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A7426739C;
	Tue, 25 Mar 2025 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gr0q7FLL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B38266EE5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934659; cv=none; b=OgYxr/s++VRASQ1buSsP+cyxnmLhd+N/jck8IXr4uu0p9LXC2vUG37D3/BRffXZhJqwpZWSqRth8/Q1Ak2aybmUFdTsZPSMJrBnNjSLE4gHaau4FVw+aWv5m+qYCExNZHhh5NdbJbv4vhvJt0t0HbLCjbw10dmz5MoYqL7bpT2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934659; c=relaxed/simple;
	bh=2vE2KA6VW7+x39gvnUtONiUTea4u7hTaqHOxHO50tiQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WchmF5lkUod/ygt1JEcOuLFIOY4lnMDngYPLtFetdU0U9TBTHReCJfT6V/V5GL3HwezOlXlT3IBVBR68MqFOqlJnOZJkgVcnHwLgq8Fz9tMqzqRnWVIKywymAItBSqMU/6lMSmqCX4KqskGP1++7Xkd2v8N+0+dDrolNfGlZtSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gr0q7FLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3B3C4CEE4;
	Tue, 25 Mar 2025 20:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742934658;
	bh=2vE2KA6VW7+x39gvnUtONiUTea4u7hTaqHOxHO50tiQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Gr0q7FLLdf3bFtYeurIF0mnQ5yyrI51TASwXEcQvLh8tosoUohLhCSSdYzEqVT+VM
	 JvqkX8wggR0JHg+FocA/HEO1D2Dh70L+JtuGkDwVNoM+UAc3qKKrxDPqQzTe3TCag6
	 GA/gr1XPPYCoTuSEl9Us0E2NeLO3VSSHmkYWQjHlZqCAeDPnF/swnsNZn9N5aw3TFD
	 IzB2wM/TQqQ+icED62/3U+zZiu/FPV1bZCw3eteqzE/JVhdfyEwrHHGo3s7RClua5c
	 hKe/ghaHSWH3sTCMFsXgeBrAhji7BA16hq1iqXs0MG6xLidekdyvKMEgSIOOBGkWp1
	 lpyBfhFHVwmHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71352380DBFB;
	Tue, 25 Mar 2025 20:31:36 +0000 (UTC)
Subject: Re: [GIT pull] timers/vdso for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <174275226574.1561082.183279031431690330.tglx@xen13>
References: <174275225552.1561082.4969731002775597670.tglx@xen13> <174275226574.1561082.183279031431690330.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <174275226574.1561082.183279031431690330.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-vdso-2025-03-23
X-PR-Tracked-Commit-Id: 652262975db421767ada3f05b926854bbb357759
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 317a76a996043d336b85197aed5f44184b36ac4a
Message-Id: <174293469517.715410.1690742832975932995.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 20:31:35 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Mar 2025 18:51:44 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-vdso-2025-03-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/317a76a996043d336b85197aed5f44184b36ac4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

