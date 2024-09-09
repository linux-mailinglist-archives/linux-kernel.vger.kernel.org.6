Return-Path: <linux-kernel+bounces-321382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C249719D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0157284F73
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F711B81DE;
	Mon,  9 Sep 2024 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqLoYhlA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746891B7910;
	Mon,  9 Sep 2024 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886133; cv=none; b=CKM8tbtXg+V9o6U1Al3k0zZBdPxhIaokzkfAy2fUfYMh/LXdglHyCG63IcB/Ulz6jlgm1/CWvsR+3zcctQqUsdSzXfZJLlnYf5VblQ0LtxORcq2BRSNiriJQzykUd1PW3mjBEUlU/Z0NZ9ywm1Ng9J/lwpnQBgVUvhXb/T20KO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886133; c=relaxed/simple;
	bh=xfXgYsa82uQLXEPjSFDvvJAeuznP7i5fAlLIvoQXUSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ed97fsXttjy1x3dmY953BEDZsHirPYFDZeMttQSzo2AAfUYKoHIGKlY7/zenlHEmS8LO9p7mLrgPzNtISs/pSgkZCJ0xb70QH/P6WheC5ZP1rPsNFQGXxLgXs1/0Oa7vPlyMYxSXDQzGH2lJVUMpWAPHhV9RMoKtbt9qJIUhQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqLoYhlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE0EC4CEC5;
	Mon,  9 Sep 2024 12:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725886133;
	bh=xfXgYsa82uQLXEPjSFDvvJAeuznP7i5fAlLIvoQXUSM=;
	h=From:To:Cc:Subject:Date:From;
	b=bqLoYhlASkMi8SwSa8U1RBPILHe3TnMEz5O3VF6/+o02aKfadDh8ni7kMZpYSLQLz
	 Der72pPnnvDmjfV1eeMG03ZT+bR5w1W9tt8wi8ENftIigeGzKCU+611XmrujjamKL7
	 79k1aVeoJcJ1lVg+1uCdbMcsg0rIgxLhjzMkB2sFCTK3hE9tT6Z9vrf9nmi2crArHY
	 BMjVEXiUf5lZH2Ig/YImHKy5H8b9zCguOKG169O70qYL2miV69djXwDWRQNxeonu0m
	 8eaEPaU8SKjwA0BEb8mjy4WHD/6OhPQ4CVucyY1i7pxm3CMpK78a9c53pp3eA0dpBj
	 NuX9VxpMUrfQw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sndpO-000000002PC-1jC9;
	Mon, 09 Sep 2024 14:49:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>
Cc: Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	David Lin <dtwlin@gmail.com>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "staging: greybus: Fix capitalization and punctuation inconsistencies"
Date: Mon,  9 Sep 2024 14:48:53 +0200
Message-ID: <20240909124853.9213-1-johan@kernel.org>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 30db8460f984a7f5299b6e07ea8a57cd09fc9557.

The offending commit tried to make the error messages of a few Greybus
drivers in staging more consistent by capitalising messages, but the
rest of the Greybus code do not follow this style so the change ended up
introducing an inconsistency instead.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/greybus/arche-platform.c | 38 ++++++++++++------------
 drivers/staging/greybus/authentication.c |  6 ++--
 drivers/staging/greybus/bootrom.c        | 16 +++++-----
 drivers/staging/greybus/light.c          | 26 ++++++++--------
 drivers/staging/greybus/log.c            | 10 +++----
 5 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index 45c1737817d0..b33977ccd527 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -95,7 +95,7 @@ static int apb_cold_boot(struct device *dev, void *data)
 
 	ret = apb_ctrl_coldboot(dev);
 	if (ret)
-		dev_warn(dev, "Failed to coldboot\n");
+		dev_warn(dev, "failed to coldboot\n");
 
 	/*Child nodes are independent, so do not exit coldboot operation */
 	return 0;
@@ -107,7 +107,7 @@ static int apb_poweroff(struct device *dev, void *data)
 
 	/* Enable HUB3613 into HUB mode. */
 	if (usb3613_hub_mode_ctrl(false))
-		dev_warn(dev, "Failed to control hub device\n");
+		dev_warn(dev, "failed to control hub device\n");
 
 	return 0;
 }
@@ -142,7 +142,7 @@ static irqreturn_t arche_platform_wd_irq_thread(int irq, void *devid)
 
 	/* Enable HUB3613 into HUB mode. */
 	if (usb3613_hub_mode_ctrl(true))
-		dev_warn(arche_pdata->dev, "Failed to control hub device\n");
+		dev_warn(arche_pdata->dev, "failed to control hub device\n");
 
 	spin_lock_irqsave(&arche_pdata->wake_lock, flags);
 	arche_platform_set_wake_detect_state(arche_pdata, WD_STATE_IDLE);
@@ -228,12 +228,12 @@ arche_platform_coldboot_seq(struct arche_platform_drvdata *arche_pdata)
 
 	ret = clk_prepare_enable(arche_pdata->svc_ref_clk);
 	if (ret) {
-		dev_err(arche_pdata->dev, "Failed to enable svc_ref_clk: %d\n",
+		dev_err(arche_pdata->dev, "failed to enable svc_ref_clk: %d\n",
 			ret);
 		return ret;
 	}
 
-	/* Bring SVC out of reset */
+	/* bring SVC out of reset */
 	svc_reset_onoff(arche_pdata->svc_reset, !arche_pdata->is_reset_act_hi);
 
 	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_ACTIVE);
@@ -262,7 +262,7 @@ arche_platform_fw_flashing_seq(struct arche_platform_drvdata *arche_pdata)
 
 	ret = clk_prepare_enable(arche_pdata->svc_ref_clk);
 	if (ret) {
-		dev_err(arche_pdata->dev, "Failed to enable svc_ref_clk: %d\n",
+		dev_err(arche_pdata->dev, "failed to enable svc_ref_clk: %d\n",
 			ret);
 		return ret;
 	}
@@ -340,7 +340,7 @@ static ssize_t state_store(struct device *dev,
 		if (arche_pdata->state == ARCHE_PLATFORM_STATE_STANDBY)
 			goto exit;
 
-		dev_warn(arche_pdata->dev, "Standby state not supported\n");
+		dev_warn(arche_pdata->dev, "standby state not supported\n");
 	} else if (sysfs_streq(buf, "fw_flashing")) {
 		if (arche_pdata->state == ARCHE_PLATFORM_STATE_FW_FLASHING)
 			goto exit;
@@ -358,7 +358,7 @@ static ssize_t state_store(struct device *dev,
 		if (ret)
 			goto exit;
 	} else {
-		dev_err(arche_pdata->dev, "Unknown state\n");
+		dev_err(arche_pdata->dev, "unknown state\n");
 		ret = -EINVAL;
 	}
 
@@ -434,7 +434,7 @@ static int arche_platform_probe(struct platform_device *pdev)
 	if (!arche_pdata)
 		return -ENOMEM;
 
-	/* Setup svc reset gpio */
+	/* setup svc reset gpio */
 	arche_pdata->is_reset_act_hi = of_property_read_bool(np,
 							     "svc,reset-active-high");
 	if (arche_pdata->is_reset_act_hi)
@@ -445,7 +445,7 @@ static int arche_platform_probe(struct platform_device *pdev)
 	arche_pdata->svc_reset = devm_gpiod_get(dev, "svc,reset", flags);
 	if (IS_ERR(arche_pdata->svc_reset)) {
 		ret = PTR_ERR(arche_pdata->svc_reset);
-		dev_err(dev, "Failed to request svc-reset GPIO: %d\n", ret);
+		dev_err(dev, "failed to request svc-reset GPIO: %d\n", ret);
 		return ret;
 	}
 	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_OFF);
@@ -454,16 +454,16 @@ static int arche_platform_probe(struct platform_device *pdev)
 						  GPIOD_OUT_LOW);
 	if (IS_ERR(arche_pdata->svc_sysboot)) {
 		ret = PTR_ERR(arche_pdata->svc_sysboot);
-		dev_err(dev, "Failed to request sysboot0 GPIO: %d\n", ret);
+		dev_err(dev, "failed to request sysboot0 GPIO: %d\n", ret);
 		return ret;
 	}
 
-	/* Setup the clock request gpio first */
+	/* setup the clock request gpio first */
 	arche_pdata->svc_refclk_req = devm_gpiod_get(dev, "svc,refclk-req",
 						     GPIOD_IN);
 	if (IS_ERR(arche_pdata->svc_refclk_req)) {
 		ret = PTR_ERR(arche_pdata->svc_refclk_req);
-		dev_err(dev, "Failed to request svc-clk-req GPIO: %d\n", ret);
+		dev_err(dev, "failed to request svc-clk-req GPIO: %d\n", ret);
 		return ret;
 	}
 
@@ -471,7 +471,7 @@ static int arche_platform_probe(struct platform_device *pdev)
 	arche_pdata->svc_ref_clk = devm_clk_get(dev, "svc_ref_clk");
 	if (IS_ERR(arche_pdata->svc_ref_clk)) {
 		ret = PTR_ERR(arche_pdata->svc_ref_clk);
-		dev_err(dev, "Failed to get svc_ref_clk: %d\n", ret);
+		dev_err(dev, "failed to get svc_ref_clk: %d\n", ret);
 		return ret;
 	}
 
@@ -504,20 +504,20 @@ static int arche_platform_probe(struct platform_device *pdev)
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					dev_name(dev), arche_pdata);
 	if (ret) {
-		dev_err(dev, "Failed to request wake detect IRQ %d\n", ret);
+		dev_err(dev, "failed to request wake detect IRQ %d\n", ret);
 		return ret;
 	}
 	disable_irq(arche_pdata->wake_detect_irq);
 
 	ret = device_create_file(dev, &dev_attr_state);
 	if (ret) {
-		dev_err(dev, "Failed to create state file in sysfs\n");
+		dev_err(dev, "failed to create state file in sysfs\n");
 		return ret;
 	}
 
 	ret = of_platform_populate(np, NULL, NULL, dev);
 	if (ret) {
-		dev_err(dev, "Failed to populate child nodes %d\n", ret);
+		dev_err(dev, "failed to populate child nodes %d\n", ret);
 		goto err_device_remove;
 	}
 
@@ -525,7 +525,7 @@ static int arche_platform_probe(struct platform_device *pdev)
 	ret = register_pm_notifier(&arche_pdata->pm_notifier);
 
 	if (ret) {
-		dev_err(dev, "Failed to register pm notifier %d\n", ret);
+		dev_err(dev, "failed to register pm notifier %d\n", ret);
 		goto err_device_remove;
 	}
 
@@ -570,7 +570,7 @@ static void arche_platform_remove(struct platform_device *pdev)
 	arche_platform_poweroff_seq(arche_pdata);
 
 	if (usb3613_hub_mode_ctrl(false))
-		dev_warn(arche_pdata->dev, "Failed to control hub device\n");
+		dev_warn(arche_pdata->dev, "failed to control hub device\n");
 }
 
 static __maybe_unused int arche_platform_suspend(struct device *dev)
diff --git a/drivers/staging/greybus/authentication.c b/drivers/staging/greybus/authentication.c
index e1a819d1b1c8..d53e58f92e81 100644
--- a/drivers/staging/greybus/authentication.c
+++ b/drivers/staging/greybus/authentication.c
@@ -93,7 +93,7 @@ static int cap_get_endpoint_uid(struct gb_cap *cap, u8 *euid)
 	ret = gb_operation_sync(connection, GB_CAP_TYPE_GET_ENDPOINT_UID, NULL,
 				0, &response, sizeof(response));
 	if (ret) {
-		dev_err(cap->parent, "Failed to get endpoint uid (%d)\n", ret);
+		dev_err(cap->parent, "failed to get endpoint uid (%d)\n", ret);
 		return ret;
 	}
 
@@ -126,7 +126,7 @@ static int cap_get_ims_certificate(struct gb_cap *cap, u32 class, u32 id,
 
 	ret = gb_operation_request_send_sync(op);
 	if (ret) {
-		dev_err(cap->parent, "Failed to get certificate (%d)\n", ret);
+		dev_err(cap->parent, "failed to get certificate (%d)\n", ret);
 		goto done;
 	}
 
@@ -165,7 +165,7 @@ static int cap_authenticate(struct gb_cap *cap, u32 auth_type, u8 *uid,
 
 	ret = gb_operation_request_send_sync(op);
 	if (ret) {
-		dev_err(cap->parent, "Failed to authenticate (%d)\n", ret);
+		dev_err(cap->parent, "failed to authenticate (%d)\n", ret);
 		goto done;
 	}
 
diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
index 8ad763026dea..d4d86b3898de 100644
--- a/drivers/staging/greybus/bootrom.c
+++ b/drivers/staging/greybus/bootrom.c
@@ -179,7 +179,7 @@ static int find_firmware(struct gb_bootrom *bootrom, u8 stage)
 			      &connection->bundle->dev);
 	if (rc) {
 		dev_err(&connection->bundle->dev,
-			"Failed to find %s firmware (%d)\n", firmware_name, rc);
+			"failed to find %s firmware (%d)\n", firmware_name, rc);
 	}
 
 	return rc;
@@ -274,7 +274,7 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
 	size = le32_to_cpu(firmware_request->size);
 
 	if (offset >= fw->size || size > fw->size - offset) {
-		dev_warn(dev, "Bad firmware request (offs = %u, size = %u)\n",
+		dev_warn(dev, "bad firmware request (offs = %u, size = %u)\n",
 			 offset, size);
 		ret = -EINVAL;
 		goto unlock;
@@ -290,7 +290,7 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
 	firmware_response = op->response->payload;
 	memcpy(firmware_response, fw->data + offset, size);
 
-	dev_dbg(dev, "Responding with firmware (offs = %u, size = %u)\n",
+	dev_dbg(dev, "responding with firmware (offs = %u, size = %u)\n",
 		offset, size);
 
 unlock:
@@ -340,7 +340,7 @@ static int gb_bootrom_ready_to_boot(struct gb_operation *op)
 	/*
 	 * XXX Should we return error for insecure firmware?
 	 */
-	dev_dbg(dev, "Ready to boot: 0x%x, 0\n", status);
+	dev_dbg(dev, "ready to boot: 0x%x, 0\n", status);
 
 queue_work:
 	/*
@@ -367,7 +367,7 @@ static int gb_bootrom_request_handler(struct gb_operation *op)
 		return gb_bootrom_ready_to_boot(op);
 	default:
 		dev_err(&op->connection->bundle->dev,
-			"Unsupported request: %u\n", type);
+			"unsupported request: %u\n", type);
 		return -EINVAL;
 	}
 }
@@ -388,14 +388,14 @@ static int gb_bootrom_get_version(struct gb_bootrom *bootrom)
 				sizeof(response));
 	if (ret) {
 		dev_err(&bundle->dev,
-			"Failed to get protocol version: %d\n",
+			"failed to get protocol version: %d\n",
 			ret);
 		return ret;
 	}
 
 	if (response.major > request.major) {
 		dev_err(&bundle->dev,
-			"Unsupported major protocol version (%u > %u)\n",
+			"unsupported major protocol version (%u > %u)\n",
 			response.major, request.major);
 		return -ENOTSUPP;
 	}
@@ -467,7 +467,7 @@ static int gb_bootrom_probe(struct gb_bundle *bundle,
 				NULL, 0);
 	if (ret) {
 		dev_err(&connection->bundle->dev,
-			"Failed to send AP READY: %d\n", ret);
+			"failed to send AP READY: %d\n", ret);
 		goto err_cancel_timeout;
 	}
 
diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index 8ee08389d801..e509fdc715db 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -193,7 +193,7 @@ static ssize_t fade_##__dir##_store(struct device *dev,			\
 									\
 	ret = kstrtou8(buf, 0, &fade);					\
 	if (ret < 0) {							\
-		dev_err(dev, "Could not parse fade value %d\n", ret);	\
+		dev_err(dev, "could not parse fade value %d\n", ret);	\
 		goto unlock;						\
 	}								\
 	if (channel->fade_##__dir == fade)				\
@@ -238,7 +238,7 @@ static ssize_t color_store(struct device *dev, struct device_attribute *attr,
 	}
 	ret = kstrtou32(buf, 0, &color);
 	if (ret < 0) {
-		dev_err(dev, "Could not parse color value %d\n", ret);
+		dev_err(dev, "could not parse color value %d\n", ret);
 		goto unlock;
 	}
 
@@ -376,12 +376,12 @@ static int __gb_lights_led_brightness_set(struct gb_channel *channel)
 	else
 		channel->active = false;
 
-	/* We need to keep module alive when turning to active state */
+	/* we need to keep module alive when turning to active state */
 	if (!old_active && channel->active)
 		goto out_unlock;
 
 	/*
-	 * On the other hand if going to inactive we still hold a reference and
+	 * on the other hand if going to inactive we still hold a reference and
 	 * need to put it, so we could go to suspend.
 	 */
 	if (old_active && !channel->active)
@@ -466,12 +466,12 @@ static int gb_blink_set(struct led_classdev *cdev, unsigned long *delay_on,
 	else
 		channel->active = false;
 
-	/* We need to keep module alive when turning to active state. */
+	/* we need to keep module alive when turning to active state */
 	if (!old_active && channel->active)
 		goto out_unlock;
 
 	/*
-	 * On the other hand if going to inactive we still hold a reference and
+	 * on the other hand if going to inactive we still hold a reference and
 	 * need to put it, so we could go to suspend.
 	 */
 	if (old_active && !channel->active)
@@ -532,7 +532,7 @@ static int gb_lights_light_v4l2_register(struct gb_light *light)
 
 	channel_flash = get_channel_from_mode(light, GB_CHANNEL_MODE_FLASH);
 	if (!channel_flash) {
-		dev_err(dev, "Failed to get flash channel from mode\n");
+		dev_err(dev, "failed to get flash channel from mode\n");
 		return -EINVAL;
 	}
 
@@ -576,7 +576,7 @@ static int gb_lights_light_v4l2_register(struct gb_light *light)
 {
 	struct gb_connection *connection = get_conn_from_light(light);
 
-	dev_err(&connection->bundle->dev, "No support for v4l2 subdevices\n");
+	dev_err(&connection->bundle->dev, "no support for v4l2 subdevices\n");
 	return 0;
 }
 
@@ -728,14 +728,14 @@ static int __gb_lights_channel_torch_attach(struct gb_channel *channel,
 {
 	char *name;
 
-	/* We can only attach torch to a flash channel */
+	/* we can only attach torch to a flash channel */
 	if (!(channel->mode & GB_CHANNEL_MODE_FLASH))
 		return 0;
 
 	/* Move torch brightness to the destination */
 	channel->led->max_brightness = channel_torch->led->max_brightness;
 
-	/* Append mode name to flash name */
+	/* append mode name to flash name */
 	name = kasprintf(GFP_KERNEL, "%s_%s", channel->led->name,
 			 channel_torch->mode_name);
 	if (!name)
@@ -777,7 +777,7 @@ static int __gb_lights_flash_led_register(struct gb_channel *channel)
 
 	/*
 	 * If light have torch mode channel, this channel will be the led
-	 * classdev of the registered above flash classdev.
+	 * classdev of the registered above flash classdev
 	 */
 	channel_torch = get_channel_from_mode(channel->light,
 					      GB_CHANNEL_MODE_TORCH);
@@ -838,7 +838,7 @@ static int gb_lights_channel_flash_config(struct gb_channel *channel)
 	 */
 	channel->led->max_brightness = (fset->max - fset->min) / fset->step;
 
-	/* Only the flash mode have the timeout constraints settings. */
+	/* Only the flash mode have the timeout constraints settings */
 	if (channel->mode & GB_CHANNEL_MODE_FLASH) {
 		fset = &channel->timeout_us;
 		fset->min = le32_to_cpu(conf.timeout_min_us);
@@ -853,7 +853,7 @@ static int gb_lights_channel_flash_config(struct gb_channel *channel)
 {
 	struct gb_connection *connection = get_conn_from_channel(channel);
 
-	dev_err(&connection->bundle->dev, "No support for flash devices\n");
+	dev_err(&connection->bundle->dev, "no support for flash devices\n");
 	return 0;
 }
 
diff --git a/drivers/staging/greybus/log.c b/drivers/staging/greybus/log.c
index ce47f16a0c5b..57dcf9453bf1 100644
--- a/drivers/staging/greybus/log.c
+++ b/drivers/staging/greybus/log.c
@@ -23,30 +23,30 @@ static int gb_log_request_handler(struct gb_operation *op)
 	u16 len;
 
 	if (op->type != GB_LOG_TYPE_SEND_LOG) {
-		dev_err(dev, "Unknown request type 0x%02x\n", op->type);
+		dev_err(dev, "unknown request type 0x%02x\n", op->type);
 		return -EINVAL;
 	}
 
 	/* Verify size of payload */
 	if (op->request->payload_size < sizeof(*receive)) {
-		dev_err(dev, "Log request too small (%zu < %zu)\n",
+		dev_err(dev, "log request too small (%zu < %zu)\n",
 			op->request->payload_size, sizeof(*receive));
 		return -EINVAL;
 	}
 	receive = op->request->payload;
 	len = le16_to_cpu(receive->len);
 	if (len != (op->request->payload_size - sizeof(*receive))) {
-		dev_err(dev, "Log request wrong size %d vs %zu\n", len,
+		dev_err(dev, "log request wrong size %d vs %zu\n", len,
 			(op->request->payload_size - sizeof(*receive)));
 		return -EINVAL;
 	}
 	if (len == 0) {
-		dev_err(dev, "Log request of 0 bytes?\n");
+		dev_err(dev, "log request of 0 bytes?\n");
 		return -EINVAL;
 	}
 
 	if (len > GB_LOG_MAX_LEN) {
-		dev_err(dev, "Log request too big: %d\n", len);
+		dev_err(dev, "log request too big: %d\n", len);
 		return -EINVAL;
 	}
 
-- 
2.44.2


