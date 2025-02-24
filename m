Return-Path: <linux-kernel+bounces-529814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B764A42B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0F33AF3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0B2265615;
	Mon, 24 Feb 2025 18:25:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2181B198A38;
	Mon, 24 Feb 2025 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421557; cv=none; b=p7pN/H+RfSBDQgNa88U5uZ3YnU4OBVMa6fMX2igR2C3x5QycuV1sIxMWcB6et/6zN3hdnCO5GatBGpItRrtciMB+zvh/V72fSATKZK1l447/M0f6Hp924RChDbemfrvOK53tWcB7O45signckSfmK9eMHUVpvNqhGDnxfHXFJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421557; c=relaxed/simple;
	bh=4wX8Yy+j0Jz+myikKPUI4GIa4qvN0F+C5YtIPn0dP50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jb7mcuuNin7kb7bsFZbWn5mgfXDzDv7hxtuZ4xsAomlLwNshOgcTELrD1lQZL/KnXvF7iAcA0RGlzOCwxkZFoAE9IjHU0S7aTy1/m2Uh3Qz0iiR/zLGpGqo8YShrg6YYR0L9m0Iq7FvxV1lm+E437wC8FqweFhl1LXjeDz/plJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F27741477;
	Mon, 24 Feb 2025 10:26:10 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B61E83F5A1;
	Mon, 24 Feb 2025 10:25:52 -0800 (PST)
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
Subject: [PATCH v4 0/4] xlnx: dt-bindings: Convert to json-schema
Date: Mon, 24 Feb 2025 18:25:44 +0000
Message-ID: <20250224182548.2715896-1-vincenzo.frascino@arm.com>
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
 .../bindings/sound/xlnx,audio-formatter.yaml  | 77 +++++++++++++++++
 .../devicetree/bindings/sound/xlnx,i2s.txt    | 28 ------
 .../devicetree/bindings/sound/xlnx,i2s.yaml   | 65 ++++++++++++++
 .../devicetree/bindings/sound/xlnx,spdif.txt  | 28 ------
 .../devicetree/bindings/sound/xlnx,spdif.yaml | 85 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++
 7 files changed, 235 insertions(+), 85 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.yaml

-- 
2.43.0


