Return-Path: <linux-kernel+bounces-510860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B622A322F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57463A42C2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BEF207A07;
	Wed, 12 Feb 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOCOECGc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B291F03C1;
	Wed, 12 Feb 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354267; cv=none; b=Sy6nPnrmL3/Mg5AR+AISeAlodtsffcqFFFs3XSDDPdfbjuPrfK3oqcjyWpbXvkaBRQUUqzSdBmmbV5bKZC/oA/ykus20uXomqYmGnuYbVuFFMJWchENGHpx+qNyZBJWZGFjNi2lVHNEdqMNgv7DPFpTzNrTCh+Gi6v6/zxzQqJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354267; c=relaxed/simple;
	bh=RfajstfpTGLNdRrMN2hNwqxhrI3a/671OeateMPFz/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ULPk6L+h9L8sAtlnRdmWpItX/OdBvqEhx6L2XNuDeptFM+nzwegnyc8LpD55y+bQcPaSSNWPPE59Inq/IzrXmrxUnE5JoLvF7zzoUjkxu9Dwj4WS4kBta0f4+aDjqKuTyYAFJXFc356QfuaquNxr/8TCLWr2c/v1eGM5gLQE6zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOCOECGc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739354266; x=1770890266;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RfajstfpTGLNdRrMN2hNwqxhrI3a/671OeateMPFz/E=;
  b=KOCOECGcp6DTePYDYwhxSj7ABlEUoqxCAjgc8vFoFWqMP/KRl/nifIAD
   QYX4IwAWim2PANdNazKM1JY61njvfq06UDaKpR0pKy19WntOuE88Pn/rK
   9znpNrW7PRNDud7FMdcEoL07D3g7akjYtBV8a1fu4rJUChZutBGRNWrrd
   cUqi8FjOeOWq/hILu3PEGmVHpb9qF4zqT+oCR0OORvi1WwN85/XxsDhVz
   8lI4zAPWUYjgLQuf3MKW3J4fYTMPUVGXl9kIe57rpJ/0dpBvZZ3UO6wD4
   Roq37q66WiImbE+TFTtOlyDnJNLzEYhiBsIvjTVCIUaDmMcLSMGKBdlXB
   g==;
X-CSE-ConnectionGUID: mkDEAnRiTeemPcnUklqKnw==
X-CSE-MsgGUID: qaRMoVerTxSeESDK9ZqOxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50224532"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="50224532"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 01:57:45 -0800
X-CSE-ConnectionGUID: 7qg0NH+vTo2+M9Vz4tKZOA==
X-CSE-MsgGUID: wzou7DIlTqS+ykPjuGYoeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112632043"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa010.jf.intel.com with ESMTP; 12 Feb 2025 01:57:41 -0800
From: niravkumar.l.rabara@intel.com
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] add clock-names property to nand node
Date: Wed, 12 Feb 2025 17:54:05 +0800
Message-Id: <20250212095407.2667743-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

1) Document the required clock-names property because the driver
   requests the clock by name and not the index.
2) Add required clock-names property to the nand node in device tree. 

Changes in v2:
  * Document clock-names property for Cadence NAND controller.

link to v1:
- https://lore.kernel.org/all/20250107084955.2750154-1-niravkumar.l.rabara@intel.com/

Niravkumar L Rabara (2):
  dt-bindings: mtd: cadence: document required clock-names
  arm64: dts: socfpga: agilex5: add clock-names property to nand node

 Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml | 8 +++++++-
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi         | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.1


