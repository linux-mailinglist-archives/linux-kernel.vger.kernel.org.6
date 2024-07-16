Return-Path: <linux-kernel+bounces-253211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EBF931E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125CA1F2184D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDE32AE74;
	Tue, 16 Jul 2024 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSeGuuBK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877852374C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091132; cv=none; b=BvU0XiEbfNCvBi748WxTQOn9+IvBupyVz4BTgwW1Y4cd8sJ6Atr/am6Vx0cJSzdB285/EOv/lwzjpZoBXpyiUzTATZG4FPX2RO99YMgB1f/lsyRppjKHvPPl1Xxey6zwPM71jA4klrjq9rB2fSvt7NQSaHjTZ8+GLNsexWXLm2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091132; c=relaxed/simple;
	bh=cdzkPKk9UuKKKzHvQiAki1qBm+07o26cQTX5wMEMWwk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VmveLHZdh5M3bSJIzyy2gT/P5pWq7f+URAK3LAMazjqRSgU++dw0FcHQp371nJ8wL/L+fNkhs8Yfg+975PrtPFMQpcGDWdvrwxJcWZ240AgtC4stxtVC75N356nbISSS5jf2Z0VZh36JLio/5OH+wXoBKms3PjycRrcdtOLv4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSeGuuBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3085BC32782;
	Tue, 16 Jul 2024 00:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721091132;
	bh=cdzkPKk9UuKKKzHvQiAki1qBm+07o26cQTX5wMEMWwk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DSeGuuBKQHaTf+/wjGzvO875seQYTRx96enFeUy1lmlkae0BIEqICLxSqkZjiDQFm
	 JpTI5ikrl7M3YQuD4vF3NAy7aUEjanBn1dIN47qhj5laqhGZH/SnxC8s00YUS4ACiW
	 76Y+lcOdYPAwEPe54oA86EYw1gZx+NhlfJ5dOtApo2vmSuDZdKgIgHEl8UraBU8OyX
	 43SPUMplt5VN0F5jJi7UzBbPrWrZY/b3P7Ja1t44qnvYghR4Uh1EnBbDBESpXf9zgw
	 GsGe4ksZK/ogaNQ/ZVHVoA5yJxlCbNKpclVfY4rMzSDnulnEOcy5iQY4ryvPYR/mp8
	 M+DL4xPyTQG5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27E91C43443;
	Tue, 16 Jul 2024 00:52:12 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue: Fixes for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpW7N55a5usrGoVw@slm.duckdns.org>
References: <ZpW7N55a5usrGoVw@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZpW7N55a5usrGoVw@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.11-rc1-fixes
X-PR-Tracked-Commit-Id: aa8684755a283536bd8ad93141052f47a4faa5a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8764c1931a4c91b9b53ee183757f70999da2bb3
Message-Id: <172109113215.26590.5372007395635327280.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 00:52:12 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 14:13:43 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.11-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8764c1931a4c91b9b53ee183757f70999da2bb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

