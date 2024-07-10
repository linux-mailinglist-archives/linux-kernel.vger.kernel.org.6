Return-Path: <linux-kernel+bounces-248134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB66692D8B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66475B22FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCBB197A99;
	Wed, 10 Jul 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeCwNL82"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828A17BAF7;
	Wed, 10 Jul 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638202; cv=none; b=rhqpGhQuAq8/ILMPpiCRBwU+6PEJmNc36yIB2N3wWJeWv0X6S2HO8OdsGKXVA8yUED4LZ/NepTsVZzvlxnwonMu5/o+w81J5ec2NMDWsedqxxPOy87FjOtiIPvjFuGXBewv13iZ/e4/tX7LUhbTetHvU4OCYuXxiDLIZdfQRY1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638202; c=relaxed/simple;
	bh=j0r7LACa5TBNmDhQ5wg6uY7GgX+nTKxlkD8UfpIB/mo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EEf/oFhTVv0NaT7R8rPsfBoQ4lT3S+P+lOloXnfKOPuQyg7+zTKX1qBYdfnOL3alo+LZJ9r2IAZlE5T4pVczewm7wnkTXEJXiKz2QyjYtQnSppfcZVxdvXD0vOL0cT3ITGBWY29fd6dEoEVmCWCFYeT3i+jHVlP/xT1CCJ5wYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeCwNL82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12476C32781;
	Wed, 10 Jul 2024 19:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720638202;
	bh=j0r7LACa5TBNmDhQ5wg6uY7GgX+nTKxlkD8UfpIB/mo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LeCwNL82NdzSodPRfS627+bBhMoHJGDmjWTgGwb6uIyIXGm5ZltOWB66/f72i0VDh
	 2MQVAGC3oDFe7BDZH7d/Rz42r9z9YWXJOp74I863jUyaPQEQFCOSJlfxoS7wqpTBY3
	 Q2HpFcgeyBPLGs8SPJ0GmzWglfQRTAFcrVhUqww+nnOkFQwTDdzZnk0PD9T4XxJ5kI
	 7hApP/NWuYY/CsCcpb8YrC15ceM4Xagq7TVaLUUKD2bp3ze67g/Aht1spFrM1DlVyX
	 LlTSVRurOkVNTw334WtJyOiEbeGyJMGZOyf9PQsYITzFpc1GEerhqrZkFEIg/Pf933
	 Da1q3YtV+QkuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0687FC4332E;
	Wed, 10 Jul 2024 19:03:22 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.10-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <lmdvnow3yfejsiqgoxg5yxcs4patibvllsc533skksxpoykzcr@fstcszxequbj>
References: <lmdvnow3yfejsiqgoxg5yxcs4patibvllsc533skksxpoykzcr@fstcszxequbj>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <lmdvnow3yfejsiqgoxg5yxcs4patibvllsc533skksxpoykzcr@fstcszxequbj>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-10
X-PR-Tracked-Commit-Id: 7d7f71cd8763a296d02dff9514447aa3de199c47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6963ab4b01cd92b9bf2eed0060907e35cc1440f
Message-Id: <172063820201.17909.15228795756205540040.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jul 2024 19:03:22 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jul 2024 12:44:31 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6963ab4b01cd92b9bf2eed0060907e35cc1440f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

