Return-Path: <linux-kernel+bounces-526683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7557A401F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87064422F67
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EE3202C4A;
	Fri, 21 Feb 2025 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOpUdbxI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F751EF0B4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172630; cv=none; b=QFCg93rpXQw8l99pNWI75j5RNp9+cDofsP+FF/vf3uu2Ga9uH9VsXK5cTuT+RrKKntEBgQn8y0HIbzy4Nl+HVZaRwBY7AaNjZawuU06l02tSKCZ33N6sdJcfqUXg9tJJeVTA8/oL7aEiRSjnGe0d1cv2vZkbAUkbVPxWM3LL/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172630; c=relaxed/simple;
	bh=Xn0fGoRkRkQzY1Hf4frI885YXwmrhNF4WvVBPf8Qr7w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pTjpXXCpQSdzqEaABpMtfxULRByT21Cf5WlGlLsnwIw/fUm9cYXWiSj0T8Cx9oOCTnzX6D9Xnwmr3w/qYUcn3YQSlXqNVICF7peEHxQLyjfSQqCZjH5Ma8agvZ8BW92m3qJLdsai/W8d+IW2FeLUDCd3/h1NIyAS867oCLEk6bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOpUdbxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42386C4CED6;
	Fri, 21 Feb 2025 21:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740172630;
	bh=Xn0fGoRkRkQzY1Hf4frI885YXwmrhNF4WvVBPf8Qr7w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kOpUdbxIC8MN3AYiCh0cBib8u5mlJuxha8GCbV98OTlP3ieEn2xfPKJa72nCI9CCP
	 veO+QAclSWxHLAuMcJKr+TlEwpJ4taG+UAhIPsc/uuuTNQG51axmkHBfN3B5hKy5LS
	 gzNF84Bz2dmOgU+4u4NLEkUW3zF8Wk2Bb5HPdH5DJGBNab4ibrtOVKr36OnEcokqc6
	 7uwP951mGUfTTr3CFvaMmkjYjMe60qEs/H+4mDLpNzPDy1PZFbGP8A95XymBlmPZgy
	 P2gJ8lZ6BxXVPVeRuKp2fl4fDJBbjZ6KFxuzSFY4RG6l9kG/8hDuDv4nw8w6gYkhUM
	 geagQd9R1zLkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71B27380CEEC;
	Fri, 21 Feb 2025 21:17:42 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.14-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyHJiMrF8nxXe=mhn0i5N1v-7RHh2TZfoz8BoUBBnuxzw@mail.gmail.com>
References: <CAPM=9tyHJiMrF8nxXe=mhn0i5N1v-7RHh2TZfoz8BoUBBnuxzw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyHJiMrF8nxXe=mhn0i5N1v-7RHh2TZfoz8BoUBBnuxzw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-02-22
X-PR-Tracked-Commit-Id: 9a1cd7d6df5d708ef244f93715855c8e54d79448
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ef7acec975bde28ab9cef92af76be8fc2ce684d
Message-Id: <174017266103.2208482.3473913192510497252.pr-tracker-bot@kernel.org>
Date: Fri, 21 Feb 2025 21:17:41 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Feb 2025 06:51:33 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-02-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ef7acec975bde28ab9cef92af76be8fc2ce684d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

