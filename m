Return-Path: <linux-kernel+bounces-348649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2968E98EA12
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0101F27960
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B253F126C05;
	Thu,  3 Oct 2024 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXCvrccx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6827E83CD2;
	Thu,  3 Oct 2024 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939246; cv=none; b=Lgw9WQBWBO5U6UJEpuc6Vy4O0s0CSZsKdNrKNXdfqrchvE/C9Wyr32n37Cxi3j9wC+Q+C8CcnisGmPahOa52RlqpZ0M3PSPjLMzygdBP6exrX4I6FQqOvqhr0x2aizYQbIxV8cUAgAX9MaipgH5Me/YfgrwG77xuYqAD4OJh8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939246; c=relaxed/simple;
	bh=CG9df6F+03dKHnVkxP0n+YhDuVOghFDYTIJ+MPKHnM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdlTrOQG+K/E9DoX+GboCiPOoiKulpTOYHzRBBLTDF0dln7gELaTP+by8WxpusOGTM+j1wvpEsFAUQ5tXWxdygDmsGYb+Ht7f4+i60k4LFjp+VVQASaz9XQg2E+mOk+M71hEMakjdJVtS0A5GxMlIapqC2RVdo0qyJ7pTZR4ets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXCvrccx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727939245; x=1759475245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CG9df6F+03dKHnVkxP0n+YhDuVOghFDYTIJ+MPKHnM0=;
  b=RXCvrccxyy9ru6wX5+z1fp7igB89a97IMRryCQIx4ZcU1y51/3SNwAz7
   m/dmGZP+hGflQJICz1kL8eBBxLG+02Iw+n8xflua8eJp9lYdinoWinl+0
   LzUWLlO9iupvVdDFld/AyKMlWe0mrw1/IdQs9TZNvkZ0UTwQZ4MNcrqpI
   qamyD+5+zJhvnOlBrHAwhnROzdnOYGnoFQWNp6tljW/TmvkzzjMfCoOSY
   RRaIRco+qSOfAe6S2kLXygse0FG6L4dXAsGgetStLMxlXPoXycE35urRh
   UPaVE5HzseJ6F8swe9sPZYtkpCgT5r24EP8okoYXiYQy9qfuvYi+viMix
   g==;
X-CSE-ConnectionGUID: qOegNXTiSfmWO23IeZLKIQ==
X-CSE-MsgGUID: o3yPKeCxQH6hASlRczVZ4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27070716"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27070716"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:24 -0700
X-CSE-ConnectionGUID: 4LLZrdRQS3uKpqWbAlB51w==
X-CSE-MsgGUID: KyqH/UxbQCuTV32ToYushg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74508381"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:22 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 RESEND 01/14] soundwire: mipi_disco: add MIPI-specific property_read_bool() helpers
Date: Thu,  3 Oct 2024 15:06:37 +0800
Message-ID: <20241003070650.62787-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
References: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The existing device/fwnode_property_read_bool() helpers only check if
the property is present.

The MIPI DisCo for SoundWire specification allows properties to be
exposed with a value of 'false'. Using the standard helpers to
retrieve the MIPI-defined properties causes all kinds of logical
inversions leading to loss of functionality - such as jack detection
in clock-stop mode broken when the device properties are read in
Realtek codec drivers.

This patch adds new MIPI/SoundWire helpers which first check if the
property is present, and then return the actual value extracted from
platform firmware.

Modifying the default property handling was considered as a possible
solution, but it could lead to other types of logical inversions
breaking 'working' setups. Andy Shevchenko also pointed out that DT
keeps values in the BE32 format, it's probably best to avoid
endianness complications.

The path of least resistance was chosen, with MIPI-specific helpers
which can be tested and with no side effects outside of the SoundWire
subsystem.

Closes: https://github.com/thesofproject/linux/issues/5129
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 50 ++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index e5d9df26d4dc..fdab3d4a1379 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -23,6 +23,26 @@
 #include <linux/soundwire/sdw.h>
 #include "bus.h"
 
+static bool mipi_fwnode_property_read_bool(const struct fwnode_handle *fwnode,
+					   const char *propname)
+{
+	int ret;
+	u8 val;
+
+	if (!fwnode_property_present(fwnode, propname))
+		return false;
+	ret = fwnode_property_read_u8_array(fwnode, propname, &val, 1);
+	if (ret < 0)
+		return false;
+	return !!val;
+}
+
+static bool mipi_device_property_read_bool(const struct device *dev,
+					   const char *propname)
+{
+	return mipi_fwnode_property_read_bool(dev_fwnode(dev), propname);
+}
+
 /**
  * sdw_master_read_prop() - Read Master properties
  * @bus: SDW bus instance
@@ -48,11 +68,11 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 		return -EIO;
 	}
 
-	if (fwnode_property_read_bool(link,
+	if (mipi_fwnode_property_read_bool(link,
 				      "mipi-sdw-clock-stop-mode0-supported"))
 		prop->clk_stop_modes |= BIT(SDW_CLK_STOP_MODE0);
 
-	if (fwnode_property_read_bool(link,
+	if (mipi_fwnode_property_read_bool(link,
 				      "mipi-sdw-clock-stop-mode1-supported"))
 		prop->clk_stop_modes |= BIT(SDW_CLK_STOP_MODE1);
 
@@ -114,7 +134,7 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 	fwnode_property_read_u32(link, "mipi-sdw-default-frame-col-size",
 				 &prop->default_col);
 
-	prop->dynamic_frame =  fwnode_property_read_bool(link,
+	prop->dynamic_frame =  mipi_fwnode_property_read_bool(link,
 			"mipi-sdw-dynamic-frame-shape");
 
 	fwnode_property_read_u32(link, "mipi-sdw-command-error-threshold",
@@ -153,13 +173,13 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
 				dp0->words, dp0->num_words);
 	}
 
-	dp0->BRA_flow_controlled = fwnode_property_read_bool(port,
+	dp0->BRA_flow_controlled = mipi_fwnode_property_read_bool(port,
 				"mipi-sdw-bra-flow-controlled");
 
-	dp0->simple_ch_prep_sm = fwnode_property_read_bool(port,
+	dp0->simple_ch_prep_sm = mipi_fwnode_property_read_bool(port,
 				"mipi-sdw-simplified-channel-prepare-sm");
 
-	dp0->imp_def_interrupts = fwnode_property_read_bool(port,
+	dp0->imp_def_interrupts = mipi_fwnode_property_read_bool(port,
 				"mipi-sdw-imp-def-dp0-interrupts-supported");
 
 	return 0;
@@ -220,7 +240,7 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 					 "mipi-sdw-max-grouping-supported",
 					 &dpn[i].max_grouping);
 
-		dpn[i].simple_ch_prep_sm = fwnode_property_read_bool(node,
+		dpn[i].simple_ch_prep_sm = mipi_fwnode_property_read_bool(node,
 				"mipi-sdw-simplified-channelprepare-sm");
 
 		fwnode_property_read_u32(node,
@@ -278,7 +298,7 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 		fwnode_property_read_u32(node, "mipi-sdw-max-async-buffer",
 					 &dpn[i].max_async_buffer);
 
-		dpn[i].block_pack_mode = fwnode_property_read_bool(node,
+		dpn[i].block_pack_mode = mipi_fwnode_property_read_bool(node,
 				"mipi-sdw-block-packing-mode");
 
 		fwnode_property_read_u32(node, "mipi-sdw-port-encoding-type",
@@ -308,19 +328,19 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	device_property_read_u32(dev, "mipi-sdw-sw-interface-revision",
 				 &prop->mipi_revision);
 
-	prop->wake_capable = device_property_read_bool(dev,
+	prop->wake_capable = mipi_device_property_read_bool(dev,
 				"mipi-sdw-wake-up-unavailable");
 	prop->wake_capable = !prop->wake_capable;
 
-	prop->test_mode_capable = device_property_read_bool(dev,
+	prop->test_mode_capable = mipi_device_property_read_bool(dev,
 				"mipi-sdw-test-mode-supported");
 
 	prop->clk_stop_mode1 = false;
-	if (device_property_read_bool(dev,
+	if (mipi_device_property_read_bool(dev,
 				"mipi-sdw-clock-stop-mode1-supported"))
 		prop->clk_stop_mode1 = true;
 
-	prop->simple_clk_stop_capable = device_property_read_bool(dev,
+	prop->simple_clk_stop_capable = mipi_device_property_read_bool(dev,
 			"mipi-sdw-simplified-clockstopprepare-sm-supported");
 
 	device_property_read_u32(dev, "mipi-sdw-clockstopprepare-timeout",
@@ -333,13 +353,13 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 			"mipi-sdw-clockstopprepare-hard-reset-behavior",
 			&prop->reset_behave);
 
-	prop->high_PHY_capable = device_property_read_bool(dev,
+	prop->high_PHY_capable = mipi_device_property_read_bool(dev,
 			"mipi-sdw-highPHY-capable");
 
-	prop->paging_support = device_property_read_bool(dev,
+	prop->paging_support = mipi_device_property_read_bool(dev,
 			"mipi-sdw-paging-support");
 
-	prop->bank_delay_support = device_property_read_bool(dev,
+	prop->bank_delay_support = mipi_device_property_read_bool(dev,
 			"mipi-sdw-bank-delay-support");
 
 	device_property_read_u32(dev,
-- 
2.43.0


