Return-Path: <linux-kernel+bounces-263628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387C693D86C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6942815A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803D74CB37;
	Fri, 26 Jul 2024 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaJIT8QQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D32482D7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019123; cv=none; b=Oq3LlovXqkwV9VpiIMxcl+R6JNnPyDzWgZW+s5ogghW3TTo54kdB1fSf+Me3R8Oe7HcouR8wNnVVtPLRER/s9E4RqMPF+CizN4VgbJ75pGkVXZgCHmzVthjysXqCYqlAov1O/a5TCz+D8j3RqCD0ot2nUoNuVRSQLjcDPPZVu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019123; c=relaxed/simple;
	bh=yNIQL6oRiqBKwOBRftDEcZtXqb13kdM79vCiHX74Z4E=;
	h=Message-ID:From:To:Cc:Subject:Date; b=jXolBwYeI6F1HRQlt2PLAlViYAaPbFZBLGyc2x87DkDUs0H9IXgfj1zFIKqQCtWBoAWQDvU7ftPVAgqr6ayNA61YEWZ3MG5rYosxclE2m+uZ5silJpSzcHN6yccx/VtHaX3U+0+bNZ94wfDgklgsNnxtPMk9E9hMxwWa21KipE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaJIT8QQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC686C32782;
	Fri, 26 Jul 2024 18:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722019123;
	bh=yNIQL6oRiqBKwOBRftDEcZtXqb13kdM79vCiHX74Z4E=;
	h=From:To:Cc:Subject:Date:From;
	b=qaJIT8QQ77Seowh+L6+QGiYHYS+Ugt7687AG4Tc0iDZArerNauXyntvakzH7alhnp
	 2AW/BUz7kKoQuqJe6dsx36rIeI3zg66qY8AFpioVia9ExGV6mteK/Yq/2JL40bJcCG
	 kQhS9Oq0lit50AJvsGElxxRE+KT01zhQTM1uy+xadZ/raG7eyrtL63U6Y4mo3D+ivM
	 W44nl1uVREmmT5Y2YQPlaph3fbEsH9Dk0uhifXghiGc5CqdwhCqVctZWSTGWdv3o4o
	 6vg+lcF7nKL51qqsubLnHqlQq1YufnmAhVOuBuPLPSRcLQ8ePvyd8ACCXmIoBA6lTp
	 Ax+9KvkXU6djw==
Message-ID: <e50192fb5b0b56a8af3c45c47d235cf5.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.11-merge-window
Date: Fri, 26 Jul 2024 19:38:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit ef0b29e744965e8abc14260503a559366219035c:

  regulator: dt-bindings: pca9450: Make interrupt optional (2024-07-08 12:50:21 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.11-merge-window

for you to fetch changes up to e975d955c07cbc2cd6a83a5d8235d8373441fdb9:

  regulator: Further restrict RZG2L USB VBCTRL regulator dependencies (2024-07-26 15:11:25 +0100)

----------------------------------------------------------------
regulator: Fixes for v6.11

These two commits clean up the excessively loose dependencies for the
RZG2L USB VBCTRL regulator driver, ensuring it shouldn't prompt for
people who can't use it.

----------------------------------------------------------------
Biju Das (1):
      regulator: renesas-usb-vbus-regulator: Update the default

Mark Brown (1):
      regulator: Further restrict RZG2L USB VBCTRL regulator dependencies

 drivers/regulator/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

