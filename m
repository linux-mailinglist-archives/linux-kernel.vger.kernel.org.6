Return-Path: <linux-kernel+bounces-528933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED95A41E39
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA7C3BBCEB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1B524EF8D;
	Mon, 24 Feb 2025 11:47:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BE624EF69;
	Mon, 24 Feb 2025 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397626; cv=none; b=QyNMXIJIVa/dMrZRgcaJ92ebxioSddsD8cZ1SXK1IF9zlnKrEDJ3QWXHtUClUPtl1geijZNJy9/8Fqckb5p+9DHPdeahTu6NW7mi+GmvyYPgYKR9NMk3g43rl0AjUqvmlxofDWSP1gTeHA6JBOFiU0NMm3z5BUlfQR8tYkcdVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397626; c=relaxed/simple;
	bh=ZFclqke8ZUlQE4gwyCnHc4Wc6HXOb7AO198d6seDxnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XihxOEGM9Kkw1NvPa25gBJQRlkc06x13N9Lrk8F06Ev0I3sOSt37iEPQ7zQ4VCN9W9jmZdKunotKpler5mHHrVqUIlbLgTulpIpH2P4o8hlVSExwzblXB/nzAH1p46L1V9a+aqLuk2s8wj+qNIFZkgwwFx1mTCIFoJxSICDHu+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C87211756;
	Mon, 24 Feb 2025 03:47:19 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74C5F3F6A8;
	Mon, 24 Feb 2025 03:47:01 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-sound@vger.kernel.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] xlnx: dt-bindings: Convert to json-schema
Date: Mon, 24 Feb 2025 11:46:44 +0000
Message-ID: <20250224114648.1606184-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the folling Xilinx device tree binding documentation:
 - xlnx,i2s
 - xlnx,audio-formatter
 - xlnx,spdif
to json-schema.

To simplify the testing a linux tree rebased on 6.13-rc4 is accessible
at [1].

[1] https://codeberg.org/vincenzo/linux/src/branch/xlnx/dt-bindings/v4

Note: These bindings are required for future work on the ARM Morello
Platforms device tree.

Cc: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Changes
=======
v3:
  - Address an issue with the MAINTAINERS file reported by the kernel
    test robot. 
v2:
  - Address review comments.
  - Rebase on 6.14-rc4.

Vincenzo Frascino (4):
  ASoC: dt-bindings: xlnx,i2s: Convert to json-schema
  ASoC: dt-bindings: xlnx,audio-formatter: Convert to json-schema
  ASoC: dt-bindings: xlnx,spdif: Convert to json-schema
  MAINTAINERS: Add Vincenzo Frascino as Xilinx Sound Driver Maintainer

 .../bindings/sound/xlnx,audio-formatter.txt   | 29 ------
 .../bindings/sound/xlnx,audio-formatter.yaml  | 76 +++++++++++++++
 .../devicetree/bindings/sound/xlnx,i2s.txt    | 28 ------
 .../devicetree/bindings/sound/xlnx,i2s.yaml   | 68 ++++++++++++++
 .../devicetree/bindings/sound/xlnx,spdif.txt  | 28 ------
 .../devicetree/bindings/sound/xlnx,spdif.yaml | 92 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++
 7 files changed, 244 insertions(+), 85 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.yaml

-- 
2.43.0


