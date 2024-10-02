Return-Path: <linux-kernel+bounces-346955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B41898CB6A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A03D1C2128A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDD6FC0A;
	Wed,  2 Oct 2024 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="WIz+3wtD"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE611FC8;
	Wed,  2 Oct 2024 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727838676; cv=none; b=aoqnjtL8jZbNduyButUmGy/6qtBy46vzFMnyjQqvq2yMktWFlZPqKIrH7chG+8DcIHcACmvzPDYtBRni12ops77x5FuUKL19p9r2SQHe2zvN+w8FlcFDzvVgV6676LUzYtHCjZBPtFJAt7xslx9e+G/7oMqIsooS5BVBPq1Nmts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727838676; c=relaxed/simple;
	bh=V1SsJh4sA3CfM9pLFXKdbdbYR0OMfp8zligAl2V9pYw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7m9LzxmDdWkYvf/EnmNQn6J9b+zDgh8qMJwQC1QexgyNeEh3WXZWjSbS+O5QHUeBE5S5KHvTprlPjzy5Uwn+uy5iYT5eJWqhiJl4+zHxu/ihDLIf7StU13I+8pN2X6p+o6uIL7nsRJxviJhUoqNVSCCvT6Z07+mzFXpXlFdx1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=WIz+3wtD; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727838672;
	bh=5+asHEmTWbRF/II5PIT3MLf7M7hMkwvunY3a2j/zFXQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WIz+3wtDEOPuqhHkWCGrbFDl6OzMEGcsELflmuL2LYvknCn2+a/L/zlnO15OH+XnF
	 yD3O1zLkpD/I1GexNgNIUtVqMEFBiJtSr8dT4T/d9Pht28WP1yEnuWWyZufHzgcrTv
	 WOhiCd9Y4+8nDxy78Tam3+xdK0IpeFAjsg4+Jr5WYEii/b0rpqwxUInAFIRW0z6CqO
	 FW+N/lLaJP1D1oGeLqz8psgdiXJzvkHhDDaIdN7qIYtB+w0/xTa1OGYnL22owPebkv
	 1J8RO3uYfxDU3WWwjXXfHpNWimwbm+KB0BZODG9+23P+hilDJNKEM5wr6quEx8vg3d
	 QFHX1o7olPf2w==
Received: from [192.168.68.112] (ppp118-210-73-17.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.17])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3FE7264BDC;
	Wed,  2 Oct 2024 11:11:12 +0800 (AWST)
Message-ID: <0ce7c039983bbc0c5bc1a1600a3613337cc45ae9.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts nuvoton: Add EDAC node
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "William A. Kennington III" <william@wkennington.com>, Tomer Maimon
	 <tmaimon77@gmail.com>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, "William A. Kennington III" <wak@google.com>
Date: Wed, 02 Oct 2024 12:41:11 +0930
In-Reply-To: <20240930214659.193376-1-william@wkennington.com>
References: <20240930214659.193376-1-william@wkennington.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi William,

As a bit of a nit, you missed the `:` after `dts` in the patch subject.

On Mon, 2024-09-30 at 14:46 -0700, William A. Kennington III wrote:
> From: "William A. Kennington III" <wak@google.com>
>=20
> We have the driver support code, now we just need to expose the device
> node which can export the EDAC properties for the system memory
> controller. Tested on real hardware to verify that error counters show
> up.
>=20
> Signed-off-by: William A. Kennington III <wak@google.com>
> ---
>  arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch=
/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> index 5aeb5009a5d7..019abceb16a0 100644
> --- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> +++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> @@ -127,6 +127,13 @@ clk: clock-controller@f0801000 {
>  			clocks =3D <&clk_refclk>, <&clk_sysbypck>, <&clk_mcbypck>;
>  		};
> =20
> +		mc: memory-controller@f0824000 {
> +			compatible =3D "nuvoton,";

This compatible string doesn't look right to me. Are you sure?

Andrew

