Return-Path: <linux-kernel+bounces-313846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BFE96AAAB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B82284A4A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F8E1C86F1;
	Tue,  3 Sep 2024 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APSFz9Qq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3125F1D5CF2;
	Tue,  3 Sep 2024 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400350; cv=none; b=JWlBsyT/8kb3W2nICcVy6+2dWAp9QohM3uVi+7qFFGx1hfRiBW0fTlkoV2nqBCr/HWaqhde8QLMQX2Sj5C0yOjA8pXbaRXSWEcMpJsEWBZIhpK7pRgBfb+9oy7SfAirCEmsHM+t/1v9XdMrgeuvMwrYycfrfvP5OaLxVww9XRv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400350; c=relaxed/simple;
	bh=5AXHSlD483lkKrn6IcQa8Qtd1HVutTf1fVZ/+vQW7nQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ullKKoa/Hq5bsSzUt4pcfnNOUDJRc6qWm4W6UQzGtqgpNNVvyYTwXtfnyKly+VdiCIs2PUKYtcxVrKXQe33wLVLop5W1Y4zVZgf0IbVvTh7lkiyxFCccUEd1mKfVao+BHovgEdxpH7uumJTm4n62+bKkHFY7ibW1OOIDuMQb8NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APSFz9Qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CF1C4CEC5;
	Tue,  3 Sep 2024 21:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725400350;
	bh=5AXHSlD483lkKrn6IcQa8Qtd1HVutTf1fVZ/+vQW7nQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=APSFz9Qq4cUhUzEOyFvHArCpAHi3s64PcN5so395igC9kMlsfmJ9ahhfhsMq4K0cw
	 Yl1gBaL44QZpR9WJC28aI6shxWvmv/zIeuiNGFdZqxHojJfPSuH5V5umYVDVa2rdKl
	 /TL5jgI6N6nmqVafDP/SWBZgdMoJU/TYNW3H5hqAHjwDxxl4RmZoNBUjzmi+10GvV0
	 PEfmaSpncM8lXHqRvfCl+tg3N1Aap6f78NsyBdItI2T6D2OOmPycE//40pjCbQkdSH
	 udI2ybqwn3vRZE7kZRVIOhZi/LD9Bg/zXo5C2+BXVM+pxn2+DPR60u0feG5Ao/e2+E
	 KUMSuVTOjTIEA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 03 Sep 2024 16:52:08 -0500
Subject: [PATCH 4/4] dt-bindings: trivial-devices: Drop duplicate
 "maxim,max1237"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-dt-trivial-devices-v1-4-ad684c754b9c@kernel.org>
References: <20240903-dt-trivial-devices-v1-0-ad684c754b9c@kernel.org>
In-Reply-To: <20240903-dt-trivial-devices-v1-0-ad684c754b9c@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

"maxim,max1237" is already documented in iio/adc/maxim,max1238.yaml, so
drop it from trivial-devices.yaml.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2c01d8d2a6d3..7cd9d55de8e2 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -179,8 +179,6 @@ properties:
           - maxim,ds1803-100
             # 10 kOhm digital potentiometer with I2C interface
           - maxim,ds3502
-            # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
-          - maxim,max1237
             # Temperature Sensor, I2C interface
           - maxim,max1619
             # 3-Channel Remote Temperature Sensor

-- 
2.45.2


