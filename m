Return-Path: <linux-kernel+bounces-189546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7478CF177
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 23:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085201F2120A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 21:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2329128807;
	Sat, 25 May 2024 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuABswg5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419F126F06
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716673204; cv=none; b=kZo1dxSUkEBiqBAJZLKHV9xO7w7rmM2whejafOzDWZDm9Th3mgkCOH54vu2q/mfVg89j3WXDUa0ZKrFGdIgBBYnHPu4UalXSeGVrwzyn9YHbyy7+NB9O+wD6OmdlzkvTO2Ol6PXNL4wRTVtn2iZPycoAJpS4qZPPRFFSihjr0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716673204; c=relaxed/simple;
	bh=KV52ZhxbqJse6ae8DzuxkjARLXbzwz5HC5leBFKCEQY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OZ9W8yNLaL+VlUV3mOj+Wj/TdVwYkiVcyxhZmbsSeIt7U63a8VL+M+N9mpGRbS0IuSBBrelgd+Y9o2pVBjRcBvGZF8c/0qlLTv9zpshYFIpI4OO1JY6M5gFHwHQk/esO22LlDCqMX/6HisB+EAt2eZSDe8/xSWkusfuUA4Fkyxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuABswg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B74E0C2BD11;
	Sat, 25 May 2024 21:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716673203;
	bh=KV52ZhxbqJse6ae8DzuxkjARLXbzwz5HC5leBFKCEQY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HuABswg5hLSY+KpCclVoNuaau+I2qPut/p1zGkv8w2w5gCtJjdgL21pfXmAywyXcC
	 hofaQ6eUlWybFH/hglMpqkwiXX2DXnN1L/eMN6pn3ukCrddqJGs6ePOro0z9a/84Gq
	 fC+T7Ls653BUkqUybEIArG0UkPPr2evS0udDvJ2uITqs1wQ/eGr48tja0h3E7B9VJe
	 irnC9lbLIctF2+expZGA5sa0qD8qjF4OXmrnkKexhsSlu9tbrbKj5u3Zp+C4r9JTvK
	 TyFf0FcKubNTsOJ1Bcvh/LyEi1ydujYFIVP+4OA0Bx0GZpL23QPUthfmI1//QvTqbH
	 hpuOQd5jGmvLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA633D38A6C;
	Sat, 25 May 2024 21:40:03 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkJhmhatRHeKuIfE@mail.minyard.net>
References: <ZkJhmhatRHeKuIfE@mail.minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkJhmhatRHeKuIfE@mail.minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.10-1
X-PR-Tracked-Commit-Id: 999dff3c13930ad77a7070a5fb4473b1fafdcecc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56676c4c06f19215fbf8b8813c73d63c986270f8
Message-Id: <171667320368.28930.11276330148537822120.pr-tracker-bot@kernel.org>
Date: Sat, 25 May 2024 21:40:03 +0000
To: Corey Minyard <minyard@acm.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, openipmi-developer@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 13:53:14 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56676c4c06f19215fbf8b8813c73d63c986270f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

