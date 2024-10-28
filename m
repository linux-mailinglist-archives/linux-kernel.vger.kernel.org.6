Return-Path: <linux-kernel+bounces-384675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36A29B2D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68665282B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A548A1D416B;
	Mon, 28 Oct 2024 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DX2w+DMZ"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6F192B98;
	Mon, 28 Oct 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112210; cv=none; b=ZjfExa+g28f+85xYA0knoCJLIoASsUYpWyELRlW0sk70LwEWrq8fwBfiBVibJ/+6zHVSo9IvTUe2Em6rSVItnKrMu14h9eL3sRy6ayfVgg0rmZFQHcgoOqqBEhQsQyD1+UmcbasNb6DWCeNZm5o5/feQEpXmDgCv1J281gmHei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112210; c=relaxed/simple;
	bh=dKU44921LGxtTNZHWpKiGiGg9xvb/uYDKjrnzhUjTJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pVe8rCemu+S4YWej62mSM02Lv/DrlFyMHQBLLtXQY9JkjbYdKWWuSvoM4c2ADJwp3BzMzcoGlBKTASR3GTAccie6rqoAoaCBPPflmN1l+M6BVoVYhP8CSyG9QCNIiMdUawY/s3kRDywc/NICePSfUfn6x6PEj8eSiIlexdJZkPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DX2w+DMZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67E5FC0003;
	Mon, 28 Oct 2024 10:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730112205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DOgf6ez67TZng8zwmp8sVft1rCsBn9PrKnSYU3fqd8Y=;
	b=DX2w+DMZsjXeEOcfMxF897y+za+Vv2VoDcONqf09RAKxoi0f6P2gQfl9k8umxautxpMOaL
	eft7mBMVLmj4RKfeVZBRdGFq2CF7z0YNOg+z1/nO75j0LAqqsgGtFThhwWZ6OZsh2mY+Uz
	pUR0QuCuImCM5KYYtjbQ8t/bmxLGUQSN5sPjaucOBkOH68pdxaFVCaazioVD2ZBW6O6I/x
	toG8itNFd5UBtlQIpH7QOAqyFV0KmM18OlCJyx9zINsQnPgLyR4GNk/c5K5cfpEGW5jmPz
	4+9teLM9pq44NMQdGNkwZtotJygpYJGzkpsgFNFHTTNrTg3QsyPiayL5j8A2eA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Mon, 28 Oct 2024 11:43:24 +0100
Subject: [PATCH] riscv: dts: sophgo: fix pinctrl base-address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-fix-address-v1-1-dcbe21e59ccf@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAMtqH2cC/x2MQQqAIBAAvyJ7TtBFKPpKdJB1rb1YuBCB+Pek4
 zDMNFCuwgqraVD5EZWrDPCTATpjOdhKGgzoMHiHi83y2phSZVXLc3YUHEdCglHclYf+b9ve+we
 7JKHrXQAAAA==
X-Change-ID: 20241028-fix-address-e7f0c40eac2c
To: Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@outlook.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: thomas.bonnefille@bootlin.com

Fix the base-address of the pinctrl controller to match its register
address.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/riscv/boot/dts/sophgo/sg2002.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2002.dtsi b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
index 242fde84443f0d6a2c8476666dfa3d72727071b1..6616f578d190f7aa2a82b233fa9c55267b41ee0e 100644
--- a/arch/riscv/boot/dts/sophgo/sg2002.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
@@ -16,7 +16,7 @@ memory@80000000 {
 	};
 
 	soc {
-		pinctrl: pinctrl@3008000 {
+		pinctrl: pinctrl@3001000 {
 			compatible = "sophgo,sg2002-pinctrl";
 			reg = <0x03001000 0x1000>,
 			      <0x05027000 0x1000>;

---
base-commit: 45a544a62ef7cac9ecc69585a90da72ca68af898
change-id: 20241028-fix-address-e7f0c40eac2c

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>


