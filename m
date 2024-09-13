Return-Path: <linux-kernel+bounces-327459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBCA977644
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA471F24317
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF4228F1;
	Fri, 13 Sep 2024 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="KtCNRIQI"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC9A23
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726189804; cv=none; b=CrElLU+EuKB71PFkWZ+gdk93NsHBnKFjvtLZAXzr5Zn2BmEK49PZ0J/nyA0NfPJJ1Lj5M7dtu7px9TkwvM0ZxKR6GnSi8UUrHGVdJhA0ci/OJfIW956XcE9C1h3rN99VBmJwAMQfquh0XbVO0Gi/2igyRGiVvKgmoN8tyBfQ168=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726189804; c=relaxed/simple;
	bh=ySTECfEsK3yMW93+R6SeJMGLvarNzzNHR+cOl6r3fak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpagZglILTt3u8oOg3x+p5Dv8OMLMMG+umH6d4UahT0yX84aX/T6EmOdOx7TuLZ2gydtbZVURztl/CgjcNQ67FHW3PQq5hq45vaOL9UVLHhzM2WFiiIT1sdZS9SPlIIuNgGlwYsFosHfFY+wfWJipAosr7yv44Q+BOlGtY+FjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=KtCNRIQI; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=/xkz6jamFzRoW2amPUsahyxrJliKuHrSnVs9kJSXKaI=; b=KtCNRIQITrK9mOiq
	yFzDLhD3m9lle7e3BSoqcAOazEWM8FxaUxzYuz/uVpwKqu7ySrSLcfoik1fLCPyougyj8uFWzDTuz
	UMYaRvGHRHzomRLBrNcuBPPVXSEeVXp+ratNZRWYj+b9ZwyOGGPdGHwNUREnuKAEbcu+l5W44cAmB
	2VqEUCVyyZuZnEJ5zJtp0y4WkU7PQ0wKSn+wKxAE8FZndQzgQL84imuQXXO9dad3YlMfloQXylSxU
	PpNH9jZ0DqQBIhbiVXVj4uytlEBVubTi2Nn5nlokGTyBw+jDYEh42KyqfyJaRYqVDrRBNO/lCaqyr
	hi1kF78yOGwr4R8jJA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1souow-005U8e-2F;
	Fri, 13 Sep 2024 01:09:58 +0000
From: linux@treblig.org
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] driver core: attribute_container: Remove unused functions
Date: Fri, 13 Sep 2024 02:09:55 +0100
Message-ID: <20240913010955.1393995-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

I can't find any use of 'attribute_container_add_class_device_adapter'
or 'attribute_container_trigger' in git history.
Their export decls went in 2006:
  commit 1740757e8f94 ("[PATCH] Driver Core: remove unused exports")

and their docs disappeared in 2016:
  commit 47cb398dd75a ("Docs: sphinxify device-drivers.tmpl")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/base/attribute_container.c  | 48 +----------------------------
 include/linux/attribute_container.h |  6 ----
 2 files changed, 1 insertion(+), 53 deletions(-)

diff --git a/drivers/base/attribute_container.c b/drivers/base/attribute_container.c
index 01ef796c2055..b6f941a6ab69 100644
--- a/drivers/base/attribute_container.c
+++ b/drivers/base/attribute_container.c
@@ -346,8 +346,7 @@ attribute_container_device_trigger_safe(struct device *dev,
  * @fn:   the function to execute for each classdev.
  *
  * This function is for executing a trigger when you need to know both
- * the container and the classdev.  If you only care about the
- * container, then use attribute_container_trigger() instead.
+ * the container and the classdev.
  */
 void
 attribute_container_device_trigger(struct device *dev,
@@ -378,33 +377,6 @@ attribute_container_device_trigger(struct device *dev,
 	mutex_unlock(&attribute_container_mutex);
 }
 
-/**
- * attribute_container_trigger - trigger a function for each matching container
- *
- * @dev:  The generic device to activate the trigger for
- * @fn:	  the function to trigger
- *
- * This routine triggers a function that only needs to know the
- * matching containers (not the classdev) associated with a device.
- * It is more lightweight than attribute_container_device_trigger, so
- * should be used in preference unless the triggering function
- * actually needs to know the classdev.
- */
-void
-attribute_container_trigger(struct device *dev,
-			    int (*fn)(struct attribute_container *,
-				      struct device *))
-{
-	struct attribute_container *cont;
-
-	mutex_lock(&attribute_container_mutex);
-	list_for_each_entry(cont, &attribute_container_list, node) {
-		if (cont->match(cont, dev))
-			fn(cont, dev);
-	}
-	mutex_unlock(&attribute_container_mutex);
-}
-
 /**
  * attribute_container_add_attrs - add attributes
  *
@@ -458,24 +430,6 @@ attribute_container_add_class_device(struct device *classdev)
 	return attribute_container_add_attrs(classdev);
 }
 
-/**
- * attribute_container_add_class_device_adapter - simple adapter for triggers
- *
- * @cont: the container to register.
- * @dev:  the generic device to activate the trigger for
- * @classdev:	the class device to add
- *
- * This function is identical to attribute_container_add_class_device except
- * that it is designed to be called from the triggers
- */
-int
-attribute_container_add_class_device_adapter(struct attribute_container *cont,
-					     struct device *dev,
-					     struct device *classdev)
-{
-	return attribute_container_add_class_device(classdev);
-}
-
 /**
  * attribute_container_remove_attrs - remove any attribute files
  *
diff --git a/include/linux/attribute_container.h b/include/linux/attribute_container.h
index e4004d1e6725..b3643de9931d 100644
--- a/include/linux/attribute_container.h
+++ b/include/linux/attribute_container.h
@@ -61,14 +61,8 @@ int attribute_container_device_trigger_safe(struct device *dev,
 					    int (*undo)(struct attribute_container *,
 							struct device *,
 							struct device *));
-void attribute_container_trigger(struct device *dev, 
-				 int (*fn)(struct attribute_container *,
-					   struct device *));
 int attribute_container_add_attrs(struct device *classdev);
 int attribute_container_add_class_device(struct device *classdev);
-int attribute_container_add_class_device_adapter(struct attribute_container *cont,
-						 struct device *dev,
-						 struct device *classdev);
 void attribute_container_remove_attrs(struct device *classdev);
 void attribute_container_class_device_del(struct device *classdev);
 struct attribute_container *attribute_container_classdev_to_container(struct device *);
-- 
2.46.0


