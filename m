Return-Path: <linux-kernel+bounces-445219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5959F12F3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634AB16ABED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE911E3DEF;
	Fri, 13 Dec 2024 16:52:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8A51E285A;
	Fri, 13 Dec 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108767; cv=none; b=YDOhTUf0F3TwDNii0yH4u1wR3msu8fzC1GfyOzgKRkrdzlQJIPkk4P6108bkoyAHSFyFF8JrF4KOLp5rt8l31yBrU2lKCshWfhTuy/ditxN3jhpqPQjE7WxHig1iOfluaaRQpvLZDAoffNPV/HiKzKB+sNmNv/yHVBB88P+5IuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108767; c=relaxed/simple;
	bh=izOmx9naMQgLKUQlxIDY3OVs/OZsvir/XDOyFX5E1cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqsBcweqw5aCAMHijUhnV4A+PaErrfkgDTK59Gs7hsUJN9ij0HfF73TvHCXU6iBnMHl96blYMcqDbKkx1K5S6rS85T5nVg9Upy/tLBLflv4W5CBvx7mr6fHBv6Vbht9IuKaypG2VSwZYVaaayOziLY979sCWin1IO9J+hwj6+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40ABF1480;
	Fri, 13 Dec 2024 08:53:13 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F00E3F5A1;
	Fri, 13 Dec 2024 08:52:44 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vincenzo.frascino@arm.com
Cc: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 0/3] xlnx: dt-bindings: Convert to json-schema
Date: Fri, 13 Dec 2024 16:52:37 +0000
Message-ID: <20241213165240.3652961-1-vincenzo.frascino@arm.com>
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

To simplify the testing a linux tree rebased on 6.13-rc1 is accessible
at [1].

[1] https://codeberg.org/vincenzo/linux/src/branch/xlnx/dt-bindings/v1

Cc: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (3):
  xlnx: dt-bindings: xlnx,i2s: Convert to json-schema
  xlnx: dt-bindings: xlnx,audio-formatter: Convert to json-schema
  xlnx: dt-bindings: xlnx,spdif: Convert to json-schema

 .../bindings/sound/xlnx,audio-formatter.txt   |  29 -----
 .../bindings/sound/xlnx,audio-formatter.yaml  |  84 +++++++++++++++
 .../devicetree/bindings/sound/xlnx,i2s.txt    |  28 -----
 .../devicetree/bindings/sound/xlnx,i2s.yaml   |  79 ++++++++++++++
 .../devicetree/bindings/sound/xlnx,spdif.txt  |  28 -----
 .../devicetree/bindings/sound/xlnx,spdif.yaml | 100 ++++++++++++++++++
 6 files changed, 263 insertions(+), 85 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.yaml

-- 
2.43.0


