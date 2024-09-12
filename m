Return-Path: <linux-kernel+bounces-327311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082689773EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2321C23E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8791C2453;
	Thu, 12 Sep 2024 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqxU/tJn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786111C1AB7;
	Thu, 12 Sep 2024 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726178099; cv=none; b=pGG+/gjTGUwXS+FEloIepjyoDpGldn8SeezMYa9TLjuc/1uJLzbM24oaRlUmEAh20D41Yiu2oTOTUfx2dUuckHdCcH0a3NCms2IqzW/0z8tpx2/1XPYVOU5h6/Btvflu9cB91ueC0+POqPHlkLhGlA65CMjgR3bLl6jsJDuHvZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726178099; c=relaxed/simple;
	bh=kmXZvanHM2aP6BvsXflVTH5pL35WMNNx+kY0TRpLKxY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K6uYQsEV6GBIcDJqixkLO7ls4vazYUDpuJjqwxcrpkjyWvulbHtm/Oujnfv4TcqNVbxKngKeaTiB0fm9cbblapxVq5dehU4r/PHsBOvjtYNsQXmIDdSiyNn7Zp/BUHDzXxabeU/qY0g9Kw8qr5iHCpq0OqF1Ei3pBqJWqS0/y9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqxU/tJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB84C4CEC3;
	Thu, 12 Sep 2024 21:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726178099;
	bh=kmXZvanHM2aP6BvsXflVTH5pL35WMNNx+kY0TRpLKxY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WqxU/tJnuuqnrEgJEAtn9blwZTZwgIs5dgDtvO/aXmh3uhXBzLGtpmXIEgJ6N1sun
	 f35IcCL6MtITXMjapHG1NsxRiooMNgCv4ERNbAMdc7x01x4/bGnut/O4M9x3gdixBD
	 I424zSsSXjeZqcr9f6agoagNwHItDhk/PqpE76XTjF4k09GT+s2oaKDePlXvbfm62f
	 1J+m8TGuBaaXzrw/YLjji7okpmnF+7IJaRF8sXhtxqcpmXQBcC1X0o6CquU883tdJz
	 5C6cshZBl/Ui5ILvdCza21eiaCPzkdZ4NwlPiTpda8M3skWSUV/y0maD6UIMy9fm+W
	 jlFosYVjfnY2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710343806644;
	Thu, 12 Sep 2024 21:55:01 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.11-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240912210215.1907774-1-linux@roeck-us.net>
References: <20240912210215.1907774-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240912210215.1907774-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.11-rc8
X-PR-Tracked-Commit-Id: 20471071f198c8626dbe3951ac9834055b387844
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fdf042df04634248b65dc88dc4913026a9d1776f
Message-Id: <172617810007.1733006.4691000440868797187.pr-tracker-bot@kernel.org>
Date: Thu, 12 Sep 2024 21:55:00 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 14:02:15 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.11-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fdf042df04634248b65dc88dc4913026a9d1776f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

