Return-Path: <linux-kernel+bounces-175786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E72DC8C24F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F36CB21221
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D57127B50;
	Fri, 10 May 2024 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/GJsT1m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FD785953;
	Fri, 10 May 2024 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344367; cv=none; b=i37IqIKF3FDXwQVkapa3B8VutImve41RdiEC18l/+c1ZIA8myW+b6ta7G2uaWOz2hKClck+CzZDpp5EtDRlhvq7YqISv/nNcSgMHVjbJL3ZKV9kcue+E1ZKXnnjC3sj1OA9AS0Rz5glPN2TeJzgXirdEmZtcqB27dNdXmgR9+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344367; c=relaxed/simple;
	bh=eMU4L7fEVPLcmvXQsT5WkTrPjtJ086MicqJB2uNlw7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9lbdK4hyD7oERiPy7kIAx3J0BMWAxO3TX6vTveVAsAbmEWqgJsi51x67vY8fa5n4Co+nkPqnK/HkQ88xhGQ9mnURZPuTCJU6tLnIeqTeAoqv6DNZjfsxMb08k3OdwjuIuMjk4VV7vCISieeK+1lJUl2q2cteQd2SXU98y1MeNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/GJsT1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94408C32781;
	Fri, 10 May 2024 12:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715344366;
	bh=eMU4L7fEVPLcmvXQsT5WkTrPjtJ086MicqJB2uNlw7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/GJsT1mHZDdH7+FH9yRMP7l9cSyHECUhVSX36K/Nw0Aiiq8Kv+f8lI0U9Itz2zR8
	 hgBreAEYy9E+rJWvgECSK0mwKlO9KvYh3ujhfRmAsTdZtDY6ka6CzxHk40CUTK3C6k
	 kIzYtq4JHVmto6RpyRHbiwFq9g6ySGaK2zFC8qknrbxM+vwY29P7t+5BwyALyQ4/0w
	 +7Lv0q+tPkUwSlYieFlw5mq0xAmeB/6QuALzTnNqXTPvxRHVDwGGDhTDv5MLOuXsjA
	 TE7bWkp+pwrwyOmhtJCJ2iQA1GsWHCQ1/8K66qtYLE3pc3cW9q4BqR8V709YQ+/NLn
	 HbIvJmMIzvayw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm: Remove obsolete RTSM DCSCB binding
Date: Fri, 10 May 2024 07:32:36 -0500
Message-ID: <20240510123238.3904779-2-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510123238.3904779-1-robh@kernel.org>
References: <20240510123238.3904779-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Arm VExpress DCSCB binding is unused and was only ever used on a s/w
model over 10 years ago. Remove it.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/arm/rtsm-dcscb.txt    | 19 -------------------
 1 file changed, 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/rtsm-dcscb.txt

diff --git a/Documentation/devicetree/bindings/arm/rtsm-dcscb.txt b/Documentation/devicetree/bindings/arm/rtsm-dcscb.txt
deleted file mode 100644
index 3b8fbf3c00c5..000000000000
--- a/Documentation/devicetree/bindings/arm/rtsm-dcscb.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-ARM Dual Cluster System Configuration Block
--------------------------------------------
-
-The Dual Cluster System Configuration Block (DCSCB) provides basic
-functionality for controlling clocks, resets and configuration pins in
-the Dual Cluster System implemented by the Real-Time System Model (RTSM).
-
-Required properties:
-
-- compatible : should be "arm,rtsm,dcscb"
-
-- reg : physical base address and the size of the registers window
-
-Example:
-
-	dcscb@60000000 {
-		compatible = "arm,rtsm,dcscb";
-		reg = <0x60000000 0x1000>;
-	};
-- 
2.43.0


