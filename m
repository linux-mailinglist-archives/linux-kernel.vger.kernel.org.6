Return-Path: <linux-kernel+bounces-262855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFFF93CDE4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C761F2285D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD815173326;
	Fri, 26 Jul 2024 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="foWbyEGq"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54010172BCA;
	Fri, 26 Jul 2024 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721973649; cv=none; b=CvTYOayFtDsvmBzuKLmgvB5JJpI8gjJbkXQ3sbBwQMLGUNCW5vyFCnLiPLogUjNoypMP0ffP7uSeNTZZ3bIq0VtkAinnnq77gB38PRSftOUFgKZxJqlQL4F+YblQDdjHsFOrhdhX4RUVeCoY6S6XyyPaE6LiJnE3e2w7BPcwLZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721973649; c=relaxed/simple;
	bh=PnqlcM84WAxNl+swGQdrhpcrwrWIJk7Lt4l0m9IDul8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZkU8M3o6T2drDg9E3l9PU1XyqWvkEW9UgcBN8GCuqwSyFMWBtDOXo3JboCh9MPIjwkVKs7abBevoR3JqX87gAT6g73VXWv/VzAS/RAMNdU0E7Q01afRxuJrDqvd9vSgEqr67iCSKkVI0hU4PmKmmum6NP4Dc0+55OY3DSqdg9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=foWbyEGq; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1721973645;
	bh=QdbI3N7Rn42gDGMrzJpsnfGLEwUVSd33OvGXdiMpLbM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=foWbyEGqPuTHASdBk94cKFKPR3WFpX+tk6hU/jIRiOtsHWML8oxuj1NPRaFhBEZsR
	 fRAdgvwqOK3/fb09Vav319CW26jnzdg+uae712ROIV79s1ppn7TXIDPiHDKkwNbLb7
	 sPMeiTMuwstFejO7k3rM9O2sKuVnF3HouebVCTk8n0j9FrxVNOEo2e5swpNjwutei3
	 EyqeqXcjP3TsSDImTOOHIr6eAt/dsruPBUNGHeOQm/g1PKSNyerQBkRRMWWpvjXYr3
	 N258giOsjwxKI/gIoQzj4POi+VM9XqiFjKV81BlSN75J4BpYwhTyoD4ct0XOLHvqbT
	 R4ClGeVYgGopg==
Received: from [192.168.68.112] (unknown [118.211.93.69])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 577B566AB4;
	Fri, 26 Jul 2024 14:00:44 +0800 (AWST)
Message-ID: <a4c2a2c25c7582b7b45fc42662b60c589b4748d4.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 1/1] ARM: dts: aspeed: minerva: add host0-ready pin
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Yang Chen <yangchen.openbmc@gmail.com>, joel@jms.id.au,
 patrick@stwcx.xyz,  amithash@meta.com,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,  devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com, yang.chen@quantatw.com
Date: Fri, 26 Jul 2024 15:30:43 +0930
In-Reply-To: <20240711130501.2900301-2-yangchen.openbmc@gmail.com>
References: <20240711130501.2900301-1-yangchen.openbmc@gmail.com>
	 <20240711130501.2900301-2-yangchen.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-11 at 21:05 +0800, Yang Chen wrote:
> Add host0-ready pin for phosphor-state-manager.
>=20
> Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> index f5ac248097b4..41e2246cfbd1 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> @@ -613,7 +613,7 @@ &gpio0 {
>  	/*P0-P7*/	"","","","","","","","",
>  	/*Q0-Q7*/	"","","","","","power-chassis-control","","",
>  	/*R0-R7*/	"","","","","","","","",
> -	/*S0-S7*/	"","","","","","","","",
> +	/*S0-S7*/	"","","","","","","","host0-ready",
>  	/*T0-T7*/	"","","","","","","","",
>  	/*U0-U7*/	"","","","","","","","",
>  	/*V0-V7*/	"","","","","BAT_DETECT","","power-chassis-good","",

Thanks, I've applied this to a tree for Joel to pick up.

Andrew

