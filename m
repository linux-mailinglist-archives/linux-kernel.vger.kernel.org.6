Return-Path: <linux-kernel+bounces-256827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9102D9370F5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA001F21ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F63146A8B;
	Thu, 18 Jul 2024 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1QBjOZh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337D146A6C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343975; cv=none; b=A0el42f6LxCi5sfYhcGWEcJW7+n+9aqAFupJ+mUbu7i+OsJry1iOxi92OMzpGI6Y4tDWk08qD8kvYWn9wXjp9Pg/EYxlVUFHG+Qq7zhkB2LduON0M1e2dcD0YLoNuaXKbx6LyfpJB4BlwV9PGxo5gn8GpsJR5Kwn4h673ED87w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343975; c=relaxed/simple;
	bh=ZqSK4H9tPG+09T1GF6JsYegTg+HFKrNbahRGvP7eHkQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fFJnY2CG0cd53g3FfYj7zMLKdIsgpRXI5O8oTERthmgirTGZf7PtLUtLBSRubh0G1JuoJVi7wdz7b9pengbtPhEi992Z0F0effdDqbENYVU/kmI1tdV3rDbFSW2+R3703y1bze9Ee8odcfRcgr9nBGSzXd7Ucnn9SAGiLyB5t3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1QBjOZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E4A6C4AF09;
	Thu, 18 Jul 2024 23:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721343975;
	bh=ZqSK4H9tPG+09T1GF6JsYegTg+HFKrNbahRGvP7eHkQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L1QBjOZhZ7JRgxbH2VZl/9wEUhcvo3CaoiYvZI6GYRtRb/CapiUJlHFmGFpVjJU7O
	 A0DIKhlmwfmR+j61x6koZcx0EP6krZofI5tuD+jmyCP2FcuxZFs2pNEcJwD51HLWXr
	 uUo0PyHckhirgyEyMYZZB1cpg52ds+D85HtxgCJkmvULSlVhPJsRqNliZLv/FMrMFI
	 tgoc8MCSSwHwJpEIIc1NN6LZkTKGFoGOHt+H/LJgBRzMH+aR+CN7D95XEfzalIV8Bw
	 Kz0O7oa4X6lW096E7yrsIlZ5hTllg7Da1mvri11+qIdsqsGT04Jws1k66IAm0TtogG
	 HmI4G96MEy6LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13EE4C433E9;
	Thu, 18 Jul 2024 23:06:15 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: updates for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zpd_luVnhT7VZz6v@kernel.org>
References: <Zpd_luVnhT7VZz6v@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <Zpd_luVnhT7VZz6v@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.11-rc1
X-PR-Tracked-Commit-Id: 9364a7e40d54e6858479f0a96e1a04aa1204be16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2fc97c18614f99179700be263ecbc667c91a4e8
Message-Id: <172134397507.16085.9253120185293670765.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 23:06:15 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, James Gowans <jgowans@amazon.com>, Mike Rapoport <rppt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jul 2024 11:23:50 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2fc97c18614f99179700be263ecbc667c91a4e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

