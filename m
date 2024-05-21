Return-Path: <linux-kernel+bounces-185354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B8E8CB3E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F49F1F22194
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21A01494AD;
	Tue, 21 May 2024 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saRXX5uF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33314884C;
	Tue, 21 May 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716317582; cv=none; b=n0e7ceSBcVLDscEZR75HgPqvW6Ga/+2K6fnRBw9o1lsF9dytH7qXpmJJN7iBT1FZYFBkMl05j/GampbGG43sclZifncP1dKRzZ1K+wgbJEl55qky1bn3oLVSQo1YQTqsdfGKbxMFfyNvA9hTtY4qKjl1mh/23EVnp9SUHSpZ+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716317582; c=relaxed/simple;
	bh=sTB3PlkRtS3vhBocKg9q5/+8qGpg1XiW1+Y2R0WYWx4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UbPPqGyM5zJMH+2PYKCWajuzYw+eA7qBO8p0r43t1SGT1onmow6rOA+jrUzWW6NIgRFyIIMOWxx5aZNu5FS9QsOy5E0U2BMVytbBp2JrnGRRlvHFUVUF+XP3cdVAgcIYUXF51PprFNDnA2MIkYYjDixcbQYvwGUI0OVtiNCcF2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saRXX5uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7A01C4AF0A;
	Tue, 21 May 2024 18:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716317581;
	bh=sTB3PlkRtS3vhBocKg9q5/+8qGpg1XiW1+Y2R0WYWx4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=saRXX5uF/bn0gpJ4sVciBmOZBwDStdT4SCGbppNkIIAEei+QvkGU1ff0XSKtdJ/vy
	 FtfRoDVG98vuvMsWS40dl4IoZjq2MrUjR1BJ6nJrm0x18noiKp5twWwi0lxmW+q6Wk
	 ho8IDqOf/eG3ZUVXqNwRS7Tx8N1KDGqGxileJxVxjrMHlvE5/CTXNEbtSA+MSK72E0
	 DIGITGUmUw1+rsCTBb0ehNmSsWG6+RGRTasPyE36LQcKiGBamIOOq8tdfjg3Un26ff
	 YB6gRgE7LYqoQiS9NRD4DmM80XWtGceHw+dIzVF1DpT5kiWJBTp8Ac6dpFJcc0REBg
	 Rk+yeebMkAI3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEE86C4936D;
	Tue, 21 May 2024 18:53:01 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0irEVCJcq=x6FXEpRh_KW2NwFD6At=2KU-Jc-Qs_se5jw@mail.gmail.com>
References: <CAJZ5v0irEVCJcq=x6FXEpRh_KW2NwFD6At=2KU-Jc-Qs_se5jw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0irEVCJcq=x6FXEpRh_KW2NwFD6At=2KU-Jc-Qs_se5jw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.10-rc1-2
X-PR-Tracked-Commit-Id: dee8f20e61aea655a43b74e5b65bcc6fbc69df7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98f312bc58156a5922b5a496119e3a42b0ad439a
Message-Id: <171631758176.16717.5909166935011429175.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 18:53:01 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 11:36:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.10-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98f312bc58156a5922b5a496119e3a42b0ad439a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

