Return-Path: <linux-kernel+bounces-255860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3889345C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBC42852C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FDF43172;
	Thu, 18 Jul 2024 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq1KR1mx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341312E7F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266039; cv=none; b=WSwJQzzlanzGI4nxa6UaLjqwjhw6635MRh4ZFn01LYOIv3djF7X+G9aUiGVrFwmIBg0wAtBLhJ+WWHGq48+CGRkLoby49RqpQx0QrIcY2AnuWv/Dw17QprI4wboEV7pgg+bD4CWbvmjsnkypcBagQt1Qcfh8Nt3W53qusJYKKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266039; c=relaxed/simple;
	bh=1SFfEqRl7wFrpBl3SQFysU69TikxJFngWHpWpRWmAHU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NOc8pzkB0MRZR63oq53XQDmROMNbtTtpwgb2JcH4IYv4RESAky5OGZDPeqFBeolWdBL7NhsmDgkA+KqumoVBDI15E59yZykrC5Q+qxoFG7sfdvz7QSBSzfCmAcGQ93Stk1VDGXAGP5mGlTjUMFpRUzZJMWvMpwrvzV50Uvzr1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq1KR1mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA68DC4AF0C;
	Thu, 18 Jul 2024 01:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721266039;
	bh=1SFfEqRl7wFrpBl3SQFysU69TikxJFngWHpWpRWmAHU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Uq1KR1mx/jej3//r0UcPlGi9yj5D7/EoODHxaqNXkacVROmkpZiI2puHThKt/KCig
	 FqX+3tLjnoFjkaW5yqHzmGscJDSEKtXpOpLTa5n1ntHNBzdIhyMzL7Czi5seKkqmKJ
	 spB9WF5plCyihBHQkn76i8WM4vGy6r3lGTeC+K24dTL1/sGzlVeRkGtycYtnS6BYn+
	 4IeDmrlLJwgCgxjwj0xS9jUOy76BnAWWrGmaqDEb1vzvDPednyRCyT9XKQ7nrbI6+5
	 GsXuSjcFxkxpshMvTP20PLlsPxSXWItBGerbbcSRO3wkMc3caGzpd9LGIob4FveXdP
	 gy+cECLL8pTwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFB88C433E9;
	Thu, 18 Jul 2024 01:27:18 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <uirri5bsktq5pk2tu4gs2u22qimjcn7hi66ek6gbj65qyczfex@yjy4brkoixfv>
References: <uirri5bsktq5pk2tu4gs2u22qimjcn7hi66ek6gbj65qyczfex@yjy4brkoixfv>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <uirri5bsktq5pk2tu4gs2u22qimjcn7hi66ek6gbj65qyczfex@yjy4brkoixfv>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024071601
X-PR-Tracked-Commit-Id: 30b866413e7bdd507a79854b5931528d3f6f438f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e504d2c61244a01226c5100c835e44fb9b85ca8
Message-Id: <172126603891.24030.11746539300178763384.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 01:27:18 +0000
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 15:34:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024071601

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e504d2c61244a01226c5100c835e44fb9b85ca8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

