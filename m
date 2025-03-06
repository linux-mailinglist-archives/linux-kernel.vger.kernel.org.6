Return-Path: <linux-kernel+bounces-548919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8ECA54ADA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9299B162160
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB1520B803;
	Thu,  6 Mar 2025 12:38:26 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EEB1F3FC2;
	Thu,  6 Mar 2025 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264705; cv=none; b=cuuYegka1XoRNmy0257hDV8C4MieOLv+4fqQuFAnvQ/H6Sh2SIgu20c88EUxLkOFImJbRqV0OJjkQFRLojpkG5HnzCxgT0uA2HmeH2lk6P+oyX2pwrDNGVmtahrS8wCLfjn9CwG5xGaS0YXqqexPLQrziO1VWq1vOmpPpSvhLBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264705; c=relaxed/simple;
	bh=UwislIDPho003Ycw/2TRpzFKcwe8vetl96CzivYkm2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S3QH8vc/D2AW8e+iKmJWcnMfhyyuysSrjBeHPxEJBKlAu1o+L3P2gqDqF3VdFGnVp5zlvJsYE0Gf5kT6WGc9KG6jWEKs/rLE81oYPH83XCMYXaspYAiO19QAthr08gpb7WID5kTuBAF+3g9AGVEWqYTXWhcajw/jKrokl2pAMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id d2b83ca5;
	Thu, 6 Mar 2025 20:38:17 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Yao Zi <ziyao@disroot.org>
Cc: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 0/2] arm64: dts: rockchip: Add rk3528 QoS register node
Date: Thu,  6 Mar 2025 20:38:07 +0800
Message-Id: <20250306123809.273655-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTB5LVh4eSUlMHhlKT0hLS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktISk5MTlVKS0tVSk
	JLS1kG
X-HM-Tid: 0a956b76b74203a2kunmd2b83ca5
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46SRw*CDJWCDMwTxoSIxYY
	OgIaCiJVSlVKTE9KSU1PTUJMQ0xPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQU9LSzcG

Changes in v2:
  Improve commit message
  Add missing QoS compatible in DT

Chukun Pan (2):
  dt-bindings: mfd: syscon: Add rk3528 QoS register compatible
  arm64: dts: rockchip: Add rk3528 QoS register node

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 160 ++++++++++++++++++
 2 files changed, 162 insertions(+)

-- 
2.25.1


