Return-Path: <linux-kernel+bounces-277583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5FC94A35A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7D61C241BB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F85E1D0DF1;
	Wed,  7 Aug 2024 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="VeOTFGLY"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6523B1C9ED1;
	Wed,  7 Aug 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020557; cv=none; b=grVHCBv9kqDgzn0DkkCRV1X2jcniHL339KBNSuT1dX80DhwjkUFTW7dBPjqMnNOYsUsoKZ7jdw9muRrIIO7gooCIp6FlGJsEx/Mf5ZNEQ87Y+gCRWmoh5D/b9VerABIBVzViloawQEbjyhDxl6oCI3srSjD2y1Hd0dTHqVJkAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020557; c=relaxed/simple;
	bh=rCHPPbTWaPBj3q4qgNv6Q4boFMkM2mOM5k75QEyACsg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UJyaveSXc8xGPE4rv0yeyWxoXrtK9FXo8TeOeZRf5152RGMFkjH9o5JMvXWukCNlJDjuCrbeuHYkKZUUl4mYMEcmnddeXE2NQ0eAkBd7kGFXQd+jVMfN0n60dov3+7AI/liP47L3dS2HeUFrX4mPEH493qbSMRCs10uO6BHvjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=VeOTFGLY; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1723020005;
	bh=rCHPPbTWaPBj3q4qgNv6Q4boFMkM2mOM5k75QEyACsg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VeOTFGLYwvm/ckObBN2Y+5f4cHxrZx64RCbPSkM5WdpMN3WXUR2bXeRjsECmknLaq
	 jc785ECVLrdshK20tO5vGTspi6NJD6EVeeqzmRHCeX/13qd4zgWo0Ji4cRr79GL+rp
	 JxzJAvP9C5ewrIkvmYV6M3r9mLwkdKExufXxhQ5M=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 7CB2366F24;
	Wed,  7 Aug 2024 04:40:00 -0400 (EDT)
Message-ID: <6c7ec8196fe01aa651f8b59b445b70de79137181.camel@xry111.site>
Subject: Re: [PATCH v2 1/3] dt-bindings: serial: Add Loongson UART controller
From: Xi Ruoyao <xry111@xry111.site>
To: =?gb2312?Q?=D6=A3=BA=C0=CD=FE?= <zhenghaowei@loongson.cn>, Krzysztof
 Kozlowski <krzk@kernel.org>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, robh@kernel.org,  krzk+dt@kernel.org,
 conor+dt@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
 p.zabel@pengutronix.de
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, loongarch@lists.linux.dev
Date: Wed, 07 Aug 2024 16:39:58 +0800
In-Reply-To: <f31609c4-1e47-49bc-9231-5b0353d35dc9@loongson.cn>
References: <20240804063834.70022-1-zhenghaowei@loongson.cn>
	 <4d1f2426-b43c-4727-8387-f18edf937163@kernel.org>
	 <f31609c4-1e47-49bc-9231-5b0353d35dc9@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-07 at 16:23 +0800, =E9=83=91=E8=B1=AA=E5=A8=81 wrote:
> The file "drivers/tty/serial/8250/8250_loongson.c" will be created in=20
> the patch
>=20
> "tty: serial: 8250: Add loongson uart driver support". Is it=20
> inappropriate to reference it here?

You should add this line in the second patch then.  Separating a large
change into multiple patches in a series is not for formalities' sake.=20
Each patch should be logically intact on its own.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

