Return-Path: <linux-kernel+bounces-235277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA7191D2AE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 18:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA161C20A4A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8BF155A24;
	Sun, 30 Jun 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed5i+DhH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592B01527BB;
	Sun, 30 Jun 2024 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719764888; cv=none; b=fO+2meFy1H6rwWByuJn9PXS0M9hxqkvRNwv3hr0XVVSUBAxE3h5nXntE2+2Bp7xqOaPz3k4kX1SWNXpCA/JghEadNMnO4o8+CzfkE3sA9PJ3wAfV8L3z681rJrC3ZvpnipL92mb+y+wfSlYHNWzuu6TDyFuwUqI0+KhDY+Oc4l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719764888; c=relaxed/simple;
	bh=amA6ya8P2RiMgGF4X4nn5bKoMBLYnO1nXauo7BYH7Ro=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g23+EgAISzifEXVXJJCG8WHxrOuuwFX7Gfp8U5hPP1yMMgBitWf/Slgtav7g4a5hZPt45d+wrnhFxnrQvlAUKueoI7/vjeP3lOy5Z0zgtevvkDCyHvu8At1mO5BMU58WjmvDaoEacnIpohkDT7kAxROrW+SNtmDLvw+ZBsGGpcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed5i+DhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A0BBC4AF0A;
	Sun, 30 Jun 2024 16:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719764888;
	bh=amA6ya8P2RiMgGF4X4nn5bKoMBLYnO1nXauo7BYH7Ro=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ed5i+DhHWYn3i8xFuiz6itCEPgAmCR9mPbEswEf4xZzUNlxm+2blKuFk7vTxCitmL
	 1ci4Bz7y5aD6OxCCE4OqVSTxpiJ1ypmzfsY94uvJzvxCzNpiNzr721qqJX03wlsdw1
	 0Coeact4A1+884DSed2HdpWg9OS/BO3pxat1OR9SW1mQpQkeuDUw7O8LaYApIoNp3S
	 mAS+ue7kfYQGD6U8PReFDMu7XV9X4DwJ9GwkrjyQzJd14pYVapJ/yV+bWcFR47LOND
	 //MzayQ5IjnxA4jNTMaoCageHy5gEiPEmwbzHUHkgQ+MlHo/Ww2ARsQTuU53d8pG8X
	 eIsWzFiZyJiQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3232CC433A2;
	Sun, 30 Jun 2024 16:28:08 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZoFnokzotlrCPKfs@kroah.com>
References: <ZoFnokzotlrCPKfs@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZoFnokzotlrCPKfs@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.10-rc6
X-PR-Tracked-Commit-Id: fc1d1a712b517bbcb383b1f1f7ef478e7d0579f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c01c3d552c29da92a91bd44c067d2c74c500a95
Message-Id: <171976488820.24413.18257116316026282109.pr-tracker-bot@kernel.org>
Date: Sun, 30 Jun 2024 16:28:08 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 30 Jun 2024 16:11:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c01c3d552c29da92a91bd44c067d2c74c500a95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

