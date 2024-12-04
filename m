Return-Path: <linux-kernel+bounces-430550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3C39E32A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29F10B28A69
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FAA165EFC;
	Wed,  4 Dec 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="DJrluDAK"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF5E219E4;
	Wed,  4 Dec 2024 04:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285862; cv=none; b=cgRK8xqtf+j880XdYtSbAW2biFRx7XVEiKGKSHseErbFcv2+/sTI6OdrCmGKZuK+oMZ56I+IWMp8C21YPvsfINb5FqeE8aA4hUbJAVkEohDtyAXuXF/qJNFrReys8k2yjqki1lCwd7xpmwobrWSK5pnXYjh0PoHzXDGwZCBevF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285862; c=relaxed/simple;
	bh=LrOFYJV2ZrZYy6LgVD19Et9UmHlo6S9eT8BWN0Eq0bQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SXt8UaPeMmxdUXx6in18mSeWYPEetORVwTcDPyvNYqTpfJkYnEy+P5mYj9UFx338ev0BwoXyPDlDpXcRAK21xVHj2mc3SPsgXEObvpoEOmrnBCc7+p52bvoZ8bZpJJ1koKTT7GZDMeVR5E2uKpSvbxWWY1hVtaglbewlZ9Aoz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=DJrluDAK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1733285336;
	bh=LrOFYJV2ZrZYy6LgVD19Et9UmHlo6S9eT8BWN0Eq0bQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DJrluDAKGeNcgsdW3x3ei/ik/ffQfZJIkBG3/v2CrO1qnlv/S7WLHQPFrZ3zuEEHv
	 Ql/kiy4lRF9SdAOLkNiMVLcm4qOlIt9pzcAHvDatDUiW7rwKAUEpHE+MusHS3ffky/
	 TmH8r50SqdUbjnz+i8N7lzhba4EMsUiqJGe8fdWAGRVfbpRK1e1/6PyfyM79sh+Nym
	 V6l9PJU0fiY0HD1KxdcqrZsUvdezusjkCVZ5bqhdgVaEBm6Fiwf59SE6TgvQwUZxzN
	 U1JQevi0+nyNR+LxqBN31xERHHWhB9pSYC/mbEyXjNpwXieFBfT65zhuVx3PzaL4yb
	 6pTB1aWUb035A==
Received: from [192.168.68.112] (ppp118-210-165-44.adl-adc-lon-bras34.tpg.internode.on.net [118.210.165.44])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C3CC96D6B6;
	Wed,  4 Dec 2024 12:08:54 +0800 (AWST)
Message-ID: <9ff74b8a13ff58921a4f7f18dbded9c06b195c06.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: Enable video engine for IBM System1
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: manojkiran.eda@gmail.com, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Eddie James
 <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org
Date: Wed, 04 Dec 2024 14:38:53 +1030
In-Reply-To: <20241203-dts-system1-video-v1-1-008e5e660106@gmail.com>
References: <20241203-dts-system1-video-v1-1-008e5e660106@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Manoj,

On Tue, 2024-12-03 at 18:52 +0530, Manojkiran Eda via B4 Relay wrote:
> From: Manojkiran Eda <manojkiran.eda@gmail.com>
>=20
> Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
> ---
> This patch enables the aspeed video engine support in ASPEED BMC for
> IBM System1. It is crucial for facilitating the BMC's video capture
> and redirection capabilities, which are integral to remote management
> and KVM (Keyboard-Video-Mouse) over IP functionality.

Can you please put this in the body of the commit message rather than
in a comment?

Commit messages need a body and not just a subject.

Cheers,

Andrew


