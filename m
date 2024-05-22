Return-Path: <linux-kernel+bounces-186676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E150D8CC765
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF971C203A5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA8146D7D;
	Wed, 22 May 2024 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTPQES5R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0268146D45
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406698; cv=none; b=kdWI8MnqmNy7vNtACULIQmIJMFR3idsChKzaMn44yV+YVymOMcgtWoLwZQVs8IDiVYdj+6kwKpl6oC2IwQrCFf38UUIGApx26xhdfVAXTL9qmHKSkcQTIyY5+JOsNsbpDz5nMMPutup5xtsTthIWxy/BWy0INrTQyTIRtppaiq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406698; c=relaxed/simple;
	bh=gsknmzddaovdDlqeVHlI4Ioe7ySmJ3GfPQtWctenp4o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EKdGhPEv3Irs/JMAxc4ASoE3bBgfXR6EeA9FhDpraMLHBVg+jlPPvnU9JcTUlgQ5UtlqC5oe5d8pkG+tiOk6DdIV78nD7uKBXlgG+fcY8yh38kSB/0TKAP0DyD7pOUrbxMXR/fD05zAOs9zKREsCae+mBDOpmWcx1Gc6nvEpLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTPQES5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D368CC32782;
	Wed, 22 May 2024 19:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716406697;
	bh=gsknmzddaovdDlqeVHlI4Ioe7ySmJ3GfPQtWctenp4o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JTPQES5R/IjOXVqjydTB9EuNr2qCuAW3wmeVE9KVEIQWEL2P1z3IfWaSRivPkceIz
	 qhhmfc3scd8R4kCZE4scxFn6BCynNgAK4Mhcdv4jddHkIL+jtdQChveRiRO2NU4H+r
	 ulAc3NicQj3udGpsMXTs5VuqUQ8YJwn0YoRqCeZkjkiaBOApI2RdlrNEHYzvH1Y58f
	 KDXnlqAW9bu3Vveh0VfZrlhPn9u9OLx1ZTfVwYxM6wHUT8afOFnwY4/SBFxtMQgfKq
	 NNzxFRDh+ISdf1eYsdS4xaME0NutM51ljrRrVpGByyx7PphBWFAwF6q9n44bgj/2aA
	 ZybEIt0z/9Ozg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4C95C43618;
	Wed, 22 May 2024 19:38:17 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zk4GetENJdycqIoG@kroah.com>
References: <Zk4GetENJdycqIoG@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zk4GetENJdycqIoG@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-rc1
X-PR-Tracked-Commit-Id: f5b335dc025cfee90957efa90dc72fada0d5abb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f16eb0549ab502906fb2a10147dad4b9dc185c4
Message-Id: <171640669778.20241.4153230340384514060.pr-tracker-bot@kernel.org>
Date: Wed, 22 May 2024 19:38:17 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 May 2024 16:51:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f16eb0549ab502906fb2a10147dad4b9dc185c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

