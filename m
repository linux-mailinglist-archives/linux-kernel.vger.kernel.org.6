Return-Path: <linux-kernel+bounces-360986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB03499A212
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B711F228EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9EB212F1A;
	Fri, 11 Oct 2024 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="WChkfWgO"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C720CCE8;
	Fri, 11 Oct 2024 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644127; cv=none; b=gFvmCwyv+sgkq7q2ZeQw/a8natAYK/tmFExjL1a5FMTH+AEW9hUYbzad8v8abgqHLHOS/k/MOC2xsjQC0OfWB//z9wn9x76HuRoZT2Hf/zNY4HUKLoyDw8uSIJqmdIvLmFVXNV7w2pykFSZMgew/pf5jUKZGGGgr9TPwpDi6Ud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644127; c=relaxed/simple;
	bh=OJGaJrmrtlx3s4Za6+e7AvFAQaEsCnVez6TXdZlxn5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTCx+WH8/EscjYl0H5lfzo5uyM5U4tHBbjfSs9PzXk9RHvlecYTirRlhyaUFFiRC84SjMmnoYFxeOtRfCEYt5JrKv3SQ7NwKRccPmMduOr0piBx1Z+D/ytS2k3ySx3BnGfcQjtCsK6fZ+s1sLxFgntlavA6Izqd6O87JX9MfJNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=WChkfWgO; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728644117; x=1729248917; i=wahrenst@gmx.net;
	bh=OJGaJrmrtlx3s4Za6+e7AvFAQaEsCnVez6TXdZlxn5c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WChkfWgOxGeDLC4pM/r/TsPgBRdy29Fq23yoAvxy2iWGjA7px2ot9iAn6SUslbSE
	 RVL7l7clqKIhORLLzbIeiO7+dEMqo/Cpa0K1nrK6t8gxr01Cmz+3lfZ3WlurTkU8T
	 okyOkWDKJcWdIwoGYf0EL0iZ/k0cXjrVIh44/cpZdcrXyCJCn2txuwuOwDzK0BIjV
	 /cd7DoFIrn+W4BglatvW0C95vmO2GcDrLsn5syj8NyTd6IFUF3DBGhvw/w3CTlKRw
	 U7AsjzTjl2+9WxRycnmwbifHjz0o3ooAwuskwnfqwNCiu6kI/LFhvIbw7GJZPpOnR
	 ergtICXwcq5sW/uu0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0XD2-1tvjIe3ZUS-00rlNp; Fri, 11
 Oct 2024 12:55:16 +0200
Message-ID: <eccb2f7b-b8e8-4530-895f-915f97ff2d37@gmx.net>
Date: Fri, 11 Oct 2024 12:55:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] staging: vchiq_core: Indent copy_message_data() on a
 single line
To: Umang Jain <umang.jain@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20241011072210.494672-1-umang.jain@ideasonboard.com>
 <20241011072210.494672-6-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241011072210.494672-6-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:v+5Lb8sX71l2dSIO2AMKkNDINhCis6eJ/x9YLCXBXcGr9pXX873
 SYlWFw9spb2kLM3bNRmlbmFBQvGA00uKwQ3n8FKEBeeSFDUN/VNOA/VwjOnE/7LZsqzQ4k5
 grwBDcaETfrvAhwR5h9M3N7lXYeBVKlZv1w3UGEssFSpjBurJqbqqSewNV7SEhgl8Ri++SO
 8htgUFS5ek19/sW0e1z5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/Q9XdaBW4i8=;BDiejXyfGFT6dqYsZYeyw/8pvo3
 Axgc8DHpRynoTk2Bvhp2YBzrqr/vqLpjNFay9Wr0iKF94eb31TC2SrBm1Zdbbe5FulntjGksh
 pMVa135hajNi1DJbn9S4vvhazAlKwHSchgwbwqdxNSHSsCau0VZGal1/qrWyVAyf5ECv7r0Ln
 WbyyqwQCUGCvBlzTsX5IUOWh0HCEmc7N1WOpDCvgaeJrNqfe0FLG04BlDxZ+tecoHiogQIdQB
 A205key+9Ddr0rJfapZYfyCL7Goo81hz9q8ZMMNU+pSIRwllS3uwkB8GmJ71B2zereN/diLmc
 UPTBKOagFhqdCJns3OxfB+UlZsQFBtYI/Wusd+LyR/5gSQIruH9TCErWcOQKryjbAnYX+cCdf
 fuAdY0U+J9r1ebu5wV64IEeIzWOqcXlPWj5REAh96SHgEHtvhVGnZfJ1/TKKA+otfZVBQMznS
 wR0w1T8b9n0t34J77I7ie4B56uHwXaDPypL9SBfTKHMn4t6gxEq0sVCtARvGVFqlkVqPBaXUh
 Ay4Vdi3tGY6i3L0L0AYKpK39FB9a5ObgrSIC8qxLKeMG8QcjVse6mWV5+KJVyGSjJQwp2TTsn
 GAJm/l1tqSZCPWifQdskHiGGDQNDTEQKtf9sinLi35VPkXgMsvI41e8euc1yN8eNLBWXUneo5
 tVN9kNd1whMXpCr04Cd9lpa6iqVBgjHgkcEBd16Jjss01kNRY1QxXFDN2lw+FV+zgYif6ML9p
 +gAcJeMrdqFdCPFeMAds2VDVQlRbjY/Tlez/qWZ5SBn5gxrl6khx9lcer7VVKxlLiXy76X45n
 ReyPkH2awanZUEXc+caQgPKQ==

Am 11.10.24 um 09:22 schrieb Umang Jain:
> Fix the copy_message_data() indentation in queue_message_sync().
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

