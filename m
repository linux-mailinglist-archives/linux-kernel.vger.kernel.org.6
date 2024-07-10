Return-Path: <linux-kernel+bounces-247550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E03392D110
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 255E5B21656
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC6B190671;
	Wed, 10 Jul 2024 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="X1f364aU"
Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E121CA87
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612484; cv=none; b=ZmWy2idpyevZCWabCRzjj7OSSApIv7U7T9MLBBBZwdisdX+y3Hx3/j+wUzM6v45GTZkp93QESwGteztVJhfPj8TfTkO0QILzwDmQJ9eGctwVWRnOsdMnkW2/xrtChQtbabqTZ7TmLb7BJTPcgkYu5i+J1hou7wdNbDIaaovvy10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612484; c=relaxed/simple;
	bh=Twloi0VAveO1nR+fq6Rhh/bRgb+cH0sQ0T9CWAOBpkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZb9luj/OnMUHCvwD3n4ykpIaAcRuAnLW6NKv/GCIef4EbyYoTwvp6dtK6thGKxL3f4uTTT7LVEb9pz+wgs7sVutgLGBRLsNJWis187V3lAFZRtzSP+ip7jcxJ4mJ5Dko/7DEM3pwnCDM2zivy28A4FX5E41ez6pEmbBC+sD1tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=X1f364aU; arc=none smtp.client-ip=17.58.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1720612482;
	bh=2WC+o3huJYBya3lQYNSk/LVID1dA5qUU6KR0QQmJY0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=X1f364aUm3n72HmClZn0gusFZGH8UyAmSoZl8Us+j7DJwnlIxXInZ+0o5vaV9b9dq
	 SYjoyhCBnZDktrUyZmO48/znbsDx0nJZJbuDcDNEzSyM2Ad9jmh9Zn05TH0KpVh8AP
	 XY2H7lqj2mw1Q9H1VJKOdhZVM/dvpP0CmnN9gOIItApEY0YU/165+byFk09knuoSXB
	 Acsh6/8zMVDJpvJ/6Bz1q5FGd5lPEkjKa8kea4BgiGwVbsRaUK4ENZzxOuHMwcSou/
	 pUhE4CPI7ycDfnb1SmHx0HoiT7gBmIC7KHlB5vkiGpoEKMhsaAXJUVcdJrWKuU3NwH
	 7shgVQ8hVNKug==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id DA38B50028A;
	Wed, 10 Jul 2024 11:54:38 +0000 (UTC)
Message-ID: <97c10434-daf0-4e98-977b-0dff3a330930@icloud.com>
Date: Wed, 10 Jul 2024 19:54:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver core: Fix size calculation of symlink name for
 devlink_(add|remove)_symlinks()
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240709-devlink_fix-v2-1-22254f1138e1@quicinc.com>
 <CAGETcx8ASLya0q-Kv_fN0ubdFv8vCh-ZDN4yRh=0kQUQ-dv0Xg@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <CAGETcx8ASLya0q-Kv_fN0ubdFv8vCh-ZDN4yRh=0kQUQ-dv0Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kPa__mK1To4Ml5llZ8PFrgi-eBp2lMYX
X-Proofpoint-ORIG-GUID: kPa__mK1To4Ml5llZ8PFrgi-eBp2lMYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2407100074

On 2024/7/10 02:03, Saravana Kannan wrote:
> On Tue, Jul 9, 2024 at 7:13 AM Zijun Hu <zijun_hu@icloud.com> wrote:
>>
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> devlink_(add|remove)_symlinks() kzalloc() memory to save symlink name
>> for both supplier and consumer, but do not explicitly take into account
>> consumer's prefix "consumer:", so cause wrong algorithm for calculating
>> memory size, fixed by taking into account consumer's prefix as well.
> 
> Again, this makes it sound like you are fixing some bug. No "wrong
> algorithm" is happening here. You are improving readability. So, just
> say that?
> 
okay, thanks for code review. what about below comments?

devlink_(add|remove)_symlinks() kzalloc() memory to save symlink name
for both supplier and consumer, but do not explicitly take into account
consumer's prefix "consumer:", so cause disadvantages listed below:
1) it seems wrong for the algorithm to calculate memory size
2) readers maybe need to count characters one by one of both prefix
   strings to confirm calculated memory size
3) it is relatively easy to introduce new bug if any prefix string
   is modified in future
solved by taking into account consumer's prefix as well.

you maybe correct it, i would like to use that corrected.

> -Saravana
> 
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>> Changes in v2:
>> - Correct commit message and add inline comments
>> - Remove fix tag
>> - Link to v1: https://lore.kernel.org/r/20240707-devlink_fix-v1-1-623acb431cd8@quicinc.com
>> ---
>>  drivers/base/core.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 2b4c0624b704..51209db7ff84 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -572,7 +572,11 @@ static int devlink_add_symlinks(struct device *dev)
>>         len = max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
>>                   strlen(dev_bus_name(con)) + strlen(dev_name(con)));
>>         len += strlen(":");
>> -       len += strlen("supplier:") + 1;
>> +       /*
>> +        * we kzalloc() memory for symlink name of both supplier and
>> +        * consumer, so explicitly take into account both prefix.
>> +        */
>> +       len += max(strlen("supplier:"), strlen("consumer:")) + 1;
>>         buf = kzalloc(len, GFP_KERNEL);
>>         if (!buf)
>>                 return -ENOMEM;
>> @@ -623,7 +627,7 @@ static void devlink_remove_symlinks(struct device *dev)
>>         len = max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
>>                   strlen(dev_bus_name(con)) + strlen(dev_name(con)));
>>         len += strlen(":");
>> -       len += strlen("supplier:") + 1;
>> +       len += max(strlen("supplier:"), strlen("consumer:")) + 1;
>>         buf = kzalloc(len, GFP_KERNEL);
>>         if (!buf) {
>>                 WARN(1, "Unable to properly free device link symlinks!\n");
>>
>> ---
>> base-commit: c6653f49e4fd3b0d52c12a1fc814d6c5b234ea15
>> change-id: 20240707-devlink_fix-0fa46dedfe95
>>
>> Best regards,
>> --
>> Zijun Hu <quic_zijuhu@quicinc.com>
>>


