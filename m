Return-Path: <linux-kernel+bounces-443843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 278989EFC96
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8304E1890048
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F67D18FDB9;
	Thu, 12 Dec 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpplETQN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73386188713;
	Thu, 12 Dec 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032235; cv=none; b=Wl1o/GK1j9BlpiP1cRydXkAarxPWR/UOz501gvr/LJgePkpcqiQ0wjKQf5E279TcDG723u9SHvhRnzpYnMLMr2YRURQFioDbhUeNIr4sti6wuO51jfHv5GAeiTX7vfU3HtPq9p3Eay9ypGunjhdR1uPOLHIPOaUiUE4LwYjXrsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032235; c=relaxed/simple;
	bh=hdcrKAYIIyPuFXXVZ8CmtrVulXK1wrD6wxFqvScjbIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qNPOuM4OafJdwWlmEiOq/DKfaiB8oGPgNZmauh0vYrLloi8WaOHh76jROYDscgBiXTWyXlhyVdDkMLisRySRPGHFfGRxHhYD521HvUwiKD5p4XjtZcbKju8kAjx8mEdpZJdOzWuMIigY3U30MgW9Pp0w19LeGcod99JVszIweQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpplETQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6831DC4CECE;
	Thu, 12 Dec 2024 19:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734032234;
	bh=hdcrKAYIIyPuFXXVZ8CmtrVulXK1wrD6wxFqvScjbIs=;
	h=From:Date:Subject:To:Cc:From;
	b=bpplETQNFBZv3HutxSMXgLIil1ThPMeD04QQ2DMOeJ0r+ScUdezfQzVwoT/VNS9eP
	 UGaoiP+tUAn1WmE9KylxSd3hpasJ5E+RnIxke8vzzmPb4EmMDnsaLiYuJ1MWslCvQo
	 2cJ74G7RR4AATxRP7UH9XIpxEO7b2nKfW6qWh8o/wfWuXOTKD4zyZfvINCYSSFdk+h
	 d13ujdKmmUSJr+Adr3qNX/H4/KX36o3vWpr1+DPN6TG3Bt+U0vHaW0jSokCxRIprW6
	 T7RElRY8Ea0rMVm81sUDYq2wHC0624fCmzwTAqpjI3DUjzT8b0Skw6uV9IaLfw4nvn
	 JAqlAsxtozOtw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 12 Dec 2024 19:36:32 +0000
Subject: [PATCH] arm64: defconfig: Enable Amazon Elastic Network Adaptor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-arm64-defconfig-graviton-v1-1-86830c3d572b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAD87W2cC/x3MPQqAMAxA4atIZgO2/oBeRRyKSWsGW0lFBPHuF
 sdveO+BzCqcYaoeUL4kS4oFpq5g3VwMjELFYBvbGWssOt2HDon9mqKXgEHdJWeK2DC5vuWezEh
 Q8kPZy/2v5+V9Py/IZeZqAAAA
X-Change-ID: 20241212-arm64-defconfig-graviton-0eda53e5d19d
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, soc@lists.linux.dev
Cc: Ryan Roberts <ryan.roberts@arm.com>, 
 Aishwarya TCV <aishwarya.tcv@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hdcrKAYIIyPuFXXVZ8CmtrVulXK1wrD6wxFqvScjbIs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnWztnQFh2ayZYX2jrI3ujSzKsagUwM5yM6SNHfzN8
 whUygQWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1s7ZwAKCRAk1otyXVSH0JSHB/
 9qvkdRV1j2ni2DdfrXhTXK9fN9RAJkPBJQW3U3g1If9M3Zi9mtWDNNwJniXHWGqIKtmEUdpJ19YglK
 NdlpBuvkjC3OK0d1w0DPUBK5vxS5S7/0kM/TNPPRULWBs6PIeCuCUroeJsjQVBLwgOIF9N1iIy20eI
 W7EwvbzdGeTl0xPHH9iGuYomwjpu3U9BUgV/K0ToWB66MK8vN7hkGJfM469nlk0suhiLi/lP6oKOHQ
 XkKfUsijlTJK+6ZCAGV50tIg+calT0n3hpqV5OG5iFCZOZUH0j28XO1NxPZus3DHApjh8qTfi4+50O
 ZID6ifE3LAyZ+c+DSLAzGyygywDjjD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The Graviton SoCs available in AWS use a custom network adaptor, enable
support for this in defconfig so standard defconfig builds can be used more
readily in CI. The driver is left as a module since it is relatively
unlikely these will be netbooted.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c62831e6158633f07c1f3532fba62f09b31e7448..b48940b3d100dd03945a29735b8ba26b145d51ad 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -330,6 +330,7 @@ CONFIG_VIRTIO_NET=y
 CONFIG_MHI_NET=m
 CONFIG_NET_DSA_BCM_SF2=m
 CONFIG_NET_DSA_MSCC_FELIX=m
+CONFIG_ENA_ETHERNET=m
 CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
 CONFIG_ATL1C=m

---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241212-arm64-defconfig-graviton-0eda53e5d19d

Best regards,
-- 
Mark Brown <broonie@kernel.org>


