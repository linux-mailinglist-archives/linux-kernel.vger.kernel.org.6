Return-Path: <linux-kernel+bounces-251093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E521D930088
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224701C215E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A6B2232A;
	Fri, 12 Jul 2024 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sCprKgua"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A231B5AA;
	Fri, 12 Jul 2024 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720809793; cv=none; b=jP1BgN6iAAeelmssCbwISofArW0btOcz4YGlAQSDVC0RYDTLLpogEBB5Fnt2uNPYPtZ1/8W/vVa+75qhcKG0gsZca7+uR6xW8vZ4UFIIlG7+uCIMM3s5YwFR6EfhGbeigmyU55AYtj21GEmmmXcZ1G1qYyCPRoPqLIsHvCkolhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720809793; c=relaxed/simple;
	bh=XwLry6Zd99fHziJMybVqb5W8aCxNuXN1ll4cZATj080=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ZDzWEjDPrO46eeWmoJgOBhwCdMUBmLHKFKMukcaH56VdFkAmwDQIhY3LUHEmTk+IV06yXLOjEkQxSaG1HQdt1CC/Yo3IQeQzI8iM3wn22bDjcYRZgsz45746vGTSGr7cPfZPq7F7oLYacp/Nm90l5s/V+6+KxTuC4BCOGMV/Sv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sCprKgua; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720809775; x=1721414575; i=markus.elfring@web.de;
	bh=kVDDTPzDB2NuxrfWO1Oz69WnHAioKipho4+D88kwPeE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sCprKgua1Ha2A8+ltwqBq0ejWxp5aqz5wJ1Pp9BW3Kp+aJzowpZYimIaRANADJ8K
	 AAE5rB0j5UBm14/hi3Qq7wnbOT5AjW9kO7+CavTUGPkwPwHFSqPvxKdu/x0qBvRVi
	 wPosL9yKvTP+Dg4F7YTOp8etMoMOB3DY9Rht6USWBvN41PUAkQ6r9mecOrO8Wy3kI
	 dsS7RlcBCWXHC0oetw5PmIzafB0g0gt71nT6TuFtlgjVHYyXVRVO7tCPh/jv1Avbq
	 esBrviLGhAbhbkvVdCBa6teNsr8L2mQaaUTiFam5k2RVt8FsxOHGy4IdeAdU38jjh
	 tiIOEJD9/x8XTw13Ig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLRUV-1sk9EL3mAl-00MaSD; Fri, 12
 Jul 2024 20:42:54 +0200
Message-ID: <0d5656d6-91f1-40b2-828f-c844465f8da4@web.de>
Date: Fri, 12 Jul 2024 20:42:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pankaj Gupta <pankaj.gupta@nxp.com>, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-janitors@vger.kernel.org, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
References: <20240712-imx-se-if-v5-4-66a79903a872@nxp.com>
Subject: Re: [PATCH v5 4/5] firmware: imx: add driver for NXP EdgeLock Enclave
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240712-imx-se-if-v5-4-66a79903a872@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KJEmkJHwE2y79Kj177RRsczBXD7kki11uQR1vdwP2nfYL/oQk3p
 84sariDDPD293mw+8Tifr1TPEJRtYUGPVDhOWahXmwnavwIqTQK1AQSdZSYtViXEoqWI6F5
 tkrlUDVXpxysXiMawS+GCyRvfnV0JbK5W/psi4wjFYwYyykCbuhm80MgG6LVoaThGvWXlHx
 t35VuYHZSYJKTgK9qa6/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dmRgag29CyQ=;ZsGHiHZO2FVN1XsY2yLS89Zxpis
 G+wD/nHC/oEPHH40NMjduh95C6xNomnYRSVQtZfH29sn4/jyKvPg65q/3bnCLHJUmf6nMwgWv
 0Uh5OdplZ3gw6OTHPqPD69ULtyJyKkP/j/XCxOAHzMfjSjTbhFrbLgKDX1e+XKzBYjh1sqpJh
 Hu33SLU074f9tEFKcLN3SmMB5qelg81A7MEnV6XT4hMDl4Ij0q3Zl7rBmCLmLSbj/Z37kxZTh
 Fy4nwOJLz3TFMgP91iLcASWbfKY9xRl7v88izFpfP6iQCHuls5CIgO1D7p/mJOn7a0TzmiSRT
 OfvqnTcfBm9y0v0WNuBoJORx37gQubT2vthUTqICZfXqhp1jGYnfAHHplW9AcYrwucORlf2my
 Ye5Y30LlFHZg+Rok2akFVCtmaFwdLb4U3Exi91XM8I0yyafjwsKBN4Zd+49gcKq6pBhcO4Bx2
 wHMZl9BQj0yCsxZu0Ksz0iS4MGnBs3Bdry1kX6yZUZm9AGbc0/9/espdE5ReLAVnQwEoXNPDT
 Zkfzr0/uXBXNDw+0iRMVAuK61yAfv6BRr8J15VJNp+Y/Cy666KDYNkfbBaNZrlxGVVxyBNrJ4
 o8m4tq0fLT1Jp7xQWirhTdptEjnzaq4iTR0XvM6+zritu+Lcan6tXmHv4riC621wq5ba6B7+D
 YF5ti7/Xmn5fyxv0I4gz1oLkT/ZbyLzOknlfyUZUuo0QcLOHqjfdv9/tEeltBKMiVK8tG4cxj
 06ys3CYCDG9DnCzxrS5naElwnp2GOt7iEOjnCv87FU1RQF6n6DulY5s/arMWXk7DrYaSI9fMp
 HV5QUgnAtRsWo9hKfU2n231A==

=E2=80=A6
> +++ b/drivers/firmware/imx/ele_common.c
> @@ -0,0 +1,264 @@
=E2=80=A6
> +int ele_msg_send(struct se_if_priv *priv, void *tx_msg)
> +{
=E2=80=A6
> +	if (header->tag =3D=3D priv->cmd_tag)
> +		lockdep_assert_held(&priv->se_if_cmd_lock);
> +
> +	scoped_guard(mutex, &priv->se_if_lock);
=E2=80=A6

I interpret the documentation for this programming interface in the way
that such code may usually be used together with a (compound) statement.
https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/cleanup.h#=
L137

How do you think about to apply a statement like =E2=80=9Cguard(mutex)(&pr=
iv->se_if_lock);=E2=80=9D instead?
https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/mutex.h#L1=
96

Regards,
Markus

