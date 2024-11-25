Return-Path: <linux-kernel+bounces-421317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6B89D8A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F9CB45CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE851B4148;
	Mon, 25 Nov 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="T9YNyApc"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88881B4129;
	Mon, 25 Nov 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549226; cv=none; b=BWeKOfJNjH1PlUAZ9P7qcTipl9G1KVE3NNmqou5OP+4jcWmws/cYBIpXx35qRQE/pn1vxt1glbfryW4ZX0c1cXUUY4mGQz4xrR4TA4UHcpEbU7WAQBhz+bzmMmtRMn85eic9QgeyJbgVJIILiABIrxSwADw0IK1DtqSgC6sNxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549226; c=relaxed/simple;
	bh=DMxASQFiv5QBuW8Wp1m0A2qe7VA8svcArqc5KMbwIjc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type; b=n2NeRRtmZGJw5lnH9DzAM5vyvCui3EjWNUYAPi4ETZGo0241IJqfN2C6PgS2AKk6tC+eNuqNqEPTJ3vV3LnPTKvPK/ZL3BwyQFeVIYVFPo+tT9vvAjpIMvgHL5WmQaP5EU1rrQTo+/Yf/FxGinPYAHhBPnjzkCvy0Yxg0pObDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=T9YNyApc; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1732549214; x=1733154014; i=wahrenst@gmx.net;
	bh=DMxASQFiv5QBuW8Wp1m0A2qe7VA8svcArqc5KMbwIjc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T9YNyApcr8CnkrOW4eR7TzkxvC7xzO1pLbFzsXiAbimUzoF+oWYfamQt4T6AMU5O
	 PPp23VHHBKMs4vtLZPKp83RcwFtA4l2pc/0vYVsybIkg310Fhi20XgF63Xksmv2gN
	 K4vFcNO+i2v594rC+U+G9sr8s8rxVo2KPYF2QbdL37JqZG7bOT7NXGxyrVJzS4kD/
	 1qlTJrk3xOnNJECZ+FYZlTRuAzfQwciAYKpLGH9rE9ZpGK2vvY+ZCoMRiY1p/KpXH
	 rOFBs7sj7Ps2O7q8rML6ORL14MtzT/bsDUUc5PX8G4oONlTDRpk+JqQb13ikUIRwQ
	 fa+T+2UC3VPyU9tcaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49h5-1tgEtr1WxV-00w8AY; Mon, 25
 Nov 2024 16:40:14 +0100
Message-ID: <29371514-caf7-4f1f-981e-bb52c40f7bdb@gmx.net>
Date: Mon, 25 Nov 2024 16:40:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v3 3/3] dt-bindings: w1: ds2482: Add vcc-supply property
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ben Gardner <bgardner@wabtec.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
Content-Language: en-US
In-Reply-To: <20241124-ds2482-add-reg-v3-3-806df39c9454@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:usTGB3KqY7rt1IVtdUR9XQQYHdY3KFABw9PesgHJB9xYQFj2mun
 P1y+rk3jPAxZH7vGFdxVoJQ+wlmkn0dLqyjZI+kvxG6YExz+mA8rFbqEZ7uDIiZD6lXRyWv
 voQ1cLj6lcr9RZrzdi8++hAWjUMzuxVXy50Z740Yo6f7Q25xdNQQhZg7H0u/J2OOQQ+ehtL
 iOY3fkBljZ8KoYyiCE2zQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PPdh3LNaZo4=;opzhgqlLWWx+oosKaVivtnZarJO
 rZNFGM9OxuiVHfRsm2OW5GAtawsgRZJryF/ePmVxAaY9ir6SkQEGKlK334UDUCrqNboccAkSp
 5Qm1Z28HUUdNtj7evdRUnrVkjADmtwYGfBy1X4eMC2ToEPoVjZtyVIol9IRAOG6MC0GPdrTSg
 tngrL3xcq/Ftt1cYnz7gK3K4kkEGpqoxfyPZSaX0DIXovehoGYjPCb8mFDdYRPdVBrAZcmtJi
 HDeZViHaqrhGUuRKvDixlXwxPKimP9GVq9MS+Utt7UP3TQkgW69+K6zwFARfGNWQKfqPCRvkz
 JHU/z2S80cdTkOde0Y7TKDj4DZHiW1WfoM+lJ1xhLpbzLc4au1iqL1xnvv95GiWkRs6ZL1Xpg
 6uMd+H8KD/PDLo33y43xV1iFwoXdZLfTGdR6zurZPNHCSzGRBxBz174GFSZ4xcMK+2aa4/Vi3
 esVallSsLb2lLFKh15bmNvtyXl1hUmCOl03oZavlEzSaxmYqfB6H0cufyj/c68JOaHAjouUO5
 4tnXoanyus+DMnoKvvmHFT4KxLUaoL3Yj9KR2IcQUfIQ7cYr4cB3jB8G5OgI4AAMu0DPw4XBQ
 cyyq1Oqu6sWvJqNXrhKSS+HGaS+vYRJaMD7eZB7twY29HqDkOaD45gWbJ5S8WReR2j2PbDtml
 5LaBLX5h4+GxudgxwE9BOc6mAx+xLYA/V1QJMnrBD/rX86hPrQ6iS2xszkvkBvCXLlSCTelCG
 nDnNdslf5BNYs501UJv7XaolzOXnKy3enpSeVgMl1MQcY1CCJr/l22AdusxLeX90/f8ChQ/qR
 02AdQuowvZ5UbfwEmEgCFcSnp14pJGqRYd/A37BlBNXebRZkX/EBxbo6WXLHgXe8mSbGhdMdW
 PYS2AvAGmSgFtBWoxUnXvw/PHAk96VGHYL7QNvc7vd6+qyHNBShTIb2YDfYOwGwlafUWjtqF7
 Bi5eerlmzRpK5231ub+B8CYjyXQmsdoweFZdzLRIJwNhkzU9/8yahd7CTiwK/vMpaCJpU1Msd
 jMDofI+8gZn1/32c8lt76g0QcWWZ/qGxojc2oe4lLXP0HtPaa2AHjy+AZ4KSPyJ+/raM7R81b
 vUX+oU4WjUFUQKCRllmEiP55z8fzpS

Hi Kry=C5=A1tof,

[fix messageid]

> From: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>
>
> ds2482 has a VCC pin, accepting 2.9-5.5 V.
>
> Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>

Sorry, I'm not able to reply from my chargebyte address.

I'm fine with the content of this patch, but in case you need to send a
v4 please make this the first patch of the series.

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>


