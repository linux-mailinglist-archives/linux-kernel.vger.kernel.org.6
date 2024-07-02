Return-Path: <linux-kernel+bounces-237723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE323923D35
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D43286E32
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91DC15D5B8;
	Tue,  2 Jul 2024 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NInxXruc"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E4814D703;
	Tue,  2 Jul 2024 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921988; cv=none; b=eW0PNleh51lNhgHYD4N548zkCiYCvJdLv0UiSUV4Y0X6u1E+1MsGhGV+mohPzxO+6Gt7uoGWr8Id763MnAB/0HQMQlbAzYoCRYPqNJZZcdSyknltTU8Z/Fneo+Q9DUzWhc/fRLBD5/h89DAVCZCsbPbZVCkH/a40DBTWciOMMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921988; c=relaxed/simple;
	bh=utogO98dv+yZsk2Q5Ay914xrDaebYQbQ7fWLJh7Fet4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ht/5PZ3H/0TzgczDE+r2fG/ehSeDPrdCekx/Ztrg0zoIEY83EIt1rD+/A+P62KlGA83U+uF56zp1UKz/0Saiy5lMghNrSKEKQOqGeO7OglD2WdIkiolPxyGVg0zcKTV8JFaEx+20cRiu34lDKw+PVd6AEvkpW5stuKs4POZIiH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NInxXruc; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7eff8ae4386b11ef8b8f29950b90a568-20240702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0mrI+RsHjTTpEAV2tGpNTW+vQuiH/LV8BxE+CGYxcEw=;
	b=NInxXrucJFWgZY1DTjIEDhQ1GLYp2RZRWpmgSTfNuP340XMc3wkUgDxVk+tF2gVjh6rXDWz3gTwxP0JcF9DQC3u/Tv3jvBgcn7/iyEHmuwa8RB5SiUGlqkSgr1ZarTrHsmJv5UFXYf4Y2zzuAyy7dwF4rarKu2szIhbLtkpz95o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:40e51570-a5ec-4a8d-992d-cc3074f5d266,IP:0,U
	RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:ba885a6,CLOUDID:88ebf90c-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 7eff8ae4386b11ef8b8f29950b90a568-20240702
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <mark-pk.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 650432800; Tue, 02 Jul 2024 20:06:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Jul 2024 20:06:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Jul 2024 20:06:19 +0800
From: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To: Jonathan Corbet <corbet@lwn.net>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <yj.chiang@mediatek.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] docs: iommu: Remove outdated Documentation/userspace-api/iommu.rst
Date: Tue, 2 Jul 2024 20:05:39 +0800
Message-ID: <20240702120617.26882-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.821500-8.000000
X-TMASE-MatchedRID: olJ+MHgrKwLu6He4bORuyf9WgQ5yFeIpWYu9PKwvg8+xM//OLHLfLDB9
	ccde3hbU8urNJwQgyPBdCcmhZ8Q0VCMLnBbRowlYcX5PeMxy2v5U3K6aV1ad7d9RlPzeVuQQLFV
	Od3/b6GSYmu1c9yHchyC+H03fDWulaQPHx3YbvOYVglQa/gMvfIzjknOM+UJo+Cckfm+bb6Bmh1
	OorN5ZfPn2s1xTZaBMs4DHWQDGJb/7sqG6HklRYNUFhgTP7/bWtDSfcMR+7ZNOIo0O+5ZV4SNgF
	9/7ARmv42D56kBvvfFBBtUGJzAoN9phB3BcQx/vVnQT6gDml1VAq6/y5AEOOuOxOq7LQlGLLEnD
	LR3pDl3Iuj01kctd3srwwM67bcRV9Z8q6rO+Ih7AJnGRMfFxySQwGQSJ46Nm6ygMMToK893ldOa
	+b1x+LMcjG1Dny377e+RRT4HSyowfqPFbZMN65FEp96PnqFJsJPS3/6nvMccUlWIKEoGBmb/fkb
	xklHWA3fu6HAjJ1y0ImhhVnbXmhLkeZ/VkXL+KZwDJZynfzSt5w3WsOyy+8N9zZd3pUn7KKgb8B
	fqrnGotg+GBqf3thrFdDzVRJSPNcNPMFJIX+nO20BbG4zmyXhSRa9qpSosfJJvy/zCC/vKfUkQS
	/R/FD3aPxRKRE0lDazEBx0cBWVsH+DiyPUjnmQhWgIsZuXlPcfU+0yIKuYVPtLhlThdPEGn7AlT
	b8W2xt2fJ1xA6iK2zZnChmC9F+HHPBvSspzfjwT5e5LDjyQLTDXgcUlCNo3W8FA7SndluC50X6/
	IN7MBaRKmuujmzG57MxQnQvCwr0P4g2H0elcueAiCmPx4NwJuJ+Pb8n/VxSnQ4MjwaO9cqtq5d3
	cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.821500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C9EFB0F55206DE590D63D3AC64D30E17320E3332782F885BD9003D594DBA27AB2000:8
X-MTK: N

The Documentation/userspace-api/iommu.rst file has become outdated due
to the removal of associated structures and APIs.

Specifically, struct such as iommu_cache_invalidate_info and guest
pasid related uapi were removed in commit 0c9f17877891 ("iommu:
Remove guest pasid related interfaces and definitions").
And the corresponding uapi/linux/iommu.h file was removed in
commit 00a9bc607043 ("iommu: Move iommu fault data to
linux/iommu.h").

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 Documentation/userspace-api/iommu.rst | 209 --------------------------
 MAINTAINERS                           |   1 -
 2 files changed, 210 deletions(-)
 delete mode 100644 Documentation/userspace-api/iommu.rst

diff --git a/Documentation/userspace-api/iommu.rst b/Documentation/userspace-api/iommu.rst
deleted file mode 100644
index d3108c1519d5..000000000000
--- a/Documentation/userspace-api/iommu.rst
+++ /dev/null
@@ -1,209 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-.. iommu:
-
-=====================================
-IOMMU Userspace API
-=====================================
-
-IOMMU UAPI is used for virtualization cases where communications are
-needed between physical and virtual IOMMU drivers. For baremetal
-usage, the IOMMU is a system device which does not need to communicate
-with userspace directly.
-
-The primary use cases are guest Shared Virtual Address (SVA) and
-guest IO virtual address (IOVA), wherein the vIOMMU implementation
-relies on the physical IOMMU and for this reason requires interactions
-with the host driver.
-
-.. contents:: :local:
-
-Functionalities
-===============
-Communications of user and kernel involve both directions. The
-supported user-kernel APIs are as follows:
-
-1. Bind/Unbind guest PASID (e.g. Intel VT-d)
-2. Bind/Unbind guest PASID table (e.g. ARM SMMU)
-3. Invalidate IOMMU caches upon guest requests
-4. Report errors to the guest and serve page requests
-
-Requirements
-============
-The IOMMU UAPIs are generic and extensible to meet the following
-requirements:
-
-1. Emulated and para-virtualised vIOMMUs
-2. Multiple vendors (Intel VT-d, ARM SMMU, etc.)
-3. Extensions to the UAPI shall not break existing userspace
-
-Interfaces
-==========
-Although the data structures defined in IOMMU UAPI are self-contained,
-there are no user API functions introduced. Instead, IOMMU UAPI is
-designed to work with existing user driver frameworks such as VFIO.
-
-Extension Rules & Precautions
------------------------------
-When IOMMU UAPI gets extended, the data structures can *only* be
-modified in two ways:
-
-1. Adding new fields by re-purposing the padding[] field. No size change.
-2. Adding new union members at the end. May increase the structure sizes.
-
-No new fields can be added *after* the variable sized union in that it
-will break backward compatibility when offset moves. A new flag must
-be introduced whenever a change affects the structure using either
-method. The IOMMU driver processes the data based on flags which
-ensures backward compatibility.
-
-Version field is only reserved for the unlikely event of UAPI upgrade
-at its entirety.
-
-It's *always* the caller's responsibility to indicate the size of the
-structure passed by setting argsz appropriately.
-Though at the same time, argsz is user provided data which is not
-trusted. The argsz field allows the user app to indicate how much data
-it is providing; it's still the kernel's responsibility to validate
-whether it's correct and sufficient for the requested operation.
-
-Compatibility Checking
-----------------------
-When IOMMU UAPI extension results in some structure size increase,
-IOMMU UAPI code shall handle the following cases:
-
-1. User and kernel has exact size match
-2. An older user with older kernel header (smaller UAPI size) running on a
-   newer kernel (larger UAPI size)
-3. A newer user with newer kernel header (larger UAPI size) running
-   on an older kernel.
-4. A malicious/misbehaving user passing illegal/invalid size but within
-   range. The data may contain garbage.
-
-Feature Checking
-----------------
-While launching a guest with vIOMMU, it is strongly advised to check
-the compatibility upfront, as some subsequent errors happening during
-vIOMMU operation, such as cache invalidation failures cannot be nicely
-escalated to the guest due to IOMMU specifications. This can lead to
-catastrophic failures for the users.
-
-User applications such as QEMU are expected to import kernel UAPI
-headers. Backward compatibility is supported per feature flags.
-For example, an older QEMU (with older kernel header) can run on newer
-kernel. Newer QEMU (with new kernel header) may refuse to initialize
-on an older kernel if new feature flags are not supported by older
-kernel. Simply recompiling existing code with newer kernel header should
-not be an issue in that only existing flags are used.
-
-IOMMU vendor driver should report the below features to IOMMU UAPI
-consumers (e.g. via VFIO).
-
-1. IOMMU_NESTING_FEAT_SYSWIDE_PASID
-2. IOMMU_NESTING_FEAT_BIND_PGTBL
-3. IOMMU_NESTING_FEAT_BIND_PASID_TABLE
-4. IOMMU_NESTING_FEAT_CACHE_INVLD
-5. IOMMU_NESTING_FEAT_PAGE_REQUEST
-
-Take VFIO as example, upon request from VFIO userspace (e.g. QEMU),
-VFIO kernel code shall query IOMMU vendor driver for the support of
-the above features. Query result can then be reported back to the
-userspace caller. Details can be found in
-Documentation/driver-api/vfio.rst.
-
-
-Data Passing Example with VFIO
-------------------------------
-As the ubiquitous userspace driver framework, VFIO is already IOMMU
-aware and shares many key concepts such as device model, group, and
-protection domain. Other user driver frameworks can also be extended
-to support IOMMU UAPI but it is outside the scope of this document.
-
-In this tight-knit VFIO-IOMMU interface, the ultimate consumer of the
-IOMMU UAPI data is the host IOMMU driver. VFIO facilitates user-kernel
-transport, capability checking, security, and life cycle management of
-process address space ID (PASID).
-
-VFIO layer conveys the data structures down to the IOMMU driver. It
-follows the pattern below::
-
-   struct {
-	__u32 argsz;
-	__u32 flags;
-	__u8  data[];
-   };
-
-Here data[] contains the IOMMU UAPI data structures. VFIO has the
-freedom to bundle the data as well as parse data size based on its own flags.
-
-In order to determine the size and feature set of the user data, argsz
-and flags (or the equivalent) are also embedded in the IOMMU UAPI data
-structures.
-
-A "__u32 argsz" field is *always* at the beginning of each structure.
-
-For example:
-::
-
-   struct iommu_cache_invalidate_info {
-	__u32	argsz;
-	#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
-	__u32	version;
-	/* IOMMU paging structure cache */
-	#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB */
-	#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /* Device IOTLB */
-	#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /* PASID cache */
-	#define IOMMU_CACHE_INV_TYPE_NR		(3)
-	__u8	cache;
-	__u8	granularity;
-	__u8	padding[6];
-	union {
-		struct iommu_inv_pasid_info pasid_info;
-		struct iommu_inv_addr_info addr_info;
-	} granu;
-   };
-
-VFIO is responsible for checking its own argsz and flags. It then
-invokes appropriate IOMMU UAPI functions. The user pointers are passed
-to the IOMMU layer for further processing. The responsibilities are
-divided as follows:
-
-- Generic IOMMU layer checks argsz range based on UAPI data in the
-  current kernel version.
-
-- Generic IOMMU layer checks content of the UAPI data for non-zero
-  reserved bits in flags, padding fields, and unsupported version.
-  This is to ensure not breaking userspace in the future when these
-  fields or flags are used.
-
-- Vendor IOMMU driver checks argsz based on vendor flags. UAPI data
-  is consumed based on flags. Vendor driver has access to
-  unadulterated argsz value in case of vendor specific future
-  extensions. Currently, it does not perform the copy_from_user()
-  itself. A __user pointer can be provided in some future scenarios
-  where there's vendor data outside of the structure definition.
-
-IOMMU code treats UAPI data in two categories:
-
-- structure contains vendor data
-  (Example: iommu_uapi_cache_invalidate())
-
-- structure contains only generic data
-  (Example: iommu_uapi_sva_bind_gpasid())
-
-
-
-Sharing UAPI with in-kernel users
----------------------------------
-For UAPIs that are shared with in-kernel users, a wrapper function is
-provided to distinguish the callers. For example,
-
-Userspace caller ::
-
-  int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
-                                   struct device *dev,
-                                   void __user *udata)
-
-In-kernel caller ::
-
-  int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-                              struct device *dev, ioasid_t ioasid);
diff --git a/MAINTAINERS b/MAINTAINERS
index 0748d6bd0c4f..1359ed17337e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11544,7 +11544,6 @@ L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	Documentation/devicetree/bindings/iommu/
-F:	Documentation/userspace-api/iommu.rst
 F:	drivers/iommu/
 F:	include/linux/iommu.h
 F:	include/linux/iova.h
-- 
2.18.0


