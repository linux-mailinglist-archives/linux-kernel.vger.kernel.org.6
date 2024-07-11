Return-Path: <linux-kernel+bounces-248916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6C592E3CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595C4B229CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57711581F7;
	Thu, 11 Jul 2024 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+3mx4UN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54FD155CBA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691540; cv=none; b=MHt9LWsZPIqB/GfkchCg6cLBnfAvNDfShOdop4nJ2gTkH7BGj4/qFySbYAbJKxQWFm3IdSvT4vDflXipPG8bbW7LtdM45IHzPMl9xxPnAvVFMlI6dSU/NFoMI+UhB4xLqjvvlAX4hVJzC+/AsM9fpLY0+HY0NugNtOKjsks8O6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691540; c=relaxed/simple;
	bh=8fT3iZX4Ak9UXbYdPywtW7xLXPjIWOMseP9okwfRJuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOJVWHseiq0pTEoVjnerSJkkY2A2aOPXx/TVU2v7se7OmlPDfB6FJyf5/7Ix/d07EFkDgIn9Wuwoi2LjpKStPDfnbiO5jkaBDjgWxm4VfDBkEWwa5Td+ntS8FSOPPpmUJEUuq6P7/asth11yGpjG4dJ5ChcvG9qod+4/lw75KZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+3mx4UN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2DFC4AF07;
	Thu, 11 Jul 2024 09:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720691540;
	bh=8fT3iZX4Ak9UXbYdPywtW7xLXPjIWOMseP9okwfRJuM=;
	h=From:To:List-Id:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+3mx4UNN8dYWiUIP60+AhLYFaiOhAWuATFMyah3Xq/HI+oD1QiX00VMQFyvjdspr
	 WwGqXqKqlNOOrvS+QJQIM2wRJ9pzmil8TXOA4LtKD1fwuwG1n6WQBd48sgg2tjHGCK
	 XzMUyJh56sMMyO2zK6/ILApmw6UAMvJhyg8wfcXdVfsOrpuCjUpYQ+WcY160GJakgv
	 HcFm2llcvsCuDLyi1s5JWaUg5e1GsnnP0UAjVdwSvTdHKWf4eJgd+3iyOULlElxDjY
	 CiySy3vZDcsfDO+wPjEyNn7PrPnSbdHZ7G1w68zkToLGTKDhbQAq9/XYUQtXA36vS5
	 uDNjCQbHgd6bQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sRqTK-00000002jZt-2siQ;
	Thu, 11 Jul 2024 11:52:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-edac@kernel.org,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/6] acpi/ghes: update comments to point to newer ACPI specs
Date: Thu, 11 Jul 2024 11:52:07 +0200
Message-ID: <1ca920c8cebbb5aaac2a9f65ffccf7b4443ea666.1720690278.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720690278.git.mchehab+huawei@kernel.org>
References: <cover.1720690278.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

There is one reference to ACPI 4.0 and several references
to ACPI 6.x versions.

Update them to point to ACPI 6.5 whenever possible.

There's one reference that was kept pointing to ACPI 6.4,
though, with HEST revision 1.

ACPI 6.5 now defines HEST revision 2, and defined a new
way to handle source types starting from 12. According
with ACPI 6.5 revision history:

	2312 Update to the HEST table and adding new error
	     source descriptor - Table 18.2.

Yet, the spec doesn't define yet any new source
descriptors. It just defines a different behavior when
source type is above 11.

I also double-checked GHES implementation on an open
source project (Linux Kernel). Currently upstream
doesn't currently handle HEST revision, ignoring such
field.

In any case, revision 2 seems to be backward-compatible
with revison 1 when type <= 11 and just one error is
contained on a HEST record.

So, while it is probably safe to update it, there's no
real need. So, let's keep the implementation using
an ACPI 6.4 compatible table, e. g. HEST revision 1.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 6075ef5893ce..ebf1b812aaaa 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -45,9 +45,9 @@
 #define GAS_ADDR_OFFSET 4
 
 /*
- * The total size of Generic Error Data Entry
- * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
- * Table 18-343 Generic Error Data Entry
+ * The total size of Generic Error Data Entry before data field
+ * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
+ * Table 18.12 Generic Error Data Entry
  */
 #define ACPI_GHES_DATA_LENGTH               72
 
@@ -65,8 +65,8 @@
 
 /*
  * Total size for Generic Error Status Block except Generic Error Data Entries
- * ACPI 6.2: 18.3.2.7.1 Generic Error Data,
- * Table 18-380 Generic Error Status Block
+ * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
+ * Table 18.11 Generic Error Status Block
  */
 #define ACPI_GHES_GESB_SIZE                 20
 
@@ -82,7 +82,8 @@ enum AcpiGenericErrorSeverity {
 
 /*
  * Hardware Error Notification
- * ACPI 4.0: 17.3.2.7 Hardware Error Notification
+ * ACPI 6.5: 18.3.2.9 Hardware Error Notification,
+ * Table 18.14 - Hardware Error Notification Structure
  * Composes dummy Hardware Error Notification descriptor of specified type
  */
 static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
@@ -112,7 +113,8 @@ static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
 
 /*
  * Generic Error Data Entry
- * ACPI 6.1: 18.3.2.7.1 Generic Error Data
+ * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
+ * Table 18.12 - Generic Error Data Entry
  */
 static void acpi_ghes_generic_error_data(GArray *table,
                 const uint8_t *section_type, uint32_t error_severity,
@@ -148,7 +150,8 @@ static void acpi_ghes_generic_error_data(GArray *table,
 
 /*
  * Generic Error Status Block
- * ACPI 6.1: 18.3.2.7.1 Generic Error Data
+ * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
+ * Table 18.11 - Generic Hardware Error Source Structure
  */
 static void acpi_ghes_generic_error_status(GArray *table, uint32_t block_status,
                 uint32_t raw_data_offset, uint32_t raw_data_length,
@@ -429,15 +432,18 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
         0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
 }
 
-/* Build Generic Hardware Error Source version 2 (GHESv2) */
+/*
+ * Build Generic Hardware Error Source version 2 (GHESv2)
+ * ACPI 6.5: 18.3.2.8 Generic Hardware Error Source version 2 (GHESv2 - Type 10),
+ * Table 18.13: Generic Hardware Error Source version 2 (GHESv2)
+ */
 static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
 {
     uint64_t address_offset;
-    /*
-     * Type:
-     * Generic Hardware Error Source version 2(GHESv2 - Type 10)
-     */
+    /* Type: (GHESv2 - Type 10) */
     build_append_int_noprefix(table_data, ACPI_GHES_SOURCE_GENERIC_ERROR_V2, 2);
+
+    /* ACPI 6.5: Table 18.10 - Generic Hardware Error Source Structure */
     /* Source Id */
     build_append_int_noprefix(table_data, source_id, 2);
     /* Related Source Id */
@@ -481,11 +487,8 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
     /* Error Status Block Length */
     build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
 
-    /*
-     * Read Ack Register
-     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
-     * version 2 (GHESv2 - Type 10)
-     */
+    /* ACPI 6.5: fields defined at GHESv2 table */
+    /* Read Ack Register */
     address_offset = table_data->len;
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                      4 /* QWord access */, 0);
@@ -504,11 +507,16 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
     build_append_int_noprefix(table_data, 0x1, 8);
 }
 
-/* Build Hardware Error Source Table */
+/*
+ * Build Hardware Error Source Table
+ * ACPI 6.4: 18.3.2 ACPI Error Source
+ * Table 18.2: Hardware Error Source Table (HEST)
+ */
 void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
                      const char *oem_id, const char *oem_table_id)
 {
-    AcpiTable table = { .sig = "HEST", .rev = 1,
+    AcpiTable table = { .sig = "HEST",
+                        .rev = 1,                   /* ACPI 4.0 to 6.4 */
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
     acpi_table_begin(&table, table_data);
-- 
2.45.2


