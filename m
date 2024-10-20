Return-Path: <linux-kernel+bounces-373436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A5E9A569F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE931F21B9E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E65197A88;
	Sun, 20 Oct 2024 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2GeXb5U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445AEBE;
	Sun, 20 Oct 2024 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729455380; cv=none; b=RbQqqzW3M4YIR4zmMT53w5wh722Iicv65eEVHZiKXtUjWu85Y5zMBQ1MhxQ3j8+sMA+7CBs54eRzXYbZcSB9Jg0Jcwp0XJ4o8t7tM2iT6gp5X2DHP0R5BrqMvgQI0wS3ivzKL2zpwjckem0XQaMe2AWT4irZlBjneWTGsuz6tqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729455380; c=relaxed/simple;
	bh=h5pXbYtQoxwB4+4kjPHJs+1PoicgEZLKK+UU2yar9IY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=n5x85iPkArHBmecRw0VVkUB6x+3pT6tjEHAbAsggJm4KFs3hc/63easWHjZYkLgSiD1mYgjP1cc6FCOWcTWAN+b+H5ghgtK3JsheUdsoYu+joYp0dCIZRPhtUou47zGYWOiY+h2nQQyl22poGxHJffRDLCxtMTLuu/ahrfb9rOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2GeXb5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E209C4CECD;
	Sun, 20 Oct 2024 20:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729455380;
	bh=h5pXbYtQoxwB4+4kjPHJs+1PoicgEZLKK+UU2yar9IY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G2GeXb5U8XdmmMpp0S6ewdPmEJctg7fvRPg/Hh8NjltkHCJVw3WDygMs4mGZw5MCK
	 Xfwbss63Bmyey8/Kvk9HdTe+KVKVQXL01SjfjF8zSSyKEKqPVZs2MOTAOA6vbvLPoO
	 z4GV+74+amSXZ1n6fywSuX/f7oClQsrguak8NYWNNWBwCkrBFx1gwJ/flQ2O9UtC/v
	 /36fVbbLg17SKwNf2N2aXLjkCTNGeG3imhdWKSK/vI/FHO/OQz+QGxoJHf+6Oj8dUb
	 9Bs0PXeb51r2WamD7LVEBZlzLNulXOx/lW2mFyaP3gfufLV3NdYThnqNHzXnu4hxpj
	 OpTU3tMec2wXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EC43805CC0;
	Sun, 20 Oct 2024 20:16:27 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZxUHeLHqcv55AzHa@kroah.com>
References: <ZxUHeLHqcv55AzHa@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZxUHeLHqcv55AzHa@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc4
X-PR-Tracked-Commit-Id: 1154a599214c655c8138b540f13845257f1952fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b68c18957029b7be71a73f89a083856305536e1f
Message-Id: <172945538594.3637315.13434074280554614866.pr-tracker-bot@kernel.org>
Date: Sun, 20 Oct 2024 20:16:25 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Oct 2024 15:36:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b68c18957029b7be71a73f89a083856305536e1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

