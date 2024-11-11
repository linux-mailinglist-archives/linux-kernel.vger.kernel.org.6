Return-Path: <linux-kernel+bounces-404915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF969C4A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C791B2812D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28791C9DE5;
	Mon, 11 Nov 2024 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="kzYM1tMm"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ABC1BDAA1;
	Mon, 11 Nov 2024 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369217; cv=none; b=RPj0c9s1rOhKUOGokrjskoOIEcLR5pEE5Gr7BI1QWbsxDZf5YZSAhsEzRyYLoZglpp+tHBDK/iMOIDFy1CC/He7VyO8/gAEA5lx6q+ruByT5+5vhLHQAhmRba4x3YHIUJjn5fQefNYpoUG5XykIYSyrNY52/q3AqhxqK7Pa88Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369217; c=relaxed/simple;
	bh=/1kbnaXoTlpDzhR7Und7m0yG1HUq2WsmOLWdk0VxH2U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HumY01kdeWd02nsDbgO0ithJIG10CnPtxBRwnz+okHN8y4zEGuElqL6i8mlojkzEGl9fW0K+lSWN7CvvaPJwzG0M9XTZKyO06PyYGzhFyXpdCGx/OWslnFGiUbPYqsmGvByEXPjx/VsGa3JwuENtp3ToBhb9EFRfhN0h4lGzHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=kzYM1tMm; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731369206;
	bh=/1kbnaXoTlpDzhR7Und7m0yG1HUq2WsmOLWdk0VxH2U=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=kzYM1tMmRXj67bu5aN2rYgWXRdBhCtsYVc1CRiDHRq0DMX6IBCZzXs/b3TDGtWyn6
	 8InZgahjgAodowhz+RAX9ztwkB3hwkk66PVyQSN1Ewcbkc048gbBvs5G81SJHk7myO
	 yjh71q0HyINmvgElK7mRITBEanF3XaDA0jD8vAnnpB0uUOW4JfIdHWI26yMQOVMtdP
	 njvoialn2fQdzvn828mP02TFz7IFzkt1aqfG87xSVumEocXTC53xo7XLjozG6vjvGl
	 LdWP+iZXCDay/2Ox1GtDy2SZsyNQ4Y50s3UqlUUhtIwh8lZF+t5GrsGuxC3DekiLC9
	 CEM+G/OcxQ8IA==
Received: from [192.168.68.112] (ppp118-210-164-236.adl-adc-lon-bras34.tpg.internode.on.net [118.210.164.236])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1E96566029;
	Tue, 12 Nov 2024 07:53:25 +0800 (AWST)
Message-ID: <434b2dab17050643badc60c50b361153631b7cdd.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 3/5] ARM: dts: aspeed: Harma: Revise GPIO line name
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>, Rob Herring
 <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue, 12 Nov 2024 10:23:24 +1030
In-Reply-To: <20241111094349.2894060-4-peteryin.openbmc@gmail.com>
References: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
	 <20241111094349.2894060-4-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Peter,

On Mon, 2024-11-11 at 17:43 +0800, Peter Yin wrote:
> =C2=A0 Add:
> =C2=A0=C2=A0=C2=A0 "ac-power-button",
> =C2=A0=C2=A0=C2=A0 "asic0-card-type-detection0-n"
> =C2=A0=C2=A0=C2=A0 "asic0-card-type-detection1-n"
> =C2=A0=C2=A0=C2=A0 "asic0-card-type-detection2-n"
>=20
> =C2=A0=C2=A0=C2=A0 "cpu0-prochot-alert",
> =C2=A0=C2=A0=C2=A0 "cpu0-thermtrip-alert",
>=20
> =C2=A0=C2=A0=C2=A0 "irq-uv-detect-alert",
> =C2=A0=C2=A0=C2=A0 "irq-hsc-alert",
>=20
> =C2=A0=C2=A0=C2=A0 "uart-switch-button"
> =C2=A0=C2=A0=C2=A0 "uart-switch-lsb"
> =C2=A0=C2=A0=C2=A0 "uart-switch-msb"
>=20
> =C2=A0=C2=A0=C2=A0 "leakage-detect-alert",
>=20
> =C2=A0=C2=A0=C2=A0 "power-card-enable",
> =C2=A0=C2=A0=C2=A0 "power-fault-n",
> =C2=A0=C2=A0=C2=A0 "power-hsc-good",
> =C2=A0=C2=A0=C2=A0 "power-chassis-good"
> =C2=A0=C2=A0=C2=A0 "presence-post-card",
> =C2=A0=C2=A0=C2=A0 "presence-cmm"
> =C2=A0=C2=A0=C2=A0 "pvdd11-ocp-alert"
>=20
> =C2=A0=C2=A0=C2=A0 "reset-control-cmos-clear"
> =C2=A0=C2=A0=C2=A0 "reset-cause-pcie",
> =C2=A0=C2=A0=C2=A0 "reset-cause-platrst",
>=20
> =C2=A0=C2=A0=C2=A0 "P0_I3C_APML_ALERT_L",

Rather than list the identifiers that are already contained in the
patch, can you please discuss what functionality these identifiers
enable, how different functions are related, and why this must all be
done in one patch?

>=20
> =C2=A0 Rename:
> =C2=A0=C2=A0=C2=A0 "power-cpu-good" to "host0-ready",
> =C2=A0=C2=A0=C2=A0 "host-ready-n" to "post-end-n

On the other-hand, explicitly calling out these changes is helpful, but
please also discuss the motivation and impact.

Andrew

