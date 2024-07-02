Return-Path: <linux-kernel+bounces-238340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26DC924886
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C41E28BCB0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FF11CE091;
	Tue,  2 Jul 2024 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5a7idKd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43711CE081
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949356; cv=none; b=r513hSn4eNzg8+u1JhkyQj7n9QtV8NBLDXD9030LEIzz/fVWMdtjjnIHY3GUJgVddP20QvOMknd10fc+erGpe+RC9lqy+jd2PJo5PDroN2LTGp1POfqdslkPrR+cuQBTU+FWT5EBnnaI6UAsq26b+8cKkI/Eh/ITxi3xSOvERdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949356; c=relaxed/simple;
	bh=lHoEuYJVwsq0uHEkMg3tkYBJkvxa8nn1eomG7AVC/1A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AWkQ9Ox1EdHclSJh2O4TcX+ZjD46A3+cRshsNSl4HZAyth0tYbPRyuCXs6wL5iwd4Ebxe6mkLewFuQKo62APU7X1gQiqTZSuF1j9D818/Lo7z/mnp/sV9V1L7Nl3dbdYra39BfNCGm3D9+Hyrqnbr0n7sJLWnbIB98eInGUFCP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5a7idKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B47E7C116B1;
	Tue,  2 Jul 2024 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719949356;
	bh=lHoEuYJVwsq0uHEkMg3tkYBJkvxa8nn1eomG7AVC/1A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P5a7idKdZtQNxcaPb25fqugvl1j9qozueC8p6XvhxzSu6wKwgdSM6F7hYmEL7FPi1
	 zHGLnei7zdN+FIJA8pyAZ2omxl9ncS6cj99OKza/V7h6JDVKj1p8Ezx5d9UkiD/gBG
	 wxYLUzS3q4mjkmCussOnJ5B1yo8BuAPHFJ63zRxO/ZixgPzZs8tczp6qoJ7MyRTt9R
	 +2+lyukpUo+WyJ9WNAl3KjPMLiikJrm6nrePE5Ut9AHb3GgYVXRzeMrM4nCqayvdmG
	 iQGblwwWBs5XC+LRj1rwcpIL9ZawOpPQ15PFCPRziALeNq7LCCFHy/fyv1WCoNgN0P
	 h1L2+ymZrMG5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2CD4C43331;
	Tue,  2 Jul 2024 19:42:36 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.10-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZoQFEp+U+689DPdO@debian>
References: <ZoQFEp+U+689DPdO@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZoQFEp+U+689DPdO@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc7-fixes
X-PR-Tracked-Commit-Id: 9b32b063be1001e322c5f6e01f2a649636947851
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 734610514cb0234763cc97ddbd235b7981889445
Message-Id: <171994935665.24472.6677336924467756417.pr-tracker-bot@kernel.org>
Date: Tue, 02 Jul 2024 19:42:36 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 2 Jul 2024 21:48:02 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/734610514cb0234763cc97ddbd235b7981889445

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

