Return-Path: <linux-kernel+bounces-426734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E859DF719
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B53BB2139C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F701D8E10;
	Sun,  1 Dec 2024 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maLkAhe7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322121D95A3
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733086209; cv=none; b=e56yYCITpej14GMOxuG97ymdwzoBidM4ZxheW38dPRYohSZSdEsAFj2i0uo6m2XK0mK2+69QZn6W+RG9sm35q2bOAryl1YSrnsBzflswLFtpBrqt/wUGtzPVtGLqpp21VgfV4ks44F6Mv2mB2BAChM7Z9J3tzYFGFK+crIBs248=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733086209; c=relaxed/simple;
	bh=ChC34DYMW5zMUQ+y7tzvdqr3zmPSJ3sLW7W1W173X98=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TTGgzN1PiEkRd2nc2PZRsGt8cq6uw1iZwgcAZuZRG+pD3GQ/BEQSWcKTxXyie/+9Pt8cPzgl3cvO4BkL+qEMxYmP4kTeFUomFq5uQypD0gb0gZtJMiEw7WByDSKiAeKY3/0l/4eYNKiFlfVqda6qkQtkEgYYgJE4JSIcO3VXDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maLkAhe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1173AC4CEDA;
	Sun,  1 Dec 2024 20:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733086209;
	bh=ChC34DYMW5zMUQ+y7tzvdqr3zmPSJ3sLW7W1W173X98=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=maLkAhe7COpoTgoNiNoV57DZWTWwvEL9pgil490W3QCepNoBxL86sH2trlJjadbXE
	 CskXG5AJ/RzamdLrXOxR5XYXM9WTj1L6+4fFE67R/Ybvdmeb5yY2IwVay+GgISbZna
	 YMZnN+vyvxwAKriL4fllAYnH5ZHYVvM82z96WGbpPnNX4RKnEaEcYY8b+mbdVcXXdj
	 aUjrAh/RJ6VFwczpdKpkAxPIlwPX5zYFx5U1XP/yDfFJDQfc3zUE2nM0D5UykJF/og
	 HoV8KxUBUwS1T2Y0MWGqUGSRLxs+gWnARpMYd5bVUM/+eS00wyb7A2DMCsFhwOj2YE
	 GYaL1CHbOdtNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B233806656;
	Sun,  1 Dec 2024 20:50:24 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241201110808.GAZ0xDmFincppAQNOk@fat_crate.local>
References: <20241201110808.GAZ0xDmFincppAQNOk@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241201110808.GAZ0xDmFincppAQNOk@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.13_rc1
X-PR-Tracked-Commit-Id: 63dffecfba3eddcf67a8f76d80e0c141f93d44a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f788b5ef1ca9b1c2f8d4e1beb2b25edc2db43ef4
Message-Id: <173308622299.2752601.17221052322311980122.pr-tracker-bot@kernel.org>
Date: Sun, 01 Dec 2024 20:50:22 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 1 Dec 2024 12:08:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.13_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f788b5ef1ca9b1c2f8d4e1beb2b25edc2db43ef4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

