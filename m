Return-Path: <linux-kernel+bounces-390941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049E29B804F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F631C21D92
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5AD1BC07B;
	Thu, 31 Oct 2024 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="PP3IWnSh"
Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1613B1BC092
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392705; cv=none; b=V0I/ziu8KRJvYkLhGaB3/VQpwX9MGf43OKacDtEXReZqXUjMSx1lS9XW+/WUN3wVZeGUL+kLeDjfFy7Qfk0S/vxNyJWJWvRxel8K7PNdzWzMNmIS2kGiEU6Y4ij2LTnssYAaTVItNr+evebyy/jRMokwLo7z10LqZGQqONGjFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392705; c=relaxed/simple;
	bh=VFMn6ViOGXV/RBm2wpEduDTGHwJW7KOXv7vL9E399kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HLvD0bq5XDcZ4b/YdxGREVz+LKnOeJLEvyQzRpN3heyUJWcSasuaTJNTlacY4/hlEh5dHo8QgEeAM5fOPag8Vh227+oU2g0BdhFre+inVdXb/0zu9e6WMOvcqMPGiZrGOa5aDc8hg+ERksi3VsTQgZzLsrO7w9yD86QYvBAsBSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=PP3IWnSh; arc=none smtp.client-ip=62.149.156.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.everex.local ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 6Y8atb5dFqJRS6Y8etNuIC; Thu, 31 Oct 2024 17:35:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1730392512; bh=VFMn6ViOGXV/RBm2wpEduDTGHwJW7KOXv7vL9E399kg=;
	h=From:To:Subject:Date:MIME-Version;
	b=PP3IWnShM85Pc794Fy9G7m5usfsR7PN3DslIheGNAhAKkxSj8HIEIwiIidtSJqVSH
	 oJz+wiUsS1BBqp6kJQnpfRuUdAc1EzdvRkC1eTTTMzeOZHwuRpkXDuL1lkiQT+E+wP
	 j9DFS3nPh3YPcQbyNsq/q4mb/l4MamBBLwKGGCD/dIoStB15PrU9dweuftXD30533X
	 8UtLkcMavTHFBnclaZxwiMS6dzCxjiy4WbQg4HS1cwReUh2MnSFXWUXCpyob/mlFWR
	 Z4pngbdg5gsxfUaXnGcUpWCYtzJC11zhPu+UBZPKc/fYBqrNf3hGk2I/SM6fdXHwC/
	 +0+KQ99UrIJ5A==
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
Subject: [V2 3/4] Documentation pps.rst: add PPS generators documentation
Date: Thu, 31 Oct 2024 17:35:07 +0100
Message-Id: <20241031163508.259522-4-giometti@enneenne.com>
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
X-CMAE-Envelope: MS4xfC4xJUzpyCeO512MKewBUXNC4nAmGrgTaZrYRB09ByD5SuetG3jKHT7f5+pLMj3x/nDQx7PZ0NY7Kh6FUgquTM9fs7rlt107VMFkASeI8bDdaPuVagbg
 s0CZ/4bJTUgvzoajhk4OOsSPNcjk/X0Pj4udoZ1NXVVBqdW+suT6YjOI9qmJYZDZ4Jgk18DKXOIfYHaWjPITDdNDYgL6MLKPuLcuFLsY6fZJQkAF6lVSuyAp
 crDj6HfPLJO+YNzhokInuNKmoNBpeKTgV+6V3h8ErcugLoTCLKxceqEEnaDssY6/2Tw5nFYGb0DdDct5JMH+ILgmo3QiIMvKCJ6gpR1gsA3FRehLK5+vzSdn
 Q6p697yL76leu9kKsMpZ+UmdFJVLFpBsEAiri+mZTiw4y91p8yAEy8MggacEerUONWK3I+ODfN1vWlg0QZ6uEoc34/ZOVOHY/VtJGjBmrY68+grEyaMleQxw
 zvYEJM3GHEKDdTpYcJdGYWnRmCjsxkRPACFx0vh87UUKFpIUaLFeHvE+3vS3jxLsB3r1/l7VfhpxIsUA3ar8rCjLl68cpwZU4Cef0Njt2zUxRU2RWEKxOePO
 HZyU6oMvz+nqGyftZZQbL8woxAP7LlKgtw/0JS+yA54Ucnc+VVnBcO7XY15uqUB0TZOf4wkJf7xjtKkPvDEevwBE4HEWEXSDiXTJJXSWNtKriaxMPHF5yF5T
 zigl0OuO8O1mHUXLSuO50dlTWEARQLXe

This patch adds some examples about how to register a new PPS
generator in the system, and how to manage it.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 Documentation/driver-api/pps.rst | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
index 78dded03e5d8..dffa06ed919f 100644
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
+clock to generate its pulses, or from a peripheral device
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


