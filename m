Return-Path: <linux-kernel+bounces-577448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB3EA71D26
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D979517B7E4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA11221A45F;
	Wed, 26 Mar 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps2+JfYc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26019219EAD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010184; cv=none; b=RGan3gHqjlhjv1I9e3vhEpH6ZWWTO1H4VyTiWAYJrvog5nrUVFkbrQ6oz29sYPpjFnLHMm/scm+31QsGU2QNUFAUgW/j27+C+SzXel7/zzL8j94z1X1vn+N4TmzQYM3D26jgBfGA1ryrMlJp/8F2E1cT1O8lTGtQ7UwjUhNwhVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010184; c=relaxed/simple;
	bh=lf96S7EETVgiWzufbW9oXQLZ8dOWlAZbZjJWpaHU8fw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Lwvbh8xfNViY76mKTmuZhkxmZqjcQLZ9HzaPlCwHjMziSntNcTwTRpcZSlanB4Tqq711Q7RBJmsTV5kQZ/8m2jc9lPizL9LpBH1oG67Qb/cKhpPfa+j60aOX0mEjISv9gTqWA+R8WWQkUnD0Qg0AzBR6FGgkGlDs+gF2ZCpCsH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps2+JfYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EEAC4CEF1;
	Wed, 26 Mar 2025 17:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743010184;
	bh=lf96S7EETVgiWzufbW9oXQLZ8dOWlAZbZjJWpaHU8fw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ps2+JfYcQesupN97CMI1y/O+F/7ilAjh6RzUTv/gH6nlVloF0IhtPXYUfY6/jvhs9
	 bK8VLTv+pxwRzt9pfZOQg0sHCW4hprVOouvPJq1Y5uiAV9T+Uo4bx2rZ0ZzW26uX4E
	 wa9z3bbeJS+MPZI/ZElPyj3PTLAqoum+urQVa536k/WA1uIDQx3aK3BEpaRgfd6n69
	 UETKhtLC1l6hTXSKwEqrcPvBjiMYTmwmvGzLydUYHsbJ2rZXteGRXRm+Mw9hnvy8Je
	 C992iINHCWB2JTKYwjyhGhxYl9YTBrU2KAzaeoXF2rEjb6SB+d8TZR7NeYdL1DO83n
	 Z9+mZ1dM9A/0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 948003810903;
	Wed, 26 Mar 2025 17:30:21 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <8r0s342o-prr6-0636-932n-10poq04p380p@xreary.bet>
References: <8r0s342o-prr6-0636-932n-10poq04p380p@xreary.bet>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8r0s342o-prr6-0636-932n-10poq04p380p@xreary.bet>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025032601
X-PR-Tracked-Commit-Id: 4ee4d7b177cff042c7135c8a7c87fbfbe28f04d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e06802b426baa2d3c2a5d7784a6d4c2a9338c3e
Message-Id: <174301022024.1396023.17079464719698046652.pr-tracker-bot@kernel.org>
Date: Wed, 26 Mar 2025 17:30:20 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Mar 2025 14:04:04 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025032601

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e06802b426baa2d3c2a5d7784a6d4c2a9338c3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

