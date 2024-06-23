Return-Path: <linux-kernel+bounces-226386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5D8913D99
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7C21C21104
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 18:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1D2184118;
	Sun, 23 Jun 2024 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VIEbXJE/"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BA314830D;
	Sun, 23 Jun 2024 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719168226; cv=none; b=jkkrzRE/xSmxGiP6haAA1Clf0C5L+yRygw87LarbWHEbX4ss9pEWvE2A5cIUVWEfacN8Y6x0plAKQJ+cjjDFLrj+dJS3IaqaD3BRzVqz9W4ayeNPpyXUZTu2KvmtIOJ7p98ah4iLgfwTAqZfun1bnGr0bgYK8sAGp+Ovs870NnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719168226; c=relaxed/simple;
	bh=w5hEXJLG4OPyvbd7nDQPT+h5KcrjcJGViT3NRwut84w=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mihNJvWrVwrK43kvCYjGqPP8/PnGOvjDVsKGkBpRW7qj38HzxbRv6l/eqp9NPklyRNqABitI02fF6AgLZbPky4RvJHpC9Rl+bvTyVDLMoTo01Q8DSzlNXusgeM0mbrV59pJQjE8+ZZ5f64uzA/wTrA4RKSsBKfxPGJ97hmAZFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VIEbXJE/; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719168170; x=1719772970; i=markus.elfring@web.de;
	bh=1dcrNaQXji2yb2Bh82SWM2XJHeDXnEcOqfxNrj9m7pc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VIEbXJE/wxAjUjt/ESseuUx0eQH5SvCYmT7KyG/Z2xjFSIK8Jht1WYOgY1nWHm+a
	 cfrx98dpNdbrBt9L/7Mhd8nihJBYIp9iYezvSUt72nE2wLFJZLC4wY3f5MHZY9h0K
	 61Khm5FQnHrwXCHwKE5bIvUii821v7lohV/9ETP/m1abEQrbj2K24qybYeGvtdqyb
	 GIgtmVorR4oxDPU2kpTMkTngoiNQtaep9aHpFmZsNJqpcnBCKZ4viaXHfRmVm3X2m
	 u/iVIVA6+irG64qODkA6Y7gAeVwMVe3FE/0R8RKRXzHMZohq4EocvyP5W1mWzs00F
	 sgRjoMQ2m57pZSjCJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhFhe-1sqxRb3zNa-00p6YS; Sun, 23
 Jun 2024 20:42:50 +0200
Message-ID: <43209c1a-7889-4dec-8385-2f3b15d6faa5@web.de>
Date: Sun, 23 Jun 2024 20:42:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Keith Zhao <keith.zhao@starfivetech.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Andrzej Hajda
 <andrzej.hajda@intel.com>, Andy Yan <andy.yan@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Jack Zhu <jack.zhu@starfivetech.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Robert Foss <rfoss@kernel.org>,
 Rob Herring <robh@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Shengyang Chen <shengyang.chen@starfivetech.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240521105817.3301-3-keith.zhao@starfivetech.com>
Subject: Re: [PATCH v4 02/10] drm/bridge: add common api for inno hdmi
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240521105817.3301-3-keith.zhao@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8UtErLEWkjKse7Z0yUU8qtJl/YJlx/hZuvrqJ8fnPQwXh0Q92U2
 /j0FUKwVLLHrvRKbfPmiXs3VdXBtF9nZw8Sh8N2tkwGV+7BoF3sgkVA+KDBYBEz+505KFXl
 5eOn5uMey4aq465MdaeSoof1/gSklk5KdExo/zqeWiMyUyyYHzF9YzTxMUADcTaC4Nes5aA
 NnZwRH+vKL8iMbBkZ54OA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vEmo676cbak=;0bvQHYhf/I3BY0oOfipEpU67Eo5
 xPtfdhaTrr8k89QH4O5X9GmTdcK8MMcac0ibniBNUiUCWPll7Ha5x6c6gT92N3Bd94fZ8f8Rj
 0t9spvDIlQzNFjQcQ/D/xf0ZAkHE/Af26NSvwOagJH+lELXYjIgObuLJEkh3rwjsK+SPhK4O4
 UA0iICskL4KX32xcI38wZNZkROB+YpsgdyMwUkStyYgTVo4Mlb2b4VLDNZLqFvandmwEEEB3+
 pK7RkIh1NDwbLp8SpLVPbPkGYeeWqCUVaKsWcOJLRAKRGC14QC00cSazSbzKUjap6ykifVHis
 ySA+Pb64b49bVbSh5RBjDfdAn3QTKAAXyvebZT8nHxTq5A1RRVsrhE0VUd0lQKDzeV3xbkZ0O
 8u+lvWsbGtmrWTQPhyDukYaE/fWZPAv44aI8722hu0mB6a0+0osOMIOqJlnBrjMlTm+uXeQKg
 +PktpEg9IaOq/0hylRcPDfsLSSI14+WZ0kpdPtmWldM/p+psHop0xJCT/L0uizF3nXqLYCRd7
 tk10V7MOm8RRoKpAAHE+K5yjlXq1HDcXCkgISh6gvCbR+3R5Q0dVlW84EIb5aaQBLpv/qhsC7
 8vsiKq0C000/xOOonM8i8KALS0YA5gV0uWVsTtEaMeLWBQTFwRRJDPB3v+rIvWQxnSb7jRBJp
 9Sm8q7UQx6WJ3cRTCVplmjQnk0LP8WxeF1bdAManBcZpkrqWt0PzqujhMpOToVfWMHy7DHY+b
 hUZR9KBGTTx66qfsHf5lWvl5xPthQAPNV7LPvLWt1RlgsydBG3IkionuTXcnLyZv9veSwlKym
 caQj2yv7EoZ4nQEc1T++XBb6NRaKc2sN/9hls27UoqrUA=

=E2=80=A6
> Signed-off-by: keith <keith.zhao@starfivetech.com>

Should the personal name be more unique
(according to the Developer's Certificate of Origin)?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n438


=E2=80=A6
> +++ b/drivers/gpu/drm/bridge/innosilicon/inno-hdmi.c
> @@ -0,0 +1,587 @@
=E2=80=A6
> +static int inno_hdmi_i2c_xfer(struct i2c_adapter *adap,
> +			      struct i2c_msg *msgs, int num)
> +{
=E2=80=A6
> +	mutex_lock(&i2c->lock);
> +
> +	/* Clear the EDID interrupt flag and unmute the interrupt */
=E2=80=A6
> +	hdmi_writeb(hdmi, HDMI_INTERRUPT_MASK1, 0);
> +
> +	mutex_unlock(&i2c->lock);
> +
> +	return ret;
> +}
=E2=80=A6

Would you become interested to apply a statement like =E2=80=9Cguard(mutex=
)(&i2c->lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/mutex.h#L1=
96

Regards,
Markus

