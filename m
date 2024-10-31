Return-Path: <linux-kernel+bounces-390285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A309B77F3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184202878D9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E13198A2F;
	Thu, 31 Oct 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ATuJevDZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jGrE2PMp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A11193427;
	Thu, 31 Oct 2024 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368276; cv=none; b=Jqvu46b6S8k2s7sDrbWN7h5tvzHSMVFBRppmB3BID2Mil3o3aXBRy72Dd0mvDhZ1o6Z4FXHJNhPenQ856esvvPnJzufnD6B4u3FcvpIiwUULmXBZpdLVkz3dfDexd2EuegMB2iCfkc0DIasx+FcKCNlZoTFBXfByvi6ZaWKh1lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368276; c=relaxed/simple;
	bh=wlOq8gEb2DgkuOYk87YvKkPUL36YuiCQFr8S9YW/bKI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fVMz6aw1VaJn/BcMgzS5ne/vROU3RuQvA9iUhM1YCK+GDomc0o2QhCQa79OksyYNXV0YZbsVmzSEvDOOcx1+TeSWZCvvMp8gZx0LbPloBTIHwmlrYpHsljbRL9V6qkGpdbDq0hzu178NBqkD3Wp83x1ntdP83xvJpiJF5gJZcdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATuJevDZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jGrE2PMp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 09:51:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730368273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTsRVWRoZXjpJi9E9xfwnpzFr8fuigWeKrJNuIDNf/U=;
	b=ATuJevDZcE4fUc517BvUqxF8BMnS2bLqOTwhum4m13XD8eMctYkJ9/ck5JLNKc3jW/pSYQ
	P+GZIS1oXb6qBcFRElSAlRhHD8t57fO1KM5askzuV7Ns4Rx5G/d0gxkQAZOR6LVxfqikBI
	oga1QWGtyEBenp7emN/XO/awpYEDydQELFoSjoD8wdGKwoMxM7leS3AxXIK4XKDXbc/liX
	66lbgfqoh3QZg5XrJqjLPz58NkbccTAr74SnpIoBWrvDsp3kFU1LP1oZ9TO/nUd6dUpmF0
	KRmr+W06y8MRzNRdhv6ODe3EfILK1KX1ks9Sj1QAJigQYrwWgsSlmQ10FinU+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730368273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTsRVWRoZXjpJi9E9xfwnpzFr8fuigWeKrJNuIDNf/U=;
	b=jGrE2PMpiKEcsSi5QQuhp2B0Vu+8epFCQ5nSDjAqhuA877NV9+a3h0VXHyDAGUWfbIybMn
	NgL7nVXOXCPnUGDQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-tegra: Remove
 clockevents shutdown call on offlining
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-11-frederic@kernel.org>
References: <20241029125451.54574-11-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173036827152.3137.12415773273788477374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bf9a001fb8e46a23c43d4964523963e717d9e972
Gitweb:        https://git.kernel.org/tip/bf9a001fb8e46a23c43d4964523963e717d9e972
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 31 Oct 2024 10:41:43 +01:00

clocksource/drivers/timer-tegra: Remove clockevents shutdown call on offlining

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-11-frederic@kernel.org

---
 drivers/clocksource/timer-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index e9635c2..35b6ce9 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -158,7 +158,6 @@ static int tegra_timer_stop(unsigned int cpu)
 {
 	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
 
-	to->clkevt.set_state_shutdown(&to->clkevt);
 	disable_irq_nosync(to->clkevt.irq);
 
 	return 0;

