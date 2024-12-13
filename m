Return-Path: <linux-kernel+bounces-445164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AA39F123D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F4A162167
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA28D1E4113;
	Fri, 13 Dec 2024 16:32:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D941E3DD7;
	Fri, 13 Dec 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107550; cv=none; b=ClDKhwyTOOSfopBkakRq99U4aclSdodSzdIMEkQ7MkZwEJu7EgpMfdkHmNcO+gmWrdNx+qdefsLbqgYDhrSIGQUoG0irtxQOL8OUXP43jBCDv2pMmTMYNmExgIGKmuYwUSGbyrtodhP7L9w59hksBDEEpGW2srU9uZNwvjE3264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107550; c=relaxed/simple;
	bh=3iIGP2hOIj4VbIPNL9RRmI01WU5S2lBJExWB0gvxekc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXpP1blr5MUWghTfhPhPbolAA5zsR5esgMTLDHwl2XWzNlhh//Btfd3Iwx2tSLM2cnyO4r10bIra1pP5zRhsWsUG0zM8maSv3NYPTuz0dgQBPUAE5SEcsCkePN1EYbPx6Lot4cCk69jLhLV3tEoxz1WQD0iva07YZIdkx3mVlJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41DC41595;
	Fri, 13 Dec 2024 08:32:54 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D4933F5A1;
	Fri, 13 Dec 2024 08:32:25 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vincenzo.frascino@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 0/8] arm64: dts: Add Arm Morello support
Date: Fri, 13 Dec 2024 16:32:13 +0000
Message-ID: <20241213163221.3626261-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Morello architecture is an experimental extension to Armv8.2-A,
which extends the AArch64 state with the principles proposed in
version 7 of the Capability Hardware Enhanced RISC Instructions
(CHERI) ISA [1].

This series adds dts support for the Arm Morello System Development
Platform.

[1] https://www.morello-project.org/

To simplify the testing a linux tree rebased on 6.13-rc2 is accessible
at [2].

[2] https://codeberg.org/vincenzo/linux/src/branch/morello/dts/v1

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (8):
  dt-bindings: arm: Add Morello compatibility
  dt-bindings: mailbox: arm,mhu: Add missing properties
  arm64: dts: morello: Add support for common functionalities
  arm64: dts: morello: Add support for soc dts
  arm64: Introduce Arm Morello System Development Platform
  arm64: dts: Add Arm Morello System Development Platform support
  arm64: Enable Arm Morello System Development Platform support
  MAINTAINERS: Add Vincenzo Frascino as Arm Morello Maintainer

 .../bindings/arm/arm,vexpress-juno.yaml       |   3 +
 .../devicetree/bindings/mailbox/arm,mhu.yaml  |  10 +
 MAINTAINERS                                   |   6 +
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/arm/Makefile              |   1 +
 arch/arm64/boot/dts/arm/morello-soc.dts       | 267 ++++++++++++++++++
 arch/arm64/boot/dts/arm/morello.dtsi          | 112 ++++++++
 arch/arm64/configs/defconfig                  |   1 +
 8 files changed, 405 insertions(+)
 create mode 100644 arch/arm64/boot/dts/arm/morello-soc.dts
 create mode 100644 arch/arm64/boot/dts/arm/morello.dtsi

-- 
2.43.0


