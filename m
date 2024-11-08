Return-Path: <linux-kernel+bounces-401199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 383EC9C171F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9EAAB22E70
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B881DF26A;
	Fri,  8 Nov 2024 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="l+5hL0Mr"
Received: from smtpcmd0756.aruba.it (smtpcmd0756.aruba.it [62.149.156.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB871D12E9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051520; cv=none; b=LvMiNlWZTpqxwq4f6Vp9GeYao1ahYj5rrEAV1w9I2+aU1+H0wda3Ij8vTWPPjUV1k3tim2lqokeq7fgTymJSXf5nUczkA9ioyKmJeabJ86sl57nLCRe46M3AG77L2b9URJCGWTFWWkPEy27/vx2tr4wWtCD688WpKLZkpG3zwWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051520; c=relaxed/simple;
	bh=L9tCvOiQSlxC+XUZd0dK9si0gZo88vvaD5/hqTT0opY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mgWcwbc+ecZzw/Hjdcbj0cIRoEw3A6bbXiK8uu+ljCMocPiDPkvhURaQIDOScz7ApRmv3Iq2dZC9Pl4B4ZGeOsjt/vUEKpzQZNjdXj3D1QFfL6uCVFAqY2od2YfdmBerVYRFqrOuadBB59GwG3lXRhL0+5WK45H5E0Rfa0A9+Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=l+5hL0Mr; arc=none smtp.client-ip=62.149.156.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.everex.local ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 9JSetHUHi6epj9JSitjpei; Fri, 08 Nov 2024 08:31:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1731051081; bh=L9tCvOiQSlxC+XUZd0dK9si0gZo88vvaD5/hqTT0opY=;
	h=From:To:Subject:Date:MIME-Version;
	b=l+5hL0Mrw0lf3lHegqhO9bBd5DVfpN/CNfHCZLcPO/3kKd5SrXh1C/uW7VFlNQkjj
	 iQuo8kYVL4KiLWPolnvRUyCBpSXWa8ywYMHolqq/USDiQE65bd+Z3P5HOlxFz8U66S
	 upYUdU9K1zpDtcTn/SQAg7crxaCGapW8f+e08hbC6LaDB+B0WpMHJVApreCRfrhBr2
	 Xcdfbn91k5vwb0LJZ2cvEpk87RDCXc2wVFj4nGAkbAtI6e2ophwXV12ZmSMCckbCW5
	 OyAcRVvRdNpKa7I9eOAbRM9AuO1L0bE4g7gRIlsSuidnEcslPWbk9YNO72txDaglE6
	 d1IBRsE572UTA==
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
Subject: [V3 3/4] Documentation pps.rst: add PPS generators documentation
Date: Fri,  8 Nov 2024 08:31:14 +0100
Message-Id: <20241108073115.759039-4-giometti@enneenne.com>
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

This patch adds some examples about how to register a new PPS
generator in the system, and how to manage it.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 Documentation/driver-api/pps.rst | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
index 78dded03e5d8..71ad04c82d6c 100644
--- a/Documentation/driver-api/pps.rst
+++ b/Documentation/driver-api/pps.rst
@@ -202,6 +202,46 @@ Sometimes one needs to be able not only to catch PPS signals but to produce
 them also. For example, running a distributed simulation, which requires
 computers' clock to be synchronized very tightly.
 
+To do so the class pps-gen has been added. PPS generators can be
+registered in the kernel by defining a struct pps_gen_source_info as
+follows::
+
+    static struct pps_gen_source_info pps_gen_dummy_info = {
+            .name                   = "dummy",
+            .use_system_clock       = true,
+            .get_time               = pps_gen_dummy_get_time,
+            .enable                 = pps_gen_dummy_enable,
+    };
+
+Where the use_system_clock states if the generator uses the system
+clock to generate its pulses, or they are from a peripheral device
+clock. Method get_time() is used to query the time stored into the
+generator clock, while the method enable() is used to enable or
+disable the PPS pulse generation.
+
+Then calling the function pps_gen_register_source() in your
+initialization routine as follows creates a new generator in the
+system::
+
+    pps_gen = pps_gen_register_source(&pps_gen_dummy_info);
+
+Generators SYSFS support
+------------------------
+
+If the SYSFS filesystem is enabled in the kernel it provides a new class::
+
+    $ ls /sys/class/pps-gen/
+    pps-gen0/  pps-gen1/  pps-gen2/
+
+Every directory is the ID of a PPS generator defined in the system and
+inside of it you find several files::
+
+    $ ls -F /sys/class/pps-gen/pps-gen0/
+    dev  enable  name  power/  subsystem@  system  time  uevent
+
+To enable the PPS signal generation you can use the command below::
+
+    $ echo 1 > /sys/class/pps-gen/pps-gen0/enable
 
 Parallel port generator
 ------------------------
-- 
2.34.1


