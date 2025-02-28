Return-Path: <linux-kernel+bounces-538106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EEEA494A1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C803AC6FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D18F24A046;
	Fri, 28 Feb 2025 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="NAZ/bSS5"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A51B21AC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734332; cv=none; b=Z30jOajS+EPLjGigxqfieVQsmnH+QFQ7KdbyW62LBZVbkyFO+/wc6i9MvgxoYxlLU7Sq0Q0dlhBWXmoVFcHAaPa2Z3PMe+ZiX1+a1etVO48SneHksmwmRJb+JKWOji9TLskSDLTW9JjyLWjxwLsGag6JwF2UecMea2W1M9oYs2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734332; c=relaxed/simple;
	bh=LMn5TDBLGTKdWMmooFzE+OAAHcbwpJBbJ88qKl8V17Q=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XQANJ5lmNhtjBg83OoMNSD1QNYuoPEMkknu8iLlWIEGj8mFfIXHzYJAka4FocKaA3DVFA541aA00YtB28irepZFq1Eo3Yl+tlZPJ4rU6DsmFR2sLz7dLPReAnOBd8VTsDnTwUMYvsMGbKRUTsl1gKAet4wwhE7B5aQUOtptp2q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=NAZ/bSS5; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1740734318;
	bh=JgzES0WZ+Wx5kdBNCJuvn2E0r1/Jx+wWi7EE+40opbQ=;
	h=From:To:Cc:Subject:Date;
	b=NAZ/bSS5aZSkqIOJUUI6HLocMZP7tSHq/4OMWARatvRGCf7vOuSBAZRVWrEj185pl
	 08DDTd1ucgDrZDDCpe5Kks87NirpOK9P9SqZ3SxIr1EZrVx4aOSFal3gJpMU5XNqCy
	 MI4U979IXcGmI7I1kZVJokQ1lPxWIMJ5DWjvy2i4=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 4A51D2A5; Fri, 28 Feb 2025 17:18:37 +0800
X-QQ-mid: xmsmtpt1740734317tkg89ouqu
Message-ID: <tencent_66CF9C91EB4A4417F70E9511649A57DEC906@qq.com>
X-QQ-XMAILINFO: MaaIYtAFx2QDP+/dvJeySgnapen3gvSe1CLCDy99YyF7StMCPsKwGcwA9vz4V0
	 IUw6YVTvL9eKI08/aL9f7chYkhqqCenPHnKT3WucXgkIc469GsmvgvY8OTdIixFZuwfDWvgxwC5V
	 w/GRaFADUiHTT9Rm3TAh5+sVBDcX3MgcmCjoK9HZ7Sd5h6JPl0uBFqjefYQt1ZYxRdeKFrObgsIv
	 GbaDGMetvyJPa+JXnWf95dwLiSi2Nbf+o+w+ymcV+0O7HmlXjk0JxsZcEAX/h2Ti1HWrXRnxNpCl
	 RYqFjVqam/BAX5mAlWg90lIJtv+cRj3fP7cCTN+Va9U30V9jsEQnlcaoGT3ifIb4U1FT2JCspObg
	 Syvw7GQmHfdO4i94TMwILfOT6eYGvYbAoFBFp0Z1W3bjxt7u03GbfzHk/0MimLXpbvhaj3Y7KF5y
	 IsOiNpy3Jg+aobJ6W5QJdFf8+kADcMjD64esaRPHWDiBc/ONDC/zCN4IdTdx+HoHN4SsUWkVTPnf
	 tMpY12IJZzquJMVl14wpHUzM0A46cdhLABajdkLepjZEQyE+ntmyN5h1t+oFvorhuMhsWXGIKiGz
	 FaGpAnes3P1cyxyKalHKr9MzE8XeZ7B/UsXstf/S8b3NFIsL4odSbRj2/wkatyIlBDpvBPANzvB0
	 3mEokdeUhObrSVHKaFnP6q3XYSpk+UAX1aLJd8Kc9NLfmEJneUq/npgMMXu7Nyk+hx8tt2FQH/WG
	 hk0oBBPKmpz2eIRSS4gO1CNopZOpzFwhkWJ++r9pgdRGtqgESwOsXh6YrMAUBmHw/ZgInx2lIfO+
	 M58uoa4JxvKqwy7SgTUcv32gFUiUNMjQVitk7GUwqI93TRB5yEFh2xYkrIh7XaSdCBW9AOes1jmE
	 K45AYBr2er+V2QvoL/em2uR3u1BXELtUiM91ZQ9ja507NReAGFusLhQIi5D3ar6luDELPnBZPqlp
	 5kYkTYfA5zmKoVaG5nKnXCyo95uCOCcqJDkvJjwXE=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: xiaopeitux@foxmail.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] driver core: Split devres APIs to device/devres.h
Date: Fri, 28 Feb 2025 17:18:35 +0800
X-OQ-MSGID: <7f59c984f5a675b77864af288fef404cd9fa2b7f.1740734232.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

Since a21cad931276 ("driver core: Split devres APIs to
device/devres.h"),but some APIs like 'devm_alloc_percpu' didn't move to
devres.h. we should also move it.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 include/linux/device.h        | 60 -----------------------------------
 include/linux/device/devres.h | 58 +++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 60 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index ec330af24151..ab383a9bbc17 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -281,63 +281,6 @@ int __must_check device_create_bin_file(struct device *dev,
 void device_remove_bin_file(struct device *dev,
 			    const struct bin_attribute *attr);
 
-/* allows to add/remove a custom action to devres stack */
-int devm_remove_action_nowarn(struct device *dev, void (*action)(void *), void *data);
-
-/**
- * devm_remove_action() - removes previously added custom action
- * @dev: Device that owns the action
- * @action: Function implementing the action
- * @data: Pointer to data passed to @action implementation
- *
- * Removes instance of @action previously added by devm_add_action().
- * Both action and data should match one of the existing entries.
- */
-static inline
-void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
-{
-	WARN_ON(devm_remove_action_nowarn(dev, action, data));
-}
-
-void devm_release_action(struct device *dev, void (*action)(void *), void *data);
-
-int __devm_add_action(struct device *dev, void (*action)(void *), void *data, const char *name);
-#define devm_add_action(dev, action, data) \
-	__devm_add_action(dev, action, data, #action)
-
-static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(void *),
-					     void *data, const char *name)
-{
-	int ret;
-
-	ret = __devm_add_action(dev, action, data, name);
-	if (ret)
-		action(data);
-
-	return ret;
-}
-#define devm_add_action_or_reset(dev, action, data) \
-	__devm_add_action_or_reset(dev, action, data, #action)
-
-/**
- * devm_alloc_percpu - Resource-managed alloc_percpu
- * @dev: Device to allocate per-cpu memory for
- * @type: Type to allocate per-cpu memory for
- *
- * Managed alloc_percpu. Per-cpu memory allocated with this function is
- * automatically freed on driver detach.
- *
- * RETURNS:
- * Pointer to allocated memory on success, NULL on failure.
- */
-#define devm_alloc_percpu(dev, type)      \
-	((typeof(type) __percpu *)__devm_alloc_percpu((dev), sizeof(type), \
-						      __alignof__(type)))
-
-void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
-				   size_t align);
-void devm_free_percpu(struct device *dev, void __percpu *pdata);
-
 struct device_dma_parameters {
 	/*
 	 * a low level driver may set these to teach IOMMU code about
@@ -1163,9 +1106,6 @@ static inline void device_remove_group(struct device *dev,
 	device_remove_groups(dev, groups);
 }
 
-int __must_check devm_device_add_group(struct device *dev,
-				       const struct attribute_group *grp);
-
 /*
  * get_device - atomically increment the reference count for the device.
  *
diff --git a/include/linux/device/devres.h b/include/linux/device/devres.h
index 9b49f9915850..8f93f7388dc1 100644
--- a/include/linux/device/devres.h
+++ b/include/linux/device/devres.h
@@ -126,4 +126,62 @@ void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int in
 
 #endif
 
+/* allows to add/remove a custom action to devres stack */
+int devm_remove_action_nowarn(struct device *dev, void (*action)(void *), void *data);
+
+/**
+ * devm_remove_action() - removes previously added custom action
+ * @dev: Device that owns the action
+ * @action: Function implementing the action
+ * @data: Pointer to data passed to @action implementation
+ *
+ * Removes instance of @action previously added by devm_add_action().
+ * Both action and data should match one of the existing entries.
+ */
+static inline
+void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
+{
+	WARN_ON(devm_remove_action_nowarn(dev, action, data));
+}
+
+void devm_release_action(struct device *dev, void (*action)(void *), void *data);
+
+int __devm_add_action(struct device *dev, void (*action)(void *), void *data, const char *name);
+#define devm_add_action(dev, action, data) \
+	__devm_add_action(dev, action, data, #action)
+
+static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(void *),
+					     void *data, const char *name)
+{
+	int ret;
+
+	ret = __devm_add_action(dev, action, data, name);
+	if (ret)
+		action(data);
+
+	return ret;
+}
+#define devm_add_action_or_reset(dev, action, data) \
+	__devm_add_action_or_reset(dev, action, data, #action)
+
+/**
+ * devm_alloc_percpu - Resource-managed alloc_percpu
+ * @dev: Device to allocate per-cpu memory for
+ * @type: Type to allocate per-cpu memory for
+ *
+ * Managed alloc_percpu. Per-cpu memory allocated with this function is
+ * automatically freed on driver detach.
+ *
+ * RETURNS:
+ * Pointer to allocated memory on success, NULL on failure.
+ */
+#define devm_alloc_percpu(dev, type)      \
+	((typeof(type) __percpu *)__devm_alloc_percpu((dev), sizeof(type), \
+						      __alignof__(type)))
+
+void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
+				   size_t align);
+void devm_free_percpu(struct device *dev, void __percpu *pdata);
+int __must_check devm_device_add_group(struct device *dev,
+				       const struct attribute_group *grp);
 #endif /* _DEVICE_DEVRES_H_ */
-- 
2.25.1


