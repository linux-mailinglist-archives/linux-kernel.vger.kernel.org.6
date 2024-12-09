Return-Path: <linux-kernel+bounces-438202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731B69E9E2E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2CE16486F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB7D19049B;
	Mon,  9 Dec 2024 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWSAwHqo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42E1850AF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769502; cv=none; b=EDTf682A29Y8mWEWsPHrZCgJlocLkkPSP2z45tJshCRiH17mq4z2GdQRxi2pffI+zUdjYMi66LtM+GfwIjMeRt4+doYsXgwMFCKQIVKqOk4VLL4WXi1jF+vh3j2KonPVMdVYDx/5OQYr958gxk9vbasokZeZ3JcHOZDG9iewE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769502; c=relaxed/simple;
	bh=2TkC8QUmkcVXVrvJMng7Yq5N1s2NTs++j7povCTbe5s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ari+ldO/xi1zI6jrf7b8z89DaEFTxsSd1ADylrsztNoU5fN5SRad1HgWnadF7o19L9+5YzsWSok8yDJDKlVtjTXY9KU8q5+wGTo90riuFADdqHvoYZUDvnAtwq52TO2d89JB1C3QrzKrg/7mNdKWM1wKSllgj8BBuBuMLg63d6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWSAwHqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E206C4CEE1;
	Mon,  9 Dec 2024 18:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733769501;
	bh=2TkC8QUmkcVXVrvJMng7Yq5N1s2NTs++j7povCTbe5s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gWSAwHqowklpswfZjJlXkWL9Y3HDUFfveHlyYOVAt8dMKyBToWlznYmmDHGxeGro0
	 ELpiwGc1RRSZeKGeRlLxCK0qhG9qtdIt9H7ulE+/PvFy6aPTE/Bgr4toghAlxNNuFb
	 aAeqH2bRPL2HqKxQmDYXPZyWLNQonYII5Gp2fxX6JHaLv5c6/aknqw2wUK7qUlFhWs
	 6dO2hLq6dgMVjOwf9vrqowfYg8IwrvwamjXCfkuXgUTLnL45IUdBPjm3WYnd1PREL6
	 zNNxYE44nvbYOUxEjwra4A9VRLQ2NUXOmpNNibpkqG8hjSs650nlKbvYKcmLrdBXwr
	 0UaxIKUrYUbFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71683380A95E;
	Mon,  9 Dec 2024 18:38:38 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241209101159.GAZ1bCb25_H5m4Fb9i@fat_crate.local>
References: <20241209101159.GAZ1bCb25_H5m4Fb9i@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241209101159.GAZ1bCb25_H5m4Fb9i@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.13_rc3
X-PR-Tracked-Commit-Id: 9f3de72a0c37005f897d69e4bdd59c25b8898447
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4c995f92b210ab353aa39e4c100ffc5d12eb13c
Message-Id: <173376951696.149590.10553821879737081791.pr-tracker-bot@kernel.org>
Date: Mon, 09 Dec 2024 18:38:36 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 9 Dec 2024 11:11:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.13_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4c995f92b210ab353aa39e4c100ffc5d12eb13c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

