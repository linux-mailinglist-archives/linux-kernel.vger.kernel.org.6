Return-Path: <linux-kernel+bounces-315284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 582B296C06A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF7428EF7F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F401DA62C;
	Wed,  4 Sep 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="DsGUwLNx"
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B341DB925
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460011; cv=none; b=P27mkCrFn9c8BKVHuk2s30WHB+ik1L4c+6dMZKk+TBgFloIRrHGlH+GXE6FGWWnzhNsXCMXqV+8jyglVcbYXBjsVigs0UuLONwLsZGO0zZX+vzInnb0b59X3bNYRExWC3EXIVcPohfuA+BOoyTfJAMFZJIr+7bQ9WGbE0MAfgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460011; c=relaxed/simple;
	bh=NTobsPyQnRSqRRQDbFR8HB9nbopBtYezx/kSPuJ5qgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPNFzwSIPBkKQ27NlD0qait0MhAM43/p/RNhPSE83jfeJ61PxhDB6YEKe9z0y/3U6KjbYiNi1PS3sWzevuDS8eDGmbczMx9HAB5GFD1tEBq1TplMJNUDGnUAk+4w6RsqpgFD2tpUPArTJZORQgXYrc61RJtX+sWnfX7fQqSbIm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=DsGUwLNx; arc=none smtp.client-ip=17.58.6.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725460009;
	bh=+DToCl5HwcApbAbhFLBWz4JkPhSklG1aL9LG4PbnRls=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=DsGUwLNxBK8nQIf/ygjjPnK/px8py9sXpjyhiEkMQ5tuVUlNiCtGhfEX/CL/jnUVl
	 6KVktKk+HMZhYrOnhdFFp50bO8FIwFg95PHE3lqx44CI9lO6KIAOIThPF40VhUK/nB
	 /7fuMftQGij1pAFVRJ2Udr9CCntoGrj7EnuEC90wAKihFkzBVBnFr0HTx+qKP0wyzd
	 /hskx/9kwl6vwx01eKAMEx9PVyvXMHI0/ZWDlCqu6Bol2k6m/M9dB/V/l0Edx1jZoH
	 NyZSwGpviRLR3gFvjaHrj9TS4bqXNXsj16jpG2kxRKt7i59BRYaHee3+dfSUTUc/Ib
	 Ls3SUAOktuLjQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id 8486880332;
	Wed,  4 Sep 2024 14:26:43 +0000 (UTC)
Message-ID: <1b79fb55-26d7-4966-9260-d3cdf3e0e8c8@icloud.com>
Date: Wed, 4 Sep 2024 22:26:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] driver core: bus: Correct API bus_rescan_devices()
 behavior
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240904-bus_match_unlikely-v1-0-122318285261@quicinc.com>
 <20240904-bus_match_unlikely-v1-3-122318285261@quicinc.com>
 <2024090403-viewing-snagged-4249@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024090403-viewing-snagged-4249@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0pAOKhYlda1FM6ic_pc1-QytuXAu1u6X
X-Proofpoint-ORIG-GUID: 0pAOKhYlda1FM6ic_pc1-QytuXAu1u6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_11,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2409040109

On 2024/9/4 21:54, Greg Kroah-Hartman wrote:
> On Wed, Sep 04, 2024 at 08:56:44PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> API bus_rescan_devices() should ideally scan drivers for a bus's devices
>> as many as possible, but it really stops scanning for remaining devices
>> even if a device encounters inconsequential errors such as -EPROBE_DEFER
> 
> -EPROBE_DEFER should not be an issue for scanning the bus, that's only
> for probe errors, so who is returning that mess today?  Let's fix that
> up please.
> 

drivers/amba/bus.c:
struct bus_type amba_bustype = {
...
        .match          = amba_match,
...
};
amba_match() may return -EPROBE_DEFER.

you maybe also look at below AMBA bus related commit.
Commit: 656b8035b0ee ("ARM: 8524/1: driver cohandle -EPROBE_DEFER from
bus_type.match()"

is it proper to change bus_type match()'s return value type to bool type
back if this issue is fixed?

> thanks,
> 
> greg k-h


