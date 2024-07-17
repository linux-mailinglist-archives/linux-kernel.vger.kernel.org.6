Return-Path: <linux-kernel+bounces-255646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A1D93432A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DC5283362
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719E818E76E;
	Wed, 17 Jul 2024 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoDdzVTE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EED18E74A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247517; cv=none; b=aR8J1zdI/INBzXCOijV437Sm/+o0QtBBSnkpA6X8r2hXLeze/U7rnQJ6YBNkUAyd2YQY7feVuby75KdwUb51ZwlFUfZGnkVgA5Ruh631+c9ZPBJpD4B6UvudKfLOLllpQAUVrdj6b50dwA9O1abxhfS1zcPVVWpy6XVyNrNsKQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247517; c=relaxed/simple;
	bh=fPw+pU9G9udejd/VmaMyZqGwYj0J+K9j0mTbUzHmge8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MwIMSTYk35ipCVm657VbsuJ6VzzeAxBCwOip6DHNF8y0pvVSqk7k5vooO56KzdAY5J6lGoZhMgoKstAMjWu65oK7E4+JacLDSbB19UVKhi7OFcngaaLrfYTgYdYRG62nW0mbcaSDzlgfPObB8sv2gpQ584FY+vh1kKrfbagt0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoDdzVTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DC93C2BD10;
	Wed, 17 Jul 2024 20:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721247517;
	bh=fPw+pU9G9udejd/VmaMyZqGwYj0J+K9j0mTbUzHmge8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LoDdzVTE/9XApUQhGmrUffyKIz+ZxyAZfHFQRxwxLrV9zWYQuqovOnnqbZhtrgywu
	 2iE8FqcFbi9HOC7KgWXPhFXVJylKz4pEA6MObtGQYo25Ppg14KE/lNc9Q7bswKP/tb
	 ERNDhermf86tu6WyVFBPzhP9/aE/nukjWA97kr8OfAlOC0c0Vgn547mjB0Ozb+MHBg
	 VEkjZl2rDDF+L67fFSX23II6fe+vq6gyWiQiU8iqeR6cg83+mueYUuTPG+jBAvxeHB
	 xxZY2bLbLCqfPPXSVoIuuTPErW+PGjr9vzU+JBtFYYI/lEna3WlMhxpcfPv7PxObHV
	 GcZ0+H397Ijlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35BA0C4332D;
	Wed, 17 Jul 2024 20:18:37 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd_M5+ZHh9aWowoOcOLtwbOpX4TtUa7ea4VcEtKTq1nmNA@mail.gmail.com>
References: <CAKYAXd_M5+ZHh9aWowoOcOLtwbOpX4TtUa7ea4VcEtKTq1nmNA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd_M5+ZHh9aWowoOcOLtwbOpX4TtUa7ea4VcEtKTq1nmNA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.11-rc1
X-PR-Tracked-Commit-Id: 89fc548767a2155231128cb98726d6d2ea1256c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0260b0a7445c62a08938fa66fad256e5d0779817
Message-Id: <172124751721.12217.14042656743371620615.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 20:18:37 +0000
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 21:01:33 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0260b0a7445c62a08938fa66fad256e5d0779817

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

