Return-Path: <linux-kernel+bounces-197203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4D98D677D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194261C24F79
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E68176181;
	Fri, 31 May 2024 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsQQe8/3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B83158869
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174545; cv=none; b=RF9m3pkIfw+4JegHCBb7BAD24nFmwd0YcQMYkif2N4T5GLb9sDIVdNiwbRqDDuXUbyH7T65CmLzMBcpIp71PpbNId8PuRorLpaTyiqilEJWofWuNLbF0fk+R1vcRL9EtMK6V1D69qRjj9uK4j1x09P4MtxY7H0UYvyAtjAWBRYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174545; c=relaxed/simple;
	bh=IRc4uSV8tqEkuKCHVh9bSaenQRqN5VARcm90v+3+buM=;
	h=Message-ID:From:To:Cc:Subject:Date; b=SjTiJbDE1e5UlVnu3VBJzUxI6FCRU1RYfKv+BpMJrMo19lknUkJArAzmX1Rx8VBKyK3wkgoztFeCX6Rt3rX2szgqoF8LP1ymKBlTKSKn5YljKcDU9qCYyAr7/oDCr77dltKQ4HpQ+tsMUge+Z7BymhE3Td2gll83Wsr7N+pW8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsQQe8/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B894C116B1;
	Fri, 31 May 2024 16:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717174545;
	bh=IRc4uSV8tqEkuKCHVh9bSaenQRqN5VARcm90v+3+buM=;
	h=From:To:Cc:Subject:Date:From;
	b=TsQQe8/3vWmS5MaE3LA7HbgpGfWOlGBNJ62065+fuRAI/rXv6wJHVvNY/8Lw5nHxv
	 bYrwKLKJRPB800jCPTKuMz44UxJHr4Cby949WWcS0158hDupCIWKCxizQDsEx8WYhU
	 vKXVQAFLwoM2arZNMNXHiQaQcE3cLSiTcGXgimJc1c6huNJNx1NTeopyBb+oycXOqj
	 AbeuVotjPtqGrYz1BD8cWstK5WztXpC3Lk25q4aaRbGP9SZkL21Db1JSVuRmITRnqj
	 UosGWoFen+oFscj0qYBPH3MefI6Xv8iQYpr+cKSZpStMK7EfozMtE/FP/Q19+avSuc
	 LMkAQHIsnHx3w==
Message-ID: <61fbae7ae23cc7bdb6d20621db77ebb4.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.10-rc1
Date: Fri, 31 May 2024 17:55:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.10-rc1

for you to fetch changes up to 72b6a2d6506843375c7b91197f49ef38ca0c6d0f:

  regulator: rtq2208: Fix invalid memory access when devm_of_regulator_put_matches is called (2024-05-28 13:22:54 +0100)

----------------------------------------------------------------
regulator: Fix for v6.10

One fix that came in since -rc1, fixing misuse of a local variable in
the DT parsing code in the RTQ2208 driver.

----------------------------------------------------------------
Alina Yu (1):
      regulator: rtq2208: Fix invalid memory access when devm_of_regulator_put_matches is called

 drivers/regulator/rtq2208-regulator.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

