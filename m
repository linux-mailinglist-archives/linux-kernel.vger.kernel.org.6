Return-Path: <linux-kernel+bounces-203853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C42618FE142
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67144B24316
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050B713C8E0;
	Thu,  6 Jun 2024 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iTaJJJdi"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5AB3C28;
	Thu,  6 Jun 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663268; cv=none; b=Dmwhgn6/sb+ea8CX80/F3hwSLR/+iYfVWoZaP1mHCTC6lhg5VO0oP2LRF22TD7QJHkGPHOW7uJRdh2e4Avsu7Rb0RqMlbXa5etw3BksVj5zJE6VOMTiR+z5oMNtoLqReE52eII7LpXk0rWGXj6DocB1y91u7GLC2uICiF4Ztoy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663268; c=relaxed/simple;
	bh=e/VCNqfFaWy7ItYcqEMDM5/mC8drdFcJnkaRYXy5E1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeqj/NPkXuv+6cz1qvmB5bnMVmVQzXprP7NY3CG/dSdQOElTRThCuu6B3Zhig5v6rGaYKkALfrZCReDJhbmdOmc0G8+nquRH+tDAJipoivnOj2I6s/GbW6fdo1m7R5b4haIxqJMCJvu61CYbbopgfSgpz7hj05GqPy8HP4QIwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iTaJJJdi; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717663246; x=1718268046; i=markus.elfring@web.de;
	bh=e/VCNqfFaWy7ItYcqEMDM5/mC8drdFcJnkaRYXy5E1o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iTaJJJdiHHoU2vqr6/pTK33mLIrxRUtim6UtXSwArVU0EkuO5Q1Xgldt7Z5i5xTf
	 E4MAxX1igCPy4GxnZ3mSEbnt7ugujb1jUQ90g+44KJC5keH7fiqCofMbZ2atUYrOl
	 uQQr47xzX77QNX0xU2qlq+vLNyBLOYNPN+GHrSDet/nj6H21ytMyZoumCXcm54J3N
	 PIg7KdaIZ3jXmumtpW/l9k8jJ2YXtdUu1n+exJAlK4KkXtS+/ru/Y8mws751S/mmp
	 lwlJ4kCboeBXG/UvhteMKzVgFwMZUGGppoRnEIMyUsa+JQpp1i3CZAwNQdb0bj3kP
	 RI6B+n+uLl9LBMXt2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsrhU-1sZ12U0G2C-010a0Z; Thu, 06
 Jun 2024 10:40:46 +0200
Message-ID: <a3363ad5-26ff-45a6-841b-b090baa5a19d@web.de>
Date: Thu, 6 Jun 2024 10:40:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: usb: typec: anx7411: Use scope-based resource management in
 anx7411_typec_port_probe()
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Xin Ji <xji@analogixsemi.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <889729ac-3fc5-4666-b9f5-ce6e588a341a@web.de>
 <ZmFqWxqOsd6FxD3l@kuha.fi.intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZmFqWxqOsd6FxD3l@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XYMNeB+wdOJ+rY7H6hGuDKhAA3nTC8k5yav9AqBoPIX5FWvDPnH
 6ApVFN7ysrNQIhsKvfWF8eYigC+mk26QUPsxczK1hO3iTxqCBa0CK4pu46VcTme5WF2kJCu
 8CCrJNUDUzmaOmKsUBBO+DyJioOWkdDEtzVwCtyUDesLERN/gYVwty4xuNxte490MelW7kY
 JaWu0TrzB41dMqZjEzXvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:krzoOp3aQ5A=;zesfMb/xqfq0vCU8okDGwkUCe4q
 1pVB9tV7kv4OE5lAC/LxHwRibJirnVTsd8mymXfoE4o3rQhxzudx1W4UXBy9X0jt9EWq5iOAz
 Kw5exO/AAJl0swJbMiT71OgSZ4TMnX+laK2ilm4zYlMbaUM/4/859jBMXkw7mYsHFh/5MLe/k
 lVoJvLAv6GBiPASdVx3bQwrPj0X/KLwPWcj1gbMv++wa5Yf5BmJLWpSmxRFwcE0yDpVrrjE7Q
 4YemhtGbSUsGfTaU/g8JM7mIKaIqo2Qr3lwjq4WhIxuZNb6jTv/r6viJAvEu8vn5rODOedjpi
 LH7OPslCj86E3dIsGWXFTaO1HnRxF3eoed6psPfZ31lvsuLv1HKPJ38kqZf5Mq10X/M+IYRiy
 8ea7k4CARWwtIhrzD4zO27xE8hyg5fK3jlfv+wk96M5jIsvqkZ2HBc3XfYnPbPtxkB5148Kmi
 AtYhOQvypXnJt1rqNexM1M2/179p8ctEhnYDV7Ee6IIYVKg+i7JeioDssWOtpJIEiF3/NUAZ0
 vp+lZaT7XQ1avb6Bf9mFrOXWVc5lq3h2J/86uWuIaS4Gj6Bns/qCzNdTf9Ph7QvHEtxjfxbxI
 FnAtJ3CKa5qBTyiIJ/1S5jzq4e7Khy7J/4PKIj7N/P/QIqF5KIMT+Xh4tyVYNWynaK1y7ajZt
 53pZHOvGSEHtSG+C0Lcj/ZWHV3Za5wJ3D//JdLola6FbklRwj+G4BnGYsjxwxisbiyfoKmVJU
 4eY42iCq3IsH2eEFE5pLpMXebuWyELR/GBeaVGly+sqVKgI3rcysLmbWwuBKxf9JVa4c5PU1m
 pjQ1rpq0thtZL2A1YnN4LlFglq46zgkrWpRCaVS56AC1w=

>> Scope-based resource management became supported also for another
>> programming interface by contributions of Jonathan Cameron on 2024-02-1=
7.
>> See also the commit 59ed5e2d505bf5f9b4af64d0021cd0c96aec1f7c ("device
>> property: Add cleanup.h based fwnode_handle_put() scope based cleanup."=
).
>>
>> * Thus use the attribute =E2=80=9C__free(fwnode_handle)=E2=80=9D.
>>
>> * Reduce the scope for the local variable =E2=80=9Cfwnode=E2=80=9D.
>>
>> Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 supp=
ort")
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>
> Was the fwnode leaked, or why else is this a "fix"? It's not clear
> from the commit message.
Can you notice that fwnode_handle_put() calls were forgotten
in the mentioned function implementation?
https://elixir.bootlin.com/linux/v6.10-rc2/source/drivers/usb/typec/anx741=
1.c#L1140

I propose another code cleanup accordingly.


Will development attention grow anyhow for information in the available
API documentation?

Example:
device_get_named_child_node()
https://elixir.bootlin.com/linux/v6.10-rc2/source/drivers/base/property.c#=
L839

Regards,
Markus

