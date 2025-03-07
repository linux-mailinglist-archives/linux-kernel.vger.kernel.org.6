Return-Path: <linux-kernel+bounces-550215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C97A55CA7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53774188DECA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1CB13FD72;
	Fri,  7 Mar 2025 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Njf7QMD7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536FEDDA9;
	Fri,  7 Mar 2025 01:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309682; cv=none; b=t3LKAs05YOS22HQpN3X/n/w7lutiFKmWyokqSIszAesymrlC/enLRTfDaHuluQGxsFQuJX6jn1PKOXkbO+ycUSPDzU/mYvLME5o00sSxHzhtl7QCMAsfZnYUPlcR9pUrlaFlMBxC7Z9w0MOuVyUOk/acSLikNDwoSHBfygYE4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309682; c=relaxed/simple;
	bh=fpZX9r0ri866I0j++s9N+Bgxt0gF1Ymb9nhjREwFK5g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tRA9OsfjmL5mnAWtHxWej3SyjmW/q1qw087NpestbLdBmZV/Z0pBkHNGUYY+1Dm74Bh/Vt3PcnHm4STtzYZqvbC3mb7S++YjuFOLOh8+EDyUkoNrjsFVGw05NcDdFApPKqoexzMHNMXch3doBkwhRD4XUgYCrRrDall9YvLC9YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Njf7QMD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6A3C4CEE0;
	Fri,  7 Mar 2025 01:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741309681;
	bh=fpZX9r0ri866I0j++s9N+Bgxt0gF1Ymb9nhjREwFK5g=;
	h=From:Subject:Date:To:Cc:From;
	b=Njf7QMD7j/Bm1XlFCG3YOFrs4GSyAOww8DDK3IDbJ+V6RWoyV5otDGauQQqH1y8W+
	 1iXDuySq+kDmt9ytrvyJJGOEhd5irJTYLuoX/qsXisXZr5/YD0+Sd3Ibi3FFsXyKpu
	 Ffb9LoyGDvf4ehWpdHqOg3s7fQ4Rz4eQOYq6CTFOSuF1DRatRWgoduG3pVMv8QJYWy
	 RkBAXcaP9LOQvyY3MjqReHk4Sx0uHljOrk9rgWzddLCQeeKny0psPPOSNaDFTqAU0R
	 /ZK4G7CYtafXYLWeGY1wMw/XEC/WqyoPyo6NyJrpRi/Mg4EquwFxbWbOAzKAtss2YY
	 c/oAqCgrRtUSQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 0/4] arm64: dts: AMD Seattle clean-ups
Date: Thu, 06 Mar 2025 19:07:42 -0600
Message-Id: <20250306-dt-amd-fixes-v1-0-011c423ba99a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN5GymcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwMz3ZQS3cTcFN20zIrUYl2zRAtLC5MUoxQjc0sloJaColSwBFBHdGx
 tLQCV5oEvXgAAAA==
X-Change-ID: 20250306-dt-amd-fixes-6a8984d2d279
To: soc@kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

This short series fixes most of the schema warnings for AMD Seattle.

Arnd, Not sure if the AMD maintainers are active. If not, please take 
this directly.

Signed-off-by: "Rob Herring (Arm)" <robh@kernel.org>
---
Rob Herring (Arm) (4):
      arm64: dts: amd/seattle: Base Overdrive B1 on top of B0 version
      arm64: dts: amd/seattle: Move and simplify fixed clocks
      arm64: dts: amd/seattle: Fix bus, mmc, and ethernet node names
      arm64: dts: amd/seattle: Drop undocumented "spi-controller" properties

 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts |  2 +-
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts | 61 +-----------------------
 arch/arm64/boot/dts/amd/amd-seattle-clks.dtsi    | 24 +++-------
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi     |  8 ++--
 arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi  | 32 +------------
 5 files changed, 13 insertions(+), 114 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250306-dt-amd-fixes-6a8984d2d279

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


