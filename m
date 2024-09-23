Return-Path: <linux-kernel+bounces-336365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D8C983A31
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2EE1F22918
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227CF15884D;
	Mon, 23 Sep 2024 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhMh7tHl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B441553A1;
	Mon, 23 Sep 2024 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130893; cv=none; b=lVpiAHv1C7gKEQamyelF6t5wryleH3NK5RSyhzjaUsL8C/U7myeGErlP/L0kBxM+dJ3TwGViTR3nfOC0OECi1OGuVm0yz+eJdWSqUGLTfcSAPZRlzRFD9/V6qKul/5+VCstNr6QYrEGaq9C7g2xFB1e2TDVJxceNeQvgaw4hh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130893; c=relaxed/simple;
	bh=xU4bii3jbR5ofF0oZImLG78/3mzj5EK9lhpf3Jpr9JI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RoduvsuWYdUaaVA+j8nZ6R++XYtv1m2V3ZHNmXrLi5X2cqQpmRzYnNAtfsEm55nPJMskjc8unjGib8Lrkg20QXNep1ovrUkrQyUZKxoaGxXxbpHkPaO4+F5t3C3uhVnaP/QIYT3QgJ2kdyr2LOwsYXDYzQAtZ7v1qn/E8m8sHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhMh7tHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5959FC4CEC4;
	Mon, 23 Sep 2024 22:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727130893;
	bh=xU4bii3jbR5ofF0oZImLG78/3mzj5EK9lhpf3Jpr9JI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qhMh7tHl96bdh7xutYWeC9bJgFrTuYh3CwXAHXYDYJnKaqwZw9OvUpdYPil4EAqQd
	 fcOYHTkIgbQHgdKgMrhLvQfOIP9WjgDLs8QqAMXvL1T8nDWZ1b7zNpV6jzyZGsJQIw
	 ZoSmcR312ZDXUb07Ov0yWePEbiVKtj7nVJ37GdcN4VmuBAW2lFmpMWqAanTgofsedR
	 4jT676S45cQgWpGR9HQwmwpGM+SU7QbeLpG1p9mxz+RyQORr5uSEL7fLEXOaQrTVTn
	 M9gO1ZIuN+T4nPi9VBIm/Ft014q/KoeHA1WGntN6qpbhfL9+N3P6OZcD/VWVzJ/VtU
	 uah4kckkeFTBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0633809A8F;
	Mon, 23 Sep 2024 22:34:56 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240923182958.818256-1-sboyd@kernel.org>
References: <20240923182958.818256-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240923182958.818256-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: f00b45db02ae4e0288bb719a9935b966733c7e91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ab27b018649c9504e894496cb4d7d8afcffd897
Message-Id: <172713089538.3509221.460543698981703314.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 22:34:55 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Sep 2024 11:29:56 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ab27b018649c9504e894496cb4d7d8afcffd897

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

