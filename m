Return-Path: <linux-kernel+bounces-281563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCBA94D832
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61350B2362F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB116C685;
	Fri,  9 Aug 2024 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzbTR8/5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070316A920;
	Fri,  9 Aug 2024 20:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236418; cv=none; b=Hp8UcxpkF9M31FuH8kS55XBEMY8fA+gzg9i9iZqWzNRbrmGF71Rbkm/bNaKLI4xxJaMal41lwILcpYfqklVjtkAdBrKG0CF5pzYDAFclg47aOAZBLIBIYMitED612b4tpOxnD+2AXJaEaU1hJD0wOiZAhmgsF3bgzqaoDo+YcU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236418; c=relaxed/simple;
	bh=JNxVvv/EfzVtbKjbF0NpKVqcqD/2GnJB003zz+T1q5s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoU/7AfYPBILBviyoclodeb4+wdy3/3DXfMk2XbmxppngsvF3eeRtxS6jayghnP8Obu7gGIpqSGFmikTfa6DfHIo7ugE0ozSqGePWl5bwhzMx7H0TpbQdfqR1DO77U3Q+8pZwvnUOaw3DxpEOgIF+HnMXL0H3NP1QiWCEG8VukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzbTR8/5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723236417; x=1754772417;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=JNxVvv/EfzVtbKjbF0NpKVqcqD/2GnJB003zz+T1q5s=;
  b=dzbTR8/5hUvT1kLtWYQzQzydT1YJ+JgXaRDTDahPGITJ9GgyIHe1Wpz+
   rQC1WT2mrqUWfojoa2rv3DSnj9xZIojCe9jFG44nkiBHXzuwUq6YSXs7e
   e5eiEAXV4wAVdAvabd4WCIBQWAUVllSvc1YVkUxvJBin9ioXH3qsojoWI
   ODQlgPBmVbsn2jZ0oAm5Jm2kM6544eespsYFHQt764BHefpFXBNyB3dJn
   ioe2jjtvpta7BZNeq3rsbgx6DA5AtwCU5Hu5VhR1ssZgC8g2CIiFrkAAL
   BjlFb7s6B1RWiN80t4Wo1D9YkVxpbYoogXTNEDd1azot1wHP3dg48qoyr
   g==;
X-CSE-ConnectionGUID: nf/+TrSIQ8umYCOHtnZpjg==
X-CSE-MsgGUID: BJzcLbu+TEqAL6eWxntJmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="32819030"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="32819030"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:55 -0700
X-CSE-ConnectionGUID: Fi5AWvU9TuakCPdJLyYfMw==
X-CSE-MsgGUID: nPSWNRkTSDe7e++RJM6TJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="57650475"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.221.156])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:55 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] platform/x86:intel/pmt: Create inline version for telemetry functions
Date: Fri,  9 Aug 2024 13:46:34 -0700
Message-ID: <20240809204648.1124545-6-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809204648.1124545-1-xi.pardee@linux.intel.com>
References: <20240809204648.1124545-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create inline versions of functions in Intel PMT Telemetry driver when
config option is not set. Drivers that imports the INTEL_PMT_TELEMETRY
namespace could compile when CONFIG_INTEL_PMT_TELEMETRY option is not set.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/telemetry.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmt/telemetry.h b/drivers/platform/x86/intel/pmt/telemetry.h
index d45af5512b4e..6798a900042a 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.h
+++ b/drivers/platform/x86/intel/pmt/telemetry.h
@@ -21,6 +21,7 @@ struct telem_endpoint_info {
 	struct telem_header	header;
 };
 
+#if IS_REACHABLE(CONFIG_INTEL_PMT_TELEMETRY)
 /**
  * pmt_telem_get_next_endpoint() - Get next device id for a telemetry endpoint
  * @start:  starting devid to look from
@@ -123,4 +124,20 @@ int pmt_telem_read(struct telem_endpoint *ep, u32 id, u64 *data, u32 count);
  */
 int pmt_telem_read32(struct telem_endpoint *ep, u32 id, u32 *data, u32 count);
 
-#endif
+#else /* !CONFIG_INTEL_PMT_TELEMETRY */
+static inline unsigned long pmt_telem_get_next_endpoint(unsigned long start) { return 0; }
+static inline struct telem_endpoint *pmt_telem_register_endpoint(int devid)
+{ return ERR_PTR(-ENODEV); }
+static inline void pmt_telem_unregister_endpoint(struct telem_endpoint *ep) {}
+static inline int pmt_telem_get_endpoint_info(int devid, struct telem_endpoint_info *info)
+{ return -ENODEV; }
+static inline struct telem_endpoint *pmt_telem_find_and_register_endpoint(struct pci_dev *pcidev,
+				u32 guid, u16 pos)
+{ return ERR_PTR(-ENODEV); }
+static inline int pmt_telem_read(struct telem_endpoint *ep, u32 id, u64 *data, u32 count)
+{ return -ENODEV; }
+static inline int pmt_telem_read32(struct telem_endpoint *ep, u32 id, u32 *data, u32 count)
+{ return -ENODEV; }
+#endif /* CONFIG_INTEL_PMT_TELEMETRY */
+
+#endif /* _TELEMETRY_H */
-- 
2.43.0


