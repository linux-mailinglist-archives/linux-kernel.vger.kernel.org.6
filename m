Return-Path: <linux-kernel+bounces-390943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786D19B8050
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C75B22123
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBAF1BE239;
	Thu, 31 Oct 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="WfGYJXTP"
Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD31BC07D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392706; cv=none; b=XhJBM8gVogmq+iMRA82nbRrQCZZIJPLyvPb/EiyM9yrES5ckpAfn1YFi0X8sD+aGnpdVKXLMBSfHAJ2Uw1usf19XlmAlCTQWzveU3cuE59140B8xfJPkuibMtkTnJ6QhKDq8BtP84Joi5Zc1uMVs+BtBj/pOpe6HJ+A5ejODByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392706; c=relaxed/simple;
	bh=gTLrUi+ogGOSBZjhzxkPXbV+MjJz+x1w78sA14AoOAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jiWXLVzPu++r+Qj9FKLrnFm6bDYSo94CQTlYPQ3MEKIlQi1j477ki+Odv1w80dwWxpkLkTXsDtkudI+CuDEW2dyncqF6hnuKhGDhBr4RFnNr76hcQVcmh6KZWOPRPRXafGQRhkt1GpYhtTXBKEf4Oz4qHYukPo6KsBDh4nB0gP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=WfGYJXTP; arc=none smtp.client-ip=62.149.156.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.everex.local ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 6Y8atb5dFqJRS6Y8etNuId; Thu, 31 Oct 2024 17:35:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1730392513; bh=gTLrUi+ogGOSBZjhzxkPXbV+MjJz+x1w78sA14AoOAM=;
	h=From:To:Subject:Date:MIME-Version;
	b=WfGYJXTPSxrAUzlYPckcXdb3KYzMYApZzbnDFq1DbOKyzwqtqGEDdT5HFia3MQECE
	 qe+Qzo6GYg7KSRR8DljHmGd/+YdQqK23QiKTwHe4PhAu6dr7gk5bb/+xQULnia2P0r
	 hUeb29DM3eFkHCbFSXt7IWzB6eg+xgfRLb8MJSI56K3dh3+p0ZHorG4R940kHEca1m
	 g4YQ3eeQix/KHGQvG9+uSsuzueqqtyGtnNhGTwvDi6dl4h9+AmhD7se2ChRkhggVZ/
	 etGsM5wYZJi+fugfDzeAlXnzwMcVz1HOuuvsW2Gk4xtPHTFPFjQT8LgDpXUlzLWfe5
	 Wqqh6xDwK7J4w==
From: Rodolfo Giometti <giometti@enneenne.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <greg@kroah.com>,
	corbet@lwn.net,
	Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>,
	tglx@linutronix.de,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dong Eddie <eddie.dong@intel.com>,
	N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: [V2 4/4] Documentation ABI: add PPS generators documentation
Date: Thu, 31 Oct 2024 17:35:08 +0100
Message-Id: <20241031163508.259522-5-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031163508.259522-1-giometti@enneenne.com>
References: <20241031163508.259522-1-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNhVFdCIMPZv4rJQzhVFX9H/8YBNU08/9vZg6hF6quaO1eE2OdPxa5VADHxuLCumXOV3o4UFolahD17uxS4sUes1ubmxYIUk7zbKUg0Q+x3FMW8wFRpO
 L4N8racZWsKP2tsNLHO+ED4cHYXeRv38d45Bmmy7QEhLPu+EonmztyOW9ghKGuF+/faCR2w8bnZuESScE2Y2l1XiakZOjjTorGt9i89j7J76h8YvbOvIEhBF
 J7ibHw2cISki4TX2MJ5VkDZV/17TDsjLNclweSLCLl1zY5ivGEc5NNhGP4PyGwd1r7bq8Mm/w/DkIu3Nj12C/jS6Ob/l5qBQZDmrkx4L/AuxZBexw1ZV9jhq
 UWNj2JXfRaBLZZVPlIYDRAl79n8X9DvZG/y50htuwOVzSHseTvGgxHB0VU7ePbpZUeJmPwyNL7S031xaoFE4Vc4VPo1qFP+iWwv8lr+9sSjapPUq751UJKCX
 O+qV4KmC+tuVkWlptYNbITew0bAjQNDMNKw3VHDwqqMGKCf5gxpGpCW+re4KP/XBzT5i4dDMrC7+IBdPgE1xUivHXmcuulXVFvu8T/E8ToaZS/bz+s+1WK3K
 Ps98DQUWEanMc4WlLU5W97kzPEfDiMmcGDseDJDZiEBehB1uqANfe/rVS4un29RIEDSDK89Qg6rq9TvdT9hLi1aKTZzaYBrSZxgOuPdz1zCW8DfK7EGofU8s
 N8V816dXZDDtDpTUt5y/6CgixI/YHw2g

This patch adds the documentation for the ABI between the Linux kernel
and userspace regarding the PPS generators.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 Documentation/ABI/testing/sysfs-pps-gen | 38 +++++++++++++++++++++++++
 MAINTAINERS                             |  1 +
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-pps-gen

diff --git a/Documentation/ABI/testing/sysfs-pps-gen b/Documentation/ABI/testing/sysfs-pps-gen
new file mode 100644
index 000000000000..7effe495d062
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-pps-gen
@@ -0,0 +1,38 @@
+What:		/sys/class/pps-gen/
+Date:		February 2025
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		The /sys/class/pps-gen/ directory contains files and
+		directories that provide a unified interface to the PPS
+		generators.
+
+What:		/sys/class/pps-gen/pps-genX/
+Date:		February 2025
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		The /sys/class/pps-gen/pps-genX/ directory is related to X-th
+		PPS generator in the system. Each directory contain files to
+		manage and control its PPS generator.
+
+What:		/sys/class/pps-gen/pps-genX/enable
+Date:		February 2025
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		This write-only file enables or disables generation of the
+		PPS signal.
+
+What:		/sys/class/pps-gen/pps-genX/system
+Date:		February 2025
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		This read-only file returns "1" if the generator takes the
+		timing from the system clock, while it returns "0" if not
+		(i.e. from a peripheral device clock).
+
+What:		/sys/class/pps-gen/pps-genX/time
+Date:		February 2025
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		This read-only file contains the current time stored into the
+		generator clock as two integers representing the current time
+		seconds and nanoseconds.
diff --git a/MAINTAINERS b/MAINTAINERS
index 63871eb816eb..d0b628c973f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18532,6 +18532,7 @@ L:	linuxpps@ml.enneenne.com (subscribers-only)
 S:	Maintained
 W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
 F:	Documentation/ABI/testing/sysfs-pps
+F:	Documentation/ABI/testing/sysfs-pps-gen
 F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
 F:	Documentation/driver-api/pps.rst
 F:	drivers/pps/
-- 
2.34.1


