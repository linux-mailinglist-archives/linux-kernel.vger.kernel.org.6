Return-Path: <linux-kernel+bounces-401200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8829C171E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFA81C20E38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821531DF730;
	Fri,  8 Nov 2024 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="UHn7PUe4"
Received: from smtpcmd0756.aruba.it (smtpcmd0756.aruba.it [62.149.156.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF6B1D173D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051520; cv=none; b=uHoSmCkNeU9zmLcM5U1jSaE+60kUR3ZFxQPG0Pb1rslsB0DUYaqdsd+oxI/K4jZH1junyGIDtN7oV0ako4px5oTpGL+TpNyKG/8yULGrScuVWqxYiRO/1v0ZdMmgurAQOok6RlNc9QIxN+BqlyZbduKT/YrL5mzwWIQtSDask6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051520; c=relaxed/simple;
	bh=clU5E4Cj40RGlQga2eSAucvDuowSdrOWRq2hMukgfLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=avj4Saku4xeCvywLcnHKM7Y0KkIjKJA4Td7Vui4dgVmCgrY8hDUbbSHUzjPJ0xSaTHpRlpANTbO8IPHChrSxkedb11BSAYYyioBaoOzkXNU5bNSsd3R6zRJ3gMnamNsi58yMt8Q/+/4WaHXYdHog/DZVvZGGS8P72WzJeCOl7us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=UHn7PUe4; arc=none smtp.client-ip=62.149.156.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.everex.local ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 9JSetHUHi6epj9JSjtjpf3; Fri, 08 Nov 2024 08:31:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1731051081; bh=clU5E4Cj40RGlQga2eSAucvDuowSdrOWRq2hMukgfLw=;
	h=From:To:Subject:Date:MIME-Version;
	b=UHn7PUe4By/gWDGfPSs8kGOX5/clDhkogoyB0Bi2L9C8fzpERg0v/34kJnnjIkq9C
	 wTYDDmwQa3jAdhXAnHMJKBCJoxC/EzYjCezX2gA0ArytZgh6VUF19icRGyfMpp4j7/
	 SwEyCZFmGfxxKm2wYRh1CCBUPqu4h1wjVa0ilQ/V1SHNJuk7YDvBzppAgWtvGM4vHX
	 oh6mqX0yZJG+acZ9Ir2X8SpaUCnU2H1Eet6PcVJE5b3+b5iHXVO/O3WD31uCAkJG67
	 NyuG+qZl9T+8PtWC/PuY4XWh1JpMCPZ0aOxPo6R71LkhewDw7AVXiPTPGo58zv52fQ
	 hbFDDzX6348+g==
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
Subject: [V3 4/4] Documentation ABI: add PPS generators documentation
Date: Fri,  8 Nov 2024 08:31:15 +0100
Message-Id: <20241108073115.759039-5-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108073115.759039-1-giometti@enneenne.com>
References: <20241108073115.759039-1-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFrLF5IO2JyylQ0Fj+GPE4d0lB8LXZ8yMFYX5v2O27ifTUnAf2mwRuveBqQ5W1NYmjC+qYuBtlL53IHzwpx/8F1hpiyZX3mw5cjRUW7PMW2pv+OVTVBv
 HcYorQoyVJfJrAaDs2O9ZJFmyefILZE/HbVWQGQjWXFkzT/1nsgGNoUqAvy5BlIr+VWDzKqvMqbg+wAHVFTNZ7s0SfHP6s/8Sg7TGHtZdwc0Z26I75oHH4kQ
 dRWLI90v00oPy9h5UW/Ddd6TMbCqQBBSO5g0n7sW1NriiyWvTGYEbCqkTOEl+AtrBcwoyF0Gv4F5+y7htsjHazFJk+U/WREX9EIh87mMLHEQy1MGxcM9N2Qv
 3T6yXP5TQ1StoJLtKKFSdDCkcnoJEvYEBJ8rSA/QjAPN92Zner6hvgJT2I4zOzNgkoMm8/IMpaFQ7dyJ9+qQKaizhXZ3p0HykR0Qc+w/VEiYM4OEfgvTx0lA
 6ipZEwUF79DSapY9Aelt+abnNfQr+AxWH6hL7BrDRRXi8oNsopCZtIU7Y7yt96nISk7G0qy6CZPy93HOeidDiFdrwEH8Jx0FiYQhpz1gMQ/D/nx6WzYQIaiP
 BGTNzkmXLB3J9krSppNuTeCyqc0OHaZk9XyjWHZHSg/HfE/bnbb8mde8n9MIlqrIeyiP+iOdoD7jLToH7XvvV8F9nxfrJmKvBwoLCStcMoD4K/ptBDljPdZP
 XQNKUgYkM/qnRSCNZO3yTHr1+nV4DJZnGzB5u2CrOFBvn6MbEL5Y0bUkNGIGG7lp467DKF9qq5Y=

This patch adds the documentation for the ABI between the Linux kernel
and userspace regarding the PPS generators.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 Documentation/ABI/testing/sysfs-pps-gen | 43 +++++++++++++++++++++++++
 MAINTAINERS                             |  1 +
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-pps-gen

diff --git a/Documentation/ABI/testing/sysfs-pps-gen b/Documentation/ABI/testing/sysfs-pps-gen
new file mode 100644
index 000000000000..2519207b88fd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-pps-gen
@@ -0,0 +1,43 @@
+What:		/sys/class/pps-gen/
+Date:		February 2025
+KernelVersion:  6.13
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		The /sys/class/pps-gen/ directory contains files and
+		directories that provide a unified interface to the PPS
+		generators.
+
+What:		/sys/class/pps-gen/pps-genX/
+Date:		February 2025
+KernelVersion:  6.13
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		The /sys/class/pps-gen/pps-genX/ directory is related to X-th
+		PPS generator in the system. Each directory contain files to
+		manage and control its PPS generator.
+
+What:		/sys/class/pps-gen/pps-genX/enable
+Date:		February 2025
+KernelVersion:  6.13
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		This write-only file enables or disables generation of the
+		PPS signal.
+
+What:		/sys/class/pps-gen/pps-genX/system
+Date:		February 2025
+KernelVersion:  6.13
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		This read-only file returns "1" if the generator takes the
+		timing from the system clock, while it returns "0" if not
+		(i.e. from a peripheral device clock).
+
+What:		/sys/class/pps-gen/pps-genX/time
+Date:		February 2025
+KernelVersion:  6.13
+Contact:	Rodolfo Giometti <giometti@enneenne.com>
+Description:
+		This read-only file contains the current time stored into the
+		generator clock as two integers representing the current time
+		seconds and nanoseconds.
diff --git a/MAINTAINERS b/MAINTAINERS
index d65e54e385b8..236eba6a429e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18483,6 +18483,7 @@ L:	linuxpps@ml.enneenne.com (subscribers-only)
 S:	Maintained
 W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
 F:	Documentation/ABI/testing/sysfs-pps
+F:	Documentation/ABI/testing/sysfs-pps-gen
 F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
 F:	Documentation/driver-api/pps.rst
 F:	drivers/pps/
-- 
2.34.1


