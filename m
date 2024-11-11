Return-Path: <linux-kernel+bounces-403630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B076E9C384D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46681B2180C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 06:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DE915532A;
	Mon, 11 Nov 2024 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GGKZWmu6"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93A1EF1D;
	Mon, 11 Nov 2024 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731305972; cv=none; b=ShavnLVNqJGK6SGZLYhvmGiDLqvUuXmFQvJSN1fm6gYhvrkqiR9sHETeXvRE0ZHTT2CxTxfap/JdTQHkjRTJSnGGhXIjBgQm4Iw8Djw0NvPVq2FwqbPQE6CJpKzmDfTcgQHvWul1HTRpj/PTwaZjI3G8OTEFRP/mvbMrfxW4BYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731305972; c=relaxed/simple;
	bh=Lg53M/R7zkmgm7QVC7CbS+N0DQXZYxbKQDd8WKdmnsk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=sMIoeeNrs8RwsToqPXR8GlWMl/Su7ZCNBFWpCwgBdjMOrU1upa/Nvqhc6DTsxxtnRC43x92Hz5CweExLUR66rl+xSmRsGnjikH3+ATsiJgDqrPyI7Edu8Bk15JWT4T5tNz1Tg7xEGceXqwayacEckXYbjQnscVoYL+kvO2e2y3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GGKZWmu6; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.1.148] (unknown [222.129.38.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 51DF23F0A6;
	Mon, 11 Nov 2024 06:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731305960;
	bh=Lg53M/R7zkmgm7QVC7CbS+N0DQXZYxbKQDd8WKdmnsk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type;
	b=GGKZWmu6dQ70k0FFbTJ9462v2I6lIgVwcsHaNL8oRA8jQ6Bk1gyc8xTSApKZGSMMx
	 u7tIQaAhstgVj67fcozKcLvQfYueCxB5FZWF/gyH3MXr79HmJzeoxu8GLhpMBtYwFy
	 D5MVsSsqJlEDIQ6f1mhONisauv1rRPkB+jNWGA3d4R0sizaxKVw7kDFsiBm3BWC3Hv
	 kZpsjrJcBvSk6g6ySW58AUKtR5e25SdPvJRnnJ3HguR0xGLawuEiURzEGKZtqCegGe
	 /dIimnFApBcxbQZiS3BLhoPYvHwlyjouhKoNxgmQpwXR4Ly1/2z5wdoUTK0vxA+7ql
	 GtxVJrqSMfThA==
Message-ID: <da650a93-6d21-444b-adb7-045566f53d5a@canonical.com>
Date: Mon, 11 Nov 2024 14:19:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
To: even.xu@intel.com
Cc: bentiss@kernel.org, corbet@lwn.net, jikos@kernel.org,
 linux-doc@vger.kernel.org, linux-input@vger.kernel.or,
 linux-kernel@vger.kernel.org, rui1.zhang@intel.com,
 srinivas.pandruvada@linux.intel.com, xinpeng.sun@intel.com
References: <20241024081023.1468951-5-even.xu@intel.com>
Subject: Re: [PATCH v1 04/22] HID: intel-thc-hid: intel-thc: Add THC PIO
 operation APIs
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
In-Reply-To: <20241024081023.1468951-5-even.xu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Even,

It fails to be applied on v6.12-rc7.

There is no file intel-thc-hw.h.

Regards,
Aaron

