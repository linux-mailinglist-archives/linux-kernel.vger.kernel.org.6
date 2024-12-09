Return-Path: <linux-kernel+bounces-436939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E09B9E8CE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C881886872
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50435215171;
	Mon,  9 Dec 2024 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Jxc9xGMK"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC7C21516A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731307; cv=none; b=gjyysAKGNjOIiwoAkBYUrmRjlu6dETZA5rappUm42+QqseAHHA00FEkdDqQKQI31TMvS1+U3J6Zt6gFkxJS0blbWPUYrLeNxwmq9oJ14Cn7vPzE8JYIp9oeQuIwXmUBrt1vodma8Y0OhqvLMsa4eZRF+0Zirhz7BuHZB/za/CBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731307; c=relaxed/simple;
	bh=euiQk/GCI+bp+pu7KciWhX1UAtRzddPAULx6OOPQAFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSb2U+zD+tgopzHdF787DqGlBque+h/tB4F8z4bWw8ht6Kq67BDAFsgsVpf+BMg+W5ET1z9cHjZ30gbsGXOyJvOi776Jm3mkv4459Xth7W4bWevX6j/0EfmFt4sM50OmTy8FraHcDdcfaJfy5RvYMO8IeregfkdEf+xS4F+vJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Jxc9xGMK; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Jxc9xGMKduo5uvpQ4VlwVi/1hbzz1yqr2xULY/u4oLxx4njYxbNrFLBKy+xaNL7PORSahY266J62RtZ5aOcfno7yS0Bv7oyfIgQGWAYaNBQA+qZfnTiK2BrENCb8YaYINDfJU0A1hTA6ptDR7afF2Rp4XSsAIRj4GPpGCOR+RT7OyWSecx+s5B3n1YRSBUKCWI6Yao0cS1+oETEA1klWaziCJ/nwxzHMBnfeUDrO0ZKPCW4Lm+p1E28QLTq7ra3d0B5Wrc6L/f4iW9o5KVx9JQJKiHoXBGh/54RyumebLk8AJoumJMYS7bp2Pp0Ic57oT+PWt7KN1DFiFFclvD5GCQ==; s=purelymail2; d=purelymail.com; v=1; bh=euiQk/GCI+bp+pu7KciWhX1UAtRzddPAULx6OOPQAFo=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68229:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1477585645;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 09 Dec 2024 08:01:13 +0000 (UTC)
From: Umer Uddin <umer.uddin@mentallysanemainliners.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	igor.belwon@mentallysanemainliners.org
Subject: [PATCH v7 1/4] dt-bindings: arm: samsung: samsung-boards: Add bindings for SM-G981B and SM-G980F board
Date: Mon,  9 Dec 2024 08:00:56 +0000
Message-ID: <20241209080059.11891-2-umer.uddin@mentallysanemainliners.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209080059.11891-1-umer.uddin@mentallysanemainliners.org>
References: <20241209080059.11891-1-umer.uddin@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Add devicetree bindings for Samsung Galaxy S20 5G
and Samsung Galaxy S20 board.

Signed-off-by: Umer Uddin <umer.uddin@mentallysanemainliners.org>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.y=
aml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index 168e77375..fab29f95d 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -241,6 +241,8 @@ properties:
           - enum:
               - samsung,c1s                     # Samsung Galaxy Note20 5G=
 (SM-N981B)
               - samsung,r8s                     # Samsung Galaxy S20 FE (S=
M-G780F)
+              - samsung,x1s                     # Samsung Galaxy S20 5G (S=
M-G981B)
+              - samsung,x1slte                  # Samsung Galaxy S20 (SM-G=
980F)
           - const: samsung,exynos990
=20
       - description: Exynos Auto v9 based boards
--=20
2.43.0


