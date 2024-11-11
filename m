Return-Path: <linux-kernel+bounces-403671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E231E9C38DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B76B21431
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6840C158533;
	Mon, 11 Nov 2024 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jVnOqObA"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0347015699D;
	Mon, 11 Nov 2024 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308869; cv=none; b=cfgZocfRoflWMgtTLw+0jvDa8xkIZikexRUaryrkXxS347nUi33+0YMOWotytDb7wIEXeKCNkpL3OTrih295LlMLTGt2jRMrcOtak2d2z3DujhQUVsSA1y+PWrtRGfwCMkcrrpt9IdgmZFbbBvSr2GM9P35WVtGEAWlWJ6bBPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308869; c=relaxed/simple;
	bh=aEYEXc57dK33w/1qt7cmXZbV8lMovsU9PyhUIlBtImI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0iJon5PYnKTEgZUhpr8Mb+as9LBSzKi/tlDwLT4cYqKsRr9+f5MHBV8yK2wlP/0FRcgp7rcSzmdcfghLztq4Es1amWJ178LuDxQb9dh/sdGe3/WN+ILFllJnFKt3Zgo4fnJ+fAmQYpdeLPbFA8mwRqDqs5Jq+dQRJAmw22ZSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jVnOqObA; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.1.148] (unknown [222.129.38.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C2A2A3F189;
	Mon, 11 Nov 2024 07:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731308864;
	bh=aEYEXc57dK33w/1qt7cmXZbV8lMovsU9PyhUIlBtImI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=jVnOqObAErp3SFP3KpGLQcTp+YtU1zAqoXnu7zMWt4FOArT78YGzhfFekZNH56LSd
	 zmH1sLila3ly6JzW3GoxsL9ox9lhh7uvDoNAQb+vWy0E8+yaKsdN3hoK0LUEV71b8e
	 7dZxiek2T64DB9rHHHBpa4HWtM6LJaLjxlEF1YEMpNzsYxRzg9AyHYdpdqJPOZ+WqB
	 Wj11dUmw9HHQOoaKL2gUBxzKLliznvb+3/w3k3HSQ45W5hCHJC8rX7UmVQq5Qs/UQu
	 e5HnAEXUFWQKQQiP9FRmTrdHZZziEPnf59IkFSnorN3l+9csBQBs30bFFBocT+7Bux
	 KsAxy3d6Qc+5w==
Message-ID: <1a8f80ab-135e-4e57-b9b7-1940e4bfb4f3@canonical.com>
Date: Mon, 11 Nov 2024 15:07:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v1 04/22] HID: intel-thc-hid: intel-thc: Add THC PIO
 operation APIs
To: "Xu, Even" <even.xu@intel.com>
Cc: "bentiss@kernel.org" <bentiss@kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "jikos@kernel.org" <jikos@kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Zhang, Rui1" <rui1.zhang@intel.com>,
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
 "Sun, Xinpeng" <xinpeng.sun@intel.com>
References: <20241024081023.1468951-5-even.xu@intel.com>
 <da650a93-6d21-444b-adb7-045566f53d5a@canonical.com>
 <IA1PR11MB6098D581A332E576528FD30DF4582@IA1PR11MB6098.namprd11.prod.outlook.com>
Content-Language: en-US
From: Aaron Ma <aaron.ma@canonical.com>
Autocrypt: addr=aaron.ma@canonical.com; keydata=
 xsBNBFffeLkBCACi4eE4dPsgWN6B9UDOVcAvb5QgU/hRG6yS0I1lGKQv4KA+bke0c5g8clbO
 9gIlIl2bityfA9NzBsDik4Iei3AxMbFyxv9keMwcOFQBIOZF0P3f05qjxftF8P+yp9QTV4hp
 BkFzsXzWRgXN3r8hU8wqZybepF4B1C83sm2kQ5A5N0AUGbZli9i2G+/VscG9sWfLy8T7f4YW
 MjmlijCjoV6k29vsmTWQPZ7EApNpvR5BnZQPmQWzkkr0lNXlsKcyLgefQtlwg6drK4fe4wz0
 ouBIHJEiXE1LWK1hUzkCUASra4WRwKk1Mv/NLLE/aJRqEvF2ukt3uVuM77RWfl7/H/v5ABEB
 AAHNIUFhcm9uIE1hIDxhYXJvbi5tYUBjYW5vbmljYWwuY29tPsLAdwQTAQgAIQUCV994uQIb
 AwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDNxCzQfVU6ntJ9B/9aVy0+RkLqF9QpLmw+
 LAf1m3Fd+4ZarPTerqDqkLla3ekYhbrEtlI1mYuB5f+gtrIjmcW27gacHdslKB9YwaL8B4ZB
 GJKhcrntLg4YPzYUnXZkHHTv1hMw7fBYw82cBT+EbG0Djh6Po6Ihqyr3auHhfFcp1PZH4Mtq
 6hN5KaDZzF/go+tRF5e4bn61Nhdue7mrhFSlfkzLG2ehHWmRV+S91ksH81YDFnazK0sRINBx
 V1S8ts3WJ2f1AbgmnDlbK3c/AfI5YxnIHn/x2ZdXj1P/wn7DgZHmpMy5DMuk0gN34NLUPLA/
 cHeKoBAF8emugljiKecKBpMTLe8FrVOxbkrazsBNBFffeLkBCACweKP3Wx+gK81+rOUpuQ00
 sCyKzdtMuXXJ7oL4GzYHbLfJq+F+UHpQbytVGTn3R5+Y61v41g2zTYZooaC+Hs1+ixf+buG2
 +2LZjPSELWPNzH9lsKNlCcEvu1XhyyHkBDbnFFHWlUlql3nSXMo//dOTG/XGKaEaZUxjCLUC
 8ehLc16DJDvdXsPwWhHrCH/4k92F6qQ14QigBMsl75jDTDJMEYgRYEBT1D/bwxdIeoN1BfIG
 mYgf059RrWax4SMiJtVDSUuDOpdwoEcZ0FWesRfbFrM+k/XKiIbjMZSvLunA4FIsOdWYOob4
 Hh0rsm1G+fBLYtT+bE26OWpQ/lSn4TdhABEBAAHCwF8EGAEIAAkFAlffeLkCGwwACgkQzcQs
 0H1VOp6p5Af/ap5EVuP1AhFdPD3pXLNrUUt72W3cuAOjXyss43qFC2YRjGfktrizsDjQU46g
 VKoD6EW9XUPgvYM+k8BJEoXDLhHWnCnMKlbHP3OImxzLRhF4kdlnLicz1zKRcessQatRpJgG
 NIiD+eFyh0CZcWBO1BB5rWikjO/idicHao2stFdaBmIeXvhT9Xp6XNFEmzOmfHps+kKpWshY
 9LDAU0ERBNsW4bekOCa/QxfqcbZYRjrVQvya0EhrPhq0bBpzkIL/7QSBMcdv6IajTlHnLARF
 nAIofCEKeEl7+ksiRapL5Nykcbt4dldE3sQWxIybC94SZ4inENKw6I8RNpigWm0R5w==
In-Reply-To: <IA1PR11MB6098D581A332E576528FD30DF4582@IA1PR11MB6098.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Even,

Sorry, my fault.

The patchset is applied on 6.12-rc7.
Building, will let you know the test result.

Thanks.
Aaron

On 11/11/24 2:31 PM, Xu, Even wrote:
> Hi, Aaron,
>
> Thanks for the information.
> The file "intel-thc-hw.h" should be there, it was added by "[PATCH v1 03/22] HID: intel-thc-hid: intel-thc: Add THC registers definition".
> I tested it on v6.11.
> Anyway, let me double check what's wrong and come back to you.
> Thanks!
>
> Best Regards,
> Even Xu
>
>> -----Original Message-----
>> From: Aaron Ma <aaron.ma@canonical.com>
>> Sent: Monday, November 11, 2024 2:19 PM
>> To: Xu, Even <even.xu@intel.com>
>> Cc: bentiss@kernel.org; corbet@lwn.net; jikos@kernel.org; linux-
>> doc@vger.kernel.org; linux-input@vger.kernel.or; linux-kernel@vger.kernel.org;
>> Zhang, Rui1 <rui1.zhang@intel.com>; srinivas.pandruvada@linux.intel.com; Sun,
>> Xinpeng <xinpeng.sun@intel.com>
>> Subject: Re: [PATCH v1 04/22] HID: intel-thc-hid: intel-thc: Add THC PIO operation
>> APIs
>>
>> Hi Even,
>>
>> It fails to be applied on v6.12-rc7.
>>
>> There is no file intel-thc-hw.h.
>>
>> Regards,
>> Aaron


