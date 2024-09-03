Return-Path: <linux-kernel+bounces-313845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBED996AAA9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854421F24734
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FCB1D5CDE;
	Tue,  3 Sep 2024 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQa6HwyF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0180E1D58BE;
	Tue,  3 Sep 2024 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400349; cv=none; b=ZplfvSEacT5WTN20iHH6LJ4CM7H9GfaPv8aY6zTyn0JkbYrlsvPgMc2dPh3UGNinbj9AzfQYb082fOwPce4HeuuJFSOFLUhfSJ6Ag1ZbgtxCs1Y4eaDLNCqYCwBDrdGoUR5e0XEVD+QHK4dC1cIamMoLa7a0499NHWeYo3NMFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400349; c=relaxed/simple;
	bh=8oFg8PCet+eRxsJw+4vArngX/fuCwv7/e9HPZ4QcII4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ChAh9B4Jh9rVJTVp1aesWLDHBFqZdbLlNFKaMAtkcTT1iCOQ640/owtcxcrDf/mOfJ9h9x+zaJwkX408zDgnSVrzT1wIa78J+NY30RqOPllt31sIBlANqNgBe8p0UBZ3EgGrPJKx9vtTdjEooAdgXrUuqjyMw1GzY/MEveJA6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQa6HwyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F140C4CEC4;
	Tue,  3 Sep 2024 21:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725400348;
	bh=8oFg8PCet+eRxsJw+4vArngX/fuCwv7/e9HPZ4QcII4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rQa6HwyFqDfylILW9PNQ9jyTf3MtgkxXUCQDRZ1mnx3+NCkx3XgDFVEFcapVgZP7N
	 exujlWJpyM7MqcZ5O+zIN+lcvGWG/Qtf182gb+H++X4DYJeeqX6+YfmY+h3FTNDOfg
	 Mi5aR27HrcjXSSxFPjDbGl6tgedPKtEx13QNLg8UrmkU4Hj4uYoyKKQK5QpLVbmN/r
	 BHIQsmak2Z8jlReYvQ8bfpQu4PpO5prMqv97Ab7nETCLRgaDK1MMgPfbOcaORZgl67
	 Mym53u5bm47dllxy4dDyCJ+0qCRbXRZ2ATUXwWc0B8Xyaj0JBWjA3blxHhCI83ycZ1
	 5q601ffA4pQ4A==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 03 Sep 2024 16:52:07 -0500
Subject: [PATCH 3/4] dt-bindings: trivial-devices: Drop duplicate LM75
 compatible devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240903-dt-trivial-devices-v1-3-ad684c754b9c@kernel.org>
References: <20240903-dt-trivial-devices-v1-0-ad684c754b9c@kernel.org>
In-Reply-To: <20240903-dt-trivial-devices-v1-0-ad684c754b9c@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

Drop LM75 compatible devices which are already documented in lm75.yaml.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 79c771a4cd9e..2c01d8d2a6d3 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -73,8 +73,6 @@ properties:
           - dallas,ds1631
             # Total-Elapsed-Time Recorder with Alarm
           - dallas,ds1682
-            # Tiny Digital Thermometer and Thermostat
-          - dallas,ds1775
             # CPU Peripheral Monitor
           - dallas,ds1780
             # CPU Supervisor with Nonvolatile Memory and Programmable I/O
@@ -197,8 +195,6 @@ properties:
           - maxim,max5484
             # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
           - maxim,max6621
-            # 9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
-          - maxim,max6625
             # mCube 3-axis 8-bit digital accelerometer
           - mcube,mc3230
             # Measurement Specialities I2C temperature and humidity sensor
@@ -394,8 +390,6 @@ properties:
           - ti,tmp121
           - ti,tmp122
           - ti,tmp125
-            # Digital Temperature Sensor
-          - ti,tmp275
             # TI DC-DC converter on PMBus
           - ti,tps40400
             # TI Dual channel DCAP+ multiphase controller TPS53676 with AVSBus

-- 
2.45.2


