Return-Path: <linux-kernel+bounces-436159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFE49E81F3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A688216614A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 20:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EF8155743;
	Sat,  7 Dec 2024 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=radix.lt header.i=povilas@radix.lt header.b="RqFG+goD"
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7892F153565;
	Sat,  7 Dec 2024 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733603213; cv=pass; b=hsYWbVBzD1Lmpd2oBxjriX2SFyqZGT7QrFxeQm/4k2rsykXhY+V+jDrCquQsaJErlVxRHwvUxFYLIJRq2BqpDJ729D/OCl+Cf5ytogd/CMxv4v89v9RL4tLWjRQ4xMrjXk+w7bqw7jDgLjPI5N6TKGgIy33P3ivnWCmcFDt2QxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733603213; c=relaxed/simple;
	bh=NopiB1Eb/FaQydMT34A+1eoTBGATjEMq82DdMXzQ+9Y=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=E+BveGmH+XWNCH06lE5uvW4LltPOvQZvBDCzY5hRMBdplVbv0tIjzL1rw4ag+wfCvcpVTTFLU0XtXTy1vHqtwOnQ1PJydtP40HKF7jtEzUv0jnK+ydCxRZ9HvDloX7HGbSdWR2k5nBdaOINcudSDq4dsE17KyyZPxpElHXQk02Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radix.lt; spf=pass smtp.mailfrom=radix.lt; dkim=pass (1024-bit key) header.d=radix.lt header.i=povilas@radix.lt header.b=RqFG+goD; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radix.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radix.lt
ARC-Seal: i=1; a=rsa-sha256; t=1733603192; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MgAg4k9iLl3skhOUWxA0x1U/Vcn6XFSv5APC3/vl7zUlM9Ha9inMTMA1zbaneA6OZtP2TuuQ4KFTjHqk+Ya4n7soB9a80ILVD+fVUuT/dglCPB6E9JoHKa/J3Rdm6W9ML0oCyM9NJsOnMKIZvQjr/LaEymghhPUkBXOXYvBOY/A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733603192; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=esyrfn6zed3J0aX33DmPQ/m2ecvc1j+MAt8KepMxEsY=; 
	b=hW/V+vqiePEMpruzJ+EFKvWGkaPIXFXZQFx+ua45gP2h/npMqe5Pss3WTMc/EA0ElnhHkGrvpcBVb75DkHZJJjXAdzZ992Yk+3EfoL99j5mvUgRmjUDMhquEPYbQuN9A8MmETXdyM76ZfcyBL4qz++fccglSksoYzgOL/IkGGxc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=radix.lt;
	spf=pass  smtp.mailfrom=povilas@radix.lt;
	dmarc=pass header.from=<povilas@radix.lt>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733603192;
	s=zoho; d=radix.lt; i=povilas@radix.lt;
	h=Message-ID:Date:Date:MIME-Version:From:From:To:To:Cc:Cc:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=esyrfn6zed3J0aX33DmPQ/m2ecvc1j+MAt8KepMxEsY=;
	b=RqFG+goDENquupD8LHbkhDmwo63dcbyRTYSwzYFzcgbHIIU/JU9+ZWL9pUNqEz15
	lI9818USN9j12dUmFfTodj1M7mEZPfHUr2etUd50jjuBMRqa5THaYtjWhXtatQJdyDc
	ACCjfsHkIZhvrorVuJ1ksYvjPlG7Sg+9rJXyjur0=
Received: by mx.zohomail.com with SMTPS id 1733603189997314.9608378018047;
	Sat, 7 Dec 2024 12:26:29 -0800 (PST)
Message-ID: <e5d65c8a-4785-4635-ad77-d5155f517155@radix.lt>
Date: Sat, 7 Dec 2024 22:26:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Povilas Kanapickas <povilas@radix.lt>
Content-Language: en-US
To: pali@kernel.org
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Add Dell XPS 9370 to fan control whitelist
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Add the Dell XPS 9370 to the fan control whitelist to allow
for manual fan control.

Signed-off-by: Povilas Kanapickas <povilas@radix.lt>
---
 drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index f5bdf842040e..bcb295ea3319 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1544,6 +1544,14 @@ static const struct dmi_system_id i8k_whitelist_fan_control[] __initconst = {
                },
                .driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
        },
+       {
+               .ident = "Dell XPS 13 9370",
+               .matches = {
+                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 13 9370"),
+               },
+               .driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
+       },
        {
                .ident = "Dell Optiplex 7000",
                .matches = {
-- 
2.39.5

