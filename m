Return-Path: <linux-kernel+bounces-313236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE3196A22C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EFF288342
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454FA18BB81;
	Tue,  3 Sep 2024 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbk2iYQU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893811885BC;
	Tue,  3 Sep 2024 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376786; cv=none; b=NUkQwXewyBReqPSds8cDCdYSCw20kvXddb3zbzvmos/EpG81U5uy9paHE7CKPcv++bRRSr2JKwtLkamaDiSjtgkjprsZ4bz3x10Ug7zI5t1X/F1EzBaqiDI0IFUk2BQquQzLFzSpdOizj8wXUkcXc74NylZD1q4P8vbv9pYKGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376786; c=relaxed/simple;
	bh=+0qkQcTLuPB/TnUCPxHpSWHlgBQAayfiJ/jdPsTKGCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtyQwGJLcTt1Jw5wdFsHDFo+/jT5yX/NHGrsbYna/RemnqS0SqHYqTh48womn70g7V9mX5wSaMWVqvPFhnB0hf+gvEyhVmI/Sn+Cx4y5RLk+2KdH/pGq60g1Hf2L0REUsaRPh4mG183HE+YBxPw6Ptu/6OgqAbwQKntGp/vbiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbk2iYQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AA5C4CEC4;
	Tue,  3 Sep 2024 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725376786;
	bh=+0qkQcTLuPB/TnUCPxHpSWHlgBQAayfiJ/jdPsTKGCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbk2iYQU+0fzlBCM4zIU1hq2PbTV+m6T+gE03cnaTsRBd0kxvb7M77dq0sTfsO7Op
	 t5R+mR2gvAu1yeEt6m283kqR7SU3vXERoVR/Xfr32UhXiSJ2Hv4vbR+BiVxpEXw2ao
	 hS6EZMvmgL03S6K4TEqbxrO3GMv6OECRc3X5xmgFCJkdRGyxLFDkxYYcIHLBVdBDBB
	 a9nuh9lXbCnFFfvHyyzp1DEu1QR1b7fen6tiQX5Z4AY9UEOcV7ZQexQY58cygrWMOO
	 nCfBHJQzpsUDOwmX+tWFU8ZYqybjbmOb3Dv3RioTngWUN7G4J9edoVvvMkuLgiUp/e
	 zw1I82amoQtqw==
Date: Tue, 3 Sep 2024 10:19:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: krzk+dt@kernel.org, devicetree@vger.kernel.org,
	alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev, conor@kernel.org,
	nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 02/12] dt-bindings: microchip: atmel,at91rm9200-tcb:
 add sam9x7 compatible
Message-ID: <172537678441.1036972.2017632915833338890.robh@kernel.org>
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
 <20240903064233.49366-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903064233.49366-1-varshini.rajendran@microchip.com>


On Tue, 03 Sep 2024 12:12:33 +0530, Varshini Rajendran wrote:
> Add support for sam9x7 device compatible with sama5d2 compatible as the
> fallback as the sam9x7 SoC uses the same tcb IP as the latter.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v7:
> 
> - Elaborated the commit message with justifications to the fallback.
> ---
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


