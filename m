Return-Path: <linux-kernel+bounces-363103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35C799BDDE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AF62814D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D1813D891;
	Mon, 14 Oct 2024 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgVmwYCL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A88C57C8E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728873559; cv=none; b=bdv0cfsNWVtb/50G2MKmaNMO5M81UBIPAfzdSqECBkYnQ7gg+Wg5PhR0twz3K7gxCbRwOTQYCkDNB2x1zfXTGsBKlv0Cr9FggsXThNof2NFVZhfVXVAVs/TeOi6+RrS8+RIwkUi6LT3Ij9auEe12M1TA41QLSk18yYS4YFJDrV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728873559; c=relaxed/simple;
	bh=VA0nbpg9xX2OPaNKh6n2Nlyn4suBDzj41fEb77YSaIY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r9pOK7bheOgawuPdo+y3v8Kc0L8nxfCnL9FQ0/TH+eZzYBuFkJB3eE0xZGTEnvAoTM71Izh70Mw3zD34mOGFDfMY4HLExc7yXay7SAlmC+p7n/EHeQSdyb2qVBVbAhavG5MHzEi7cg0REhgiycoJi0WeKHNBrs9KcjS6pfT9i6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgVmwYCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09291C4CEC5;
	Mon, 14 Oct 2024 02:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728873559;
	bh=VA0nbpg9xX2OPaNKh6n2Nlyn4suBDzj41fEb77YSaIY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mgVmwYCLpX/nO9ji8AcodRZeI/tj1mo61fO1mR6jbSzUWcGarwBdTpAPl60nhtRdu
	 KXdkF7eFxfprLx6CWMN3cMVaFEJRFfP0EffwunIj/yYYGd0u8sfSvcqlT9ayotEzNg
	 3gc0+Sbyg9OlAyu+A5142HrcaDpmXkZhYqewdY5F5QpDFE80x9ptLRpL87Py1bMgqo
	 sL80in7FR1s62smwzJtwF9d9RKewmxrISa5DJaIlz8/m5BT4Ddn913UVLfYqyM0aru
	 WMQGnoiTjhRkDJsaWdd1igMl2585bFnDAGHEmot2U6a4+SAeIGaRW0cXEJZwmfd2qh
	 9K3yZkH3VBKaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A61838363CB;
	Mon, 14 Oct 2024 02:39:25 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2410132332520.20286@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2410132332520.20286@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2410132332520.20286@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024101301
X-PR-Tracked-Commit-Id: 2934b12281abf4eb5f915086fd5699de5c497ccd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6485cf5ea253d40d507cd71253c9568c5470cd27
Message-Id: <172887356394.3903120.8001756916541145929.pr-tracker-bot@kernel.org>
Date: Mon, 14 Oct 2024 02:39:23 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 13 Oct 2024 23:38:06 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024101301

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6485cf5ea253d40d507cd71253c9568c5470cd27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

