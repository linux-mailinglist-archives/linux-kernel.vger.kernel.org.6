Return-Path: <linux-kernel+bounces-216152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068D8909BFE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 09:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863B928303D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 07:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2EC16F0CE;
	Sun, 16 Jun 2024 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="nkp8cjs7"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EC349637;
	Sun, 16 Jun 2024 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718521333; cv=none; b=shmwU97TPB0O+vSgB7IOlGqaogPO6sckp87fFfR7aB/zu6UdKuAJrakyuvQPHEgpCMYKUaNp4rPaLNXLw7jEJc9j3n1q8XHkDjz3e9t7FSAW44futCu4TuBAqbk2BCxqZswJ/JlYe7v76SaUL8ZhOYkfbjTssE9/GgVsgmvmiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718521333; c=relaxed/simple;
	bh=m8efvqW6Btrs3xRpdD/WYC5AdiHwFW76qFg0/hS6lts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtPzhhuwy9tdb3UCkSiIR6kXmLXkiwlbKDQfg95AzH4vmHhRop2/t0nMYImJybis3x4EOU+7Y3WrUp9ZliBHzV1oX5be7JE+fMI0lQgwgQof+PE1f/WkZYPcLsbYa2JwS+k0oybAIqTKC8P6gB9LoeHQvNalvVJ/EgTaohddEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=nkp8cjs7; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=r1hzxcxDWZtioQbWh9y3RfIQWJfYmt55lg+MTy3ToSI=;
	b=nkp8cjs7vCMKwIN8Aaf8mLKCKg8Tol9iAAFJrMQoac108OcLirFkZCs11IF1Wx
	IJLCgUlaiXWP7Bj1iY07Lx2/F8zuumglGBAPIr/Gqx3L1FIS9r91pcjG5cBdVfIn
	C3/ZZAc4V0Y8OTEAr8Rxevnj6AQp/52fjCgkwpE7ZUE2o=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrAD3v0LZjW5mGy3_Bw--.35031S3;
	Sun, 16 Jun 2024 15:01:47 +0800 (CST)
Date: Sun, 16 Jun 2024 15:01:45 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Fabio Estevam <festevam@gmail.com>
Cc: Adam Ford <aford173@gmail.com>, linux-arm-kernel@lists.infradead.org,
	aford@beaconembedded.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] arm64: dts: imx8mp-beacon-kit: Fix errors found
 from CHECK_DTBS
Message-ID: <Zm6N2W4E/DeHIMDQ@dragon>
References: <20240601135230.89980-1-aford173@gmail.com>
 <20240601135230.89980-2-aford173@gmail.com>
 <CAOMZO5CVrEEj20v+EDX7rmCvW29wL+gD37mfMZAp-uY=tnz-rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CVrEEj20v+EDX7rmCvW29wL+gD37mfMZAp-uY=tnz-rQ@mail.gmail.com>
X-CM-TRANSID:ClUQrAD3v0LZjW5mGy3_Bw--.35031S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4xAw48Jr1DZr17Jry8uFg_yoWxKrbEyF
	yrKrW0grnxJFn2vr1qy34rAayfWr4DAr4xt390yF43u3ZI93ykJr1fJFW5XrZxXa1xtFy3
	uw17XFZYyFyjgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0wmRUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGBsAZV6Nn4yK5AAAsI

On Sat, Jun 01, 2024 at 02:43:07PM -0300, Fabio Estevam wrote:
> On Sat, Jun 1, 2024 at 10:52 AM Adam Ford <aford173@gmail.com> wrote:
> 
> >         adv_bridge: hdmi@3d {
> >                 compatible = "adi,adv7535";
> > -               reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
> > -               reg-names = "main", "cec", "edid", "packet";
> > +               reg = <0x3d>;
> > +               reg-names = "main";
> >                 interrupt-parent = <&gpio4>;
> >                 interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
> >                 adi,dsi-lanes = <4>;
> >                 #sound-dai-cells = <0>;
> > +               avdd-supply = <&buck5>;
> > +               dvdd-supply = <&buck5>;
> > +               pvdd-supply = <&buck5>;
> > +               a2vdd-supply = <&buck5>;
> > +               v1p2-supply = <&buck5>;
> > +               v3p3-supply = <&buck4>;
> > +
> 
> The extra blank line is not needed.

Fixed it up and applied, thanks!


