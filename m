Return-Path: <linux-kernel+bounces-370930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89789A33E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168361C223BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2E717B50A;
	Fri, 18 Oct 2024 04:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="XBWSeuFA"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D7F154C00;
	Fri, 18 Oct 2024 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729226087; cv=none; b=tZ1DSl0lmotTUeGXAUNWYHuTk2VuFqpQiplYRqn6+m7jkZCEt0LLprgndlS8x/1I2aISKLIuxa/Rkvp0whG3CdkFU6FbvDLaVNTSzOf5PMH78FlYqpTgnhA7ZlGpPtXRW6mZTCmj0g3kmhvDqctrMzmpoSE82nb08aoldRxXmUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729226087; c=relaxed/simple;
	bh=NVgrL2WOQph8wmsbm7UkzIk2HTAgFgli91BjoMiJlY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eORTHhs4i8GoiDijB7+q/yJpAvHUxCE2Drx/CDMrKOqWrk+BSBTuEoHaHtZeqwhmkJ/jNTxn6Upuyfx5U+5WOg6hwP+LT+/7JCnb0dQtgGozaZGWdXTorOKMbwzdWGLEjobKGPr2/UjCKytSO+/aiAqe9O/WtuDTG9oswJUJt/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=XBWSeuFA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1729226083;
	bh=aMcQO5d9C/nTsULBi3LiUoDLWN+3h+b/LE+WPCf0930=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XBWSeuFA/JuoPWflWqKnmR92HIpUD8bW4xds9zkIzwt+MmWm6hYm8Gpn1js1Uq3K7
	 KL2PuiNo5vO5bQTAiRgORiYTq1jZ8O8k/tR7Mnk+P+FMMTTCnhEAoDIsCivm71nxqS
	 hFUMJq9jHk6lXgptAsZP0EwYaGYffv2UufEPt5SXNbZbhg4pA0rLbnR+S+URuwlKIm
	 L4MKumijPdJMXYB1iCRW/ErzIEltZAU6UZhZHw6H2ySYFiddH+t+m2wKgJKeJAau3d
	 byCM2M2/KawLwp3D3VhqnS2/PLhGv4B5BjIsWicdmClrzZMyVTf+KZG93UZA2MjkfX
	 VPQZoDzGCZWtg==
Received: from [192.168.68.112] (203-173-0-39.dyn.iinet.net.au [203.173.0.39])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C6D24681B9;
	Fri, 18 Oct 2024 12:34:41 +0800 (AWST)
Message-ID: <d514fd066353c529052e59c564d1d15f91b6a8b5.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Jefferson BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Joel Stanley
 <joel@jms.id.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, 
 Open Source Submission <patches@amperecomputing.com>, Phong Vo
 <phong@os.amperecomputing.com>, Thang Nguyen
 <thang@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>, 
 Khanh Pham <khpham@amperecomputing.com>
Date: Fri, 18 Oct 2024 15:04:40 +1030
In-Reply-To: <20241014105031.1963079-1-chanh@os.amperecomputing.com>
References: <20241014105031.1963079-1-chanh@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Chanh,

On Mon, 2024-10-14 at 10:50 +0000, Chanh Nguyen wrote:
>=20
> +&mac3 {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_rmii4_default>;
> +	clock-names =3D "MACCLK", "RCLK";

Should this be overriding `clocks` also? There's only one clock
specified in the dtsi.

Andrew

> +	use-ncsi;
> +};

