Return-Path: <linux-kernel+bounces-206759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB01D900D61
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6232877B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0EA15531E;
	Fri,  7 Jun 2024 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIBOenLq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E713DDC5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795025; cv=none; b=Jxn9OOX8aKp9P3i+pnI8P95Xc6YZGs/izrCC3U490kRPduBiMd21xlZe0hKFZqhUtpoDqhxlvgrfm1U71QCmR5JaXnCp6zsUQ4cMQlOhDJUTncfss9EiZsErqIMSY7UXdSSq2N185ofNPFDlCXbMLdC3UzxYhnYbA7hVc5Rsef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795025; c=relaxed/simple;
	bh=S+gLfAfsgGvz+l36YgNd/bEuEfEMMCVX1IbnE/gNbUw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hTba2+SSYKZUyFdO647sNSp51e7FIR858Lsms6YPi0G9Et9k7Zh1HalK1AFoH2neIIC3snZ0o8ePrhodhVzWECitJ9KkNxCLUPEzSju9dnIddVYm4PF8nL04vDDeHHJvp8SHAyri0BUfrGMwvcjMkwWMiRxTtPAOdq95BSzW/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIBOenLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DE88C32781;
	Fri,  7 Jun 2024 21:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717795025;
	bh=S+gLfAfsgGvz+l36YgNd/bEuEfEMMCVX1IbnE/gNbUw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qIBOenLq/l+q3uayFkgbFCBDshkX48ZlkjF5Wh5k0+B1/0n1Ok7ZlNo0BroaEX8E7
	 dhgdbOeHhRBdZY48asj5DXtjmOz2i9mR/hii3qaKc+pOfR0HBhVIZc08d6chIdaDcw
	 PAD0jAPl1y1Zsf6qtNn9j9E5ITnm1+OC0AHDLn6RvDjBvPJSVUGAcyfqQWFVDD6PE3
	 kVr1bt6QZQFQyUZruL4t37HXyHd5Nq7eJiMFCyM5kgNWQT3hLo/gyInPOxK4x/zFuJ
	 34URQsRQf/ihMHfhz8eDRu/y/9sUqryX5svCm2ATTkp8rLihj0t6u/wovBmPRUH7KD
	 sItn8RCbE9m7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62572CF3BA3;
	Fri,  7 Jun 2024 21:17:05 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyvjs75_Op_yXD=vD_ZLQwZRzio0=_oM=vGkeOkaGW=TA@mail.gmail.com>
References: <CAPM=9tyvjs75_Op_yXD=vD_ZLQwZRzio0=_oM=vGkeOkaGW=TA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyvjs75_Op_yXD=vD_ZLQwZRzio0=_oM=vGkeOkaGW=TA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-07
X-PR-Tracked-Commit-Id: eb55943aab89be99a26e34fc2175ebb3583a2778
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e32d580757362edc95fdd7a86d3b869b78e58d8
Message-Id: <171779502539.6230.4106074234980545453.pr-tracker-bot@kernel.org>
Date: Fri, 07 Jun 2024 21:17:05 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Jun 2024 12:05:49 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e32d580757362edc95fdd7a86d3b869b78e58d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

