Return-Path: <linux-kernel+bounces-426406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BE69DF2A0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 19:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61CB5B212E1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6901A76D1;
	Sat, 30 Nov 2024 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyA7/ojd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00638468;
	Sat, 30 Nov 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732991972; cv=none; b=YTpibY5b2+Zip5IBuTJRAGaIv4udDgaac5V6xGbKPP7jU32sTfGqZ+/Prv+Pjvr68DOjSTjc3i0YVf8cb5Z4rKxx4wk+VfCT3Pkl4GKGpzNtGbiBrX6M4j43pmlNLOSeM4q8ccxixzD6/LiIr45QCtChLJOFL31OBLUmElCk/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732991972; c=relaxed/simple;
	bh=QJ58azcCtcLEUw6R2UPBt5ekUNQpl81VMETB4UBUwjo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bgUF9+ubC2gfJ1ZMTUf877hCJCIeSQKskHGOMo5yDe6TvMoH3et9EPSuQRNNoBtx45j6j/4XaFuiaMl9Nb2twwjzADj26/jhP/Copv6x/VT47UBtLvX0EvYBeMq0/IKKDV8O6YuAN1D0UHfkXZbRwgTtXZypgWntpCVnHhVhv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyA7/ojd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC00C4CECC;
	Sat, 30 Nov 2024 18:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732991972;
	bh=QJ58azcCtcLEUw6R2UPBt5ekUNQpl81VMETB4UBUwjo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EyA7/ojdt4SFKNUbuJeoQ1cFn7OHKQN5q37QpbBUF3qjd2Hpny1LT2c+/aAXTfg+v
	 zarsstxx/iuEO3bpYM7YcHWuaGMamj19LgeTq2boAY2uWFqtnCnKQkLVNu82eCWqr4
	 czjdN5N2boc4tFbcRXcXoXFRj4ItuFq1orQZMBGeEXiWYdwBHqcafrhh5qurU9I8Hi
	 5k3dcaeXXq3+bzvghPtLQodrb0wk0uu+t72x5MMUdYYvelD1DD3HyK/pC8XjqTQsHF
	 aQwlfXHPnpQkHPNKHNN2YYqk+T4J0EQkPDtYHGPHF1zrb+syZjzdiJzY42Pg4JmcBS
	 CCG4cUJBrDNQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7181F380A944;
	Sat, 30 Nov 2024 18:39:47 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241129180323.3625355-1-idryomov@gmail.com>
References: <20241129180323.3625355-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241129180323.3625355-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.13-rc1
X-PR-Tracked-Commit-Id: c5cf420303256dcd6ff175643e9e9558543c2047
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d0ad045533ee37a208991ac5baaf6641e60a9ed
Message-Id: <173299198604.2451487.7635017904739044730.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2024 18:39:46 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Nov 2024 19:03:19 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d0ad045533ee37a208991ac5baaf6641e60a9ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

