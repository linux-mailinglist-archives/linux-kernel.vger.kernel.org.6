Return-Path: <linux-kernel+bounces-323917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBEC97452E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F80B24C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A652A1AB53E;
	Tue, 10 Sep 2024 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAwu4jNA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2821AB53B;
	Tue, 10 Sep 2024 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005566; cv=none; b=N8I3B/Di3fqCWU0SPK9o1KABhyBBiGSkgysepN6C1R+E/CzsBjHsz2ftkmGKOub07iTCz1cKrHY599aC0DrfAf06qLJUuKxfSwwfTvvLCwsQLx9+j4tHlBuN0tRLFkhvh4vn9sjjf0CUQjFw+idXMhs1JzNVFGyt9s7k4DcD6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005566; c=relaxed/simple;
	bh=UWuaZDgJ6tGulVX0rI1/ynCwmXvQXt1xlLFKmmMCsPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYUKTk40Me27/DQj+OqGx9GhqjSdzInEj9oQbTvTCLDa0r5zlwjoyLix1UAzOT8M6JGgfer00MAmCZLLPowiYacpU/77hpk2ozJ08x8+hRWFm8c2ffbr+zdsewgY3CgQmtQrKRUooqkgC79s7cFQCASCdOxKz1NdTfIzWdosb0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAwu4jNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BF5C4CEC3;
	Tue, 10 Sep 2024 21:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726005565;
	bh=UWuaZDgJ6tGulVX0rI1/ynCwmXvQXt1xlLFKmmMCsPw=;
	h=From:To:Cc:Subject:Date:From;
	b=PAwu4jNAI2v1WVW1CzSjymZobuCC0+qNIGcOadst3eUqvtylZ8LjMtkUIVO8YSJUa
	 FNNoSbl+RmdTFAVQSWlwel0NcDOTi/XPY0BlQ6aZohPFPVRpKAyRebYLgfQYSjuoHG
	 rkWxfI+KVVsQ2zS7PTUc7fQbnlYu9QK2jKwL2TK+tOUPbGGNkXuJ3V45vcZRPrTj1u
	 P0U17R6zOJnD/WxqGgwB7MTNmDtiTsNJRBCOvEkx8MsCFUO6+gp8ZZ9zpNSXGej18d
	 TdgoqooPzC8DGhhZdwOEez1mJ4EqArsUJeggynmB1NrpanLuej4DhEtkk4/1BRo0RU
	 BLolP4CP0pzgA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: socfpga: Fix at24 EEPROM node names
Date: Tue, 10 Sep 2024 16:59:20 -0500
Message-ID: <20240910215921.823721-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

at24.yaml defines the node name for at24 EEPROMs as 'eeprom'.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../boot/dts/intel/socfpga/socfpga_cyclone5_vining_fpga.dts   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_vining_fpga.dts
index 65f390bf8975..3adafb556bf2 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_vining_fpga.dts
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_vining_fpga.dts
@@ -135,7 +135,7 @@ temp: lm75@48 {
 		reg = <0x48>;
 	};
 
-	at24@50 {
+	eeprom@50 {
 		compatible = "atmel,24c01";
 		pagesize = <8>;
 		reg = <0x50>;
@@ -211,7 +211,7 @@ &i2c1 {
 	status = "okay";
 	clock-frequency = <100000>;
 
-	at24@50 {
+	eeprom@50 {
 		compatible = "atmel,24c02";
 		pagesize = <8>;
 		reg = <0x50>;
-- 
2.45.2


