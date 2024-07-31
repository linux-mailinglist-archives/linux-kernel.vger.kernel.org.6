Return-Path: <linux-kernel+bounces-268682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F18E9427CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CF21C22BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99661A71FE;
	Wed, 31 Jul 2024 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="LMBu5sVO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hro13r4+"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D9114B06A;
	Wed, 31 Jul 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410734; cv=none; b=I53fKus42FPoexcnOwbCAnNr2XM10CEaz7zZs0+1+wD5/yxunH0IzirNeQP0xBrYAosNICn6HflLOiy2vFaLJhdr+e9UAoNQI3c56x0QjJJU5ZhYLXGSbPNZ5YB/yGSB/OWFB23M+NI5D5LTri5sQaIoSbO4I6owID94FXWr5yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410734; c=relaxed/simple;
	bh=XkylKA6k21eR+D3vpZ/fdsQuccCX71vl/ZmwvFHk9EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIghjrgdE7hosiY1Ixb/J7ebr6KkIiOCmsSEzLYgoS5AEU9BRuELicS6aylA4ZxNEKwxxKi19m3DgFyUfOD3QAPBxEDhPgmdmhR78sLH9mPpoMetYh13lI0DWGmBmf5sx1p4hMC2VszX33gRuAW2yBNY30Zy7x7f1g6uGlFVPy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=LMBu5sVO; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hro13r4+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1722410731; x=1753946731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ljRVMtI3/uA/PAPJfaXzg5wQ3wGpOg3v75G2fyynLG0=;
  b=LMBu5sVO3RZnYMHthUX4dsKy/qvnyiQRS3d5idYnO/UeZ/Z+Nxy34oKw
   6wEgoW5xII9KtRBVfja9u5WHzKwaYBXV6LPR6TzinXprPXA2K+O3aHzcQ
   RRUif92jZwbVGgg+u9Ogwuv/njeXin4sSOYByIdJex/6/vEPZbXLwRwB2
   45GY7WuAEjSK2J9ZF2Y32IbnQTO4eW8MXOCMky/WObhiLkHyWDIgGz4Gb
   z+Uocup3xOMU/pvoWl+numH6PyA/RfCpUW7h2H79uAbg2Vr5txdGqwMXA
   F96ruE1ocw8t6DhUcn7KcvU/OeBl09a7m2bUy8rOtKsnfyagVWIplZ4xL
   g==;
X-CSE-ConnectionGUID: DZEUvla5TYa6bTDYHRQx/g==
X-CSE-MsgGUID: Tj6tXjdNR3utYAfE3j8VXw==
X-IronPort-AV: E=Sophos;i="6.09,250,1716242400"; 
   d="scan'208";a="38163601"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 31 Jul 2024 09:25:28 +0200
X-CheckPoint: {66A9E6E8-10-2D4D5AC2-F2EAEA09}
X-MAIL-CPID: 28B5A56728CC8C5E94E424D1D7330E5A_3
X-Control-Analysis: str=0001.0A782F21.66A9E6E8.008D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80C40164488;
	Wed, 31 Jul 2024 09:25:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1722410723;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ljRVMtI3/uA/PAPJfaXzg5wQ3wGpOg3v75G2fyynLG0=;
	b=hro13r4+nzHX6adGhRfm9CDDx0nzLN3Afu6T08KwVOeA83q5xPeiwg9k0ukf3zU5YysYkD
	2Dph7HXcKS/QL2yMyaqpK8tl8XwAqEXBVudMh65U+fMnHBvcnmPrGv/zWE2y40EFm/l24h
	LUO2oA//hEiZVrFVv89CG3iQnTRVrw4G5zS+o2/ke5i2Lzu6icS9U3rvU9zLU6n3bCVAf6
	oHLu6MUV5KwCGv8lA+wH9TQc+9GOSoADf83oIHGvfp57UXaMJq9jAVVb2uFPasaF7GizGV
	xlh/tNDEju6wxMtcRd4IfuAEpJ+YxE5WeYen61mfwiS2s5NXlaj5URELtJR+LA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: usb: microchip,usb2514: Add USB2517 compatible
Date: Wed, 31 Jul 2024 09:25:24 +0200
Message-ID: <3633627.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240731071950.989113-1-alexander.stein@ew.tq-group.com>
References: <20240731071950.989113-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Mittwoch, 31. Juli 2024, 09:19:50 CEST schrieb Alexander Stein:
> USB2517 is a 7-port variant of this USB hub. Add an USB compatible
> based on USB vendor & product ID.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/usb/microchip,usb2514.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml=
 b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> index 783c27591e564..245e8c3ce6699 100644
> --- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> +++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> @@ -18,6 +18,7 @@ properties:
>        - usb424,2412
>        - usb424,2417
>        - usb424,2514
> +      - usb424,2517
> =20
>    reg: true
> =20
>=20

One question unrelated to this change but regarding this binding:
Why is this referring usb-hcd.yaml and not usb-device.yaml? This USB hub
is not a host controller but a USB device.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



