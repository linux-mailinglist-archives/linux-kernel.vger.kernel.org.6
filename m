Return-Path: <linux-kernel+bounces-416205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 495319D420B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D49B2388C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEA51BC9FC;
	Wed, 20 Nov 2024 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9hf8FrP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0BC1BC9E2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732127512; cv=none; b=SWt2VCoUAsIEjJX6Y4j6Bp37ghMBhaGsCSlXzVHyxpW3STJvpRIG8HVzDmfRr0chnwojcMp224/mb3uhjvWFMDIOmDP4D7k7163v82yefpwuUjcvzkm5QL4e3SFgbphw122X7QgpALKTslZpkEzb0vYtWZ6vvswTQWesKHy/ESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732127512; c=relaxed/simple;
	bh=owy1z4JbuiVnZZOJCXM1lfEp43YOJg4p8KeqZ+sxsOE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kUiAQq/HTK/w0L/BRyf0GCQz4ZG09PzTlGfTG5jXZ4Yp7ttaap8Uy3U1K2b41jPcu4lFHco2SPKlXEwx6fArl5pSXjrl2F5BBiohoA7n8MLRThY/mbCZlY6WRVvTfJiU4I/zKdLFzG6tR0CN9ZKKLS8YEZbKGimonv2O/msEQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9hf8FrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D58C4CECD;
	Wed, 20 Nov 2024 18:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732127512;
	bh=owy1z4JbuiVnZZOJCXM1lfEp43YOJg4p8KeqZ+sxsOE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d9hf8FrPkjYcOWPrp0rBVl90dQ2xrF86SxTNvOH5LfLN1uH7EumQw5IQ5RCLGuLbV
	 kg7QSs62xZYxtW20qc5gHmeEvpdWimOJak2pRobtS/QcWBdoN5XBwgfKtCuTtusHUz
	 qoqOaFYsHJuio3zPG7J0+HxFFLMRkM9O6jD3G7kdA4CE8SoYtKqIVSAh9y3mn7PBbt
	 /oE2qzhPAjaZxLQtEDrcX55CDC/ORdVLvw86lQ6tw6+78AhjTwq2eQISmXwO2BvbTb
	 I1+dcfvWQAdXzsAEgDrUNeMnZgcJnZMdrT5j42RHWieDN1eUC/rELQ0xvQ/UGfwSNC
	 /Gujwbg49lDvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D073809A80;
	Wed, 20 Nov 2024 18:32:05 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118143016.c94b7c8ec5d9ed8ae29a66d5@kernel.org>
References: <20241118143016.c94b7c8ec5d9ed8ae29a66d5@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118143016.c94b7c8ec5d9ed8ae29a66d5@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.13
X-PR-Tracked-Commit-Id: 4638d7ebeff5a741e22139cf00aaa9db0f668a8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0e752bda210e7ff61c37ef3f7898bcbcd2693cb
Message-Id: <173212752415.1310468.988510739986538063.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 18:32:04 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jinjie Ruan <ruanjinjie@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 14:30:16 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0e752bda210e7ff61c37ef3f7898bcbcd2693cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

