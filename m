Return-Path: <linux-kernel+bounces-445344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155079F14DC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C657028337A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251551EBA08;
	Fri, 13 Dec 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="jiXHgLc+"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DD41E048B;
	Fri, 13 Dec 2024 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114091; cv=none; b=mglVqCTpd6fSjHxjj/hg/RhDfbMCM1JBb/ZR3K+WUa6DCQo5eMD025W7bXANyWBLy7IbPBoTFXkOb73sAdm1Kj1ik9KbACLjwuvCc2NYn6yavCFy1cMMukNdPRe48zi2VC/Q3J9aFvbM5LqKHPHTte8vR1/YmMKape6BManLdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114091; c=relaxed/simple;
	bh=FjPXo6BxFKKLA8ZrbiSiN4Fx69AHdFEAFlcVbFHNz4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrhopBiKyPtTjVMsJYGoxZAoAoish+D33/nBjsVl3oBGgPf+gFLz+ISA7GE1YXmU0ZwhS2WPYgO5GbjHkVLplUWzg+G9iD975lH/gVF8rDNJtjw/Ed1ZILRJf6NTmpaMZEFHYzAIqLoZXLWHGfw0QrsLFjdmqChf/84diwkMlck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=jiXHgLc+; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 186E0404EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1734114089; bh=F6/aLflciz6wVnpv9AxpaYczVWgHDtrn6Q0EXWxfMWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jiXHgLc+u3SAk5aJiklQ2ednZdNnnbtap9Bdy9B2XWgf9Ec1v3RhricJ3VfVYx4yA
	 fpA2YiHSihRbtAi+zgBwsFvTCy4/jpc1lZsnDEOOY4t3e7sgmB7+ICo76u+Th3qyZD
	 QpUNEMlJ2/RqaB+1zqzsGxWQ0Gx7xzSXV+p7F5RAnRSsFep2MAJ7DZ1C/QQs2DqpaE
	 VfMduuZR00lzVp5r2xc3/C7AB78OmKihv5CCDfo9d1jMBKiP3lbrsAALSd+FrDo0Lj
	 IR59GBNStrhznFCzpjffA79B/piPOuGz5Hht/CfpifIK5W/oGXbcDZEc1Q4nhV5H6t
	 bTp88OF3x2puQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:5e00:625::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 186E0404EA;
	Fri, 13 Dec 2024 18:21:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/3] docs: admin-guide: bring some order to the "everything else" section
Date: Fri, 13 Dec 2024 11:20:54 -0700
Message-ID: <20241213182057.343527-4-corbet@lwn.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213182057.343527-1-corbet@lwn.net>
References: <20241213182057.343527-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bulk of the admin guide had become a big pile of stuff haphazardly
tossed together, mostly in the catch-all "everything else" section.  Split
that section into a few broad categories and sort the documents into them
as appropriate.

No documents have been added or removed, they are just reordered.  Note
that many of these documents are severely obsolete and should be considered
for removal.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/admin-guide/index.rst | 161 +++++++++++++++++-----------
 1 file changed, 100 insertions(+), 61 deletions(-)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 6864b079b391..c8af32a8f800 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -18,18 +18,41 @@ etc.
    :maxdepth: 1
 
    README
-   kernel-parameters
    devices
-   sysctl/index
 
    features
 
-This section describes CPU vulnerabilities and their mitigations.
+A big part of the kernel's administrative interface is the /proc and sysfs
+virtual filesystems; these documents describe how to interact with tem
+
+.. toctree::
+   :maxdepth: 1
+
+   sysfs-rules
+   sysctl/index
+   cputopology
+   abi
+
+Security-related documentation:
 
 .. toctree::
    :maxdepth: 1
 
    hw-vuln/index
+   LSM/index
+   perf-security
+
+Booting the kernel
+------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   bootconfig
+   kernel-parameters
+   efi-stub
+   initrd
+
 
 Tracking down and identifying problems
 --------------------------------------
@@ -53,104 +76,120 @@ problems and bugs in particular.
    kdump/index
    perf/index
    pstore-blk
+   clearing-warn-once
+   kernel-per-CPU-kthreads
+   lockup-watchdogs
+   RAS/index
+   sysrq
+
 
-sysfs
------
+Core-kernel subsystems
+----------------------
 
-A big part of the kernel's administrative interface is the sysfs virtual
-filesystem; these documents describe how to interact with sysfs.
+These documents describe core-kernel administration interfaces that are
+likely to be of interest on almost any system.
 
 .. toctree::
    :maxdepth: 1
 
-   sysfs-rules
-   abi
-
-Workload analysis
------------------
+   cgroup-v2
+   cgroup-v1/index
+   cpu-load
+   mm/index
+   module-signing
+   namespaces/index
+   numastat
+   pm/index
+   syscall-user-dispatch
 
-This is the beginning of a section with information of interest to
-application developers and system integrators doing analysis of the
-Linux kernel for safety critical applications. Documents supporting
-analysis of kernel interactions with applications, and key kernel
-subsystems expectations will be found here.
+Support for non-native binary formats.  Note that some of these
+documents are ... old ...
 
 .. toctree::
    :maxdepth: 1
 
-   workload-tracing
+   binfmt-misc
+   java
+   mono
 
-Everything else
----------------
 
-The rest of this manual consists of various unordered guides on how to
-configure specific aspects of kernel behavior to your liking.
+Block-layer and filesystem administration
+-----------------------------------------
 
 .. toctree::
    :maxdepth: 1
 
-   acpi/index
-   aoe/index
-   auxdisplay/index
    bcache
    binderfs
-   binfmt-misc
    blockdev/index
-   bootconfig
-   braille-console
-   btmrvl
-   cgroup-v1/index
-   cgroup-v2
    cifs/index
-   clearing-warn-once
-   cpu-load
-   cputopology
-   dell_rbu
    device-mapper/index
-   edid
-   efi-stub
    ext4
    filesystem-monitoring
    nfs/index
-   gpio/index
-   highuid
-   hw_random
-   initrd
    iostats
-   java
    jfs
-   kernel-per-CPU-kthreads
+   md
+   ufs
+   xfs
+
+Device-specific guides
+----------------------
+
+How to configure your hardware within your Linux system.
+
+.. toctree::
+   :maxdepth: 1
+
+   acpi/index
+   aoe/index
+   auxdisplay/index
+   braille-console
+   btmrvl
+   dell_rbu
+   edid
+   gpio/index
+   hw_random
    laptops/index
    lcd-panel-cgram
-   ldm
-   lockup-watchdogs
-   LSM/index
-   md
    media/index
-   mm/index
-   module-signing
-   mono
-   namespaces/index
-   numastat
+   nvme-multipath
    parport
-   perf-security
-   pm/index
    pnp
    rapidio
-   RAS/index
    rtc
    serial-console
    svga
-   syscall-user-dispatch
-   sysrq
    thermal/index
    thunderbolt
-   ufs
-   unicode
    vga-softcursor
    video-output
-   xfs
-   nvme-multipath
+
+Workload analysis
+-----------------
+
+This is the beginning of a section with information of interest to
+application developers and system integrators doing analysis of the
+Linux kernel for safety critical applications. Documents supporting
+analysis of kernel interactions with applications, and key kernel
+subsystems expectations will be found here.
+
+.. toctree::
+   :maxdepth: 1
+
+   workload-tracing
+
+Everything else
+---------------
+
+A few hard-to-categorize and generally obsolete documents.
+
+.. toctree::
+   :maxdepth: 1
+
+   highuid
+   ldm
+   unicode
 
 .. only::  subproject and html
 
-- 
2.47.1


