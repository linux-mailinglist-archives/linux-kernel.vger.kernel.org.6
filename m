Return-Path: <linux-kernel+bounces-169925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 060668BCF5F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416C51C220A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1366E7FBBA;
	Mon,  6 May 2024 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bwo2UIIj"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E77A705;
	Mon,  6 May 2024 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003220; cv=none; b=G0ge6zXjpA7j09HHNu+XfX2gsZM/kLmhYd68Abtgq3ygDWYeJPestKYPxty5iZQB16y7YE/pm8LbwByjwjO0FBdVwnnVP7VMMYulsMHEu7vE40YyERBXbtHlNMFwv+GBoDICdaxE1RAaCJY6SKbzDf2KSx7kXge7iXAnsw9DYIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003220; c=relaxed/simple;
	bh=/24xSxMILkRoZq3cQvY/RH3bqeYXcL6di8umjoqu0v8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LBXGG0PYvQggE/ObMoVSrzUF6Oqc0nJIH9A4NYVhAOmp1qgSeVm7oJJPpYcplk7JHsyPY35Rl6Y3/czV4an4qvCOs1TKqGLuxifnNpPkIuXlMsB71kMX0cgkSD7jyjWxz/Rt4UHPDP8w5hH/guWeLkhblLLJSqoVAbOwBSYFT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bwo2UIIj; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from sparky.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B13A62009E;
	Mon,  6 May 2024 21:46:51 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1715003215;
	bh=2fhzb0hzM5CoC8a/Hka9EaoE507VJeZDLIbAnWrjUbc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bwo2UIIjoltuTMynVf0nfgO+i7rXvZ4kRTueU/ZTz4FjuAxtap4hBzajaFDed0WMa
	 kNpCyzWGAQmuISBjc32x5sOskt7mPcIUPaPbEV0wFzDEHuVCV4Ak26gDCnBpDt17sJ
	 O9FLFfdxTnW9TyBhVo6w1env8+YTqOcTYEYqVX+I+x5pbpBOEnAqAnJv+6K1oLeK/N
	 67xNd7N3f9C/AhtK3PK/J9F9dvTz427MH5CD8FSu6xY/qSVSzPLNfs0KSUayN/Y0S4
	 /EGKzAiakLl16imLL3GWlxPDZz/o4GqcbCqec+PSb9blfm3cwDtgdQ6RhJqBDNE1G7
	 kpmh4eOKIRqLg==
Message-ID: <42ec2da02cc1260fd1c05bdeb620f770c8ecc767.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/2] [RFC] i3c: ast2600: Add MCTP-over-I3C support
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Dylan Hung <dylan_hung@aspeedtech.com>, robh@kernel.org,
 krzk+dt@kernel.org,  conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au,  alexandre.belloni@bootlin.com,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
 linux-i3c@lists.infradead.org
Cc: BMC-SW@aspeedtech.com
Date: Mon, 06 May 2024 21:46:50 +0800
In-Reply-To: <20240506105120.3028083-1-dylan_hung@aspeedtech.com>
References: <20240506105120.3028083-1-dylan_hung@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dylan,

> Add Aspeed AST2600 I3C controllers and add minimal changes to
> validate
> the functionality for MCTP-over-I3C.
>=20
> Dylan Hung (2):
> =C2=A0 [RFC] ARM: dts: aspeed-g6: Add AST2600 I3Cs

I'd sent a similar patch earlier:

  https://lists.ozlabs.org/pipermail/linux-aspeed/2024-May/012193.html

And a v2 to account for some feedback on the dts layout:

  https://lists.ozlabs.org/pipermail/linux-aspeed/2024-May/012213.html

> =C2=A0 [RFC] i3c: ast2600: Validate AST2600 I3C for MCTP-over-I3C

Looks interesting, I'll check this out soon.

Cheers,


Jeremy

