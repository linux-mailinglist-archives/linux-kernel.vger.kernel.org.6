Return-Path: <linux-kernel+bounces-558519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEFAA5E705
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B539D3BB310
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F6B1EFFBD;
	Wed, 12 Mar 2025 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E44FLZko"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732E61EFF81
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817384; cv=none; b=Ith6gAksZI12JWFypEfwrrcI/slILyUf492gI6Dv7vtisB/wFGnr5QrF4+gPMJS0qr/aXPQCzLOkFMonZmHPgiNlhsVw3Ywntqna4r2XNeHZTZqG0tZm5lySoeUS6Ksaaxnu0CY7v2L4/n8YiiUshh2KRFNWjUnXZQ9ucyS/c8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817384; c=relaxed/simple;
	bh=2p/Mvj5hsjGWyRmJ3lcv7yD69WG2sVEN9vWFWMRBX1Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gBylqehHtV+22xXe8SwB9RkcvbHtWpk4BcfYnA8rjVwkibcmZ9wxB7QVXO7C2eCFuo8vnIttWEz1gcsSiJ30sIGVd4TFUYIYfLIqB9ZDfS3jpA9AVuoGWovQ6qbEuuLy5Y5Qw31hmemc/G4F76uSiGAzgwRyp3g2ZFYD058it20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E44FLZko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47941C4CEEA;
	Wed, 12 Mar 2025 22:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741817384;
	bh=2p/Mvj5hsjGWyRmJ3lcv7yD69WG2sVEN9vWFWMRBX1Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=E44FLZkoFDfhJ1BHnmU9+WEstwTTKDQNf9wmUoVdbr45BzzUZHTn32ug/hZ2xxTYh
	 0M/p/XMk4uS/YgGaTBh6Y4Ph6NHNbg+NtATy/BD2xn2BIwn9EuRMislyAbIkAC8yXt
	 R9L+x8rNXOgnb39VjsV7RMXonlfksyj0ym94x9y1ewrdGXwLnRyTfWGz6iGgk1GvMl
	 uSoVTRpxhUmvZP0s00woeEHIon+CLXP0SjnWfmQnG/spKknwtCbvhXBooIFUkB1yLN
	 ig1KHHEvnpTTtAeXcVB9EsH5aUowP/FgcTkRrSZmB33MR5Ycf38RHtJchn6Pl0J3mQ
	 OBqWPsbt6ycIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECE60380DBDF;
	Wed, 12 Mar 2025 22:10:19 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: A fix for v6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z9H5G3I7A477CRuP@slm.duckdns.org>
References: <Z9H5G3I7A477CRuP@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z9H5G3I7A477CRuP@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.14-rc6-fixes
X-PR-Tracked-Commit-Id: 9360dfe4cbd62ff1eb8217b815964931523b75b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7f94fcf55469ad3ef8a74c35b488dbfa314d1bb
Message-Id: <174181741841.948496.9786650234398591289.pr-tracker-bot@kernel.org>
Date: Wed, 12 Mar 2025 22:10:18 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 12 Mar 2025 11:14:03 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.14-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7f94fcf55469ad3ef8a74c35b488dbfa314d1bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

