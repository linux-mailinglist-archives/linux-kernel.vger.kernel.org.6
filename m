Return-Path: <linux-kernel+bounces-383972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3BB9B22A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4159C1C2146F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264B915383B;
	Mon, 28 Oct 2024 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="q77f2JYA"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DA62629D;
	Mon, 28 Oct 2024 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081712; cv=none; b=KHLd49Q/dfw46X8HqUs6CvWLYzM4D+4p/j7066SnZTGB4pXTR7n+52wzr8XEgONoJXj5PStpMbKI80zGuahapc+C2yAnaynWjDwB8c8IjgMZPJ1P+GW4KqQuUAFrFB73tpB70Fs8R7EpGA7FMCWtY2ne/pgkbolyGRQeyoWslSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081712; c=relaxed/simple;
	bh=qOpmfzq1zZPVrbZu6jEOURF8rOtlQ47Zc0Oox+5/794=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pWaC14t1yZfGhjiOyn0ewyOmEMwpFl8LJt0iZkrF/5GMlQmwF6YShZr7YFWOWxIA2+dI4lgaxkCQgcy7VYzk7fe/k4d4bRh88Xf9dCrGqu3vyIn+xvJ6CJLQgLWrpP6aODhNaobI3xHll7MvLtI2cP+ZiUl+Vk6gfcJY/zVNHz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=q77f2JYA; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=G9A9dhYXFghwDACfgYuSKfIOqKKGDpFfQkzXRmV9zrw=; b=q77f2JYAT4NJHTLD
	b8lTsQUHXLIVQYeiAGaHz5IeOtY+SyBUWgt41Zi0XjocuNgx5w9QxCOa8djKyfgobPC6mzsvdaJp4
	hRj6ICltFv+V5gKcogeI5vLHYJ/NbqD0wwOom+Sg83D56gU9PUelwpMUWOTdbggDgAfRG1cn8fyCw
	xw/JD5GQk+JFpIaP0WypfcySOUUCAMWe98G/RHNUYrxImCoMoYxwdZVh5S07iXHl43gs7XsEAGt9L
	SCsQ+MRHJJEVf+/Gt5MoeRdovRE9NnOC2Jz2lvLr5repbgf/DMrb6U4/9MzCHJXRYIkLOI5im58n8
	XCanXhbaZuyG/NsdwA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t5FHZ-00Dq0T-1E;
	Mon, 28 Oct 2024 02:15:01 +0000
From: linux@treblig.org
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] regulator: devres: Remove unused devm_regulator_bulk_register_supply_alias
Date: Mon, 28 Oct 2024 02:15:00 +0000
Message-ID: <20241028021500.478043-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

devm_regulator_bulk_register_supply_alias() has been unused since 2014's
commit d137be00ee01 ("mfd: core: Don't use devres functions before device
is added")

Remove it, and the static helpers only it used.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/regulator/devres.c                    | 74 -------------------
 include/linux/regulator/consumer.h            |  6 --
 3 files changed, 81 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 5f2ee8d717b1..a1995a16febf 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -426,7 +426,6 @@ PWM
   devm_fwnode_pwm_get()
 
 REGULATOR
-  devm_regulator_bulk_register_supply_alias()
   devm_regulator_bulk_get()
   devm_regulator_bulk_get_const()
   devm_regulator_bulk_get_enable()
diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 1b893cdd1aad..6d6ddeb62f57 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -491,15 +491,6 @@ struct regulator_supply_alias_match {
 	const char *id;
 };
 
-static int devm_regulator_match_supply_alias(struct device *dev, void *res,
-					     void *data)
-{
-	struct regulator_supply_alias_match *match = res;
-	struct regulator_supply_alias_match *target = data;
-
-	return match->dev == target->dev && strcmp(match->id, target->id) == 0;
-}
-
 static void devm_regulator_destroy_supply_alias(struct device *dev, void *res)
 {
 	struct regulator_supply_alias_match *match = res;
@@ -548,71 +539,6 @@ int devm_regulator_register_supply_alias(struct device *dev, const char *id,
 }
 EXPORT_SYMBOL_GPL(devm_regulator_register_supply_alias);
 
-static void devm_regulator_unregister_supply_alias(struct device *dev,
-						   const char *id)
-{
-	struct regulator_supply_alias_match match;
-	int rc;
-
-	match.dev = dev;
-	match.id = id;
-
-	rc = devres_release(dev, devm_regulator_destroy_supply_alias,
-			    devm_regulator_match_supply_alias, &match);
-	if (rc != 0)
-		WARN_ON(rc);
-}
-
-/**
- * devm_regulator_bulk_register_supply_alias - Managed register
- * multiple aliases
- *
- * @dev:       device to supply
- * @id:        list of supply names or regulator IDs
- * @alias_dev: device that should be used to lookup the supply
- * @alias_id:  list of supply names or regulator IDs that should be used to
- *             lookup the supply
- * @num_id:    number of aliases to register
- *
- * @return 0 on success, a negative error number on failure.
- *
- * This helper function allows drivers to register several supply
- * aliases in one operation, the aliases will be automatically
- * unregisters when the source device is unbound.  If any of the
- * aliases cannot be registered any aliases that were registered
- * will be removed before returning to the caller.
- */
-int devm_regulator_bulk_register_supply_alias(struct device *dev,
-					      const char *const *id,
-					      struct device *alias_dev,
-					      const char *const *alias_id,
-					      int num_id)
-{
-	int i;
-	int ret;
-
-	for (i = 0; i < num_id; ++i) {
-		ret = devm_regulator_register_supply_alias(dev, id[i],
-							   alias_dev,
-							   alias_id[i]);
-		if (ret < 0)
-			goto err;
-	}
-
-	return 0;
-
-err:
-	dev_err(dev,
-		"Failed to create supply alias %s,%s -> %s,%s\n",
-		id[i], dev_name(dev), alias_id[i], dev_name(alias_dev));
-
-	while (--i >= 0)
-		devm_regulator_unregister_supply_alias(dev, id[i]);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(devm_regulator_bulk_register_supply_alias);
-
 struct regulator_notifier_match {
 	struct regulator *regulator;
 	struct notifier_block *nb;
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index b9ce521910a0..adaacd7676b6 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -185,12 +185,6 @@ int devm_regulator_register_supply_alias(struct device *dev, const char *id,
 					 struct device *alias_dev,
 					 const char *alias_id);
 
-int devm_regulator_bulk_register_supply_alias(struct device *dev,
-					      const char *const *id,
-					      struct device *alias_dev,
-					      const char *const *alias_id,
-					      int num_id);
-
 /* regulator output control and status */
 int __must_check regulator_enable(struct regulator *regulator);
 int regulator_disable(struct regulator *regulator);
-- 
2.47.0


