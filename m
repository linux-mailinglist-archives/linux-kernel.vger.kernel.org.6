Return-Path: <linux-kernel+bounces-371864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D87289A4170
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09EE41C23C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA631FF60E;
	Fri, 18 Oct 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="bqAWRSex"
Received: from smtpcmd0986.aruba.it (smtpcmd0986.aruba.it [62.149.156.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84721C3F10
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262550; cv=none; b=FT7dqwaRd3WqyqKrWM3bqI/tL3TO5n/WT2xHzTE6pYq7ZzX/eIpa1tQWFfX3KT+ac+lP3TGHjR4fdi/EPE+vjE58M8PoFaRT4QR7cVLV0XGxcttCHt2XQnhXy3zKKuYwC4T3FoDVxW/4D01+6rggZFOb1YtKfsZDYuMwYFV9zKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262550; c=relaxed/simple;
	bh=cdcJb9H8yy7FXPibF4xVZrLc+VV4/S0BBeF8nOGjdO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+Q8Yro+lzETPz+kLrpF1Ua3eYNmSb4kLLAR/ro+nH/C/sVfxY0Rg9xpmH5xrentvsIFgUHgrUXorE99KTlSf3GIx6zZyOVgAaZZoYjysUilErCNNJc2vNgiuwEhZhDdeJl9UhzEFPpDufq7SJbzp4h2MvRah844NWrcH78SqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=bqAWRSex; arc=none smtp.client-ip=62.149.156.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.homenet.telecomitalia.it ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 1o8JtbKaEcvwV1o8LtrUAg; Fri, 18 Oct 2024 16:39:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1729262357; bh=cdcJb9H8yy7FXPibF4xVZrLc+VV4/S0BBeF8nOGjdO8=;
	h=From:To:Subject:Date:MIME-Version;
	b=bqAWRSexXUQEYQ7S0gpWmMky7ZpOsYFM1HisIuVWO37kqy1mgSAPU5r3hqs6Pqcgj
	 cKRl/ASioraqI4gCWNzRBART58TiN7Jsn05NLBEtjkSyneRsYVT5k0A9sPbUy1uyxT
	 XnbUPJ0382yfN4gvIGpIEwrTiP6KdIdm2KejBwN8Mcb+NYURfVg9dNl/FfujE8aF04
	 AWQNGGdnhqERiBBL1d1t8HiNEn59ehVph06wqxfvn18Ou97G1fD2LRuuoEinq44F88
	 2eh4sWwAYTnuEW7wfz6X5BEyUZ9hpY6DSIoW4P3iUUclCc2wJsflOvYW//mYQUGTfg
	 apnvDP6Tvmt0Q==
From: Rodolfo Giometti <giometti@enneenne.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <greg@kroah.com>,
	corbet@lwn.net,
	Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>,
	tglx@linutronix.de,
	andriy.shevchenko@linux.intel.com,
	Dong Eddie <eddie.dong@intel.com>,
	N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: [V1 3/4] Documentation pps.rst: add PPS generators documentation
Date: Fri, 18 Oct 2024 16:39:14 +0200
Message-Id: <20241018143915.3877425-4-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018143915.3877425-1-giometti@enneenne.com>
References: <20241018143915.3877425-1-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHAAvZVynokt+Fh/gYDT31LaOx6QueTeFPHeTaLAB2yNNvVYm+ULZem6GPFLtkjZIaBzKvPQPDfdfXJ5r3HVGHGIpQxY7dxJ74Ol8YEQPP2LRwdjphB0
 brM0IUQaDydHFrXNuJkRtknfGz/+hh+qE6oxt4zjiB48Z31BgigC1J0KRJo6iodERF2ZHclOzZJzWj4bFfkwZJnz5tjna/7vH/W4wHDEwmoqy03bixNwd/Rh
 qnHucwWlbKCtCAQwm+P7XHS8FhPAVmGXEaidkbIYkivGbhrYKgCXKXGtRN5meQimW/8lzY9OJJCkoSsNALk1IIulmNFmTvUa3K/RJTzClDrz24CS9hkJgWjd
 vF9+fd/4Y5pDvbZFN7cbd2/+miOwHq+0STYHdlLb2FkP3Hd/M2vhti1cQXKnTSP8TcNJnjKIUnRo9GUdsgX2n2DDSE5In2cqZzIkZtWXj5iAgfXzEYR7AQVF
 5yS4njpFXSHK+OOTWrHy57Sbign6DAEGcvR2rMj6++Gr7aaarTrTq/NyvdW36pq7NgvR/Af8qt0XmQojrgRpxN3HeY0KjzSFAS0xtNXu4sLhioUcrcRIumKI
 Rwi3WbNekPLEuzzwpsd6hCTjbD6wQlUWT2jjsoJeMixIWgfEx8G2pSdjy0JHG76lpF9rYFaRm69W2+urZpTKDbDJ9uCw8CrImFmIgzW25LfLlXXHe7hSaY2a
 FT4xAoYrQpWGjA2ikn6fsd6CsRJm133x

This patch adds some examples about how to register a new PPS
generator in the system, and how to manage it.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 Documentation/driver-api/pps.rst | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
index 78dded03e5d8..c71b3b878e41 100644
--- a/Documentation/driver-api/pps.rst
+++ b/Documentation/driver-api/pps.rst
@@ -202,6 +202,46 @@ Sometimes one needs to be able not only to catch PPS signals but to produce
 them also. For example, running a distributed simulation, which requires
 computers' clock to be synchronized very tightly.
 
+To do so the class pps-gen has been added. PPS generators can be
+registered int the kernel by defining a struct pps_gen_source_info as
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
+clock to generate its pulses, or from a peripheral device
+clock. Method get_time() is used to query the time stored into the
+generator clock, while the method enable() is used to enable or
+disable the PPS pulse generation.
+
+Then calling the function pps_gen_register_source() in your
+initialization routine as follows a new generator is created into the
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
+inside you find several files::
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


