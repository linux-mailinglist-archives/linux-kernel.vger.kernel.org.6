Return-Path: <linux-kernel+bounces-380246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F59AEAF0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671931F23A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9301F76A5;
	Thu, 24 Oct 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUeAnkwQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8500516DC36;
	Thu, 24 Oct 2024 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784628; cv=none; b=XEFoacOTE7+KgVXakgaX4XlqnRvgGA3HhzxWPEUmnB/iJTzm+DSUDPwZXrf7WICSnc9D9NknUishAUL1bfjQNzWv2nVxOE2knbo0YhSPSq0KbqoMWPDLT4J1NfwCC+lMkOyTdlkCYschSGZRZFIfb925aE2p+Jjwar/XOsZIl5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784628; c=relaxed/simple;
	bh=iSzGPNvFgUGmzJ3Au97PevLtqL19gLki/sDax7pf9hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jjf3ZD3McDELMtd8wS24Iyo83ThshlEMByL+6x/CECiDtvkPy6AS7HZ0S2u3FE/+2KLnB5ryBv4OtU6gy1wPp8G65ZdejdyxAdZUALuTnQX7T/XTYSLcHFnHfgYUhHpCxhqyJuqCZAkTUwYGcV/w19vCHyKXDCWzJLTUOSHl4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUeAnkwQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729784626; x=1761320626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iSzGPNvFgUGmzJ3Au97PevLtqL19gLki/sDax7pf9hs=;
  b=XUeAnkwQFN/eMtqd0ku/uwVmu1ZTga+2RDj6k2CuL5+TMFlpYcHg4bHh
   Tk3QWFuupWw2JGrv5w//DbUAw/L7oFajjWtaxeBcsIzcTC0+dYtFW92dF
   RLLkWSP3aQ4NDaWeioN6fsd/HqK5mp7RRE5pELSs7Lb4nojLBvkPHaHmj
   tWxfYwmM++PsoiDF/bi18FTjHjXDUIlW5K1irJ08W/A8y71GMQrC9jDti
   NQiBlnqyLnYtciizYczAU90/xqqV0gSErKCuMjZuLLZspKkkPNc+m3x+T
   i/5hZl4rY92bpnSqHKOjFNAwI2LjGsOSxM+zjs/OSYHDxIwnrdOT2T9I2
   A==;
X-CSE-ConnectionGUID: acQ1/leGR8uixceDeqWv/Q==
X-CSE-MsgGUID: waiOVjVET9W4DjoY8djj9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40013060"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="40013060"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 08:43:45 -0700
X-CSE-ConnectionGUID: tCfJOhRAQOKB/Hg+/ehwsQ==
X-CSE-MsgGUID: cOYe3MsXSuqTkUhEx6bSPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="81454752"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 24 Oct 2024 08:43:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 4AB86252; Thu, 24 Oct 2024 18:43:41 +0300 (EEST)
Date: Thu, 24 Oct 2024 18:43:41 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
	andreas.noever@gmail.com, linux-usb@vger.kernel.org,
	mmikowski@kfocus.org, linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241024154341.GK275077@black.fi.intel.com>
References: <20241009220118.70bfedd0@kf-ir16>
 <20241010044919.GD275077@black.fi.intel.com>
 <20241010232656.7fc6359e@kf-ir16>
 <20241011163811.GU275077@black.fi.intel.com>
 <20241011183751.7d27c59c@kf-ir16>
 <20241023062737.GG275077@black.fi.intel.com>
 <20241023073931.GH275077@black.fi.intel.com>
 <20241023174413.451710ea@kf-ir16>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023174413.451710ea@kf-ir16>

Hi,

On Wed, Oct 23, 2024 at 05:44:13PM -0500, Aaron Rainbolt wrote:
> Hey, thanks for taking a look! Our tester re-did the tests with kernel
> 6.12~rc4, and reported the following results doing so, along with
> another dmesg log. I think your question about xrandr is answered in
> this report. The dmesg log is attached.
> 
> With the vanilla rc4 kernel plus your patch from earlier:
> 
> -----
> 
> 1. Start with Laptop powered-off
> 2. Unplug all USB-C connectors.
> 3. Boot Kubuntu 24.04 with patched kernel 6.12.0-rc4, add cmdline
>    parameter thunderbolt.dyndbg=+p. All other optional parameters were
>    removed.
> 4. Log in to normal SDDM to KDE 5.27.11.
> 5. Open 'Display Settings KCM' to view display detection.
> 6. Plug in one UBC-C connector attached to 4k display.
>    * Note these work with Kernel 6.1 and non-Barlow Ridge systems (TBT
>      4).
>    * Display does not wake up.
>    * Display never appears in 'Display Settings KCM.'
>    * This is NOT desired behavior; display should show.
>    * (Note: The test results I was given do not mention xrandr here,
>      however as subsequent results mention it I believe that the
>      monitor does *not* appear in xrandr here. I will double-check
>      to be sure.)
> Notes:
> 
> 1. With debug off, the recognition of screens is better, and previously
>    "just worked", at least for one screen.
> 2. W11 updated works, as do kernels Kernels 6.1 and earlier.
> 3. W11 from Q4 2022 (pre-update) and kernels 6.5+ do not. With both,
>    the screens usually initially attach and then time out after 15s.

Yea, they work because we added Barlow Ridge support later and this
problem is specific only on it. None of the integrated or Maple Ridge
suffers from this "feature".

Below is an updated patch. This one checks if the DP resource is
available before it adds it. I hope this covers the case where we get
the hotplugs even when you have Type-C cable plugged (it should not
happen, and does not happen on my test system but I have newer firmwre
so could be firmware related). I wonder if you can try that one too with
the same flow as above (up to step 6).

The checkerboard is unrelated issue so I would deal that separarely with
the nouveau folks. The Thunderbolt/USB4 driver has no visibility what is
going on with the redriven DP signaling except that it tries to keep the
thing powered as long as it is needed.

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 07a66594e904..ee5c8ba75baa 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2113,6 +2113,37 @@ static void tb_exit_redrive(struct tb_port *port)
 	}
 }
 
+static void tb_switch_enter_redrive(struct tb_switch *sw)
+{
+	struct tb_port *port;
+
+	tb_switch_for_each_port(sw, port)
+		tb_enter_redrive(port);
+}
+
+/*
+ * Called during system and runtime suspend to forcefully exit redrive
+ * mode without querying whether the resource is available.
+ */
+static void tb_switch_exit_redrive(struct tb_switch *sw)
+{
+	struct tb_port *port;
+
+	if (!(sw->quirks & QUIRK_KEEP_POWER_IN_DP_REDRIVE))
+		return;
+
+	tb_switch_for_each_port(sw, port) {
+		if (!tb_port_is_dpin(port))
+			continue;
+
+		if (port->redrive) {
+			port->redrive = false;
+			pm_runtime_put(&sw->dev);
+			tb_port_dbg(port, "exit redrive mode\n");
+		}
+	}
+}
+
 static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port *port,
 				       const char *reason)
 {
@@ -2157,8 +2188,17 @@ static void tb_dp_resource_available(struct tb *tb, struct tb_port *port)
 			return;
 	}
 
-	tb_port_dbg(port, "DP %s resource available after hotplug\n",
-		    tb_port_is_dpin(port) ? "IN" : "OUT");
+	if (tb_port_is_dpin(port)) {
+		/* Verify that the resource is really available */
+		if (!tb_switch_query_dp_resource(port->sw, port)) {
+			tb_port_info(port, "got hotplug but DP IN resource not available\n");
+			return;
+		}
+		tb_port_dbg(port, "DP IN resource available after hotplug\n");
+	} else {
+		tb_port_dbg(port, "DP OUT resource available after hotplug\n");
+	}
+
 	list_add_tail(&port->list, &tcm->dp_resources);
 	tb_exit_redrive(port);
 
@@ -2987,6 +3027,7 @@ static int tb_start(struct tb *tb, bool reset)
 	tb_create_usb3_tunnels(tb->root_switch);
 	/* Add DP IN resources for the root switch */
 	tb_add_dp_resources(tb->root_switch);
+	tb_switch_enter_redrive(tb->root_switch);
 	/* Make the discovered switches available to the userspace */
 	device_for_each_child(&tb->root_switch->dev, NULL,
 			      tb_scan_finalize_switch);
@@ -3002,6 +3043,7 @@ static int tb_suspend_noirq(struct tb *tb)
 
 	tb_dbg(tb, "suspending...\n");
 	tb_disconnect_and_release_dp(tb);
+	tb_switch_exit_redrive(tb->root_switch);
 	tb_switch_suspend(tb->root_switch, false);
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
 	tb_dbg(tb, "suspend finished\n");
@@ -3094,6 +3136,7 @@ static int tb_resume_noirq(struct tb *tb)
 		tb_dbg(tb, "tunnels restarted, sleeping for 100ms\n");
 		msleep(100);
 	}
+	tb_switch_enter_redrive(tb->root_switch);
 	 /* Allow tb_handle_hotplug to progress events */
 	tcm->hotplug_active = true;
 	tb_dbg(tb, "resume finished\n");
@@ -3157,6 +3200,8 @@ static int tb_runtime_suspend(struct tb *tb)
 	struct tb_cm *tcm = tb_priv(tb);
 
 	mutex_lock(&tb->lock);
+	tb_disconnect_and_release_dp(tb);
+	tb_switch_exit_redrive(tb->root_switch);
 	tb_switch_suspend(tb->root_switch, true);
 	tcm->hotplug_active = false;
 	mutex_unlock(&tb->lock);
@@ -3188,6 +3233,7 @@ static int tb_runtime_resume(struct tb *tb)
 	tb_restore_children(tb->root_switch);
 	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
 		tb_tunnel_activate(tunnel);
+	tb_switch_enter_redrive(tb->root_switch);
 	tcm->hotplug_active = true;
 	mutex_unlock(&tb->lock);
 

