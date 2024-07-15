Return-Path: <linux-kernel+bounces-253180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC12931DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A019282A61
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B7E145B23;
	Mon, 15 Jul 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg/1xmjN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA7144306
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087784; cv=none; b=Aky0djbtFirEmlVOD2/IvQXJN8ZyoGNDKomkcTaPsXcd8p/EOMpYjrVHYLoicbkqdFkQyIMttmT97zmrqFvctwLEkGvKo0fvcy2nRf89Lkov8nsqhILDWR6EuxPTb8lgJsaw97vnrIlrGvDNXzOfMaoSSlTQgpjRfuYm4SLabLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087784; c=relaxed/simple;
	bh=7X3BqHl5UdARPlqgMtfN06neQs6oPnIV8thm04QUa7M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b0NWyrHwUyh9azQUtBv7JP8PHOvS8TPEAirtNvh/FN3A31qpID8ZPa2m3g4gzuA4gyYjSLZM9sMPtvqSDEn9y85gi/0Y7i1LB9877EAIr/HgYHDDiiRW6DauZBG8yHYovq2rqwaELJyqggBL6LAIcHI1u5LwhKC7ztd3jlTfBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg/1xmjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54D5BC4AF12;
	Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721087784;
	bh=7X3BqHl5UdARPlqgMtfN06neQs6oPnIV8thm04QUa7M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kg/1xmjNj2MuI3MiA8M1pHW8PUSByEABo+JsPhujDWDHeqfe06IxqPI0jhYsZwLLl
	 fjvbj54emfPXhvoYEj7HgkMEF55oV1KAXSS6ETxt3U1ia52iyrno/bjcMFQotCbH0y
	 HfNzso0ALYSAVO7FGKN+bmgL+dRE50++rj+mqXR1HqNEnCVNk1NKoB2bza0lex8xKD
	 nPi662fSySNECNfEu0pv6ASBtyy0+jWzi/x+tkxAA7mBnaSz+K6Vfknl8FpvUGjtzW
	 LjIVsDycrowDdbM9NrXG2KTK68645z5VZ9odQsstNJhwPqVA+opVQRUH8Ng3Wbzdl6
	 S7pEq7Cg+phhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AF89C43443;
	Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue: Changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpSo08Nd3QXNFK30@slm.duckdns.org>
References: <ZpSo08Nd3QXNFK30@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZpSo08Nd3QXNFK30@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.11
X-PR-Tracked-Commit-Id: 58629d4871e8eb2c385b16a73a8451669db59f39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b02c520fee6327eb4b25696c5e2d6732f362213c
Message-Id: <172108778430.25181.9069671230372598038.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 23:56:24 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jul 2024 18:42:59 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b02c520fee6327eb4b25696c5e2d6732f362213c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

