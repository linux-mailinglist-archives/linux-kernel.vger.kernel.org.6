Return-Path: <linux-kernel+bounces-449342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3249F4D71
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD80188BEA6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AAB1F4E23;
	Tue, 17 Dec 2024 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="WoxMt3X0"
Received: from mr85p00im-ztdg06021101.me.com (mr85p00im-ztdg06021101.me.com [17.58.23.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8C1DA109
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445126; cv=none; b=caDaVNlAfF8xgG6nsSqTX4TPwE7gIxNxy7s49cUDNzHrYPK3wY24aRuBvv1tThMm51Ps8/ArsA+D42IWAU5UVVWXW3CfU9TSsyvHAIdQ1YsMHX0iJfSM6S8brW9YtY97JoLy3qKwoJ2OOb7A0+cUiIOQUd5Q9T4ihQNZDqTLWJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445126; c=relaxed/simple;
	bh=UG6LainriFkiBnj+sJIx0zlKQPDUOkaWSEVBTTLHy8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FeS6Q4KhdnSkFHRkSYVEgp/xr4JLVeIjDkJEHUMKBcDZdg+dEA+HgJXQ/4XoUQSbGSUkFYZdI/zzSk3yVdVGIqEQKJi1QMVjcz+bqjRZdui28CFr9zUzizFPxVwRX399d+qpFNrvahnl5KDyWYmNSKPhssSY3cJAS5YqZILgxHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=WoxMt3X0; arc=none smtp.client-ip=17.58.23.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734445124;
	bh=S+r2GcvyoSTCB5KXzmot6sGtLm8jwHycQaueJf++avw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=WoxMt3X0rQk7c9urbte3klLi3gDi4CCq+/fTy32T2/09NTfcjqtP0Ut1TgfZowFEU
	 TbsOo1zYB7pFa7RVWabXP7R6PvbaWYSq3S3OGJAbYtlHvpB/saaDR1eR8FBA5nG3Fw
	 lQ4/f/I/XhYtDWVPfWC8cC35tCFT+8SYOWGafESKS2PUKQcP6y1mpCHxDOuo+8/7PU
	 1FFNySYnFn37BFmqChjdG/z5Rzefe0XpJpr47+mJUuxwDsgj0tOxhnXKLroxqJlkJG
	 /jik/f5Wh7auc9dK9y0cpbK2+hxdbpTYKOO+o7nQ1pkCkv5oeLK6UB2bvWJ192Ruvv
	 8QTFyh8Gkf0lw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021101.me.com (Postfix) with ESMTPSA id C1D67802A0;
	Tue, 17 Dec 2024 14:18:37 +0000 (UTC)
Message-ID: <2b0fe939-03aa-4c84-bfd9-b91edc9bfcb8@icloud.com>
Date: Tue, 17 Dec 2024 22:18:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] driver core: Correct parameter check for API
 device_for_each_child_reverse_from()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
 Boris Burkov <boris@bur.io>, Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-cxl@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
 <20241212-class_fix-v3-7-04e20c4f0971@quicinc.com>
 <20241216152310.0000166a@huawei.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20241216152310.0000166a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fVg2wWx8yViUVGExoSBMdgb0UqFXAsrW
X-Proofpoint-GUID: fVg2wWx8yViUVGExoSBMdgb0UqFXAsrW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_08,2024-12-17_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 mlxlogscore=810 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170113

On 2024/12/16 23:23, Jonathan Cameron wrote:
>> Correct the API's parameter @parent check by (!parent || !parent->p).
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Given that 'from' implies continuation of an iteration I can see why
> it might not ever be relevant to check parent.  It's harmless, but to
> my mind unnecessary.

the extra check !parent has no overhead and make this check consistent
with others in the cluster. (^^)

