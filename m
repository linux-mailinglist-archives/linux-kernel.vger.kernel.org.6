Return-Path: <linux-kernel+bounces-380782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E659F9AF608
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5057B2135C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31EB10A1C;
	Fri, 25 Oct 2024 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi3LDO28"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B64C81
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729815590; cv=none; b=QUZARn60MIcA+JwRL/F9J11ZuX2iLWFjUzmrIlprI2TtBkobxkkbIIFDrTc/j02Lk40siszYxnad1r2IMrqidSnm4jbmnsNSIu2OeJQUTiJtHlL9FSr2lTSgIezExosmvD7zMCQS15QhIG2etgr4lTwRi9g6SxcrkV661KudjN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729815590; c=relaxed/simple;
	bh=RFrDugJd5YGcMsAvTK+VgpvaMYiluvsT2yeWsBLD29c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Pl/P6lOBqVZR0WMvlkwk8VeIt1PVVgx0rA6BiLuqzFgMy3a+o4uU6Nr8p7/U3dyEqCrRTBUqNI2tLLU92EXcoJe6/QwmH41DY4l8FLj0zqNLFkm8WKiFtQ6l8zL6d/TjyW7LRePY6MenU1uPGuHh4Ki6I1kUjjL6T+eEtdjahpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi3LDO28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FEDC4CECC;
	Fri, 25 Oct 2024 00:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729815590;
	bh=RFrDugJd5YGcMsAvTK+VgpvaMYiluvsT2yeWsBLD29c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gi3LDO28K7iMrIBcZPROeMkDpYXo50n1PKsqgMIDs7ICEX1EerTHmHlV+YzkAWbK9
	 7Px27t4ARZmZkm+nhbvvxUKZoLNpdzargElL4htFUZYDwcL9vX26F609ozY5rgGfkD
	 lTq5+hDIj7u8fuyLFDSO/3DjtqUc33FPwOeyExvC73pk9Ugnt/n5/phnx+KIBMEmsi
	 tdFOch7BTwoGfhn4CTiDcWHw4ilMZUAmd+PIq8xdVmiZaxtka7v+TRq1Da19NX7Oms
	 LNIVwxutXk3KTlQeG3oybJZVSxW/4EBVx/AKTRVdLU8+2010ymd+gEz4qtjGA2obVF
	 GnBBjVSfIcJsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE46380DBDC;
	Fri, 25 Oct 2024 00:19:56 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2410242314380.20286@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2410242314380.20286@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2410242314380.20286@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-20241024
X-PR-Tracked-Commit-Id: 51268879eb2bfc563a91cdce69362d9dbf707e7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9a50b90905a1dc79ca72d4a262da30d3572ca9e
Message-Id: <172981559547.2421084.15212310903756906772.pr-tracker-bot@kernel.org>
Date: Fri, 25 Oct 2024 00:19:55 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Oct 2024 23:18:15 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-20241024

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9a50b90905a1dc79ca72d4a262da30d3572ca9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

