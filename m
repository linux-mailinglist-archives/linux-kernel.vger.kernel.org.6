Return-Path: <linux-kernel+bounces-307449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8501964DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0650E1C229C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BFE1B86FA;
	Thu, 29 Aug 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJzZAkXr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE4E14A09E;
	Thu, 29 Aug 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956425; cv=none; b=DGtlpI5BTRX8qLE9nU5UhwTyngIF23XhAk6B7kPKEmzcrfNr1ReDaDRx2i3mlkAIx0TnCzy1029HlgoIln1J99VAFspzPGAVem8rJBkrsYeo5f829RNEuJigaoEAamCZz7gRBn4ASB4ZcNd42tXU2yOGb2j21iqbM59wF6k4+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956425; c=relaxed/simple;
	bh=eMVK8MRzStsv9BzBp46JfRMuAjUAzsoY740AMVKaYy8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nbVDOSGnoMBAnq15TXi984Av+QHDmQ8kOx3kZsGYh8kQlI+9nCy5Dz1BgJgmmcL4Y/5s21LI/NcmJBAtTBuFCNzrCY/63eJfFBE8agDdFCI0J/pBjLJs9oSNXTIvppmz8JkcOtVrZUXWPZ3gPURXF0xjo+PZU/RggEGvs+MgmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJzZAkXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244D1C4CEC2;
	Thu, 29 Aug 2024 18:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724956425;
	bh=eMVK8MRzStsv9BzBp46JfRMuAjUAzsoY740AMVKaYy8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QJzZAkXrU4KbfEhPkaJtWnW2fJ/BTjOGxeJzP4iZ7v97Dd1Lw44cCN57q3qr+piEy
	 kBSpT0td6k9PixgW+Z5Fmkz7nY8wSANODwFvvPtTcicKKIc3Nxq0KPUFtkOhid5dVE
	 hywsT/vBTDQlh5aYouuHMNe+K6NAFZ3W8fZvgmaVLbxqW0vu/UnQsUzXi6QSCMtxQL
	 l/m0WIxX5saC5dJxIKirT8eotJ3srauYDP8TAW8OurQMBb9B2S2PhBrQeQhn866OE7
	 p6XcZXGd7/fMU2zJBvPiQekMrp20ezy0ZwyM4/fvDNHl1Y3HYo+8qtIutZ0ZREwX+n
	 x2zlDYH0uihWw==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B33C13805D82;
	Thu, 29 Aug 2024 18:33:46 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240829143308.1398637-1-linux@roeck-us.net>
References: <20240829143308.1398637-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240829143308.1398637-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.11-rc6
X-PR-Tracked-Commit-Id: 7bbc079531fc38d401e1c4088d4981435a8828e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b9dfd9e59367eff5f65ef2a850f2df674f1f1c5
Message-Id: <172495642672.2046318.51285649074487323.pr-tracker-bot@kernel.org>
Date: Thu, 29 Aug 2024 18:33:46 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 29 Aug 2024 07:33:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b9dfd9e59367eff5f65ef2a850f2df674f1f1c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

