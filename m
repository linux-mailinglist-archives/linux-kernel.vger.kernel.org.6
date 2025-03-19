Return-Path: <linux-kernel+bounces-568754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7EFA69A28
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0552D3AAA68
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C121214A7B;
	Wed, 19 Mar 2025 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/ksVA/X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2520AF7D;
	Wed, 19 Mar 2025 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415742; cv=none; b=XaWxG02hI+1uFCRoLkzXWuFJNDWQNDoUknwVNYFd3IgtV/k0ykn2sNgwV3dc+quxcQ0ar4Ml8uEnzouIsVjSkuQn7uiaRIJBqbIrvycUyvBL0MjZGS3HTRVcu3JBehZiE/vVtULaRsC/uU2xKKzA6NFMJoCbMw1ByDTDUQ2OsGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415742; c=relaxed/simple;
	bh=ernwCODLIOx2EF7L2h+j7Y1uYKIw7dkscX8M4HHa3SI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nfDmvvnBG20P8q7f7JsXURcw++5uQ0/i/MGSNgHN/iYqfO/jbXZkrQC5TIgQhhXH8vp/TbTzvQ6GXqLUyzroFrLwIHm7vMNKMcgCoLPA5ipDrQqN+aiA9OPiJA/U7ka0HJYhjtm27n+1m+yWgsBiyh3qAAbaocN7HfnIqjU1Pbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/ksVA/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCEBC4CEE4;
	Wed, 19 Mar 2025 20:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742415741;
	bh=ernwCODLIOx2EF7L2h+j7Y1uYKIw7dkscX8M4HHa3SI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=M/ksVA/X+fjJuGuDuaIV5mGW6NGrDM01ZPYeq4AYSZQgmHNhQx4qIFTNf/pEgqQ35
	 YmClRDq8vqADcjs5fL9ZiWS4Q2edT98NR84jFa0UgmRvwOu1xeK2MyZSA3mHIzS/Xw
	 2tZUYfu9Fkwdrj20Eo0vJ0v9MXpc1tnac6RAuRHsFo/KuS0pViI/fH+VXAbndAPN/v
	 FFtJv+K3dxdE+d6BFE0c8U0VZG1D0yxlCH+SCP91J/Co7lwyGJHekZiQZoYdhpEZ3M
	 8D3eu29tt/nl2jntl9qEzcH3gWeACBcEBVwSvdN/ZhQyS24/pmAxCynw6ZWY86BeeF
	 F+8rl+CPr9pcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD673806654;
	Wed, 19 Mar 2025 20:22:58 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.14-rc8/6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250319161203.358370-1-linux@roeck-us.net>
References: <20250319161203.358370-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250319161203.358370-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-fixes-for-v6.14-rc8/6.14
X-PR-Tracked-Commit-Id: 815f80ad20b63830949a77c816e35395d5d55144
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47
Message-Id: <174241577735.1182345.13599797631654532425.pr-tracker-bot@kernel.org>
Date: Wed, 19 Mar 2025 20:22:57 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 19 Mar 2025 09:12:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-fixes-for-v6.14-rc8/6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

