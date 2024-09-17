Return-Path: <linux-kernel+bounces-331633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F88F97AF38
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3132D28751A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481221547E6;
	Tue, 17 Sep 2024 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="f7d4csEi"
Received: from qs51p00im-qukt01071702.me.com (qs51p00im-qukt01071702.me.com [17.57.155.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E9A1BC41
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726570979; cv=none; b=WcQgGW36dE0GynZ3XcnulwcmZKmR5BhD2lQCDng9rp83sRnEaYT1t18VVw/P1vbzyrmz+ooBXBkhx4Fn01X6s7wTfEY8uJEOwIQnehgwus/2lk+nC4c2SlAQAn08uGNCAJ3sLDP5x71tOtdApQb4d4bglaO0V+OEy3LcI8GP8WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726570979; c=relaxed/simple;
	bh=+B0c/QMAklB3h8JYBEZju8mHxfN5K2/6NAUqdJCW3XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyNn72hxFkkjtKUoWOphzGmJrmhFC6OhvmPgWfGMTWtN6qSoezoTdyjICFIGTVi7wzCkaOViHpxaC4+TzqhDQ48YmhJcyWryPwSFFJ/kIlVAgUBf8kqu+cwNyrM2Hw/GuCYLjaI/Pm9ffWBg6diGmR6sHB1nYadRz/0Ap3chi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=f7d4csEi; arc=none smtp.client-ip=17.57.155.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726570977;
	bh=wQp9W0C9HvXVILgEa9rTmn5kH5GQ3PbomengBiIPFNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=f7d4csEiidsjF9On/FwxSK4fbuHuhO3VYgpZ3s5ZbKLoHzWQIEfP92Ch0LQH0zn9/
	 zdwNt7GJrp5AZ3h0Dws8nSWGyVEFWBAi2E4TxzcBsXy7mPbzlD1A2nidATatkntNDo
	 u9wx+yAs9o8gE0wHnE5hOjD2MflQqwDoZbmcECGvmkzVHveE5S1eY2qkD4iFeDHrgD
	 rwApR0MX3i0Jw298QvrsXSKfJs0i5B+TfFc8v0ikx0E0T/G5ldalBJ6CmswrruEl+x
	 Rdn7VovNMC4CEVTv2ISggaxjS5r+ewiWqQPy5qCnLELZZWJ8wxEJ5QxJg8JM3qZBD9
	 klBKvVtkhqFRw==
Received: from [192.168.1.26] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071702.me.com (Postfix) with ESMTPSA id 3DA2F35002B1;
	Tue, 17 Sep 2024 11:02:51 +0000 (UTC)
Message-ID: <ac98845a-2461-4098-a162-0edea662d71c@icloud.com>
Date: Tue, 17 Sep 2024 19:02:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] amba: bus: Move reading periphid operation from
 amba_match() to amba_probe()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
 <ZulRbGQf1b+Gy2Ox@shell.armlinux.org.uk>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <ZulRbGQf1b+Gy2Ox@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PWCzSPIcJQdpCa5c-AZ0tFWTcRxKs42g
X-Proofpoint-GUID: PWCzSPIcJQdpCa5c-AZ0tFWTcRxKs42g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 spamscore=0
 mlxlogscore=881 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409170079

On 2024/9/17 17:52, Russell King (Oracle) wrote:
> On Mon, Sep 09, 2024 at 07:37:31AM +0800, Zijun Hu wrote:
>> This patch series is to make amba_match(), as bus_type @amba_bustype's
>> match(), also follow below ideal rule:
>>
>> bus_type's match() should only return bool type compatible integer 0 or
>> 1 ideally since its main operations are lookup and comparison normally.
>>
>> Which has been followed by match() of all other bus_types in current
>> kernel tree.
> 
> How does this work with e.g. udev module loading? If the ID isn't
> known until we attempt to probe a device, then if all AMBA drivers
> are modular, there'll be no drivers registered to cause an attempt
> to match a device to a driver, and thus there will be no
> peripheral IDs for udev to use to load modules.
> 

drivers/amba/bus.c have registered a empty AMBA driver @amba_proxy_drv
this change makes AMBA device without valid periphid ONLY match with
the empty driver, that will trigger trying to read periphid with
bus_type's @amba_bustype's amba_probe(). it will send AMBA device adding
uevent once periphid is read out, then udev will notice the uevent and
perform further actions.


