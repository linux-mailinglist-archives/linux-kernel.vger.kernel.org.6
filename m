Return-Path: <linux-kernel+bounces-325802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64F1975E62
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADB82827CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC601D545;
	Thu, 12 Sep 2024 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Cru5l5Y2"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74181AACA;
	Thu, 12 Sep 2024 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726103617; cv=none; b=TaOcQ5+i7BA3zx6r4Zscj08yPIL+uGMSOYh6nyBi8TYdcO37xHITkX8Srf2GOpYJPdhF+5jCDdbJ2tGR9bPwmvb1wKoc0qEiLeoDKPUpQGmTYDnBBFFzJdGO26kMyZcLchY+JONcj+VkQZpYGxcbtxiD+KgbWEU//0bbXfOV3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726103617; c=relaxed/simple;
	bh=S+MbdhdVOhOMSghEANs8RIXiI0K1AciZRyT3zzRZOq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QL3+kJqWymN6F908e0/+7PW/GhnWLMtcDR+htxOYzhNvcXKjTQ7Z4VeITbYGVb/2lkeskjJHAM4oSoDrC5KTEFcgJGIgFTYNI4a7zW8x9zxiOPoPa4LguzaSAbCuTDRTprjtKWN1zwNEkR4UMphE2tfgwl7t3WB8C/M/IiCozWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Cru5l5Y2; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726103613;
	bh=S+MbdhdVOhOMSghEANs8RIXiI0K1AciZRyT3zzRZOq0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cru5l5Y2rBnuxKzpakQ/JaAECYPKlIOBOpGYvbSlvhvSTEcTVF1oLZpaQgdYrRHAf
	 Gsj+cbl2e+gfdes6mIsQdyphkQNPkNBWpQi0NzBfPdwPl3enSGwi4Mf0kmX3daoEaY
	 4DW5Hce8vsqEYuk22jAsPHNgTRaE8AAAa9YfD8hJeAXo/XxwIbwdHRCc+vm235DaLP
	 8ckVh6devlrBy9B3y1/248dNltGYJjfisPznYpgTPfvselxIkFbqS6s1V+Fa0RCe8V
	 KmlasRJk0JbldRS12HmKF9hEVVxQwKgtpYIu+IL9FvIzPo3yzb5hc7WSAmC2AGRQIF
	 iNRNmKChMchyg==
Received: from [192.168.68.112] (ppp118-210-89-8.adl-adc-lon-bras32.tpg.internode.on.net [118.210.89.8])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1202F650AD;
	Thu, 12 Sep 2024 09:13:33 +0800 (AWST)
Message-ID: <7c5a2a91fad3c52733beb5cd192ad4c90d48f82c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Remove temperature
 sensors on Medusa Board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2024 10:43:32 +0930
In-Reply-To: <20240910085701.3595248-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240910085701.3595248-1-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-10 at 16:57 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>=20
> Remove two temperature sensors on Medusa Board according to hardware
> change.
>=20
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

Thanks, I've applied this to be picked up through the BMC tree.

Andrew

