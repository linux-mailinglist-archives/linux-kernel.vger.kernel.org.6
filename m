Return-Path: <linux-kernel+bounces-390996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3819B80F2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46638B226B5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179C81A0BFE;
	Thu, 31 Oct 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XY4vibq8"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E55484DF5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394951; cv=none; b=rJVbOvIG9xFTohfJ514qmX8+VL7U7o+splsls8UDjI+yR1FLVqs/gL/1SqVOLyR8yF5NkkIpjHV92BnPm9yGQLi7bx+dpytiqnXhamW7ORo6ydD1Ouy6gmJmnDvLIcKNowtkYG1ONIM9JCGtHp+ODV+UkylhVCOWS+4rUlH5LMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394951; c=relaxed/simple;
	bh=B1CSh4Cm103BFDPCBBTFOksDQ82+a3zIReW8/PLgDoY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UtP37KsfMh1pbHaRikQfuWHrq36CDsiPzq+v4Vq4V885zV9UnPEmx2Z2cigZm6B6+tnvhI/pnMVVbaoE/qbcmqkfNfQWWIzi7tBdzuzlSeWst/PIj4OiK53AsV1FCHlMq3iumpOA9U2shipGsb4tvzMUtdjL5SYT45PhSovCNLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XY4vibq8; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730394911; x=1730999711; i=markus.elfring@web.de;
	bh=B1CSh4Cm103BFDPCBBTFOksDQ82+a3zIReW8/PLgDoY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XY4vibq8Hus01LyWjefv1I+EDhFHYuqIh82qdNA/p7N24F1ujrdugZDxou/fQF2x
	 84p7CHC7Q1hBU3KaBHmaIPC3pGiICSndvFzBelHSaxhIUIaVi8v/txQLL13iGX6xA
	 koiBEOakk8BYW8Dp/ZhIzs5AKkYc10i+eyxfl6+tAeTS2hHblJKL2AiWCLSVwpS+q
	 vYSCB2txaPSib0VA0+AQbLEZM/UarfuY7xt3PB089evrJahSB7JMj9l927NWDk63K
	 OQOjMP/Ly8ZhhHkQqVrkIY5bA5A9U0VvTJoGTn5gPHLlFyxDOXaaSo41Ssj1L50Zy
	 VE+fb6L7Rok/PSsKNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QUL-1tvrAR3vLR-00sgnX; Thu, 31
 Oct 2024 18:15:10 +0100
Message-ID: <28bef742-84ca-4d52-8d19-258f1a3d695b@web.de>
Date: Thu, 31 Oct 2024 18:15:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Colin Foster <colin.foster@in-advantage.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>, linux-phy@lists.infradead.org,
 "David S. Miller" <davem@davemloft.net>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Thierry Reding
 <treding@nvidia.com>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <ZyOUr7iDa9nFBxgq@colin-ia-desktop>
Subject: Re: phy: ocelot-serdes: Fix IS_ERR vs NULL bug in serdes_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZyOUr7iDa9nFBxgq@colin-ia-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kRQHuVs3K5EjHho7YbJO9j8vWGW9sKgDS1nd4EG36/HnIv1JBqJ
 xjujs+P3C1tmYi634zE+v9dzLab53BAdhTFipxaILSIW+sSD7zxOg4l415YJeyv8jEbBTrZ
 IBxsidofwYus9ovyzNfUYOwx4Xk/D2w8k/1RUHKQwZndbl/uK6jr3tDU9ZBzkIfU3q6/z3J
 QU7gzb5DJa1LKsIEBs0tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pb3yaMw5tqA=;piYEI9d1pD3ipPRhzlz3VlAZFl4
 nXqUdLULYhjKalNTRJ0vpi4rxgzceHLM55cDCf0M4+rDhWG8L8MAzhNJdyqJkGOWYL0gvqP6l
 uykJMgX+XDM9i02y2wOzvzFEMzD2tY+zBCkn918uqJwBU6ls0UaYMRpVXAT38Q+d4CQ9Q8Hxx
 0LVqEdTw4MWJJZJ5IREB6PCVqNLvuNmndzVoY+A7XbgfBQuZRXYceNHiyMswr/lVcJR4xLdkt
 Ox1sWxDzMaN+wgaF79NLhj/C5H9QGM9rmsh+gqbISvaflH0KTQnsbTK6t9R1VRLmPIOBNazcx
 7ORr4bh7MYVitDB8k3cfe/k7u8S4AGAgyYKQNEHm4363eoadmYlms1ELygTIT98dibjXETth4
 bVFHAiXlDaRsw3mrS6//WIB6dcDk755GS9zBZRNx/9M+B4RFhnzYgSXQQWlnli7MquJfZNldJ
 FMLUeSBc0kGHQ241CkMXwWY2eW5djCewl9xPY/J710Q6xzgwmv+6szT0XiEPjiQbYKKHj+DQj
 HpZTSI0/X9rLNfcARPaHsdCUCtBE8OGTRPaThK8uSmW1Xq4b6b+u8SJirjK6VK70o0upslkLC
 Pf0zZOKn8riaUcc18KqwvBHw5nFCk/y2Wo1kStlR7nxVKpJtOVWbd06pNUoCGn3a64hAMI5Ik
 rNOQOssRpc8XFoqz8prEhzY1PO/Mp6QJN47xDG+X+Tm79WIjo8vy/KQwTjZijy2ufyt1+6ynz
 xaaKQ/cxMpB/V42pirge6+rGSsX+DgXGqjsT5XfhTHeSW+re+RII9zZBIfA3lHJiFeNnfaWkL
 2FC6oHeEC74/+z5swVsv0vWQ==

> Good find.
>
> Acked-by: colin.foster@in-advantage.com
> Revieved-by: colin.foster@in-advantage.com

Please reconsider the usage of these tags once more.

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc5#n456

* Should a personal name be mentioned (besides the email address)?


Regards,
Markus

