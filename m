Return-Path: <linux-kernel+bounces-225765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE9891350F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 18:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5097E1C20CD9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 16:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2135170820;
	Sat, 22 Jun 2024 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCOFRe2A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638016F82A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719073657; cv=none; b=ZLkRfN5asc/YJsmllGQw+XwRJvp6ldks28BHl9fJ4PxC9nQMxzzdH0MPMwC0Hj/b+jEzWMSUOtxS1nFAX/BWxG0CNdL+HetvVWWbJFKIhBMdF83nUCt4dSfPjaMZxKwccM9ZUwGsn6z5mOoF2Ior92Du03+I0cted4PZUSVjczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719073657; c=relaxed/simple;
	bh=e2IaS8At5FpY8lmuwQ6MAQ9s2wzZ0gyMj8scn+IVTEI=;
	h=Message-ID:From:To:Cc:Subject:Date; b=T+mcaKdtp3tqz++k33ygLCtvxSqr4E8/rh72i3wZGOW/Dk4wdne1sYBub0VkTligJWpe11wq1M310AKXHCGXTIR7ARDRT7nBWZjdi4VQMRjfXDKJIZwRNKJ8dAEFcRxFdFE/GfL/X+JLxNXhkoZKHGB2GrPQBl5XK8uFFQUonKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCOFRe2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E1EC3277B;
	Sat, 22 Jun 2024 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719073656;
	bh=e2IaS8At5FpY8lmuwQ6MAQ9s2wzZ0gyMj8scn+IVTEI=;
	h=From:To:Cc:Subject:Date:From;
	b=XCOFRe2A6gkQKnoyb50tI8NGboRW4iMe+Ua22I/WG+QkG6QlfprubhuJpmVkjjGOd
	 V3ocpWu2qfUwtQizF6QLnLwZD2HHEmuXNDD+XQrfAZ1SmFYabwyjL2AfxAXKyZncYi
	 NdkI4sLdqkIoOfttek3ljSf1rvga41iQSfKWqUHx6YUU8EeugkNf9ZZ4t8L9IrOD+m
	 RLHE4UQykvT7MwmMPOVC4OG5vRp98WQDLpNI4tPy3hZ05YN26KGy+r769NswNwQ5C1
	 GgS4bSe3HGeBjawKQJbUWACJrKnbKlUMjuwFCZ/P8TEYiFvPI8FgbRsnj+Ebqs444b
	 IBkNLIAg6d9WQ==
Message-ID: <f91a2271e0971d201278b80773b6a6b4.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.10-rc4
Date: Sat, 22 Jun 2024 17:27:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.10-rc4

for you to fetch changes up to 0057222c45140830a7bf55e92fb67f84a2814f67:

  regulator: axp20x: AXP717: fix LDO supply rails and off-by-ones (2024-06-12 21:30:43 +0100)

----------------------------------------------------------------
regulator: Fixes for v6.10

A few driver specific fixes for incorrect device descriptions, plus a
fix for a missing symbol export which causes build failures for some
newly added drivers in other trees.

----------------------------------------------------------------
Andre Przywara (1):
      regulator: axp20x: AXP717: fix LDO supply rails and off-by-ones

Biju Das (1):
      regulator: core: Fix modpost error "regulator_get_regmap" undefined

Kalle Niemi (1):
      regulator: bd71815: fix ramp values

Thomas Richard (1):
      regulator: tps6594-regulator: Fix the number of irqs for TPS65224 and TPS6594

 drivers/regulator/axp20x-regulator.c  | 33 +++++++++++++++++++--------------
 drivers/regulator/bd71815-regulator.c |  2 +-
 drivers/regulator/core.c              |  1 +
 drivers/regulator/tps6594-regulator.c | 12 ++++--------
 4 files changed, 25 insertions(+), 23 deletions(-)

