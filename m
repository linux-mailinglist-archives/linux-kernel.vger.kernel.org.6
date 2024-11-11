Return-Path: <linux-kernel+bounces-403726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5409C39B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD291F21068
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0881F15D5C5;
	Mon, 11 Nov 2024 08:36:20 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBEF42A8A;
	Mon, 11 Nov 2024 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314179; cv=none; b=W9KP+B7tQTEAUOTl/IxBBAyQkkxwo2jR1JpU1p6lC+o3n3+6K/dMrG3mf810cBcIsSCPBPJ6WGvVd08imesxhaukNyboGV0EMkaduu0xwk7iIeGeaY3jcPsTx+V7Bl9xK9Hd3rdDEV2ffVerWiFIQBZQWonQX4UV7JK4c7BaWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314179; c=relaxed/simple;
	bh=gpbvNr/dPkU6IH8UnXNGrUDcONXcmRNRpINhen4Frqo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Re6oyioDX/yDeKvUwdl2uMd0kcTWqilchkRXRqUKwaynvR4SrPxc3yJTKGkJkmdfxIrIoxIBGMOwxZ+rl1g9YFv+cDh3seLMYb7t8pRXgEDezMFIQV3lQm+sbN8/n/BqfJJxmPDYd9d6bw9FCLDHXEomEf0Q03wwf1YqhToSYXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fde93ae0a00711efa216b1d71e6e1362-20241111
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:674c722c-e011-4853-999c-d80aa1612fe2,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:82c5f88,CLOUDID:5824cc9b858add5dafbae508937569c9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fde93ae0a00711efa216b1d71e6e1362-20241111
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 846668443; Mon, 11 Nov 2024 16:36:05 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 8444316002081;
	Mon, 11 Nov 2024 16:36:05 +0800 (CST)
X-ns-mid: postfix-6731C1F5-4405791175
Received: from [10.42.116.241] (unknown [10.42.116.241])
	by node4.com.cn (NSMail) with ESMTPA id 03EB216002081;
	Mon, 11 Nov 2024 08:36:03 +0000 (UTC)
Message-ID: <b09c4396-1578-45bb-b1fb-23c1f91cabe7@kylinos.cn>
Date: Mon, 11 Nov 2024 16:36:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [RFC] hwmon: (nct6775-core) Fix overflows seen when writing limit
 attributes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hi Guenter Roeck,
   Excuse me, may I ask a question?
   When I see this commit (Fixes: 0403e10bf082 ("hwmon: (nct6775-core) 
Fix underflows seen when writing limit attributes")), I found an issue,
DIV_ROUND_CLOSEST() after kstrtoul() results in an overflow if a large
number such as 18446744073709551615 is provided by the user.
Fix it by reordering clamp_val() and DIV_ROUND_CLOSEST() operations.

If the issue described above does indeed exist, I will send an formal patch.


diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 934fed3dd586..12ee2ca4a6d6 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -2878,8 +2878,7 @@ store_target_temp(struct device *dev, struct 
device_attribute *attr,
         if (err < 0)
                 return err;

-       val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0,
-                       data->target_temp_mask);
+       val = DIV_ROUND_CLOSEST(clamp_val(val, 0, data->tolerance_mask * 
1000), 1000);

         mutex_lock(&data->update_lock);
         data->target_temp[nr] = val;
@@ -2959,7 +2958,7 @@ store_temp_tolerance(struct device *dev, struct 
device_attribute *attr,
                 return err;

         /* Limit tolerance as needed */
-       val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 
data->tolerance_mask);
+       val = DIV_ROUND_CLOSEST(clamp_val(val, 0, data->tolerance_mask * 
1000), 1000);

         mutex_lock(&data->update_lock);
         data->temp_tolerance[index][nr] = val;
@@ -3085,7 +3084,7 @@ store_weight_temp(struct device *dev, struct 
device_attribute *attr,
         if (err < 0)
                 return err;

-       val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 255);
+       val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 25500), 1000);

         mutex_lock(&data->update_lock);
         data->weight_temp[index][nr] = val;

Thanks!

