Return-Path: <linux-kernel+bounces-318081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D34596E81D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E271C23377
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BE03770D;
	Fri,  6 Sep 2024 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi4hRffK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C681EB35
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592807; cv=none; b=bzIQlDgaMjTPmT7hTO6XwFVBT5VxcwL9CdqEupZOyjaFfpT+VLTRMLX0BPAlCT14w9VdvSOTWA7ghLDsiVMd7hC+tl9OlP8zPViZL/hynPsdfIy1ah94VrsUITxQBgRE9YppDYk9StNsfKc+8Noo/Xnlb+tdm/GhXAJIbkbSHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592807; c=relaxed/simple;
	bh=L8fDPkI3UaHOmQU86B+AfHf13q5JtjFif3c3airuw6M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HjeJO5O2pRCg6+81WVPKuk+oS6WRLAeqz5UoRMXLRm9Ds9EjqBuRuWJHS/Or9JNuIsJrn27kF4H9wCoqiPexGHi0hVTCUlNmzzY0nLZL6mmO19WOdYX+HH/IyQxyILEuS1eMIbQn0zBZK4DfjRS/HkuZ5ovSprRBdRsSx9to/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi4hRffK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77841C4CEC3;
	Fri,  6 Sep 2024 03:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725592806;
	bh=L8fDPkI3UaHOmQU86B+AfHf13q5JtjFif3c3airuw6M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pi4hRffKdiFoKH88I0Qn0Wxnf7FmD8+CA1Axk8lKlbHXCdz60dymo6wCoh+MfjHrH
	 OaOyffbuYGlSz/4r9NcKjZGHVdFim+wJkEpRf4Vn0oyZecNBfYfTeVyCHQTkcx21Qv
	 quCCsdiXZJP8Wx+QVMwKTqB8Px5Kx2QOa3ypFG6P+KUcgeaObUoU4ag3RdpqEmNy8A
	 rw6rQL9RkZTJn1lAHGQ6o3zm1Ekd/AC9e1GVn4ojAxVOdswqmxowFRj3/NU64SQs1x
	 RFqGdZLyXlhNc7ho/wZrRfa+H2ucDWY+9+f6WdE4PwTJh9m6GZY64i+BmxAP00ayRf
	 FudbGpt/5IFhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 68A643806654;
	Fri,  6 Sep 2024 03:20:08 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240905172827.6a64cf97@gandalf.local.home>
References: <20240905172827.6a64cf97@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240905172827.6a64cf97@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.11-rc4
X-PR-Tracked-Commit-Id: 5bfbcd1ee57b607fd29e4645c7f350dd385dd9ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4b42053b788a81bfec7455308c5c1ead4a171cd
Message-Id: <172559280703.1917326.17192883848925529631.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 03:20:07 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zheng Yejian <zhengyejian@huaweicloud.com>, Tomas Glozar <tglozar@redhat.com>, "Luis
 Claudio R. Goncalves" <lgoncalv@redhat.com>, John Kacur <jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 5 Sep 2024 17:28:27 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4b42053b788a81bfec7455308c5c1ead4a171cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

