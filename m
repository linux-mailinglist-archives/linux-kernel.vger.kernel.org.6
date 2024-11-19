Return-Path: <linux-kernel+bounces-414949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6719D2F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17F828352C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDFA1D79B3;
	Tue, 19 Nov 2024 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWl7B/Pf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143B1D6DB4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048533; cv=none; b=eN4nqV2y32+IPhX/6jFvMcyVo8aJOVMP7lOjh+jci1cS/Ay+TV54DYaKyZdd4/P9lEFtm54ETUDaZ02Z51fHB7D2SgwdZnLq+H1RGTk3PstFLCL1rtBYolY6764DjG7WCLz9girYFe8IbdhMXVh0KHbjn1XoVR961g4tHakD7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048533; c=relaxed/simple;
	bh=7bi6u7XkoHgT2+s+eNfCf3Mfg4h1I91IsNEHC9WSY2g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MYHeDP6I4pq2bO/YijzCsYAz7LYuMDupR0z1Do5O0DzpcB4jxGO+WdoPPvN4nT/G3OstboHotQlZtlo8l4OloJc7KhTxWqmDGTwIzb1Nb9qwbha62f9kcKB13+BatndccppmKU8mvRE92is8EWdIG2FZ/k6dnR5weuUN5jb1BTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWl7B/Pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5733C4CECF;
	Tue, 19 Nov 2024 20:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732048533;
	bh=7bi6u7XkoHgT2+s+eNfCf3Mfg4h1I91IsNEHC9WSY2g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YWl7B/Pf5gpBXVFo7BMY7nOGIndcBzxJ1N6jZFQJz0MmD5043qHj9jU+QNKV/Yzer
	 v6eBbroOcA49kmPU+PdnSLqcnEHNBAgqMN/1bgCyl3D0JPJcR2bqRzqzseZaBmRIRK
	 CmCvZh82dP2M7QhUthgRZBhGQIwAXk12DRf1AIhav9bEVCYAMHpsKmW/VZWwTeBiM8
	 ztDeWLjPB+BG5clcEwWKG9VKoZZdT0iza+LU0ypmryns9j6JB2+xUHNULUpW3gnSml
	 UKBrOhEVKJVc39oy3cHmEQmzt5hLm6aWuP7jr/6+y1jYJjFDVYGCi8QHM0fibehD27
	 t0xdOE34Lu0fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BA53809A80;
	Tue, 19 Nov 2024 20:35:46 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118210508.GAZzusBLFPq3Rqt50z@fat_crate.local>
References: <20241118210508.GAZzusBLFPq3Rqt50z@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118210508.GAZzusBLFPq3Rqt50z@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.13
X-PR-Tracked-Commit-Id: f74642d81c24d9e69745cd0b75e1bddc81827606
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8d78a90e7fca1ce7c90fa791400b287bc5b42a1
Message-Id: <173204854503.680579.1574114023155546458.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 20:35:45 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 22:05:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8d78a90e7fca1ce7c90fa791400b287bc5b42a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

