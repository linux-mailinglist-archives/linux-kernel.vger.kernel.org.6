Return-Path: <linux-kernel+bounces-340774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3A69877AC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8471F27C86
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F7215D5D8;
	Thu, 26 Sep 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqTAPdXQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A515B551;
	Thu, 26 Sep 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368672; cv=none; b=QA+5/6NhVLvjf7pKnx+SdFbVg6LQmZjVpcuUXtZgpIgs86fICeI09L74IH9V7GJUx4cmNRdne+APyxPj6sfHfbfgi5MGVbG4ekhipzgRgPoKaXCtzv+O9teGET1iuGoJpJdNAaqgNFn5Yp1aED1oqy3M+db/V2iZQWt4/CK0ONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368672; c=relaxed/simple;
	bh=y1DYoVAS/tT72ERDDQxOLTO4nYLcGNsapdI3lRbNR6E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PexGaygREPVk1ItaQVSDN17lcyiH/YNUoCo+2TaCzsZRXtFHz9C2Z32UjHfj/TMr7xnVeUzszGMfqcuWI80ttMVIx2N1xcDGJZ93h/fN0WwyLr7JYobAypTWxp3GImpgE+e8XRuqvDI/QPbeo0FLGGrQKE3RJ+kf/8Sl19WFmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqTAPdXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4D6C4CEC5;
	Thu, 26 Sep 2024 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727368671;
	bh=y1DYoVAS/tT72ERDDQxOLTO4nYLcGNsapdI3lRbNR6E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lqTAPdXQgBuVQ1NBGn9LtitnN2mTHzLcyQ9uoA0XkBZF7I/Vflu9fDVOUnpoADS7z
	 VUO8Sb57tUJUDvnKLDSrBxu0I94jC4yRc91YIq1rJvlKyLqw7z9180AXZ3RRsfHDfq
	 Z49hOBtwVnmyO/0ua2++pGIc5FoxtF1lMDrRWtVQ2P4yZ5F/Sf51+0WmHN24gdMi/v
	 D0Ix1S2+cVSMbJ3qVcQN4yVQaHUeYocObcLIBUmr2MshqLjd5ah9P/mgLtIRbUIh8U
	 88lr/ZXsrc70fiPHXmuezSnxxj8RRhZuuAumXSGKpOmGWuXJ8dfRoAj36hPnOw+hj7
	 q4YiB9K7aC6Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF524380DBF5;
	Thu, 26 Sep 2024 16:37:55 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muJnL-QRMFV=eWdY18CtCZEWijEuU_kO8RWHP0Qv_fdOw@mail.gmail.com>
References: <CAH2r5muJnL-QRMFV=eWdY18CtCZEWijEuU_kO8RWHP0Qv_fdOw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muJnL-QRMFV=eWdY18CtCZEWijEuU_kO8RWHP0Qv_fdOw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/v6.12-rc-smb3-client-fixes-part2
X-PR-Tracked-Commit-Id: 665db14d0712ac27f6a0081510bd811efb3faa3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac34bb40f748593e585f4c414a59cf4404249a15
Message-Id: <172736867421.1312674.8255797674775932064.pr-tracker-bot@kernel.org>
Date: Thu, 26 Sep 2024 16:37:54 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 25 Sep 2024 18:27:03 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/v6.12-rc-smb3-client-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac34bb40f748593e585f4c414a59cf4404249a15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

