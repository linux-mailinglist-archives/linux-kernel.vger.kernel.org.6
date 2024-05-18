Return-Path: <linux-kernel+bounces-182969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B308C9256
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E7EB212A9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 21:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096DF5C613;
	Sat, 18 May 2024 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxa/ITWC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A285DF78;
	Sat, 18 May 2024 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716066361; cv=none; b=lZy8ou4C6LomBz+M1yHJDwzjlYtOJKS9FncBEXpxPrAyk94UIShGbKx2gZ5BudMypQLbVP0bJXpWZg9+k42cH/VWlGQqdbFOioptajXlVB8YJ8/XjwOIExNejUPOZpStdzZOT5Qrhm7tWCn7Cxd0hvNz1BxXG0FIzvF9aeaWWLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716066361; c=relaxed/simple;
	bh=5oJp5eARjxirMLpahlFSgRk4jppjlarQaWWAiqzHi0w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CerTxGnVf+Az7fXzOJkVMLYUUZ7C30Bi8W9AlueEP70fpm8OucDcoYKq77p532gZQM3PG7GwZOu8WLHFxPtd4+uJpLaIQ8w4r13uLYUrGITi8bp15d04DI6mzdJmjYJm7IwS/tr34Fx8J8ypvmR4ekiJsiz0JHpB3KqqYGc8FSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxa/ITWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C393C32782;
	Sat, 18 May 2024 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716066361;
	bh=5oJp5eARjxirMLpahlFSgRk4jppjlarQaWWAiqzHi0w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hxa/ITWCwivOPxtikhoG60eT82WX6YoLsrRmuvqvnaawsBI/DFV/GUQgiIIducvyv
	 D0wi89j7IhJkqPnPgpQ5ffBvOtF0LiiS9M2/iiWVhOyQhgUcdYPKZioj3HpO3N7nd/
	 M/Az18eBmeVIbVZ/V0To6jH+SoHwr++clg8FPPeOOvR9aTzxpKWvnggBLxguwmVJko
	 wuq69kcQ+a8l6WQbGhpo4hQvE2CjUuqpUF3P4kwEpBRdhWK0py6HcvfpEdu+zYvcsl
	 hHmntweZlJgIzDqKi9Shklkg2i8xfF3FloUts48tG5XrvyLy2+Bun+PX6xQo2MraQp
	 3F5pTABC6utTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23F70C43339;
	Sat, 18 May 2024 21:06:01 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240517013155.1095253-1-sboyd@kernel.org>
References: <20240517013155.1095253-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240517013155.1095253-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 03be434863b9606435be9ef43651d4c0cbbe6788
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 619b92b9c8fe5369503ae948ad4e0a9c195c2c4a
Message-Id: <171606636114.2260.9243449844507321685.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 21:06:01 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 May 2024 18:31:55 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/619b92b9c8fe5369503ae948ad4e0a9c195c2c4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

