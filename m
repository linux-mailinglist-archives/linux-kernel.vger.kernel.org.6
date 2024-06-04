Return-Path: <linux-kernel+bounces-201350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534A18FBD68
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B3DB26E28
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A264814B960;
	Tue,  4 Jun 2024 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvFP7NYh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C6A14A09A;
	Tue,  4 Jun 2024 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717533314; cv=none; b=uYoPEmDQLe6M9T4WlWY01dCXTx5l/GtJflFVQ7mFhCcgzc/89f4LsRZw+x0Ijjg6q52XZJ53/ZuIlGBRZo/vMv7O9ZdKDEN+7WM6uxLgNoHa/6HqeB6HCu6HVMEQJ544jTdgVsrwoAwOBhKb13XoJuhCr1Ftetb5kGhnrlpglNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717533314; c=relaxed/simple;
	bh=fORW5HAx4c9mQy9bSMECv7euO6lmhcHoxVtu+0M9HBs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TU/BPiX1QKXKw1atmFUiAYaZLhj2QGmfE7vE5i3hXQ71DlNrrj/sluk3pbx8Y0SVDcRESeSkoaC9QTI8CoH9nWW1xXGSZRngCGqBoB2k27GOCA7PAxKby+d8oyFUbPRCN3g8uRKz8kVavHFZjutjkirRmlrQdRVFzZiY/bC9Y8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvFP7NYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33018C2BBFC;
	Tue,  4 Jun 2024 20:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717533313;
	bh=fORW5HAx4c9mQy9bSMECv7euO6lmhcHoxVtu+0M9HBs=;
	h=Date:From:To:Cc:Subject:From;
	b=SvFP7NYhTdI46enbAZmEci1g4EVeyUaIRocpFrKtStkNv1Zxyo4re2SEQymgbvMA7
	 fWHfSxm8pUuHB7FZljovKagB4QrZHMGsCoV1XSIGICW++wex1gl1P2QAnvLeaDNmoq
	 l0VwcU/VMQeKXdri7OQTeu7a1xuFugP3IS1UIkMwbRgFUZbCZ3f6P9KQ4qJ/jXdLMV
	 0/sFiupq0vfpOhDMOjgpRdUjBrLK5RlCbt9G0FkXrU58q1kQqv+vpCQykTPSqFbDdQ
	 8VZPXdk3k1ueJmD0TRcUSy6qnBVHLREMUxM7soAPvfKLr6xz3MzSOB02ZZa7dDoHzr
	 UHqP4TcY7MGIg==
Date: Tue, 4 Jun 2024 15:35:11 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.10, part v1
Message-ID: <20240604203511.GA1345593-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull a couple of DT fixes for 6.10.

Rob

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.10-1

for you to fetch changes up to e7985f43609c782132f8f5794ee6cc4cdb66ca75:

  of: property: Fix fw_devlink handling of interrupt-map (2024-05-30 19:43:47 -0500)

----------------------------------------------------------------
Devicetree fixes for v6.10, part 1:

- Fix regression in 'interrupt-map' handling affecting Apple M1 mini (at
  least)

- Fix binding example warning in stm32 st,mlahb binding

- Fix schema error in Allwinner platform binding causing lots of
  spurious warnings

- Add missing MODULE_DESCRIPTION() to DT kunit tests

----------------------------------------------------------------
Jeff Johnson (1):
      of: of_test: add MODULE_DESCRIPTION()

Marc Zyngier (1):
      of: property: Fix fw_devlink handling of interrupt-map

Rob Herring (Arm) (3):
      dt-bindings: arm: sunxi: Fix incorrect '-' usage
      dt-bindings: arm: stm32: st,mlahb: Drop spurious "reg" property from example
      of/irq: Factor out parsing of interrupt-map parent phandle+args from of_irq_parse_raw()

 .../devicetree/bindings/arm/stm32/st,mlahb.yaml    |   3 +-
 Documentation/devicetree/bindings/arm/sunxi.yaml   |   6 +-
 drivers/of/irq.c                                   | 125 ++++++++++++---------
 drivers/of/of_private.h                            |   3 +
 drivers/of/of_test.c                               |   1 +
 drivers/of/property.c                              |  30 ++---
 6 files changed, 92 insertions(+), 76 deletions(-)

