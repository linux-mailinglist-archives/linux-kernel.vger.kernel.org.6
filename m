Return-Path: <linux-kernel+bounces-551217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5537A56979
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70EB23A7AD8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF7321B8F5;
	Fri,  7 Mar 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="0KLGSeVD"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64821ABB5;
	Fri,  7 Mar 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355579; cv=none; b=DxVUH4DTAX0Th6112VvKAzFnRtcbeImHcHlRwyGK6s+nOtN0udUZCMK0ZEHUffNk42yL31D+IcRALQXoNsS13+JK27eAv/HLKyonzlNBM65XnI4diY0zj+TWSu8sNGFzK1ZivxIS9YstVoEF8dIVJJiHgW2wx7p7WOmi40fLjAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355579; c=relaxed/simple;
	bh=rnVgwMxWDlayjlCazB2lo1A4vnRwyUl7n22weC5e5is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZBtC4lNdrGlYXEddtys65cCzLmij/NKSEaaoQJXKuq+J1x8s7agEbTxUqJVJcx36TJpR6xFID0b7pATjPnUithCoSjJC5JkkxhxlKUVnlvJ12sjRDMtM0Un/bKUe6hRxlWNQI0B3pKZ9MyY8Y2px3Q5xtye5JiRfJK+xoUVg+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=0KLGSeVD; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A7B851F9E3;
	Fri,  7 Mar 2025 14:52:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1741355569;
	bh=OwKUxFtSQY33z/3FRQors8Lgj7M+rR14j/iYQsaUckQ=; h=From:To:Subject;
	b=0KLGSeVDHOhUGKskwnHZw+Mzza8u1akgg34tbN33ad4EZjhm5NNxcswb/NQowXy1S
	 2ZifWpzTxRiclulwdu4yX+gB/nEnQCYnDAqD/herhB4ZfX8TQ51rg35/oqEaLW+sGm
	 O2WPjBeb9ZzBsAkUk142TcomcCwtVk6Ud54GA3FwWYnlAYUmXG1bvl7c3Vzfv1nbVD
	 vsX4PZVpv0J0GXtZvRJCaHmnA5uzNwDZ5rwxUAYSanY9zZR29U5w+ATRxx5ITy7STC
	 PtYiXuKhYRpgT3YFU8AADjKpaLpPgGtYiRDjBOgkNgj+jQZESBYhUtHzVo0YQudMwT
	 8Mh64SU1klJrQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v3 1/5] of: Add of_property_read_u16_index
Date: Fri,  7 Mar 2025 14:52:40 +0100
Message-Id: <20250307135244.100443-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307135244.100443-1-francesco@dolcini.it>
References: <20250307135244.100443-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

There is an of_property_read_u32_index and of_property_read_u64_index.
This patch adds a similar helper for u16.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
v3: no changes
v2: no changes
v1: https://lore.kernel.org/lkml/20250206163152.423199-2-francesco@dolcini.it/
---
 drivers/of/property.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/of.h    |  9 +++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 208d922cc24c..c1feb631e383 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -147,6 +147,39 @@ static void *of_find_property_value_of_size(const struct device_node *np,
 	return prop->value;
 }
 
+/**
+ * of_property_read_u16_index - Find and read a u16 from a multi-value property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @index:	index of the u16 in the list of values
+ * @out_value:	pointer to return value, modified only if no error.
+ *
+ * Search for a property in a device node and read nth 16-bit value from
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_value is modified only if a valid u16 value can be decoded.
+ */
+int of_property_read_u16_index(const struct device_node *np,
+				       const char *propname,
+				       u32 index, u16 *out_value)
+{
+	const u16 *val = of_find_property_value_of_size(np, propname,
+					((index + 1) * sizeof(*out_value)),
+					0, NULL);
+
+	if (IS_ERR(val))
+		return PTR_ERR(val);
+
+	*out_value = be16_to_cpup(((__be16 *)val) + index);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_property_read_u16_index);
+
 /**
  * of_property_read_u32_index - Find and read a u32 from a multi-value property.
  *
diff --git a/include/linux/of.h b/include/linux/of.h
index eaf0e2a2b75c..5e52d90f6408 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -314,6 +314,9 @@ extern struct property *of_find_property(const struct device_node *np,
 extern bool of_property_read_bool(const struct device_node *np, const char *propname);
 extern int of_property_count_elems_of_size(const struct device_node *np,
 				const char *propname, int elem_size);
+extern int of_property_read_u16_index(const struct device_node *np,
+				       const char *propname,
+				       u32 index, u16 *out_value);
 extern int of_property_read_u32_index(const struct device_node *np,
 				       const char *propname,
 				       u32 index, u32 *out_value);
@@ -627,6 +630,12 @@ static inline int of_property_count_elems_of_size(const struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int of_property_read_u16_index(const struct device_node *np,
+			const char *propname, u32 index, u16 *out_value)
+{
+	return -ENOSYS;
+}
+
 static inline int of_property_read_u32_index(const struct device_node *np,
 			const char *propname, u32 index, u32 *out_value)
 {
-- 
2.39.5


