Return-Path: <linux-kernel+bounces-568162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB34A68EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B983ADB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2D61C5D6A;
	Wed, 19 Mar 2025 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="SHgX8MCs"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB01419DF6A;
	Wed, 19 Mar 2025 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394070; cv=none; b=UbE2SxK1Z0TCtmg6Rsxm6jl4V7BiM4vXq7Sary1TzJMHoz0S3AYL3ujVbiaASRRN71cKECIQp6G22VqXsqCvw8CP1rVF1VieCqG0c5UqRvIPdb7nEpfltEqDNA7kQwSECft9XufRVxPW/PLBRUrFpYtdL9X5zSTfAhWHBMdceOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394070; c=relaxed/simple;
	bh=rrlVal7EsGu97CqstJ0Ibqh7IXLHw0KvL7hktdEfyDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TN07EFrk0xCekecauvnxyWOd3Oh2vtRrgyiYtcAUdYJOjFBIQ20dOedsFzpTK6onSwiCxMFkuDriEa29Rz6/7+yFRltmSDEg7CsmOmBDmVFHkowk3KGLqrp5kT1EcP0gnm+7JOarpDhLtznza3EYF3uhXNsblN+/lASVHQy0wXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=SHgX8MCs; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 178F82351E;
	Wed, 19 Mar 2025 15:21:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1742394065;
	bh=qzC6GxGyesXmdmxWNUAPtLvO7ymacu2P1PTf03/VC1Q=; h=From:To:Subject;
	b=SHgX8MCsUxOEDvTNyWqE9nt7LdZ0ECLDZUvltMA3ew8dRFGS7qg7Zsb16kAMKYdhd
	 MvzyHbo9eVMP88D+d/TgdF1jn84Yhiz1kp0K88BLniAW6gw96J1cwdUihnIO8Oo7oR
	 bE2N5yAygBJ0/oINEpVC0CELAif/SjaNuUh5csKxs9V637Ljn3NHLRf+DTPaia8fko
	 FcEhmwpZ4fd3sizaSgBvCcSy75gg6xYYHgXsGVSeW8fYB0Ub/B2324k7DKWR/6TmUa
	 IVZkPfpFOzFA3ung4l+8zkoE5FyR558RLyiOog+Cwf3gfaOuaYXZKt/tp+Z2sO3Q6H
	 JjOuN6sfnngiA==
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
Subject: [PATCH v4 1/5] of: Add of_property_read_u16_index
Date: Wed, 19 Mar 2025 15:20:55 +0100
Message-Id: <20250319142059.46692-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319142059.46692-1-francesco@dolcini.it>
References: <20250319142059.46692-1-francesco@dolcini.it>
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
v4: no changes
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


