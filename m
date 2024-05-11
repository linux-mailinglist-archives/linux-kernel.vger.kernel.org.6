Return-Path: <linux-kernel+bounces-176394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF578C2F19
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C931F21807
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6571F21345;
	Sat, 11 May 2024 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="xX8Aui39";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EH49xg/J"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3023E200AE;
	Sat, 11 May 2024 02:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715395194; cv=none; b=hOWNaD4KAm33mD9GgImZ6nmpM4wd+zPL67DNXMTe8vbYT8HwW/p+VEWW3AWNYNj1msYSe9zs2iM7dgWGs4tEc9c8V3pqoACQUY/AL3phCdlGzSEW4YAapfKNPS1GnKQFdeyy9R/vgDVEFlaLdoTsDPJ1Aqqt8PEWDPDBdFYGaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715395194; c=relaxed/simple;
	bh=H+8BbCpNbxtMxSSBJR0GajqPdSX3Kcjk73MXAr/xWNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYVwaAnmagL+hCmFjLyTk+B5rzcGKz42rc1y6XgmWmNQ+/7E4IBhyIYt8LjE1z79Zcp17JH7dy3byl2kWsHPOo7Joe7r9X7OEEgnOS3zSbT11Nxyr3wIois71E/wMxjzAd0ii7KlAukHzUHFl1Whs4vXgttxuMAeA/L8eLMNw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=xX8Aui39; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EH49xg/J; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 4BA731C000E0;
	Fri, 10 May 2024 22:39:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 10 May 2024 22:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1715395189; x=
	1715481589; bh=Tl0VzhlEWbW8rzN7D7pDeLzEcnGC8nVWp7qMRoliyq0=; b=x
	X8Aui39ZzMocIxAhp0BWZpTnk3kwSg6Vsb41F/AwiMw1cv3dbINik6QiRaWphF0i
	MlxEUYMwHeQ4A5kQYvXSvimzVjvLmfX22uKMIo2MpqmkWoF932J+PFlConOvvbNc
	fd8nv2YcgLRSJvKXfiDQFKiLArWfdCLAwN6drFFkjB84Qyt1hmyqIkj59tZlfUgy
	9wi5tXLkYJm5eWDBqegFly/QeBx2KppqgNzN6VPDazvejMTODoLH46ZIJoC3ogqb
	F49ik89qf6qVpCd7a0KACAoMVwb53Cy/V47wyiFUttve91GZBXFN+URsoVQffNUs
	nnswDT+s3HIxJ5wEOGL9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715395189; x=
	1715481589; bh=Tl0VzhlEWbW8rzN7D7pDeLzEcnGC8nVWp7qMRoliyq0=; b=E
	H49xg/JKmPuH3JYDO5TuDBZL0PGmBWL4E9DUEWN/3LxRbQb5qEYOK8cQa561LwUd
	U83grPhT4cRd6WDL41bmG8TRhWuWf9Xt2Wu6g+rtDhn670er2OlBRzzfGVs+KfOI
	Clxfh90R41C5ihSxb/wvj3dBAsP9GGHzUFYrLsFJbkn0NxU69KrTa/B3EOqVm6++
	L6BB7vulp7GagX0V0JrRyEC1X5rg5DHBuBOueoF5Igi2GUwOodcPpilMr5qTenrw
	9D294OfN4YQR4N6CTwUHlWWR3SwXQvJ/Rsf608OuFmkv/n/a669ppCu1LZkw0Q3H
	cPMl66CGbk0CXzbClnfwA==
X-ME-Sender: <xms:ddo-Zmc0UqMcXoTnWxj3ymUnY98yhYT1Dy14732zpZCYbQ-DqIsXrA>
    <xme:ddo-ZgP2_k2Kppy-URis3rvYNR9bBfkkU-Y3RM1AzqxjPC4gCPkAPbyWY9dp0mRP4
    wTdjwUwJj9_g0TRID0>
X-ME-Received: <xmr:ddo-ZnjJuaLXsmQY5jdIlRvKfsuyItGTWou4pb2btQDfI8eBwEKBa8EdXgi1WTQc1cSKVUWv05qdXYYZC1OQg_tzw8xEt25P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefledgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goteeftdduqddtudculdduhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepnfihnhguohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhi
    hnuggvnhhordgtrgeqnecuggftrfgrthhtvghrnheplefhieffkedtledugfetgfegfeeh
    hfethffhffeuvefhtdekvdeikeehleejieetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:ddo-Zj8EoEN-OhByFNDrZH-2rOIWA4xDNAOMN3U4HMF3nYorCQsAsA>
    <xmx:ddo-ZistSlfPc6-sEDj2Qlf3KlUV547jvjzlpX-QJno34yaWvV5DnQ>
    <xmx:ddo-ZqF5tD3DdF395v18PmLIBhRLMBW3ZsgsL_wTsBjK5d12dMmpqw>
    <xmx:ddo-ZhMBKJwQW50prddLFVf5CD2FYFuw7KjcyULGoHMqWAGwDmeFFw>
    <xmx:ddo-ZqTkw5ODJ5FHC0IEusiCXa_wqf6K2Wlwf6gnl14ye0ZH36lPvxAe>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 22:39:49 -0400 (EDT)
From: Lyndon Sanche <lsanche@lyndeno.ca>
To: lsanche@lyndeno.ca
Cc: mario.limonciello@amd.com,
	pali@kernel.org,
	W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	lkp@intel.com,
	hdegoede@redhat.com,
	Yijun.Shen@dell.com,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v6 2/2] platform/x86: dell-laptop: Implement platform_profile
Date: Fri, 10 May 2024 20:36:52 -0600
Message-ID: <20240511023726.7408-4-lsanche@lyndeno.ca>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240425172758.67831-1-lsanche@lyndeno.ca>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Dell laptops support configuration of preset fan modes through
smbios tables.

If the platform supports these fan modes, set up platform_profile to
change these modes. If not supported, skip enabling platform_profile.

Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
---
 drivers/platform/x86/dell/Kconfig            |   2 +
 drivers/platform/x86/dell/dell-laptop.c      | 242 +++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios-base.c |   1 +
 drivers/platform/x86/dell/dell-smbios.h      |   1 +
 4 files changed, 246 insertions(+)

diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
index bd9f445974cc..26679f22733c 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -47,6 +47,7 @@ config DCDBAS
 config DELL_LAPTOP
 	tristate "Dell Laptop Extras"
 	default m
+	depends on ACPI
 	depends on DMI
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
@@ -57,6 +58,7 @@ config DELL_LAPTOP
 	select POWER_SUPPLY
 	select LEDS_CLASS
 	select NEW_LEDS
+	select ACPI_PLATFORM_PROFILE
 	help
 	This driver adds support for rfkill and backlight control to Dell
 	laptops (except for some models covered by the Compal driver).
diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 42f7de2b4522..07f54f1cbac5 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -27,6 +27,9 @@
 #include <linux/i8042.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/platform_profile.h>
 #include <acpi/video.h>
 #include "dell-rbtn.h"
 #include "dell-smbios.h"
@@ -95,6 +98,7 @@ static struct backlight_device *dell_backlight_device;
 static struct rfkill *wifi_rfkill;
 static struct rfkill *bluetooth_rfkill;
 static struct rfkill *wwan_rfkill;
+static struct platform_profile_handler *thermal_handler;
 static bool force_rfkill;
 static bool micmute_led_registered;
 static bool mute_led_registered;
@@ -2199,6 +2203,236 @@ static int mute_led_set(struct led_classdev *led_cdev,
 	return 0;
 }
 
+/* Derived from smbios-thermal-ctl
+ *
+ * cbClass 17
+ * cbSelect 19
+ * User Selectable Thermal Tables(USTT)
+ * cbArg1 determines the function to be performed
+ * cbArg1 0x0 = Get Thermal Information
+ *  cbRES1         Standard return codes (0, -1, -2)
+ *  cbRES2, byte 0  Bitmap of supported thermal modes. A mode is supported if
+ *                  its bit is set to 1
+ *     Bit 0 Balanced
+ *     Bit 1 Cool Bottom
+ *     Bit 2 Quiet
+ *     Bit 3 Performance
+ *  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller (AAC) modes.
+ *                 Each mode corresponds to the supported thermal modes in
+ *                  byte 0. A mode is supported if its bit is set to 1.
+ *     Bit 0 AAC (Balanced)
+ *     Bit 1 AAC (Cool Bottom
+ *     Bit 2 AAC (Quiet)
+ *     Bit 3 AAC (Performance)
+ *  cbRes3, byte 0 Current Thermal Mode
+ *     Bit 0 Balanced
+ *     Bit 1 Cool Bottom
+ *     Bit 2 Quiet
+ *     Bit 3 Performanc
+ *  cbRes3, byte 1  AAC Configuration type
+ *          0       Global (AAC enable/disable applies to all supported USTT modes)
+ *          1       USTT mode specific
+ *  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
+ *     If AAC Configuration Type is Global,
+ *          0       AAC mode disabled
+ *          1       AAC mode enabled
+ *     If AAC Configuration Type is USTT mode specific (multiple bits may be set),
+ *          Bit 0 AAC (Balanced)
+ *          Bit 1 AAC (Cool Bottom
+ *          Bit 2 AAC (Quiet)
+ *          Bit 3 AAC (Performance)
+ *  cbRes3, byte 3  Current Fan Failure Mode
+ *     Bit 0 Minimal Fan Failure (at least one fan has failed, one fan working)
+ *     Bit 1 Catastrophic Fan Failure (all fans have failed)
+ *
+ * cbArg1 0x1   (Set Thermal Information), both desired thermal mode and
+ *               desired AAC mode shall be applied
+ * cbArg2, byte 0  Desired Thermal Mode to set
+ *                  (only one bit may be set for this parameter)
+ *     Bit 0 Balanced
+ *     Bit 1 Cool Bottom
+ *     Bit 2 Quiet
+ *     Bit 3 Performance
+ * cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to set
+ *     If AAC Configuration Type is Global,
+ *         0  AAC mode disabled
+ *         1  AAC mode enabled
+ *     If AAC Configuration Type is USTT mode specific
+ *     (multiple bits may be set for this parameter),
+ *         Bit 0 AAC (Balanced)
+ *         Bit 1 AAC (Cool Bottom
+ *         Bit 2 AAC (Quiet)
+ *         Bit 3 AAC (Performance)
+ */
+
+#define DELL_ACC_GET_FIELD		GENMASK(19, 16)
+#define DELL_ACC_SET_FIELD		GENMASK(11, 8)
+#define DELL_THERMAL_SUPPORTED	GENMASK(3, 0)
+
+enum thermal_mode_bits {
+	DELL_BALANCED = BIT(0),
+	DELL_COOL_BOTTOM = BIT(1),
+	DELL_QUIET = BIT(2),
+	DELL_PERFORMANCE = BIT(3),
+};
+
+static int thermal_get_mode(void)
+{
+	struct calling_interface_buffer buffer;
+	int state;
+	int ret;
+
+	dell_fill_request(&buffer, 0x0, 0, 0, 0);
+	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
+	if (ret)
+		return ret;
+	state = buffer.output[2];
+	if (state & DELL_BALANCED)
+		return DELL_BALANCED;
+	else if (state & DELL_COOL_BOTTOM)
+		return DELL_COOL_BOTTOM;
+	else if (state & DELL_QUIET)
+		return DELL_QUIET;
+	else if (state & DELL_PERFORMANCE)
+		return DELL_PERFORMANCE;
+	else
+		return -ENXIO;
+}
+
+static int thermal_get_supported_modes(int *supported_bits)
+{
+	struct calling_interface_buffer buffer;
+	int ret;
+
+	dell_fill_request(&buffer, 0x0, 0, 0, 0);
+	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
+	if (ret)
+		return ret;
+	*supported_bits = FIELD_GET(DELL_THERMAL_SUPPORTED, buffer.output[1]);
+	return 0;
+}
+
+static int thermal_get_acc_mode(int *acc_mode)
+{
+	struct calling_interface_buffer buffer;
+	int ret;
+
+	dell_fill_request(&buffer, 0x0, 0, 0, 0);
+	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
+	if (ret)
+		return ret;
+	*acc_mode = FIELD_GET(DELL_ACC_GET_FIELD, buffer.output[3]);
+	return 0;
+}
+
+static int thermal_set_mode(enum thermal_mode_bits state)
+{
+	struct calling_interface_buffer buffer;
+	int ret;
+	int acc_mode;
+
+	ret = thermal_get_acc_mode(&acc_mode);
+	if (ret)
+		return ret;
+
+	dell_fill_request(&buffer, 0x1, FIELD_PREP(DELL_ACC_SET_FIELD, acc_mode) | state, 0, 0);
+	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
+	return ret;
+}
+
+static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
+					enum platform_profile_option profile)
+{
+	switch (profile) {
+	case PLATFORM_PROFILE_BALANCED:
+		return thermal_set_mode(DELL_BALANCED);
+	case PLATFORM_PROFILE_PERFORMANCE:
+		return thermal_set_mode(DELL_PERFORMANCE);
+	case PLATFORM_PROFILE_QUIET:
+		return thermal_set_mode(DELL_QUIET);
+	case PLATFORM_PROFILE_COOL:
+		return thermal_set_mode(DELL_COOL_BOTTOM);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
+					enum platform_profile_option *profile)
+{
+	int ret;
+
+	ret = thermal_get_mode();
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case DELL_BALANCED:
+		*profile = PLATFORM_PROFILE_BALANCED;
+		break;
+	case DELL_PERFORMANCE:
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case DELL_COOL_BOTTOM:
+		*profile = PLATFORM_PROFILE_COOL;
+		break;
+	case DELL_QUIET:
+		*profile = PLATFORM_PROFILE_QUIET;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int thermal_init(void)
+{
+	int ret;
+	int supported_modes;
+
+	/* If thermal commands not supported, exit without error */
+	if (!dell_laptop_check_supported_cmds(CLASS_INFO))
+		return 0;
+
+	/* If thermal modes not supported, exit without error */
+	ret = thermal_get_supported_modes(&supported_modes);
+	if (ret < 0)
+		return ret;
+	if (!supported_modes)
+		return 0;
+
+	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
+	if (!thermal_handler)
+		return -ENOMEM;
+	thermal_handler->profile_get = thermal_platform_profile_get;
+	thermal_handler->profile_set = thermal_platform_profile_set;
+
+	if (supported_modes & DELL_QUIET)
+		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
+	if (supported_modes & DELL_COOL_BOTTOM)
+		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
+	if (supported_modes & DELL_BALANCED)
+		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
+	if (supported_modes & DELL_PERFORMANCE)
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
+
+	/* Clean up if failed */
+	ret = platform_profile_register(thermal_handler);
+	if (ret)
+		kfree(thermal_handler);
+
+	return ret;
+}
+
+static void thermal_cleanup(void)
+{
+	if (thermal_handler) {
+		platform_profile_remove();
+		kfree(thermal_handler);
+	}
+}
+
 static struct led_classdev mute_led_cdev = {
 	.name = "platform::mute",
 	.max_brightness = 1,
@@ -2238,6 +2472,11 @@ static int __init dell_init(void)
 		goto fail_rfkill;
 	}
 
+	/* Do not fail module if thermal modes not supported, just skip */
+	ret = thermal_init();
+	if (ret)
+		goto fail_thermal;
+
 	if (quirks && quirks->touchpad_led)
 		touchpad_led_init(&platform_device->dev);
 
@@ -2317,6 +2556,8 @@ static int __init dell_init(void)
 		led_classdev_unregister(&mute_led_cdev);
 fail_led:
 	dell_cleanup_rfkill();
+fail_thermal:
+	thermal_cleanup();
 fail_rfkill:
 	platform_device_del(platform_device);
 fail_platform_device2:
@@ -2344,6 +2585,7 @@ static void __exit dell_exit(void)
 		platform_device_unregister(platform_device);
 		platform_driver_unregister(&platform_driver);
 	}
+	thermal_cleanup();
 }
 
 /* dell-rbtn.c driver export functions which will not work correctly (and could
diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index 6ae09d7f76fb..387fa5618f7a 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -71,6 +71,7 @@ static struct smbios_call call_blacklist[] = {
 	/* handled by kernel: dell-laptop */
 	{0x0000, CLASS_INFO, SELECT_RFKILL},
 	{0x0000, CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT},
+	{0x0000, CLASS_INFO, SELECT_THERMAL_MANAGEMENT},
 };
 
 struct token_range {
diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
index 63116671eada..5d7178df80c6 100644
--- a/drivers/platform/x86/dell/dell-smbios.h
+++ b/drivers/platform/x86/dell/dell-smbios.h
@@ -19,6 +19,7 @@
 /* Classes and selects used only in kernel drivers */
 #define CLASS_KBD_BACKLIGHT 4
 #define SELECT_KBD_BACKLIGHT 11
+#define SELECT_THERMAL_MANAGEMENT 19
 
 /* Tokens used in kernel drivers, any of these
  * should be filtered from userspace access
-- 
2.42.0


