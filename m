Return-Path: <linux-kernel+bounces-393929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A1E9BA78E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 20:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58BC2816E7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE57C18B483;
	Sun,  3 Nov 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWWUiMmA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C0E1E52D;
	Sun,  3 Nov 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730660541; cv=none; b=dCnVwekD63la3Bu+UW/Y5LcO7/450r/oXJp+vaNQ1AQZ+pgIlg5U0Dd6vJuvlT+YKFPBns9EXsZUw+70K8Ox8VvHcyfHC6dYNciXTW1pkm0VhxUzwX9mf0AWI2BCJ88Fdg3wsOQdJbeJ4AKgEG+EOruYaAGMO3fbf0z0DZw+oGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730660541; c=relaxed/simple;
	bh=IUEJUSv4hPatVISPOHkqdxj2/5oHorSFN14ll9Mb4uk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jl5eS14DU2bdZANqlzk+plktaDkmlTkJ/5kyTku27jGP75lzrI2Gov1ADn/rO8brD7ekiOxi/aljqtW4NyY7ewUSCSoCRpxLg6TKXxY4OyumCN/ZBXkf4luP1lOwRd8yN1R33Oh3M2Kf4pk9Uxe3IDGb280D02fp9Umfexrfzdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWWUiMmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B26C4CED0;
	Sun,  3 Nov 2024 19:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730660541;
	bh=IUEJUSv4hPatVISPOHkqdxj2/5oHorSFN14ll9Mb4uk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KWWUiMmA8QDtrFv5Yzd99EeT1xfuET+eKiULD1OS346ZKyX9gDwPR5BuDUTYxfR5d
	 C8pvsCb9VMQ43A+etHGpi5jfLXho0N/fSZKPE9U6EI6qPXZNyyeLoGLoAF61hSsl7N
	 Ig+8g39Y+OBwatJkHGGKQrsCtSSrGnBteDtPzVe3BcL1KPtfubqFyHnwhK5ynvR4f6
	 RYTyJ+1YRlR3mOMrVVb9xQMbljOrgOIii9T0gICwCSXPfRXL+WRQhvi77h+SxpxRpd
	 Fw5/546Zlly/V1GkBA1Dq0sUyg71QXwZo5rXWrDi4GKXMMJ7CuOftm0jbsHD/klO6r
	 GR1cUe5Wx/5fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCE838363C3;
	Sun,  3 Nov 2024 19:02:30 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZydmQblqRdfE3dZ5@kroah.com>
References: <ZydmQblqRdfE3dZ5@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZydmQblqRdfE3dZ5@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc6
X-PR-Tracked-Commit-Id: afb92ad8733ef0a2843cc229e4d96aead80bc429
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be5bfa1378f238da4a35c7d4b7cc0505ae869fb4
Message-Id: <173066054918.3233701.813371468727296290.pr-tracker-bot@kernel.org>
Date: Sun, 03 Nov 2024 19:02:29 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 3 Nov 2024 13:02:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be5bfa1378f238da4a35c7d4b7cc0505ae869fb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

