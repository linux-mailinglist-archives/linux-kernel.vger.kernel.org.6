Return-Path: <linux-kernel+bounces-563181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC6A637F2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16A1169A40
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEE01A2398;
	Sun, 16 Mar 2025 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="S8eWdMra";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hjP44SDS"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89E199E94;
	Sun, 16 Mar 2025 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742166461; cv=none; b=IZovFUxe2QSshsq1Wywp1MZP+Y8+dKAo4UXHZMHAOyjrhkk/1eLJPF4TaKe7J8PCDgQadD13OZKiq49pghsQFtzr56htMkvaj5HcriG4AjSy2mGciTbvwW+MPwV+eFieWOwGcgW9OE7Wq+K05men+SGZT50dfgezfY5564Qw53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742166461; c=relaxed/simple;
	bh=d/b92CfRATmE2P2AtJzDEumVRBazVBgp1vXAGiCdHAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfuLae9nYMjKsM46KEINvKM0w5Lzcw+DL1qUN5njHMI4g44tfqXZalC62hj27xth/HRpWaTCSP4NfeE5q3aTNnt+KtYlKmh8dX8Ba0uiELYOLtxXSf/5wge94cQ9u0cxskKSPQb7NGikioHwQPo6yeVK98pf4j0S8Q8TTwaJfmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=S8eWdMra; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hjP44SDS; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 04614254012D;
	Sun, 16 Mar 2025 19:07:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 16 Mar 2025 19:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1742166457; x=
	1742252857; bh=VGDTSGCJyo3MwS0CDSBmdsXpWUz6GNW16gOikh8F+a8=; b=S
	8eWdMraTt708WLLBt9aPnU5A/stVmgo5J/3wNAb2Hkxhy/8qpCbrYYbNZDFLgmmy
	bQ2yh3fLwaKFGOz+GB7Ia0Cz8yf/ofxlY8eU4QMPf1qkvUlQKuNSLfRCNzQc76uM
	Qfq+0mdPs9zQFtD8UkzEWF/YgUs4hspF+Ym4cce/Dz2OZE+T72M6JBZoYsbL95/X
	+9O/EoYfE0NXnkw0zxd8icM9/tAfQV09WZRB2CFHvkpuUHeE+mMFyMY0763tS01i
	pBgsK/J1GVMHB8mby3AFKKqQoS2/DW1I5gU5O2fv8KePfW0IXLKW9UDZiH1T1kdJ
	in9OmYXYIaQSn3sdSDx7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742166457; x=1742252857; bh=V
	GDTSGCJyo3MwS0CDSBmdsXpWUz6GNW16gOikh8F+a8=; b=hjP44SDSA+neCFqNd
	TA3XUjvjqgu/G1cGfFK9BLOo7hGIsz35rU6uHlT9r7F+bRW6O9gNodZwKSseX6PO
	64XZJv6JbV7TFtWpkGzxQ8s9TmyZn+f9tV/fGsUe710yzmZtqpTv5XsW7Z/Y/Wbi
	lKgPniok5SaB1bGgr1ADcDaCT+/uLFEjMicvT40fCpF8+J+2MLbDcHMHbLhAU77A
	DQmUrPitPGdu/tHwuax5Zbeo1F8TPL90C5Lc2IXyUjqN1l2YUfSMU3K3A3KijnAl
	ABqw0w9GW6KsTAKYLSG4M3MHpg0DNxUpWCORHZvt/LIeCMOBRk89M6jJSZ6Ei8NR
	FnviQ==
X-ME-Sender: <xms:uVnXZ_r8wx65G1cyfly9T0bJtbWpLs1mlUPpqJSySls5wfmzZ5oV0g>
    <xme:uVnXZ5puKXkx8QYJnzRWyhHMHE_aOsS_YqAoN9P9XUKiF4y3QG7UBauz4HKjAVoeE
    3tFKp939mNGEsrc16M>
X-ME-Received: <xmr:uVnXZ8PLWkn-zwjyRc4K4f6sTlTLJwnO3ktB0qmWBl3KNU-8zaDgFeROVtl5fPFYdpvMbn2pxceg1V6z1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvh
    eqnecuggftrfgrthhtvghrnhepueeuleeffeeihfelhffhheelfeffgeetuefhheevkeet
    uedugfetfeetlefhieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgr
    thdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinh
    htvghlrdgtohhmpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekiees
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntg
    hivghllhhosegrmhgurdgtohhmpdhrtghpthhtoheplhhukhgvsehljhhonhgvshdruggv
    vh
X-ME-Proxy: <xmx:uVnXZy5gYQUSoSNAIxvVxCn1d0E657WAbZ1K-ZIuo9ixh5CW9sSqIw>
    <xmx:uVnXZ-4Li5Hyf8KDBIt_Tr4RGYooNjcWjkme-T_NYhAy0v7AUJmabw>
    <xmx:uVnXZ6iEOskluOxTqOBy-hrhW9I8vc5kkGMLDG0ftCidN4KgnDiVqQ>
    <xmx:uVnXZw79lq7HEQPco21a55iNCxxCOOhDp5LEOQ0znPjy8vMVeq9hug>
    <xmx:uVnXZwQ6cDkflB6xHTlRUcqB2mic6VVxgdHAKAhPIj8OUqAgYSCvUmMh>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 19:07:35 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v7 1/8] platform/x86: asus-wmi: export symbols used for read/write WMI
Date: Mon, 17 Mar 2025 12:07:17 +1300
Message-ID: <20250316230724.100165-2-luke@ljones.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316230724.100165-1-luke@ljones.dev>
References: <20250316230724.100165-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Luke D. Jones" <luke@ljones.dev>

Export symbols for read/write WMI symbols using a namespace.
Existing functions:
- asus_wmi_evaluate_method
- asus_wmi_set_devstate
New function:
- asus_wmi_get_devstate_dsts

The new function is inteded for use with DSTS WMI method only and
avoids requiring the asus_wmi driver data to select the WMI method.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/asus-wmi.c            | 45 ++++++++++++++++++++--
 include/linux/platform_data/x86/asus-wmi.h |  9 +++++
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index cbc64d3a22ad..2784b8e6514e 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -389,7 +389,7 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
 {
 	return asus_wmi_evaluate_method3(method_id, arg0, arg1, 0, retval);
 }
-EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
+EXPORT_SYMBOL_NS_GPL(asus_wmi_evaluate_method, "ASUS_WMI");
 
 static int asus_wmi_evaluate_method5(u32 method_id,
 		u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
@@ -553,12 +553,51 @@ static int asus_wmi_get_devstate(struct asus_wmi *asus, u32 dev_id, u32 *retval)
 	return 0;
 }
 
-int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
-				 u32 *retval)
+
+/**
+ * asus_wmi_get_devstate_dsts() - Get the WMI function state.
+ * @dev_id: The WMI method ID to call.
+ * @retval: A pointer to where to store the value returned from WMI.
+ *
+ * On success the return value is 0, and the retval is a valid value returned
+ * by the successful WMI function call otherwise an error is returned if the
+ * call failed, or if the WMI method ID is unsupported.
+ */
+int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
+{
+	int err;
+
+	err = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, retval);
+	if (err)
+		return err;
+
+	if (*retval == ASUS_WMI_UNSUPPORTED_METHOD)
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(asus_wmi_get_devstate_dsts, "ASUS_WMI");
+
+/**
+ * asus_wmi_set_devstate() - Set the WMI function state.
+ * @dev_id: The WMI function to call.
+ * @ctrl_param: The argument to be used for this WMI function.
+ * @retval: A pointer to where to store the value returned from WMI.
+ *
+ * The returned WMI function state if not checked here for error as
+ * asus_wmi_set_devstate() is not called unless first paired with a call to
+ * asus_wmi_get_devstate_dsts() to check that the WMI function is supported.
+ *
+ * On success the return value is 0, and the retval is a valid value returned
+ * by the successful WMI function call. An error value is returned only if the
+ * WMI function failed.
+ */
+int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
 {
 	return asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, dev_id,
 					ctrl_param, retval);
 }
+EXPORT_SYMBOL_NS_GPL(asus_wmi_set_devstate, "ASUS_WMI");
 
 /* Helper for special devices with magic return codes */
 static int asus_wmi_get_devstate_bits(struct asus_wmi *asus,
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index a32cb8865b2f..96ff25b2b51b 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -160,6 +160,7 @@
 #if IS_REACHABLE(CONFIG_ASUS_WMI)
 void set_ally_mcu_hack(bool enabled);
 void set_ally_mcu_powersave(bool enabled);
+int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval);
 int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval);
 int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval);
 #else
@@ -175,6 +176,14 @@ static inline int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
 {
 	return -ENODEV;
 }
+static inline int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
+{
+	return -ENODEV;
+}
+static inline int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
+{
+	return -ENODEV;
+}
 static inline int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1,
 					   u32 *retval)
 {
-- 
2.48.1


