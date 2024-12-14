Return-Path: <linux-kernel+bounces-446004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3229B9F1E6A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 13:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2C51887A52
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 12:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAD9190072;
	Sat, 14 Dec 2024 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="bU9ZvT68"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A9917B4EC
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734177643; cv=none; b=dee4/fFpYsiJwgRNxEUg+pLOyOvEbSLqeMJJQW/I1giM4HIQZKdp5V4hS1TJH/g9RG+Zo4rgQIRTyd6G5cMc3iQSnEYp6d0Y59pNJ+OlcOyk8rUzTnynbPeVAQoo82MCI8zQWDQAu9dN/pX1fe5sr0U6NnXT7nush7Dg+mf1buY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734177643; c=relaxed/simple;
	bh=vZjQH4jLLh+PJA7ZEulwt93RcdAvvXTWLz4r72z3nAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sichumre+u6e41jfoqNniZq8dWAGUKlFTEy8YE6EW5ynrjtMmaJ+hTm9luDTXtQdRVKfdUAXw4kaT714zLMnamhowNocowtrXzT0Hnemm6dnisoRHprYPtbiEzEZ6r7gDso8CRsHoKdl5mC8A30tAExzy3ZKbdrlVj3AOtuay94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=bU9ZvT68; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=bU9ZvT68b35Vnf/jG+nfSrI+u3RPLfDLpdt/v0IuELutyH6qBHcNxA/9v4cNA0OWm0qwy2Abbu4H+2hht2o6uFqsSWFI6qEwMkE538QD/8XH9Gim/mmS/2XBVmLuH+YrKXr7ebNVbY7Dz4y1aT2jeY914OjR4TmgU6x8DWAUW/D0ysEoRxPWnCguuxCFsPJIOd4VCvZ7PTZnjhMKntL3vECtxyYWR0bERB8zB8pms/9JIstrYj14q7EBkYmP57VJIOZbel0u402ZxNXiDYKG3L2LnYXGItR26WYO+OMsxmUOtO04OvYiLWrp0gWABCOtD3yp+lQlisy1k97U26A+qw==; s=purelymail3; d=purelymail.com; v=1; bh=vZjQH4jLLh+PJA7ZEulwt93RcdAvvXTWLz4r72z3nAQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68229:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 770029855;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 14 Dec 2024 11:59:06 +0000 (UTC)
From: Umer Uddin <umer.uddin@mentallysanemainliners.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	igor.belwon@mentallysanemainliners.org
Subject: [PATCH v1 1/1] arm64: dts: exynos990: Add a PMU node for the third cluster
Date: Sat, 14 Dec 2024 11:58:55 +0000
Message-ID: <20241214115855.49138-2-umer.uddin@mentallysanemainliners.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214115855.49138-1-umer.uddin@mentallysanemainliners.org>
References: <20241214115855.49138-1-umer.uddin@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Since we have a PMU compatiable for Samsung's Mongoose cores now, drop
the comment that explains the lack of it and define the node.

Signed-off-by: Umer Uddin <umer.uddin@mentallysanemainliners.org>
---
 arch/arm64/boot/dts/exynos/exynos990.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos990.dtsi b/arch/arm64/boot/dt=
s/exynos/exynos990.dtsi
index 2619f821b..c53df5d7c 100644
--- a/arch/arm64/boot/dts/exynos/exynos990.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos990.dtsi
@@ -46,7 +46,14 @@ arm-a76-pmu {
 =09=09=09=09     <&cpu5>;
 =09};
=20
-=09/* There's no PMU model for cluster2, which are the Mongoose cores. */
+=09mongoose-m5-pmu {
+=09=09compatible =3D "samsung,mongoose-pmu";
+=09=09interrupts =3D <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+=09=09=09     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
+
+=09=09interrupt-affinity =3D <&cpu6>,
+=09=09=09=09     <&cpu7>;
+=09};
=20
 =09cpus {
 =09=09#address-cells =3D <1>;
--=20
2.47.1


