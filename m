Return-Path: <linux-kernel+bounces-561009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 128EBA60C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF1B3B063B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1141DE3D1;
	Fri, 14 Mar 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKQZhTEj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291A11DDC28
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942644; cv=none; b=V0OadVjZu+tt4SAFC2hL1jME1w9PjivFK5YymwQDXgeOpjZh94ZWgOhXZZZ2Qk/y908Hf7G5zN6Fov3yGfjVVAJrwhwnM8+GekNyaRep/Ibi+tZzbSW/Zz8m/XgnhxgHTvvkTlm8aLznuZLzEptM8lnbi5JsYBQWrSx9ynQoQtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942644; c=relaxed/simple;
	bh=Wt6EQ+gmaMT7P+wTt642ww7xztKlQ8QVzn8b8zd4uCk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A+mqzsR8UCaqW99C3bJ/l7EkuzXsjz1ZaxSFYpmRxi6fbVklPc+6g6Y8GxRB51z7bNNMfvpPPBP95rmfCN+5WtfFR/ad6JMYc77CtXJ7J2mXwg9ni3doUfAZKx+dEBgyp4LhV7a4W9wnRJuZHPeUyGChtnFr/I37pO5sxbS8tO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKQZhTEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FDDC4CEE3;
	Fri, 14 Mar 2025 08:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741942644;
	bh=Wt6EQ+gmaMT7P+wTt642ww7xztKlQ8QVzn8b8zd4uCk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FKQZhTEjOAJfEDJG9Yw121R83VXWVenb8BrEaUmym1B8QkYoJ4zgLlk2CvkNRVxyu
	 PNO2xp/4jXtvK8ZpWd2Ez8MU8EJg03DTiFgc+CURki5RqNGj5s/ZO/hErmhU1WL0q7
	 qtjo9YFZQoaR5OgUAioAv3l8uzV73bhvR+Ah+MBqW3civoOJcNDzYDRu5PEEeVKBoM
	 ImHssJrGkPd6B6UbuZgNMB9TsYIJ6uloL5bscrIbZxHRUX9HT4btf0M+qCPhHEeXWs
	 ceungCg36tC7Nm/qH2lMf2ISTJp0ycGfAauLfXfmSgbnQkXcYwVrL/kUAkh2PzhEU1
	 BMUcdY2ZOc4ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5A53806655;
	Fri, 14 Mar 2025 08:57:59 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.14-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tynNkAv1s70kbsCVHj31sGTXL1AQ0Dv6n0kwr7kw1rhkA@mail.gmail.com>
References: <CAPM=9tynNkAv1s70kbsCVHj31sGTXL1AQ0Dv6n0kwr7kw1rhkA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tynNkAv1s70kbsCVHj31sGTXL1AQ0Dv6n0kwr7kw1rhkA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-03-14
X-PR-Tracked-Commit-Id: d1d77326f585ccf1fb388e1bcc18a630e044577f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00ddc3f951e266a7df5fead1cfec69b251ca7d41
Message-Id: <174194267853.2165191.4608357621548683618.pr-tracker-bot@kernel.org>
Date: Fri, 14 Mar 2025 08:57:58 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Mar 2025 17:11:16 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-03-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00ddc3f951e266a7df5fead1cfec69b251ca7d41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

