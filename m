Return-Path: <linux-kernel+bounces-558518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20BA5E704
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D443BB31D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AE91EF0A3;
	Wed, 12 Mar 2025 22:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEVC6W8O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB221D5CD4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817383; cv=none; b=l7ixOhnZut4V7+xMLVSk7ug9hjNpcyWKimVjvZ9x3yYWmwc2VoZIY4c4b4XKlOLXTflCb4qZn0L3GPBEGhHpR8CUrcKUqUstgM45ftpiK84xoBcB/ANj7Ou/dIWFIz+xTBeNDHZmfHuocDavnaMF8PREs/4zEalpEDzKSg44iAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817383; c=relaxed/simple;
	bh=2p/Mvj5hsjGWyRmJ3lcv7yD69WG2sVEN9vWFWMRBX1Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o5p2WmC+W4mDWtNYE+Khp3MxbT+2z/ptGjp65aJNqn4spVpJ3R/pB5ZNuN98qXO5548jfSgXF6HSYA6O14OxCRALQ+Qd+izTuGR2ewK24JNMG5rS4nc5gCTITa+dmCmtPSHSb3iJnUS3CJm/h5/+O3R0o4jwPQKsQELY7zulyQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEVC6W8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F5CC4CEEA;
	Wed, 12 Mar 2025 22:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741817382;
	bh=2p/Mvj5hsjGWyRmJ3lcv7yD69WG2sVEN9vWFWMRBX1Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GEVC6W8O7Zx5xjW8nXPcNX4D3OaEArrSFHhKmI9nmOWJGRd4K1f9cBHACdeeHPel8
	 cV3XL/ntxGLaVbbIbYjXNZk2twdOYTOkwdi1ueswcA4AkWX+MXWonr6arRZ9929Ta4
	 wyE/6HbUcEySmEny4US3P6UvwnnARDP+zQCZKLgouGKxVQeYQjLJeE/E5e0dsE4bxu
	 tD3ujXShjqnQ5fxmFS7xpHLQyXOK0NuVbXfWJPwO+FZAtyvp34iSYFWy++a9douDui
	 Nl8XJ4EeMmcquBlV/+fu58U/+u64ERgLrMhLgjNkZCqA2Jfqt6T1T50Nqi9dpLHg5E
	 AphT/E6H3dngg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7350C380DBDF;
	Wed, 12 Mar 2025 22:10:18 +0000 (UTC)
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
Message-Id: <174181741709.948527.2776315216196839401.pr-tracker-bot@kernel.org>
Date: Wed, 12 Mar 2025 22:10:17 +0000
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

