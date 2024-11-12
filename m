Return-Path: <linux-kernel+bounces-406096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFF19C5AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08E82823A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81181FF050;
	Tue, 12 Nov 2024 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="j5+6yYWc"
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4131FF039
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423105; cv=none; b=nTv/MLuinnpyy3RDl4eBuP1Cb87rCTfr12agzxIAjGNRTjo4DlGiO+qB9j3o+9TQ5LXvA46Xs9Ox0bG9P7aNwB6eO5tk5M9KXqTvrNucED1bqj8OSbN+4NXlMEPJ8wvXt30QlQ2xU7Cfn8BII5dMvZlebU3HTChNrnQhMaRtQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423105; c=relaxed/simple;
	bh=cnFTCrNHTZ0oqP7oWQdSuORcvJ7CSPnfCRJKOfwrbP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYzX1mBRz3ZQLvxldeLhm5uCmuDqvpyt/3f9se4I9fqpwMDSCjzs4pMWY8Vuf4V3v2CgUHvGGEtHPWAlaAx3CY29apbbDVVNd5eoz+Fb9kv1ndPqZAYFNHqrDNXizlqEuPEZouCiPhENJ2GtXJDjO6vnFflluketb2W3h5baRqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=j5+6yYWc; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731423103;
	bh=lhw7gLuX5PSbNju25BD4nqQppSgpS4xwSxhlDI2syaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=j5+6yYWcIpYp7WBDvsK8QTPrj2Zla2cFP0xjaJhlbrv/dDGh9jk25lbpaHw3WMwmw
	 JjzLVzR90FJjZ0djFwMtkkJ8EpzNQli4JrcLZEdHnSegsQv4lmt4xjFs1A1IK1LbaI
	 d7+TfW0N2sVIqd4JAEGW8i1Et8yxDdHe8OzW0nmEnglax/iqpDc697jSsebztqjb3y
	 bXaYk6Q201rsjgVujqoTG2wkcwkUTjqi32VtudRpberR6m8MJ0UBV1APTauPMXBeDz
	 xyrp3jG1QEdjJHxmXHjDfUtWGxlynTP6/vkmuS2LyUNOxFFmhXjeQRASh2/4r5SuIq
	 xrSpfZXdbZiww==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 8D8FCD002B9;
	Tue, 12 Nov 2024 14:51:39 +0000 (UTC)
Message-ID: <2824dfcd-0f8d-4d5e-a687-9b0398ba1458@icloud.com>
Date: Tue, 12 Nov 2024 22:51:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] driver core: class: Delete a redundant check in APIs
 class_(for_each|find)_device()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241105-class_fix-v1-0-80866f9994a5@quicinc.com>
 <20241105-class_fix-v1-3-80866f9994a5@quicinc.com>
 <2024111230-diabetic-stubbed-102b@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024111230-diabetic-stubbed-102b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nVX73SZH8YtkDraQrJsATGDIvw7NcwPf
X-Proofpoint-GUID: nVX73SZH8YtkDraQrJsATGDIvw7NcwPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=898
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411120119

On 2024/11/12 19:45, Greg Kroah-Hartman wrote:
> On Tue, Nov 05, 2024 at 08:20:24AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Delete redundant check (!@class) in both API class_for_each_device() and
>> class_find_device() with below reasons:
>>
>> - The check is covered by later check (!@sp).
>> - Callers are unlikely to call both APIs with NULL class argument.
>> - Make parameter check consistent with all of other class APIs.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/base/class.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/base/class.c b/drivers/base/class.c
>> index e81da280af74..120d3aeb52fe 100644
>> --- a/drivers/base/class.c
>> +++ b/drivers/base/class.c
>> @@ -408,8 +408,6 @@ int class_for_each_device(const struct class *class, const struct device *start,
>>  	struct device *dev;
>>  	int error = 0;
>>  
>> -	if (!class)
>> -		return -EINVAL;
>>  	if (!sp) {
>>  		WARN(1, "%s called for class '%s' before it was registered",
>>  		     __func__, class->name);
> 
> Now, if I pass in NULL for class, I get an odd warning, AND the kernel
> crashes with the dereference of class->name.
> 

yes. you are right.

i did not notice "class->name" in warning message.

> So this is not ok :(
> 
>> @@ -456,8 +454,6 @@ struct device *class_find_device(const struct class *class, const struct device
>>  	struct class_dev_iter iter;
>>  	struct device *dev;
>>  
>> -	if (!class)
>> -		return NULL;
>>  	if (!sp) {
>>  		WARN(1, "%s called for class '%s' before it was registered",
>>  		     __func__, class->name);
> 
> Same here, this change is going to break things if people get it wrong,
> please leave both of these as-is.
> 

okay. agree with you.

> thanks,
> 
> greg k-h


