Return-Path: <linux-kernel+bounces-363100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F34399BDDA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE811B21DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36673487BE;
	Mon, 14 Oct 2024 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuimgGDa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E6136E3B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728873549; cv=none; b=ngCQXZ6Pm7k3SwIlXn1X2DMzlBJpERHT5+JaoheVAzdZRjb3cV3Rl6C/U9f68z43tAnwF+ctdbJ4r35LDnl9D06T+9j5ASW4WkLLh7KxXReKovGzT2GsaRcZr/IlANJocpaWzIrJfZeJrnXOaIxJltF/HqNgv1X1sT/2vioq1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728873549; c=relaxed/simple;
	bh=DbDppARrfWx7MPQETcoArhs0F+3D7OS9cy1pKoMvy+w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=io0u06VYSBdodGSnWr0LcS+85F2GvVTJrbCvuoQX188adYBf5aE41+Kq4PWdTRpvSdWkHV6v4wxqQhCv8NgPBf06Kci5fCciR+yc8nIbxTbIfhUSnkHj291sEid6CKgNLomOnpz9JSvYJs6PrAi6H4GXUABdOqSlDHSMgA1Z0Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuimgGDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752FBC4CECD;
	Mon, 14 Oct 2024 02:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728873549;
	bh=DbDppARrfWx7MPQETcoArhs0F+3D7OS9cy1pKoMvy+w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QuimgGDaWHKVHl53Ix2Ij2n6RCkFR1/BP9LbWz3u5Wz/l6WzWYKyE+vBBVrffybh3
	 XhlCwtA4q183dEE53bfhSujcnadhvw76L35u3+fTBzrZPBQaRScDcf3EqatBGXH5p1
	 Qk1vFjScqmqRzqy0TcTzHagzKIAouhU9jdjNQ4TenDfFf64O62YBiAxD/axPEZ5MgB
	 vIzzevhTYzB25OkiyIbHtuZudxULQKMb471g4SQHXHv/i4l3Ixl0OzaG64a1BaRfgd
	 f/aJNNye2p/zPvG+akxSSYRHsCFvh5zLwlKNcFW2qlCM/JlH5Wkrpm5KXGD20XCkO7
	 8xaGmioFZjGgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF9338363CB;
	Mon, 14 Oct 2024 02:39:15 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.12-4 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87ldys6ha3.fsf@mail.lhotse>
References: <87ldys6ha3.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87ldys6ha3.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-4
X-PR-Tracked-Commit-Id: 8956c582ac6b1693a351230179f898979dd00bdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36c254515dc6592c44db77b84908358979dd6b50
Message-Id: <172887355423.3903120.18171876866386045405.pr-tracker-bot@kernel.org>
Date: Mon, 14 Oct 2024 02:39:14 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 13 Oct 2024 10:19:32 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36c254515dc6592c44db77b84908358979dd6b50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

