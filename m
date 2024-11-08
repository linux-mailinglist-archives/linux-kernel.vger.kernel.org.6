Return-Path: <linux-kernel+bounces-401196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CB69C1716
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D032C285F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCF71DE2B6;
	Fri,  8 Nov 2024 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="Css2DYNF"
Received: from smtpcmd0756.aruba.it (smtpcmd0756.aruba.it [62.149.156.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DDE1D14F6
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051519; cv=none; b=WQzMxqtC3yFlAe45Sbaial505tTT0shY9bV7u2LRB+IGVi/mFBzsSSlO7gMcLTrHTGAkta/yaElgL1pQvXIZo/Vz3BCRZK24ns47OMew9iOBQi7Akmmvtx3orC/9ZRmc0Bx9VaJ4V+BYOAs269cloXs3Ta3dG10cG4oQoAU7NSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051519; c=relaxed/simple;
	bh=QKoQV9rzxbUvExdR1zo8vScm8DHJmBVckIzULfmkNq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LXFxgXssSjR/rWjydkaf4jbWy+56DPSqaNWt/+AC/oUrZAR7mkV9RybHzbOlKtqyZfFgGNahYNMSKPEdVmEKD4m7ZjqS4+94FUB1P1kgxf0LiDK16TnJX4Tpe2o7Kgzvp5Q3HZVDgc6UJG4DC7uti761FLb61+mZgEjDTQYppAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=Css2DYNF; arc=none smtp.client-ip=62.149.156.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.everex.local ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 9JSetHUHi6epj9JSetjpcz; Fri, 08 Nov 2024 08:31:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1731051079; bh=QKoQV9rzxbUvExdR1zo8vScm8DHJmBVckIzULfmkNq8=;
	h=From:To:Subject:Date:MIME-Version;
	b=Css2DYNFJ5B6EdJYZMlVwAsyPJzJiibXDvBc21lQMFqdgePig2rXzsK7ETgbxIPiD
	 /qcw+gsfMk6nm9jpNTQAPquLREtdsfEW5vtBkE5sZP7+40Mk1+XgM8TlPuFgEBs33f
	 qE53drtY5Mg/AQwZPJYYNikiJO74w1iGmpqEp1Kwe32I09/vcTjkWwhPGK0SeifLXX
	 Gy/V9Ox6PEMxjrYALPSAz2EXNQBXeEa6Wxc3EI2BuzJpIIWtAqaSfQbZWYcs84crs/
	 DkOFXHjXZ8MQMyR7AIufMsODyvuylh0e0973qDloPxAmN3ueGPsTF8Vceq2ls9Xprt
	 aGUzf2xkm9Kqg==
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
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: [V3 0/4] Add PPS generators
Date: Fri,  8 Nov 2024 08:31:11 +0100
Message-Id: <20241108073115.759039-1-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIBaUzqGFrtQ02cmwgNzNriiHgUdh/O/4Y9/6+QLfKGpQzi/Oocxj8WMsGcqh/iO4av9lut/DG1WSvh3DgPAhHYOD7lV86qwTd5jtGM1QttjjiMNtePX
 dcRcId4705JuhB0WwEnU9K3WepmCJYHBUY651kLCkTB7yKE5GJAxvkhziiAT5j5mv4OVak+nP36dggj8EC2jOdTuKRuYhksTzuPbbhNWqIMXhpCGhDrbMIAF
 vE7ImzH1uTi/QXd/ZUOyaEL0Z/clsji7FIinah41+Z7GSFS4BCt2UEejewlgDWF5lGrRFxMcfg5f0Q3PH4g/rpFr2e7BuwuRitSkub4dxSQ82PWJAPuiU6Dc
 Cp/8yu5zCpkq63wQb3QbKE4AIUqDSlBjf//8tEhKABPYf4g7A12G4GN1FwFE9PmS+oM3p9z2V6LLba3rf32pGbnsC47fQuG2oYK2qhL3wxuEYQkFkv1m0ABW
 zHlI8FtFfogevQTB6obZd2Ywv5MowZliZMyYxBq8rSAJfdIRBFGusoOIqnD4WHaub6ASPLaYoltiCte8tUBdg4ElZCFwtc2fctLP+ORmJiRLHNclSAcW/HVW
 5DlfSxHbuVa7sTbXg7rI5qleyr3IqrB74o/OHUiHSME+IcjJ9Q3YfshIDl2wdyh0K6EyPZ9cL1IYOfvXXnS+KBzCHTs9RH4nTSul5zz1VYLm8CS7Usz3/iW8
 QSMcjVVY78Pz8fvHWgiQwkrFk7bM8RtQMD/r9dRoYAiIhYlVDb3AdSxUcHE8HbQrE9fGgDpi7Wc=

PPS generators are special hardware which are able to produce PPS
(Pulse Per Second) signals.

This patchset adds PPS generators class in order to have a well-defined
interface for these devices.

Changelog:

V2 -> V3:
    * KernelVersion entry added to the Documentation ABI
    * spelling and/or syntax errors fixed

V1 -> V2:
    * new file Documentation/ABI/testing/sysfs-pps-gen added in MAINTAINERS
    * date for the documentation ABI set to v6.13 which will be released on 2025-02
    * removed documentation for non-existent sysfs "name" entry
    * spelling and/or syntax errors fixed

RFC -> V1:
    * char device reworked (get_device/set_device)
    * dummy driver has been moved in a separate patch
    * idr_ replaced with ida_* functions
    * fixes in include/uapi/linux/pps_gen.h
    * MAINTAINERS updated
    * new ioctl PPS_GEN_USESYSTEMCLOCK added
    * new ioctl PPS_GEN_FETCHEVENT added
    * .compat_ioctl dropped
    * WARN_ON() removed from pps_gen_cdev_release()
    * not needed pr_*() calls removed or replaced with dev_*()
    * more quite driver
    * name attribute dropped
    * white spaces removed

Rodolfo Giometti (4):
  drivers pps: add PPS generators support
  drivers pps/generators: add dummy PPS generator
  Documentation pps.rst: add PPS generators documentation
  Documentation ABI: add PPS generators documentation

 Documentation/ABI/testing/sysfs-pps-gen       |  43 +++
 Documentation/driver-api/pps.rst              |  40 ++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   2 +
 drivers/pps/Makefile                          |   3 +-
 drivers/pps/generators/Kconfig                |  22 +-
 drivers/pps/generators/Makefile               |   4 +
 drivers/pps/generators/pps_gen-dummy.c        |  96 +++++
 drivers/pps/generators/pps_gen.c              | 344 ++++++++++++++++++
 drivers/pps/generators/sysfs.c                |  75 ++++
 include/linux/pps_gen_kernel.h                |  78 ++++
 include/uapi/linux/pps_gen.h                  |  37 ++
 12 files changed, 743 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-pps-gen
 create mode 100644 drivers/pps/generators/pps_gen-dummy.c
 create mode 100644 drivers/pps/generators/pps_gen.c
 create mode 100644 drivers/pps/generators/sysfs.c
 create mode 100644 include/linux/pps_gen_kernel.h
 create mode 100644 include/uapi/linux/pps_gen.h

-- 
2.34.1


