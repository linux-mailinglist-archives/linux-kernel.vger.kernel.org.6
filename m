Return-Path: <linux-kernel+bounces-411244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082209CF51F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4493B347CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086661E25FD;
	Fri, 15 Nov 2024 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp3GKUJM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDBC1E25E1;
	Fri, 15 Nov 2024 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699494; cv=none; b=biDlnGsM8ABXA96FYJ4eUoB6LXpjzwCEOIry0xq91uOa443p3kFD+kz8PGpzogYLjUAySckPFw09PLYuhCY4MeMvaNhgYnkhQDUFdKabbj/gJBgTu5xrZR8U681crrGkUqGhHOtgCZCmpfYgCEeRjhbhFcyncNNhEjzeeTiRMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699494; c=relaxed/simple;
	bh=n+Y3/vywDHOX4fTfCMH9P93v6vPkfw+CgMztsz7Apq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0UCLz5+jAcglIvxJhf270Esfpon/VAE3DhmudF5cNTRfCNpyPfDDCNOnMWtODNLkvNC9oZPIYGy+BhmdoGC3KJ1CcYdqYrNHLXI+EU84jDBG5+ckut0rOR6ELKO1oWMt9NujaIlV6cjJVOk0KsrFJlB/oBdG/3q/946bd65t5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp3GKUJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31FCC4CECF;
	Fri, 15 Nov 2024 19:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731699494;
	bh=n+Y3/vywDHOX4fTfCMH9P93v6vPkfw+CgMztsz7Apq4=;
	h=From:To:Cc:Subject:Date:From;
	b=pp3GKUJMRCunUAVAnnI9VLqbDpINKZGFIz6PzOjN31bBurFIxtvwzNGrMouqkQhMa
	 iQqmLmHdv+qSs6AlYPCOuPht677bOxJjTJtrOfQz3eZl8nMHuxGY28H9w0ANDMm+NJ
	 yFNyM+k1UitETiP1erYg39wFKkzxpdoZ0RALM1/RU3k3w83BzPy3a4imNniVQ5gcAm
	 nqdUq9z2TkTn7PMIRQEDpUmZXM+y+I2lVwZc9FX4K1aGhXliSvmodW5IkqRdzuiSe/
	 eau432BbgxX013DWqCIpE70QIpftfchjBBv9C8CiBleFPlsYXvlGvDMO8VtUibmiDB
	 DR8FXrPFjSjuA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: soc@kernel.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: amd: Remove unused and undocumented "amd,zlib-support" property
Date: Fri, 15 Nov 2024 13:37:40 -0600
Message-ID: <20241115193740.3622591-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove "amd,zlib-support" property which is both unused in the kernel and
undocumented. Most likely they are leftovers from downstream.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
SoC maintainers, please take this directly.

 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts | 1 -
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
index 1a65f1ec183d..7c82d90e940d 100644
--- a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
+++ b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
@@ -27,7 +27,6 @@ psci {
 
 &ccp0 {
 	status = "okay";
-	amd,zlib-support = <1>;
 };
 
 /**
diff --git a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
index 52f8d36295a8..58e2b0a6f841 100644
--- a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
+++ b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
@@ -27,7 +27,6 @@ psci {
 
 &ccp0 {
 	status = "okay";
-	amd,zlib-support = <1>;
 };
 
 /**
-- 
2.45.2


