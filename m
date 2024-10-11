Return-Path: <linux-kernel+bounces-360927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B254199A173
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF84281CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB1212F05;
	Fri, 11 Oct 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYRwUg99"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D24212636
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642847; cv=none; b=QmNYkczj2+vqOa4lsH+LklmtU623j5HiicBI1E2tganhazKDXxBjUzpGxlw8rPDmwkL2ouLO7L0fKE+WFBcRPn18K/UzpCjoZozU7GsO3qHyVr6pm7k+4xerMOJxrEOlL+wZcPzt7WoF4eauJ/NHyiSuylTrGhQezIVXZ5klAbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642847; c=relaxed/simple;
	bh=Oq0L/QItMXTcWCVlSe/UxkCy03fNvzNKMSL9QGcpxfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PmKEilBqw/0VcMamkJgsaHwXdAVNObaRr3Z2V2xZoqdt+vDa/uNGEAO/Ew8p433aaye6NOOPl1vctoKQPk7UR4KC9BPHudoU1RYHIYCy25dl3kjRumZBsDz8Q87fPuOgFwSP0E596TZYT7J/zX7v8sLXBinNi2TE5g31Nnj2GcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYRwUg99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D273EC4CECC;
	Fri, 11 Oct 2024 10:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728642847;
	bh=Oq0L/QItMXTcWCVlSe/UxkCy03fNvzNKMSL9QGcpxfY=;
	h=From:Date:Subject:To:Cc:From;
	b=lYRwUg99LfZjq1UJZDCj64lRlp6n5gxB/9uJ8YmJEmvZ3FQuD2qrzSU8g2sKuZMQz
	 4lnDcdvl2+ftECiBqOtN1VeNmjQm1qa4mrhgsEGDgWvXa4bdCjpy7tGBIWv7LqoSBR
	 ffeVmZgDGrdULDnjGLkvH/ua0HuBb62I+0lOk3hBseX6bpSsjq/gC2TKilqQ7X4glf
	 STKlmz7IjFCPPZOeAWebz12KpwwMG34cYgJv9ucXK3sVEpMxfS6Xf43jiCBV2wiLfB
	 KDqsQO3pfBGXJkldj+yPEGy2b5qoJJ+hWdTypb81I8lH0flFpWeLutSIaMAbO3YIlw
	 g6p7GjP3dP9bA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 11 Oct 2024 11:30:25 +0100
Subject: [PATCH] arm64/sysreg: Update ID_AA64MMFR1_EL1 to DDI0601 2024-09
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-arm64-aa64mmfr1-2024-09-v1-1-61935a085010@kernel.org>
X-B4-Tracking: v=1; b=H4sIAED+CGcC/x2MQQqAMAzAviI9W9jGUOZXxEOdVXuYSgciiH93e
 gwhuSGzCmfoqhuUT8mybwVsXUFcaVsYZSoMzjhvjTVImhqPRI1PaVaLn0ATcKTA3DqK5AKU+lC
 e5frP/fA8L1ceeLhpAAAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Oq0L/QItMXTcWCVlSe/UxkCy03fNvzNKMSL9QGcpxfY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnCP8cwNgXtoN6Jzs+fny1TcaoYb06IKOAyPPFF
 1Xew3L51VmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwj/HAAKCRAk1otyXVSH
 0OkJB/91NA5kWNS1Sw2vA+SEa6Rlv/VQKlsh744ZZnxvTZSQ0FzdkI8OkfghqXAgEQHV7P3YzVP
 IAHIjRPrBWjhGXi2fRCYYj6Ui7/IT/47rORS3gJTyQoV5Sb7bmZAaqT5f58RnEszGIVvOyQSZrM
 0RlZhlKZlKsC5WURONp5We6EoTX5F+M0gZYJ57WRjin8sbDtmpyLCOhIEUD3xUSxoD9n/hIVpa6
 nW2IyMtgUADBfrS3fHjLbkT1wb2xCT27JKSP23lu/duN919BBZdhUy+FfHxkIqInJ2YlCy7gQfN
 JxhGPKt8hegzWoe1GouOzqjAIXFF20RbNMSmml5xwLPFWP7l
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

ID_AA64MMFR1_EL1 has been updated by the architecture to enumerate several
new architectural features since the last time sysreg was updated, sync
with the definnition in DD0601 2024-09 to include two new versions of each
of ETS and HAFDBS.

Reported-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8d637ac4b7c6..ae64ba810298 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1648,6 +1648,8 @@ EndEnum
 UnsignedEnum	39:36	ETS
 	0b0000	NI
 	0b0001	IMP
+	0b0010	ETS2
+	0b0011	ETS3
 EndEnum
 UnsignedEnum	35:32	TWED
 	0b0000	NI
@@ -1688,6 +1690,8 @@ UnsignedEnum	3:0	HAFDBS
 	0b0000	NI
 	0b0001	AF
 	0b0010	DBM
+	0b0011	HAFT
+	0b0100	HDBSS
 EndEnum
 EndSysreg
 

---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241010-arm64-aa64mmfr1-2024-09-ba9ee72aca29

Best regards,
-- 
Mark Brown <broonie@kernel.org>


