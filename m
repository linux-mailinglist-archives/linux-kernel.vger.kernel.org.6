Return-Path: <linux-kernel+bounces-236683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A6891E5C1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00C51F249D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D2D16DC12;
	Mon,  1 Jul 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nETWEwBk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A116DC28
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852583; cv=none; b=R5okjz9DeE8CTkwB6P6q/bvY7v1I765DhdUQtrD/WMYToGdATTSKAIJBkejWmzoZpoUsN6XD61P1iajo+I8xWvVigNQRdJnaAw5x4JPLrchGMnfYBQFR0q01bcB9YgkCjQJQkdEGaZjcqJvUUMuu72LS9y3fgOt1uriOJ7Y/rLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852583; c=relaxed/simple;
	bh=aIy8w2x4i39X1sEGi7Yo4OKtvRgd6sbGVj+X1IPp9hc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZNog11zlYlrxPsnv9p4+9lGTU0XmqrleamLY1R8dOu22xKmJsIDFj1b3xxxAcMZcjWC3FedSOlcC4QDaIU7GY2jw9+Ij3t/uY8bsNCQhzpN9U9X2H+qoEcjqrinmVi1o1LvER//931yQsAWFkhLJ/XbTiOvaZP6KEyB0G75p0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nETWEwBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A27B5C32781;
	Mon,  1 Jul 2024 16:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852583;
	bh=aIy8w2x4i39X1sEGi7Yo4OKtvRgd6sbGVj+X1IPp9hc=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=nETWEwBkViETCOMRbr/aNo7rsET1W64vQHQtv+ftwAyUJBEZHiWsuOqlpLZGEnqUs
	 Ftjr3NrZwGFrRVU4A7kftk7Eg3i6C/ZTjWhIbadpx1/r+RwzBJLbPCiEPKrwTvtQJJ
	 3nBag6NIkXcqxrPb7SrJ++lv2Q6aTFnrzY9FmMEeJXtUp3t8T/hy2DZw1YzFPIuG2d
	 QqBcq5Gb3EKG9gerEY0cLHwtNyaQCxdBrj2pLCcAkYg+CIXdMhe7kUF7v/xWbqxYAg
	 Ny9MxINsXsZoOKsu5gYOgCWySey/ZWbp7X83HdsW7T6UTSIf3ejBmup/ksHSkrmz3x
	 +h3qdvlYk4/gA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95DC0C43446;
	Mon,  1 Jul 2024 16:49:43 +0000 (UTC)
Subject: Re: [GIT PULL] SoC fixes for 6.10, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <3040c98f-940b-4380-9a90-dfcae18a47b6@app.fastmail.com>
References: <3040c98f-940b-4380-9a90-dfcae18a47b6@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <3040c98f-940b-4380-9a90-dfcae18a47b6@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.10-2
X-PR-Tracked-Commit-Id: 07917ee08723e6c46074a2655a380126acee3898
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 651ab78190e2e4817eb6c21bbc5b4119c2fb34f7
Message-Id: <171985258360.24381.15874330138736099680.pr-tracker-bot@kernel.org>
Date: Mon, 01 Jul 2024 16:49:43 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 01 Jul 2024 18:00:20 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/651ab78190e2e4817eb6c21bbc5b4119c2fb34f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

