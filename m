Return-Path: <linux-kernel+bounces-175723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E3F8C2411
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31608284088
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DD216EBE5;
	Fri, 10 May 2024 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO+CPuxH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B821340
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342301; cv=none; b=cwBwvSNOU2TstVPx0YoVeo8GhJkr5Up25X2jmCg3Z0NSgtkbVg7tQVWaJJK9be/dOPqhaLd6beehGN/jjuRNW/rwPtQ4DS0B95RWkRrorkYSmLSg+lp7uwCrFUB8LHsu68TYmloYrCCtMxQiNdB8dgYmPgW3gASv4BP0M/s5U5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342301; c=relaxed/simple;
	bh=l1+qHEhMt9OAwRHmaM4J/Mj6s8ThW/PsHrbGScytz3U=;
	h=Message-ID:From:To:Cc:Subject:Date; b=IaEFSjblqjcEPHX7qVLC+da0fEvswtZgry2/+k4OrWecxbtDnXdctCn7qLdjlZSot8VdrikAR3iE20ICDS1uBPqqCRDClEXyIuN/Ib9wlgvCq3twbPX4la8mHGUL7zyCsRhDzM832Vmmh6QqNlQrJeQl/P7oXhqqaa2U2BAEFc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO+CPuxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9860BC113CC;
	Fri, 10 May 2024 11:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715342301;
	bh=l1+qHEhMt9OAwRHmaM4J/Mj6s8ThW/PsHrbGScytz3U=;
	h=From:To:Cc:Subject:Date:From;
	b=PO+CPuxHDeXr3dP49DI0viTOxFiKrkvueHFxHZS6aUPjHU5ty8yU4kw1/jlC5pBKy
	 qoLjt6wKBA084dX0/ToKYBCBFAaNs5CgTgo/gV88fW1GrRpU9seSUjyES9tyyL+AC/
	 Bv0mmavafFNQMglwkuxwX3mKFqv9TpPo4aPP6Fy2ucGIFUr8FSIt7/39VYvSAFQgGw
	 rLEfFxceCQCqzm7sVcsHn6eZukZt4ZArNxWFVnZEPgFBKblFcBUvAd6EzAotVBrMPp
	 syS12ta3ps7if1S2JuEiA+BweetfokGck0yofMiednXXwhLfMguMYrRBo7nFce1o5G
	 vRFVk4LsFqOCg==
Message-ID: <5a083c1fa21b73db20ea4b8a8c86a5c9.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.9-rc7
Date: Fri, 10 May 2024 12:58:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit ff33132605c1a0acea59e4c523cb7c6fabe856b2:

  regulator: change devm_regulator_get_enable_optional() stub to return Ok (2024-04-24 10:13:30 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.9-rc7

for you to fetch changes up to 2a4b49bb58123bad6ec0e07b02845f74c23d5e04:

  regulator: core: fix debugfs creation regression (2024-05-09 17:43:57 +0200)

----------------------------------------------------------------
regulator: Fixes for v6.9

Two fixes here, one from Johan which fixes error handling when we
attempt to create duplicate debugfs files and one for an incorrect
specification of ramp_delay with the rtq2208.

----------------------------------------------------------------
Alina Yu (1):
      regulator: rtq2208: Fix the BUCK ramp_delay range to maximum of 16mVstep/us

Johan Hovold (1):
      regulator: core: fix debugfs creation regression

 drivers/regulator/core.c              | 27 ++++++++++++++++-----------
 drivers/regulator/rtq2208-regulator.c |  7 +++----
 2 files changed, 19 insertions(+), 15 deletions(-)

