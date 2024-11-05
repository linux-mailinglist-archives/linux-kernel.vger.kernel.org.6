Return-Path: <linux-kernel+bounces-397157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0989BD77D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD68283F82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32380215F52;
	Tue,  5 Nov 2024 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny9sCyO6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7363D81;
	Tue,  5 Nov 2024 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730841529; cv=none; b=dvYa7KK1f2nxopGgDWPVI+ZQHNXcWymFNV1hiOLd+EIiOz9wo3dcL2TyHKtVzO4rWpfufdOzGYd99oCHovALkGn92aS5AQySmHW93kW+bVPnKSBQmtVFm9FisMbm+4TZjLq7PHirU/ZIRSCD9q7TBn2gsoESih5SEIyxAe8/U/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730841529; c=relaxed/simple;
	bh=ITqqGq6mWtWfAtqIp8o0iLGvCeORRBMChO8HBBT5CJQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EDxF6xgESv7vZL/JQbfdmHMqDRDnBzO+w7nrDbTmhr0UmrFtlZNkZQK3XErvkPAWLHtN+OjiYl92bZn87j2Jrur7kq3l3tSowCHsPeppkT0RZX7JkTgq6TV3NfL0Bmxke9STVVPlYOv+UZZDtXBcttYodqWZpAdBluFhBgsv8a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny9sCyO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08673C4CECF;
	Tue,  5 Nov 2024 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730841529;
	bh=ITqqGq6mWtWfAtqIp8o0iLGvCeORRBMChO8HBBT5CJQ=;
	h=From:Subject:Date:To:Cc:From;
	b=Ny9sCyO6mFQ3XL9ao31MrZF9ooikmFG6s6XV/aBBCvYDQrH1D1qzfCsKcSn/xTEJ7
	 QwxvKM07WDP0NvT3wVLx/5m4JQzB4V+0UoijRdoI4+6rBeR5v3Gj6gqlVxLU73r9hu
	 S2FHh3GZ62ZoeNFbl5OoJBWTEZniFu50rGrFpnt4wx2Y6SFml9ReW5N6BfwajOsLAT
	 pAy7sKp9am8qMsDijiHE+Sre7aj92gnIm2M9SyLKkUCzQD/RzGhunIois98/bWr42b
	 Md09g0x8T1UIm09ya3ZGPSNxxVx6XtpyxlUb1DkfMUeXJwtKgBKfaXlx/2pC3KSE5n
	 AgRtFFbv2v6JA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH RESEND v2 0/2] arm64: dts: PL022 clock fixes
Date: Tue, 05 Nov 2024 15:18:38 -0600
Message-Id: <20241105-dts-spi-fixes-v2-0-623501e5d1ca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK6LKmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxNDQwNT3ZSSYt3igkzdtMyK1GJdy2Qjk1RzczPjNOMkJaCegqJUsARQS7R
 SkGuwq5+LUmxtLQDbJBfPZwAAAA==
To: soc@kernel.org, Kuldeep Singh <singh.kuldeep87k@gmail.com>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chanho Min <chanho.min@lge.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev

Arnd, this series[1] from 2.5 years ago was never applied. There was 
some discussion on the lpc32xx patch, but nothing on the first 2 
patches. So I'm resending the first 2. Please apply directly.

Rob

[1] https://lore.kernel.org/all/20220311093800.18778-1-singh.kuldeep87k@gmail.com/

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Kuldeep Singh (2):
      arm64: dts: seattle: Update spi clock properties
      arm64: dts: lg131x: Update spi clock properties

 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 8 ++++----
 arch/arm64/boot/dts/lg/lg1312.dtsi           | 8 ++++----
 arch/arm64/boot/dts/lg/lg1313.dtsi           | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)
---
base-commit: 6f2ca0f00f319c694ad5bb494b64745a43b40756
change-id: 20241105-dts-spi-fixes-9c24e7763f3b

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


