Return-Path: <linux-kernel+bounces-533816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C136BA45EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB65316E998
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C54821A425;
	Wed, 26 Feb 2025 12:23:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1FA258CD2;
	Wed, 26 Feb 2025 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572612; cv=none; b=Xb5IwxXsrGFKjUiZOwYfIjoEkNIM/uVqc6z/o4nxgJAXcJuNuPUSanh9J+AImNyO1yljtJJVOb3oM1QyXskUO8SVSg2gQUR7gKglW6+5Mc0vVKdJNW/ID7GM2RQXuq4p15a8/0+FFCZPn6ZdoFum6bb8+g12YgYZG1t0R+Fw3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572612; c=relaxed/simple;
	bh=fAqlBot061vHiWVkJRN64vfvgl+i6LKS5sFXrcE4rQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=clNyuia4ZLHGSi44kDZoFlmlE/moYQaj938/o0qiTMtimyYPmlkTwgE5xeECyUnC5aD5350PIH+lFIvJXlZhk1h9I2Gi+yNCFWGULhbe0BwHIWBcs01aQXOV06adH3O5zbmANYWa/OoL5PpBgLT+lJliB9K6aCV58aK1xDiBKUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FBA813D5;
	Wed, 26 Feb 2025 04:23:46 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83EBB3F5A1;
	Wed, 26 Feb 2025 04:23:28 -0800 (PST)
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
Subject: [PATCH v6 0/4] xlnx: dt-bindings: Convert to json-schema
Date: Wed, 26 Feb 2025 12:23:21 +0000
Message-ID: <20250226122325.2014547-1-vincenzo.frascino@arm.com>
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

[1] https://codeberg.org/vincenzo/linux/src/branch/xlnx/dt-bindings/v6

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
v6:
  - Address review comments.
  - Rebase on the latest master.
v5:
  - Address review comments.
v4:
  - Address review comments.
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

 .../bindings/sound/xlnx,audio-formatter.txt   | 29 -------
 .../bindings/sound/xlnx,audio-formatter.yaml  | 72 +++++++++++++++++
 .../devicetree/bindings/sound/xlnx,i2s.txt    | 28 -------
 .../devicetree/bindings/sound/xlnx,i2s.yaml   | 65 ++++++++++++++++
 .../devicetree/bindings/sound/xlnx,spdif.txt  | 28 -------
 .../devicetree/bindings/sound/xlnx,spdif.yaml | 77 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++
 7 files changed, 222 insertions(+), 85 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.yaml

-- 
2.43.0


