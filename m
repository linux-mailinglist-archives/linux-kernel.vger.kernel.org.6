Return-Path: <linux-kernel+bounces-516806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E0A3779D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154591675C0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D31A23A9;
	Sun, 16 Feb 2025 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrzK1s2b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6DB81E;
	Sun, 16 Feb 2025 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739739723; cv=none; b=tBF3Ij4a+I/pp7MIOgo7pxA50+nQwPD8kskUldGHr2symtWq3vYS6qqU18gNH55jlhlZlN3m7UA9KYQX293Z6g2skq9nwGfVRldfayIt3GAKSO9BvF/8NDklTmMBdZh3oPm/ik4oEyBB43Xd9t7J82EQyztM43KRhDrLFzv7w5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739739723; c=relaxed/simple;
	bh=7DkzFB0zxDFxDpoGTooHWm0F5p8XaYGWCzSxFFap+74=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RBYi6/49vGJPOkoULrArlBPylzqFJ0j+x56kvvjpdZ6QiFFLiBK60Ygk1484ogN5HZAT/Cxzz4yRttVH+1vKmNACuRlUWsSGtxW6qi7xPxU8E42bDdoQBKdvUcbe5sKM+QuVQfwj+CNzEAA3qIcNMTf4Yfx66hDST0K7wCXCNBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrzK1s2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C060C4CEDD;
	Sun, 16 Feb 2025 21:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739739723;
	bh=7DkzFB0zxDFxDpoGTooHWm0F5p8XaYGWCzSxFFap+74=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UrzK1s2bASATQCVsyej7IsgirYfLQV66vIsRlS/IvhHuhJvLwgRH5X7c8jhmuOMrS
	 SbE/0J3ANNu86jS9avnTiZanz0WOTP/qc0s1ThwspxLbNrBmtUXSeEA8mEnNybNBRg
	 XVq9ctM2iKr8Ng5UUGmwtOZPHdPN8ROXzfw3bjLsdeCtKgdl6SR3055vFms7npFkiT
	 0grQ/WJrWyBXn5QwkHilGnHyTXjaKXQqFry3eVnlmgbTz0qf82LbQ6aZE23n38wQRc
	 pb3XS6uzzq0tBVfW9tZhezbGqxZcbuEqLXKiGY78T9EThrG6lhkeUNwP5yaaSqALgW
	 B3sZWYJV2+pXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34028380AA7F;
	Sun, 16 Feb 2025 21:02:34 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z7IAH0twfNXO-j_m@kroah.com>
References: <Z7IAH0twfNXO-j_m@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z7IAH0twfNXO-j_m@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.14-rc3
X-PR-Tracked-Commit-Id: 659f5d55feb75782bd46cf130da3c1f240afe9ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bfcc5fb2fcee1e914708ce55b70e707d03d8097
Message-Id: <173973975270.2568330.7734608061308816747.pr-tracker-bot@kernel.org>
Date: Sun, 16 Feb 2025 21:02:32 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Feb 2025 16:11:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bfcc5fb2fcee1e914708ce55b70e707d03d8097

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

