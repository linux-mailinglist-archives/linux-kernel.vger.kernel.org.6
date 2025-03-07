Return-Path: <linux-kernel+bounces-550339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE513A55E20
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EDD1892300
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CC318F2CF;
	Fri,  7 Mar 2025 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU9wzVNK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2FA18DB25
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 03:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317355; cv=none; b=f1GB4eJKOPI0lFqqVW0vrNWhS74iXKIrL/T2jHTPBsCHGMIX6yoVJ8E9thleBjBpQ/QNT3ykGXPegQU5WucZEoH2CzL0giMZbSxsqfx6d1jm1tX5FHLdeJ86QAzijDgYiy/ExVsilgPv3qCJ5f6fEc9J+byMuYewKTNaNnODXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317355; c=relaxed/simple;
	bh=7h+UBrEXQO1LvVxgZHM4+dtU9wb3eB3zIpexChTB3Y0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YAsApyxYEbCKfJZZHdeGINVUFBv9XBp5QB32klrhxxOQsC8w9D8LrvM0c4OA0xPZrFR7K0Krq6S/F1T2Ut39rq930TeowBYd66DugX2BpXtpJzq1FAZAEhUCwkydt+OkicPLu5q7OhUJEE8Dd9qsw/Tty9a2TxmvDUePcTCJgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU9wzVNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BF4C4CED1;
	Fri,  7 Mar 2025 03:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741317355;
	bh=7h+UBrEXQO1LvVxgZHM4+dtU9wb3eB3zIpexChTB3Y0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aU9wzVNKs+Bhrywc/6I2gt7f6BXz0gVWAPbsxqBJeZa3j3UdnMpRk8nny3m2xLb8I
	 7Yonmu6dHp0jrL0CrrGXTfVdIlhJNlevZ75mYtVzfos3RP/wVENV69OeObsjypyLxP
	 IQgbYa6wLSrNBI9fgcQbz33ZfJFW+xjjTHAqOxvU0r+pSxKoZG/EUv3XZT1YUNQAyg
	 4IgQ9GiHgB15CkhBhDrSHP1MKs8OTmsVk4SoR6aOMr35LDtPC3B1NxJBLXDdEOMj1h
	 fAIdRMDOLs/kQMX/XJUxubroCh+xtUCa7rEpGXKDrNDqKG8P3KarTBMM08L6+UgUDQ
	 22FPQtLOnycVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DBD77380CFF6;
	Fri,  7 Mar 2025 03:16:29 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzHwhm74Z=itrPBz=yz=0VZOrcbnKs6u5LLQuwJrng5zw@mail.gmail.com>
References: <CAPM=9tzHwhm74Z=itrPBz=yz=0VZOrcbnKs6u5LLQuwJrng5zw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzHwhm74Z=itrPBz=yz=0VZOrcbnKs6u5LLQuwJrng5zw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-03-07
X-PR-Tracked-Commit-Id: c8bc66206a44f389649af374f5301b2c3a71fff4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28f587adb69957125241a8df359b68b134f3c4a1
Message-Id: <174131738857.1870846.6425521194522709127.pr-tracker-bot@kernel.org>
Date: Fri, 07 Mar 2025 03:16:28 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Mar 2025 10:13:09 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-03-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28f587adb69957125241a8df359b68b134f3c4a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

