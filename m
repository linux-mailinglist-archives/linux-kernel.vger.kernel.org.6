Return-Path: <linux-kernel+bounces-332479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D115C97BA45
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564BA1F22282
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A86F17838A;
	Wed, 18 Sep 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="AixCLcuq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hBYp8toK"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9022E17B50D;
	Wed, 18 Sep 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652588; cv=none; b=P4u+6K/WpCEqEuxebVTXth8MVaC+z22YOmy6LtwyI6Z4kj+ZGwe0cN/eJFBaJnDRQkP5bPaStLQKCLsosLTkchKvFb3ctjaZdWAdH9EeckO2yW1rpuNLY4P2pbXOdXvpYgWsr7O49fpyS9Evgv0b1F/7V5h+khn1CnAmrg9f7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652588; c=relaxed/simple;
	bh=O96sYC5Ug9Zp8RMKUhJ8u5roIGp362BSBi7duGz1+cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cvw9AcUO206UfXJ7/26vyhD7p2deL9j5Ir0+9Z7z6UQoGkwwk0YqG0jqdUT7QSY6hLLHjjXsTMPqXYWxY+VXwQncNUshxTLqOL699lApd2YdQlWRRcYQd6V90qZi6pebX7dFL9bVtjG4d2LZR8XEUyP0lmgrrSPpje4oES0cZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=AixCLcuq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hBYp8toK; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC92D1140251;
	Wed, 18 Sep 2024 05:43:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 18 Sep 2024 05:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1726652585; x=
	1726738985; bh=pj8rp/V3y0t4ezJEt/AMlFyCoYwxf7z3NOGZOaJq+W0=; b=A
	ixCLcuqdF/OlDazi9X7B/pl00AZREvgAcHQWz/StQt6VZGDOysnsb2K8OGEhcNEk
	QLrCb9az0bvFYd7jyB/OJRuLUGwz0gCUyh0PvHB1dKq1cGP7mN5xVtoguyhR0xo/
	r9y19PleSxmmI6CVXaAyW4v0cCUGYhj3N7g+6wQcS75IP+VKUQA4KNjwAbJgehVc
	owbaEGSUXX6z1xuLNXVAz8Pb4n6fxE1IJio1jMMGz9MtCUITAoP5lDAw36QBEP7+
	lcN7YlPDpVrhNCM5uMNUJzNXGFw7hgD4AHj2e2992zwZSO9xuXkDrSOF7lNSG/v2
	0mVjOdHt0ccx4CepcZ4gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726652585; x=
	1726738985; bh=pj8rp/V3y0t4ezJEt/AMlFyCoYwxf7z3NOGZOaJq+W0=; b=h
	BYp8toKxGYij5UyzD+E6xoLA//1o7AA6UQ12KvWxzK2kXlxiQnyOIxXQdWZfvd87
	T3ux46isOpfTgAgjmjrUZ2K113uJHYJ+jk0+Kzj1C2EgSgtzYJAiJ3ArfnfVEYH5
	IuV9zhwPNVtwdRjcZgq5iKiVJPZZKi2ND1a9+EIzeoHJiUM6jDlQhE2jY1zRK9wF
	lcdndvm27hihlwx6cq3pQwIOO0j2ZkSmmuOM/ebaOogrJb9dmUvdyOEKLWtTR6mT
	gh91b+cOTwFjMPPF8T2pArTmMS8lsOK32ZcSCU/RiagcAKhO2Ab/cAMXbAe7jjOZ
	gGV3Ai/ha/E7yOIQlnU6g==
X-ME-Sender: <xms:qaDqZslH8k6QeABW3ccFhlEFwJj3OH2UvvXz51gOZPNPIMMh-8JUVg>
    <xme:qaDqZr1C6QxP118Wn4zf1pVJN_IZN38tQqZBUIyrOIPNGbPG2wdd_W9yjDeOhezd3
    yvDOOMC-6pfZ4LVBws>
X-ME-Received: <xmr:qaDqZqqQ43S4BzpcL92qUS8mo5zNU-sDmTQQZKE6ZbB6L4dqPEDXFBnThJxt7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgv
    shdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfe
    dugfetudeuheetjefhuefggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonh
    gvshdruggvvhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdp
    rhgtphhtthhopegtohhrvghnthhinhdrtghhrghrhiesghhmrghilhdrtghomhdprhgtph
    htthhopehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:qaDqZonAeEblV5QiEhtMTvJ2DJlRsoJ6hnJVNzNyHQV2elUwWyy0bA>
    <xmx:qaDqZq3U9AZUZA0jTLJu33igdvmNYdvWBVx2t-Agsfkxj-PzMK49cA>
    <xmx:qaDqZvuXtIPoAznfB0xwYoGa-rW5wi0zdCdHFJ33uyb6Y7gYh8M7Ag>
    <xmx:qaDqZmXJcYwujKiU5yKH6PZFUjYIjUf2U6HKKYNxOEkuKOO5XmWZDQ>
    <xmx:qaDqZm-bG6lci1W2Jyxcs8STYamSm6jEfMO1NKv7xEb6--dpkklDWtjm>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:43:02 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 2/5] platform/x86: asus-armoury: add dgpu tgp control
Date: Wed, 18 Sep 2024 21:42:47 +1200
Message-ID: <20240918094250.82430-3-luke@ljones.dev>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240918094250.82430-1-luke@ljones.dev>
References: <20240918094250.82430-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the dgpu TGP control under the asus-armoury module using the
fw_attributes class.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-armoury.c        | 21 +++++++++++++++++++++
 drivers/platform/x86/asus-armoury.h        | 18 ++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +++
 3 files changed, 42 insertions(+)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index 6e4507be0f05..176ab5f105dd 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -51,6 +51,9 @@
 #define NVIDIA_BOOST_MAX 25
 #define NVIDIA_TEMP_MIN 75
 #define NVIDIA_TEMP_MAX 87
+#define NVIDIA_POWER_MIN 0
+#define NVIDIA_POWER_MAX 70
+#define NVIDIA_POWER_DEFAULT 70
 
 /* Tunables provided by ASUS for gaming laptops */
 struct rog_tunables {
@@ -77,6 +80,11 @@ struct rog_tunables {
 	u32 nv_temp_min;
 	u32 nv_temp_max;
 	u32 nv_temp_target;
+
+	u32 dgpu_tgp_default;
+	u32 dgpu_tgp_min;
+	u32 dgpu_tgp_max;
+	u32 dgpu_tgp;
 };
 
 static const struct class *fw_attr_class;
@@ -467,6 +475,12 @@ ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DEVID_NV_D
 ATTR_GROUP_ROG_TUNABLE(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_NV_THERM_TARGET,
 		       nv_temp_default, nv_boost_min, nv_temp_max, 1,
 		       "Set the Nvidia max thermal limit");
+ATTR_GROUP_ROG_TUNABLE(dgpu_tgp, "dgpu_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP, dgpu_tgp_default,
+		       dgpu_tgp_min, dgpu_tgp_max, 1,
+		       "Set the additional TGP on top of the base TGP");
+
+ATTR_GROUP_INT_VALUE_ONLY_RO(dgpu_base_tgp, "dgpu_base_tgp", ASUS_WMI_DEVID_DGPU_BASE_TGP,
+			     "Read the base TGP value");
 
 ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
 		       "Show the current mode of charging");
@@ -495,6 +509,8 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &ppt_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
 	{ &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
 	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
+	{ &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
+	{ &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
 
 	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
 	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
@@ -659,6 +675,11 @@ static void init_rog_tunables(struct rog_tunables *rog)
 	rog->nv_temp_max = NVIDIA_TEMP_MIN;
 	rog->nv_temp_max = NVIDIA_TEMP_MAX;
 	rog->nv_temp_target = NVIDIA_TEMP_MIN;
+
+	rog->dgpu_tgp_default = NVIDIA_POWER_DEFAULT;
+	rog->dgpu_tgp_min = NVIDIA_POWER_MIN;
+	rog->dgpu_tgp_max = NVIDIA_POWER_MAX;
+	rog->dgpu_tgp = NVIDIA_POWER_MAX;
 }
 
 static int __init asus_fw_init(void)
diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
index 8bb75cf88305..95f4b6d8ab6b 100644
--- a/drivers/platform/x86/asus-armoury.h
+++ b/drivers/platform/x86/asus-armoury.h
@@ -89,6 +89,20 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
 	static struct kobj_attribute attr_##_attrname##_##_prop =             \
 		__ASUS_ATTR_RO(_attrname, _prop)
 
+/* Requires current_value_show */
+#define __ATTR_GROUP_INT_VALUE_ONLY(_attrname, _fsname, _dispname)     \
+	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);   \
+	static struct kobj_attribute attr_##_attrname##_type =         \
+		__ASUS_ATTR_RO_AS(type, int_type_show);                \
+	static struct attribute *_attrname##_attrs[] = {               \
+		&attr_##_attrname##_current_value.attr,                \
+		&attr_##_attrname##_display_name.attr,                 \
+		&attr_##_attrname##_type.attr, NULL                    \
+	};                                                             \
+	static const struct attribute_group _attrname##_attr_group = { \
+		.name = _fsname, .attrs = _attrname##_attrs            \
+	}
+
 /* Boolean style enumeration, base macro. Requires adding show/store */
 #define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)     \
 	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);    \
@@ -105,6 +119,10 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
 		.name = _fsname, .attrs = _attrname##_attrs             \
 	}
 
+#define ATTR_GROUP_INT_VALUE_ONLY_RO(_attrname, _fsname, _wmi, _dispname) \
+	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                           \
+	__ATTR_GROUP_INT_VALUE_ONLY(_attrname, _fsname, _dispname)
+
 #define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname) \
 	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                 \
 	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 7caf2c7ed8c9..86629e621c61 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -134,6 +134,9 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+#define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
+#define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
+
 /* gpu mux switch, 0 = dGPU, 1 = Optimus */
 #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
 #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026
-- 
2.46.1


