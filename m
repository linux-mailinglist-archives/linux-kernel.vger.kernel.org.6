Return-Path: <linux-kernel+bounces-264256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8105593E0CD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C796282174
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAEC187856;
	Sat, 27 Jul 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7WtVr2b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CD5187561
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110843; cv=none; b=sXjmThydfyz+d8swov24+BzaGtQ3KcV27H+tDW/gd2JMtltoTTtq9e/RwcBJnh04ET5H5bU9XgfOdk+jHD6iS1NPXKVdjX4tn6XkycKTSI7Eaa6EQUxWqcY/NGxSD4bxeP6MNC7xU9TvC5qpr3FDLTbYgTAEq8JMK4brBSdwCT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110843; c=relaxed/simple;
	bh=HfDokw1KeliRJ+D0UChjNqu3r8C12KMGHI/KXSmySw4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J14p1+j6MFwqus3xz8Dh/uX3cXeExx3IpYa/SqcXuKuaV5YF0o2ZHCkijw2w1VrkXiv/XCHGLhaHD1YJyX2vbI0dOaCqq/u68emv/YEhPTysf3NCR4OGmPSZZ4W/VuSj4IvJGR2mevdpp/QcGOs1v466RHgUlzZFg/RddYa/ajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7WtVr2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45571C4AF0A;
	Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722110843;
	bh=HfDokw1KeliRJ+D0UChjNqu3r8C12KMGHI/KXSmySw4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T7WtVr2bZjHY7lwd9MpzpEo1UY3C46cRiAg77mFy0pu0yp0DjU2QybUtSqhgKW7F6
	 RL1pwEqsdogAjDAC3gswCqICEp4szih7qL9lK3aqmz1s3FIH9G92D2ajl6hCJsKBuG
	 VQ4sC/tNwvT4dbLWL049IWtRBhvtFctgr15/L9JNBJdzWJoOc6zJVlkf3jO75p6xQa
	 gaC19wwe0jaLKdmWVKcrA8rxl4ir+nBsHIVvYXyJeOFWRPDBZLFe7br1e7j/mWDCLC
	 5SbmpytPJSV/lHkQuFfkcCQqoA1/3naAUcNCARY7nTwmDstvb6eeH4//aBEE5qmy/S
	 CD3qxMwmJlMRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D058C4333D;
	Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240726123924fec081e4@mail.local>
References: <20240726123924fec081e4@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240726123924fec081e4@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.11
X-PR-Tracked-Commit-Id: 24168c5e6dfbdd5b414f048f47f75d64533296ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c85e1497dd10879f447d6a12f97762c581093e9b
Message-Id: <172211084324.16614.3773917655928475321.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 20:07:23 +0000
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 14:39:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c85e1497dd10879f447d6a12f97762c581093e9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

