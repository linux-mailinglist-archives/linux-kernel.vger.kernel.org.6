Return-Path: <linux-kernel+bounces-529509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0ACA42734
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FDE3B468D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B5D26156D;
	Mon, 24 Feb 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Oe31VYAn"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D173619DF8C;
	Mon, 24 Feb 2025 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412517; cv=none; b=Kz/mDJVrivTwwUcGwsQ+RmEHkHZVXjvZV/nAL2Gt/wHFAIS/LOSbgomPGToZm/eP7YCaeJTAiMtg5huw7StZGlEBAWxxKqjT14/OmcIQ5YCMvmewC4Q9d/4vkgkYOsq+eAat0dLDqhZvY2SmlCdt39KZkew6xIWZqlnaCrdGZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412517; c=relaxed/simple;
	bh=n1vzjyg+AAL5eoDMhMpdyqZw8VAPptGDuXWS/5jsk0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QLC1JKD9aKqqJKedg4ym8U18xHbdLUATPUBOGTcyL9iKkF/44CP8PXA8eCTHNn4jZUJFyH2Bwz+5DKCuBKqfIEFQ8GzdUAX7IdjfhFsBW/PMDZ1L/w70QfbyvQUaY3o5E+NV+O8fgCdCz4ByI83zxuNEIVJ5a2HKUgdlIEjhtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Oe31VYAn; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 99CEF1FB5E;
	Mon, 24 Feb 2025 16:55:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740412506;
	bh=kZZmY/KyJCWfsHeBvgPFKOqoIGsQ79eJkeNmXvmXmN0=; h=From:To:Subject;
	b=Oe31VYAnLV1np47+2of/1eZPmLQqjC0bB43u+8WrN6FlsvdTnjpieRXfy7WKZfkJu
	 A9M2ri9jz7kzPhU7FuPBuItj6JyDhBHQFTvNg5UJHx+EOd6tVJb9urPIWnn5s7Z/76
	 lTAM4+o7MUA+nJX1Z2LE/9ZTm+0TJ/0vJLmhifbIXtqRPWQ9gRphZWrzJ0Jm3ElNB+
	 /rN75EWjERzuQRycjDjXrQdICiWQL4VFK6KN1/7zuEwEu9/6vyXgFJPr/k0eGX+Cm1
	 Ahn4A6TGqONC+A5BTiXAiz34mT6Dk6/gOJr/I9NqWYVNZPLXEfzfWxJv7A+OfSVhPJ
	 RgW8ahQH7A3aw==
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
Subject: [PATCH v2 1/5] of: Add of_property_read_u16_index
Date: Mon, 24 Feb 2025 16:54:56 +0100
Message-Id: <20250224155500.52462-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224155500.52462-1-francesco@dolcini.it>
References: <20250224155500.52462-1-francesco@dolcini.it>
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


