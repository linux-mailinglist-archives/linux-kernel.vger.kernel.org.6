Return-Path: <linux-kernel+bounces-549139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D8AA54DF9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 738E17A93E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ABE17799F;
	Thu,  6 Mar 2025 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="DlU/j4Al"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F4DF71;
	Thu,  6 Mar 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271989; cv=pass; b=tkSGiZt/t2jmr8gmCn0nTtVt6sVJLEWTVQs8O9K7lJJNE9FjMAfurrU9VFq4O8RPe11ZlBTM3wZAgjr4UFm+/Af4bpXQvgDghm616YIHqodGC5Aem18kfXq/vbKribrJ8KJpLharBE3XyoIZUlkolNhbiImXKg7+HcwH/8SgQPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271989; c=relaxed/simple;
	bh=WwQuaLVdpGWctaHJJ2OorTeu2KK/SiSnnjYicksgVYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbysQ4X2eDFyEgK5v4YY0OR1TLNcsDqyVVyXD/JxKd0vINpurKv+NL58+fpEjaj9wWnnvHV12tTXdq8Il93LrPyTbiEoNKSiikTIH83QIla5WMFJ43Ojb0WjkL3IgRihV2UNEs6ftkvcjk7E7SHKVt2mSZw/nnpl4Rw5X8IIDsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=DlU/j4Al; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741271947; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=f189TiqKaVtBiJW/aJ8g/VLuBqrAnVJqp8Mg2EopEtKZc26oVpxnjy3yehtmCDoo7D4qpSuK2NmEzpCweb7fR1vqnggfZN0noKIBt+yfDGOcC1uhUZIAGA8yZYx74hhwrwaZEpjp2bGyadbSpMw4YHKVmfZ+Gi9AdEMXyu/pQIY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741271947; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+//d8YaKM1HPYqDbAwn6xqi0NfBlNp/hPbdkEog/gtk=; 
	b=e8b6+txvoTW3oZGE3zpaG4sgldvr/Ox9KnpAFU2TXac4jwwo/mjAZbNI+bNsUgjOd3YcBTHybdb6vyfZmkaJ1/kuSSRfTTPwO5nMKIh+iLpycP8XGJudZZ2S17xn37AE4HiodVgkij8pYRIYdnAmsIkaNN9RdO9HA63T1icpEqA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741271947;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=+//d8YaKM1HPYqDbAwn6xqi0NfBlNp/hPbdkEog/gtk=;
	b=DlU/j4AlaxuLJoq2T4Afnf+/npcH5yCOio/5SydONGIIzFiTihflwKdetE1L4f5i
	oU8XkhJfbAcv9FsopV7l8iiEoRqCD7Peurlo8e+86FEExWdz10aAS5tim1rjOfWdJul
	Sln4vqPfohijJjafwzjQkBltx8lP5D19+krFhHA0=
Received: by mx.zohomail.com with SMTPS id 174127194550959.191258083911634;
	Thu, 6 Mar 2025 06:39:05 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sugar Zhang <sugar.zhang@rock-chips.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject:
 Re: [PATCH 3/7] ASoC: dt-bindings: add schema for rockchip SAI controllers
Date: Thu, 06 Mar 2025 15:38:58 +0100
Message-ID: <8514337.T7Z3S40VBb@workhorse>
In-Reply-To: <81d60550-4929-48c1-b4d3-1473b902bf12@kernel.org>
References:
 <20250305-rk3576-sai-v1-0-64e6cf863e9a@collabora.com>
 <2376575.ElGaqSPkdT@workhorse>
 <81d60550-4929-48c1-b4d3-1473b902bf12@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 6 March 2025 14:43:21 Central European Standard Time Krzysztof 
Kozlowski wrote:
> On 06/03/2025 14:13, Nicolas Frattaroli wrote:
> > On Thursday, 6 March 2025 08:42:54 Central European Standard Time
> > Krzysztof
> > 
> > Kozlowski wrote:
> >> On 05/03/2025 22:24, Nicolas Frattaroli wrote:
> >>> Rockchip introduced a new audio controller called the "Serial Audio
> >>> Interface", or "SAI" for short, on some of their newer SoCs. In
> >>> particular, this controller is used several times on the RK3576 SoC.
> >>> 
> >>> Add a schema for it, with only an RK3576 compatible for now. Other SoCs
> >>> may follow as mainline support for them lands.
> >>> 
> >>> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> >>> ---
> >>> 
> >>>  .../devicetree/bindings/sound/rockchip,sai.yaml    | 151
> >>>  +++++++++++++++++++++
> >> 
> >> Filename based on compatible.
> > 
> > Sure, but more compatibles will follow. Are you certain you want a file
> > named rockchip,rk3576-sai.yaml to then contain rockchip,rk3528-sai? If so
> > then I do
> Yes (or the other way around if 3528 is older)

They were released at about the same time from what I know. I'll pick the 
RK3576 though since it was the first to get upstream support.

> 
> > not understand the reason behind this policy.
> 
> So the name will match hardware, instead of sai.yaml, sai2.yaml,
> sai3.yaml and sai-green-frog.yaml.

Downstream called the compatible "sai-v1" so you're onto something here I'm 
afraid. :)

> 
> >>>  MAINTAINERS                                        |   6 +
> >>>  2 files changed, 157 insertions(+)
> >> 
> >> ...
> >> 
> >>> +
> >>> +  dma-names:
> >>> +    minItems: 1
> >>> +    maxItems: 2
> >>> +    oneOf:
> >>> +      - const: tx
> >>> +      - const: rx
> >>> +      - items:
> >>> +          - const: tx
> >>> +          - const: rx
> >> 
> >> Why all combinations are possible?
> > 
> > Because they are. sai5 in rk3576 is rx only. sai7 is tx only. Others are
> > both
> What is sai5 and sai7? Instances on the same chip? Does it mean some of
> instances can only receive and some only transmit?

sai5 and sai7 are instances on the same chip, yes, see rk3576.dtsi changes in 
this series. Some instances can only receive, some can only transmit. Some can 
do both. I think the way I wrote the binding already allows for just "tx", 
just "rx", and "tx, rx" but not "rx, tx", which is I think what we want here.

> 
> > tx and rx. Do you want me to enforce that those with both are always tx
> > followed by rx?
> 
> Best regards,
> Krzysztof

Cheers,
Nicolas Frattaroli




