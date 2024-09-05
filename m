Return-Path: <linux-kernel+bounces-317926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 930CB96E59E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41E22B21601
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886CA19EEC8;
	Thu,  5 Sep 2024 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVHn8XXF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BFE14B95F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725574174; cv=none; b=P+wIs5dHojvCORRfp3N9DzJED9fP8u6+WVCpDKZTU2UJHpyOpvqGD72N6m052eeWSm4lqu+ZYsyQ/R5zwht8nxoKSW5/F/oQOk/WT5q389JVUNjCVg3fTojCnQy0CoAX0ocmZdjwut5MV5HlhHCr08uptvLsFJMRc01bPkMohF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725574174; c=relaxed/simple;
	bh=mfkD7wV6Gy1CK5SHQXwGcVxtdxvU+GitaP24okbq77g=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Fyh2TzDxIkw/Bamk7uKJYiNlL3fBuKJOyF8gFEwLZw1ZF6f2z2KzGiB6O1t2Sw1mcEeDMYoAbjuxntY1SHJOi7GVo5yGRNcVYM8/CQAR4ChNvKukMU1jDHlKt6Vg6BE2wUUAME282qntnsc4GG5c9XRYavy196N3tXudrJOifx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVHn8XXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10134C4CEC7;
	Thu,  5 Sep 2024 22:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725574173;
	bh=mfkD7wV6Gy1CK5SHQXwGcVxtdxvU+GitaP24okbq77g=;
	h=From:To:Cc:Subject:Date:From;
	b=pVHn8XXFSP07rWuKRibWRoBUZjW2F04fLAcYx9SJJ3kmRnhkLT06uIucGUoE06Uwf
	 0VBJNoG7c4AP8enTy4UZzjeGDUDeAVSX2L4pvIw7WuVM7ZygxWkR7mcXXboYZ8n8CH
	 nT5NJjfB+B/G4u0WhHum+ZAFS5a6ISNV7GJQDg7ZTEeN0QakTPGI1welk7sBc2b/nS
	 lGtwsXGZ07kUnwYtVAG1TXTD+spwG9GWyFWEJ/5gqxDhRDop5WFUKTdd+9QLDEKROb
	 GUDzczRoj6ZSa21aWmckUko+zqgEXZUqlYeHUJfIGDIESScjb584UkmEvLuBdvrxno
	 m+uDZeZmG236Q==
Message-ID: <328dea14aef5ae409040961478b6a083.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.11-stub
Date: Thu, 05 Sep 2024 23:09:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.11-stub

for you to fetch changes up to 1a5caec7f80ca2e659c03f45378ee26915f4eda2:

  regulator: core: Stub devm_regulator_bulk_get_const() if !CONFIG_REGULATOR (2024-08-30 15:43:52 +0100)

----------------------------------------------------------------
regulator: Fix for v6.11

A fix from Doug Anderson for a missing stub, required to fix the build
for some newly added users of devm_regulator_bulk_get_const() in
!REGULATOR configurations.

----------------------------------------------------------------
Douglas Anderson (1):
      regulator: core: Stub devm_regulator_bulk_get_const() if !CONFIG_REGULATOR

 include/linux/regulator/consumer.h | 8 ++++++++
 1 file changed, 8 insertions(+)

