Return-Path: <linux-kernel+bounces-323427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE96973D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AA81F2204D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85BC19DF4A;
	Tue, 10 Sep 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUW5EXG4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2564139FC6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985559; cv=none; b=toeAt4HyKBlJsyCWxutshSqyjyQ92GISKe16HT76l+kGM+4V4giFFLHDvGdRN6aeIVPHyeueCUrVBPi88mFuMg4wlIWwbdNL/3ESxuZs1WfCt3gtjQIodVstldd2+7lrG32TPXBuVg4G8/wx3KRIIzjbHBOsPfHeX5ktC8CY6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985559; c=relaxed/simple;
	bh=ZmDOCid8pwzPm2iiFaQsIWJS6V0DSePxW5vLHA6EFPs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dCgEYDCofUD55wyYL7NERyNPgFsfTqYh06wy8CGORBO6zhZWTnwvmGMCxnydM4Fx72QUv+N1acQt/8XwwH/QpFPod/QERE1P7gXkxvq6JhQ07q4bMSeeeJYhY/ABD18O0kTm3UZK8phAf8m5ploHGJufEtWG8qdJ900jDGvtsX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUW5EXG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D4BC4CEC3;
	Tue, 10 Sep 2024 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725985558;
	bh=ZmDOCid8pwzPm2iiFaQsIWJS6V0DSePxW5vLHA6EFPs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GUW5EXG4W2WlssEAvRuLxN06hP1RQH4+pBGoWpmk/0VQ+O7ts9SpSuhpz4suGr8uy
	 f3iUEQ8lD7o5jHmDQza++F27ny3CqxmGv4qf6OnX7+FBaXM50JNPu8E/6FUsZvmfTE
	 L0M6/Xcp66hEj7vMJs6tI3iuoBf/6/XF6nPlErNglLR2+MYTiBAKGjGYicfTBvOowW
	 iox2O7EhBMzREmTShHL4FI7aSwQxqwoHkib78ywQcvL9hChLezNsraVptTozenxRny
	 Zyzm7V810YvWyrl+chGhPsagxENumBc0ryVP8M1uPM202Hxwc3BGTC6yW/kAvQqoPf
	 cG2edc8tOD7kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB32A3804CAB;
	Tue, 10 Sep 2024 16:26:00 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: A couple of fixes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240909161454.1d79e239@gandalf.local.home>
References: <20240909161454.1d79e239@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240909161454.1d79e239@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.11-rc6
X-PR-Tracked-Commit-Id: 4e378158e5c15bd237a6ff44b7abb9184d61208c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d8d276ba2fb5f9ac4984f5c10ae60858090babc
Message-Id: <172598555948.313072.12707113535902937711.pr-tracker-bot@kernel.org>
Date: Tue, 10 Sep 2024 16:25:59 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 9 Sep 2024 16:14:54 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d8d276ba2fb5f9ac4984f5c10ae60858090babc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

