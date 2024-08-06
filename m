Return-Path: <linux-kernel+bounces-275720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9908948904
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5856283388
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F11B9B4E;
	Tue,  6 Aug 2024 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfZTk3Ii"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272F1BA88F;
	Tue,  6 Aug 2024 05:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722922955; cv=none; b=fGYoEoawCzYP1BZEGmCyzgbEIj+kcAhyJP1R7NsCDCv1ArlP/juKoV7CNzEBasNRQb4u5w1Kazk3k1PQzlt+ZQUo5rCdB+DGGCthz3lD9YqHgr0aJ+/Ga4KDr0uWHGL/e2Xm1KAItvulWDVtQRF1n2Xj9r2e558OpYF8xqTb+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722922955; c=relaxed/simple;
	bh=pJzxN6ErICmuHoCjqiLqidgAMaots8ii45rYl6qVPfs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bRaZ3PydM3xrf3kzc62iNVy7GqW8+EZSMR6yaQcOW+cWsXyqHDcTS9moqHMeBBLKD1u6iICNGaXq4E/v1uEvoROwRf/RaZghGwx9ssi0VqnPvbCU3Wy0i2YtpcO7eOFjMt46CifdhyANsOTHP3u4QPidDnva0mPRcPlClxJFeWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfZTk3Ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D57EC32786;
	Tue,  6 Aug 2024 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722922954;
	bh=pJzxN6ErICmuHoCjqiLqidgAMaots8ii45rYl6qVPfs=;
	h=Date:From:To:Cc:Subject:From;
	b=MfZTk3IiFQcX7PLsNav9iDUusU1ZWEv9FaXHQ9NpL4zEOJeCfVbOuq0uuiEyee2q1
	 vqxnrQG4IzKx635OX0XZ9ksEakyYY1Xq8TkRcMMkYUP3koqH6Cj4vTCTIBbF9tDDH9
	 GzSK0eFIiIFf61zywCbjEcQWjU7NQrs3GAoJahQUKmt4J5ETBcp8rah3YtMkf0SLq8
	 NxZHFsKMzkNNwCcQ7Wbsi+Mzwv3LWNka0G7TH0+Y2FqF+lpM9GPbktN1cnFiQs+4dJ
	 1WPml8TGk4KVbW4aT1R/NBI3a68TaTH4zqoWBWN0CFY3nR6bPM4QAViZbyLD4Dvi5A
	 Xotokflu2J/sQ==
Date: Mon, 5 Aug 2024 22:42:32 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 19.1.0-rc2 uploaded
Message-ID: <20240806054232.GA3815137@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded the second LLVM 19.1.0 release candidate to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the initial
19.1.0 release happens.

Cheers,
Nathan

