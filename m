Return-Path: <linux-kernel+bounces-574727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA0EA6E923
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B87E87A4E88
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 05:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965731A89;
	Tue, 25 Mar 2025 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg4GDNWb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70C6FC5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878956; cv=none; b=V1/b4VXvqM9zaY1LA9vo9sbnuP9J/SY/Xw0ibQTaYnH/wFqF15WUiw5Qw09gZNSiifDxNJSSsR6mzG1s9CgQL4y7idmMlrd8625PSAc3QH6MkxhmH9i/9eVMII1N0jm8mEHSSJVj0AhoaZ3mzm1oy2ubzenxLuSXFjBMDnROwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878956; c=relaxed/simple;
	bh=l4fe6UUdPhv4y/b6SQuNoatD3cca99+Lr1ibIfVqwVs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ebdth3p61wMJ4X/CrA3U2AMZDz+0W5gPM9OBk+zJtH30Ux+UkJLhUnzgvDMQBn4hxEaN6WlZMCKybR7/MrpvMDgSfDn0zNwZH0mlPFrJo8NaZbaOmjd/AuQd+/f3Uu7D+MyJsKVLvFvthYXXG4KoMgTKhFkBm4OyRLZUtHEc4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg4GDNWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C465C4CEE8;
	Tue, 25 Mar 2025 05:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742878956;
	bh=l4fe6UUdPhv4y/b6SQuNoatD3cca99+Lr1ibIfVqwVs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sg4GDNWb4H7eSvAQZ0IcR1OTo1Rpj8BMkkMF51HYdQQQdRBI9AcLfM6WHk3THIovC
	 D0KEp8mXrQCDB7hmRHAvJ0aww5pj0aRpFZR5iQ8BS1nk/yojvjfWEMg4yiqzp5TR9F
	 LRghFv0ELJKOyCyCKPWSSsg8ofZ53eYeaSjZMAKOoxWNHrIr8fsEz7biW9fiVWGXLD
	 se7WqCE5D7UE6BRznJM1hlWP6BmEbM0yi1QjlAX/uugvh/ZjvyHgVcv/z0B7IdC3vN
	 arI0qbgaUB0gLKKtejlJO4bwbE6ASUnfZi/Gnte+8BoaPkHBhOoCTjIp1agivMWUJa
	 3dUvp1m0zxa0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93DB3380DBCD;
	Tue, 25 Mar 2025 05:03:13 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z955ZyIi-tum55pL@gmail.com>
References: <Z955ZyIi-tum55pL@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z955ZyIi-tum55pL@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2025-03-22
X-PR-Tracked-Commit-Id: 35e6b537af85d97e0aafd8f2829dfa884a22df20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23608993bb224968a17d6db0df435ddb8e77412b
Message-Id: <174287899228.94045.2324054776294036331.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 05:03:12 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Uros Bizjak <ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 09:48:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2025-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23608993bb224968a17d6db0df435ddb8e77412b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

