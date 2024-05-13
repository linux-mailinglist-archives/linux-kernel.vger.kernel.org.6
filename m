Return-Path: <linux-kernel+bounces-177898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6B98C45FA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA441C20CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8BF22EE5;
	Mon, 13 May 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq5YaLOZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CF020DE8
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621279; cv=none; b=A6ZrIefVIUAZlGTZVzG+su5o+6xjn5nAOLVb0rzcVySoCq20B8jHwUQtzrFGfFgDoRUEVm4jp32SPud59GsVTpBEnEMPbKMWzmG6mb3DthANI5G/jgGMSJXdo/CyAaf9ypDLwPC+wZwacqvL5HupNLgZ+afwmPVK6Uoo4qIo9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621279; c=relaxed/simple;
	bh=xtfDumXXQ5dXj56673dFxtzAYm3DwRlPuS1OLardQ1s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dJJh9WKPAzWNYbYDYvHIOp6U2ukVORmqsOMmOHYvRu5TWfBqfe+E0q17oh9XQasfknlf1KgySV8AGYAYzkZ2IB7vc+NmPwYZCS7D+E7llRSXOSHg5NRm1sGUj36BrHf4np8tiXLrGx/OgmWQW3PCFfdRF3tz36lo/udDN6q8iSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq5YaLOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCCBBC2BD11;
	Mon, 13 May 2024 17:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715621278;
	bh=xtfDumXXQ5dXj56673dFxtzAYm3DwRlPuS1OLardQ1s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Zq5YaLOZNX+/1/GBqciRu0Wj8DJpBsScQVz6EkZpCMiSTerBWB6xi0VQ62bDzxq37
	 rMQGhyD3INopmFHvrNZqgFJA6IWKcB7TUSBlaVm47/XU7ZDpa8Y03skbAcVDCoxWk1
	 T0b1gTaC7bqceivIiiyiwLO2teQmWhdx07MAUhB7o0L9eY6l4BeZ2PR23i7oJ76CNH
	 Siw3oYBXpq2OLFZV6iSWW2YhqUFECVensanXpFvsEG1sqY0awZlX8SfR7/ZXtC/zKI
	 cshEMkF3yggrf/H1JGtNJ0KmS0w+SGII2F6ffIEXHgltP/2Zsncfr8Q/OmbAyeBYF1
	 LE/ZHz9S5RWjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0EF0C433E9;
	Mon, 13 May 2024 17:27:58 +0000 (UTC)
Subject: Re: [GIT PULL] KCSAN changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ccdfb04f-9d2c-4033-a29c-bb9677fcbea5@paulmck-laptop>
References: <ccdfb04f-9d2c-4033-a29c-bb9677fcbea5@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ccdfb04f-9d2c-4033-a29c-bb9677fcbea5@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2024.05.10a
X-PR-Tracked-Commit-Id: 31f605a308e627f06e4e6ab77254473f1c90f0bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c07ea940a011343fdaec12cd74b4ff947ba6f893
Message-Id: <171562127877.25347.11798495440341857877.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 17:27:58 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, kernel-team@meta.com, elver@google.com, penguin-kernel@i-love.sakura.ne.jp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 12 May 2024 10:33:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2024.05.10a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c07ea940a011343fdaec12cd74b4ff947ba6f893

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

