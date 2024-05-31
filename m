Return-Path: <linux-kernel+bounces-197600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EC28D6CF0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9B0B25358
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D432D13699E;
	Fri, 31 May 2024 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJVyl1lw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E4B13665A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198817; cv=none; b=Rdi+gAqK3576PjX9jr6BB2NahHdpLmvDt9WRouN0N3D5iesavTALAdHTc1jcRjyV/9YloQ+uYsBM8mAhm6LxsFr2MvIPhVPDacx0PnG/itFvzptTOhAWRnFKjlEiGGc1lfOSmXT8h808yxIk/suswg6Eri4RksoLxWOOrQFm1Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198817; c=relaxed/simple;
	bh=1KlMNONzxAK2P1ijtWrLwDEe0sUk3kWuIs8qOS8MZhE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A+W77hQNDTL7IbkqB8bhbu6WtrPonTEeaao+7bSCfJy5chECyQDSDD0VFJgPLRJi8l+2+pftHyx3zop+9jURdMGiuWEmIKqSjIUW9i3EfrTnGYkEkrUxW7VTJARSaqkbz0wlfjgPBkCKsM9HDtHkRqBf9wJ9Sn+fkMIOkF+UWHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJVyl1lw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE222C4AF09;
	Fri, 31 May 2024 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717198817;
	bh=1KlMNONzxAK2P1ijtWrLwDEe0sUk3kWuIs8qOS8MZhE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pJVyl1lw9ZSDMTHq7UNqzcpQYWxmQKC0nPA9OLJX/Mn7ZeniVrvuhc7FQmzPVHqNc
	 rIdEg+WgbWkqRPo1qzth8iT7K0rELmIujPr0MBv+gLDxFd782O3QNogTeRjs6Vzryp
	 p0eSqgOl5fEs7T0jqzTWvUZ85G8sQNXc+0WbhIX+7PopBluDP6BhELVWWvFtP2U7U6
	 w+TeS14wVJzbFkTHSH+UkbGyAPo9K9ClAuBDrhAbQdvzAs/uJzm73Esc7tUgqu4wLp
	 hlqndHZw0rwZ2aM/6LmPgnKk/TMGoTNbdwvS05WuVGs1iesktbMt4HMm32okeulDg8
	 VpEr5ZYXO5Eug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3D11C4361B;
	Fri, 31 May 2024 23:40:16 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzbuJuE=aW-A9Uwst-VuqJwXHR0Ez6Ov-OMxTvDEVjsMA@mail.gmail.com>
References: <CAPM=9tzbuJuE=aW-A9Uwst-VuqJwXHR0Ez6Ov-OMxTvDEVjsMA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzbuJuE=aW-A9Uwst-VuqJwXHR0Ez6Ov-OMxTvDEVjsMA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-01
X-PR-Tracked-Commit-Id: a2ce3f7752bfbb47e659574fc2e1e6942bca3c29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc8ed4d0a8486c7472cd72ec3c19957e509dc68c
Message-Id: <171719881692.1891.16468497625005432196.pr-tracker-bot@kernel.org>
Date: Fri, 31 May 2024 23:40:16 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 1 Jun 2024 06:46:21 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc8ed4d0a8486c7472cd72ec3c19957e509dc68c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

