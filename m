Return-Path: <linux-kernel+bounces-407699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 398309C713C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E596A1F222DA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A7B204012;
	Wed, 13 Nov 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Pny72/1J"
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC82003D8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505444; cv=none; b=apEL8Kzfc+OQCzIiEBqt24DlMCjA0hfTH3L7nJDxP1j0BVb99sL9hnTDxKZ7nXsjeU+5crmAui/c6CdCoUGNOKbGUEzli64Uqs1+IUmz+l9pBACddEmO09X2SFZSAsE3qcDybBg4Jj3QCtescqdT2J0EqmzxX36ybc1U3PVsYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505444; c=relaxed/simple;
	bh=E6SufiaT/IjBWLmUK8oM6ceTReFX/bP6WwRsNM1if6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MchoD0I7VApsrVQo5vWsOGy8OpBtxnrS8ESSNahQ2pD6bJ3ZyVkDR/jwEyWM/wzRLnGwPt68lzaOhFXoTGVguMjH2293E+A9TgYcngKRxLY7Y5rUSGXiDTpec6avOPzJqQVfDEY810r4dvcucMBt5oj1IxueM+OWR3wmKr5R9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Pny72/1J; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731505441;
	bh=Ayxk7fKf8jvcZbZqlJ51YdAFB0LJAT0d6aO7ywet5ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=Pny72/1Jbe+lyShhzG67QpiF5zgwijcWST6NwtBI02rffGRpPyRKjfexbYP6FHVVD
	 M1Wsr+9bUr/J+4SXNrNxw5AplHh4j21l6NSuGuFQt5vknGT63iutuyxXfajFumtIkw
	 PgkkOGB7Qj/gch6IyHXPG9wLiqIA8oYAHsoYZde6Al/PORpGeOY5Oi914+irRNrTAt
	 yYhc0SxYC4+Z4AC5lErA+JYD4pgBGVv95U6+fDUdyDQKF6zNS4bXDp2Y4WCLPkQA35
	 BeqB1NPEktjrobU1SmUoPeTESBkz+sBIK0gNt1XCSuB0ZZbAo6mi0opY6J949QVSes
	 +rv8VTBd8oe3g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id A2068D00081;
	Wed, 13 Nov 2024 13:43:57 +0000 (UTC)
Message-ID: <beebf034-f2a6-4451-b68c-2f23f8dc92ec@icloud.com>
Date: Wed, 13 Nov 2024 21:43:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 0/2] driver core: bus: Fix issues related to
 bus_rescan_devices_helper()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241022-bus_match_unlikely-v2-0-1a6f8e6839a0@quicinc.com>
 <2024111228-snowcap-counting-b833@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024111228-snowcap-counting-b833@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: O065zpPQ_UrAq4P1rcOFMJ6QerOfguop
X-Proofpoint-ORIG-GUID: O065zpPQ_UrAq4P1rcOFMJ6QerOfguop
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411130117

On 2024/11/12 19:48, Greg Kroah-Hartman wrote:
> On Tue, Oct 22, 2024 at 07:18:00PM +0800, Zijun Hu wrote:
>> This patch series is to fix issues related to bus_rescan_devices_helper().
>>
>> The function is improperly used for 2 incompatible scenarios as
>> explained below:
>>
>> Scenario A: scan drivers for a single device user specify
>>  - user may care about precise synchronous scanning result, so the
>>    function can not collapse error codes.
> 
> I do not understand this, what is wrong that this is fixing?
> 

for scanning drivers for single device, it gives user wrong scanning
result(success or failure).

patch 1/2 is a concrete example.

>> Scenario B: scan drivers for all devices of a bus
>>  - user may need to scan drivers for a bus's devices as many as
>>    possible, so the function needs to ignore inconsequential error
>>    codes for a device in order to continue to scan for next device.
> 
> How often is that needed?  And why can't that still work with the
> existing code?
>

1) API bus_rescan_devices() invokes it and can't achieve its design
purpose due to error described above.

2) as shown by recent mainlined commit, usage of API
bus_rescan_devices() have been dropped due to some bugs.
Commit: 3d6ebf16438d ("cxl/port: Fix cxl_bus_rescan() vs
bus_rescan_devices()")

3) there are only 2 usages for the API now.
// does not do what the comments say
https://elixir.bootlin.com/linux/v6.11/source/drivers/pcmcia/ds.c#L725
// do multi repeated iterating, can be simplified if fix the API bugs
https://elixir.bootlin.com/linux/v6.11/source/drivers/hid/hid-core.c#L2967

4) i have more reply in below link about the API's bugs.
https://lore.kernel.org/all/20240913-bus_match_unlikely-v2-2-5c0c3bfda2f6@quicinc.com/

we may go to patch 2/2 to continue discussion.

> thanks,
> 
> greg k-h


