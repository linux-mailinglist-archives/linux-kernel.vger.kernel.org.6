Return-Path: <linux-kernel+bounces-441030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D01699EC865
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49971637AB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19663DABEB;
	Wed, 11 Dec 2024 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI/kqwyG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A623EA60;
	Wed, 11 Dec 2024 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908059; cv=none; b=kBtpeFaL4e953yUVBgeQ+QmJjjnrdv1egRTR5uZNhSqLKysZhbhbh0h/l8PBu8aLPVVw51MtarSJS9WFA7APyV4e2sawBGQXNb1ojPnBn5Ye1d+Z4Q/sA4DTrxaMKyQsIxiH26JWxoFI4bpuyf2iXljVOXqnvbxaEL2Efj7ifnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908059; c=relaxed/simple;
	bh=kdr44ZFWALRmzKhMErBMYbgtszA9aLiO1WmwzyljX3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbUqlKPDWPSr4OKKculBZKtqJk6TK1Z9zO1AcO+T+h2C31t1dI4FmMFwX2SuCdMo/WB90Lmwuc4TxquEifqHtcuZWM5Twvhb3OT1tA2MFYlnyVxKOm8IoQ6iXquBr2FKTOl/WVRNgcOCKydM1lgQOuouF8BfU3B6igPJZnAeAvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI/kqwyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A093C4CED2;
	Wed, 11 Dec 2024 09:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733908058;
	bh=kdr44ZFWALRmzKhMErBMYbgtszA9aLiO1WmwzyljX3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uI/kqwyG+FFyXV+CgtZw1SWrkPw34oK5VtLRyCuT8SoaGPshxdbxzYtjJwPY7V3Xg
	 gUPcrXVrJspTB48Beev7OGYq3+Rr2giH2z2P57WG8xBnt8J1goTqC2wo/0rUar82fI
	 P9ldaJhmDXutm0RMgsJxqGAuhWrxrnlBai5HC1Cq6XNWsXePtSbw8uDk0asBiDgeHP
	 krU2f+cilkMNqRQzPVRdHeJSI0IZhorJKRo4py1C/Sj2yrY+EH4HH4dJgy9d7ZCse4
	 XlMkzGyX38Og3BPuw+iZIQNnWq1lXJT4S1EpSnm6Q0c9RTFCv8zDR7KWJyNhKPxZfx
	 GIIMHJH4GmY0w==
Date: Wed, 11 Dec 2024 10:07:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, festevam@gmail.com, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, frank.li@nxp.com, aisheng.dong@nxp.com, daniel.baluta@gmail.com, 
	laurentiu.mihalcea@nxp.com, shengjiu.wang@nxp.com, iuliana.prodan@nxp.com, 
	a.fatoum@pengutronix.de
Subject: Re: [PATCH v3 4/6] dt-bindings: clock: imx8mp: Add syscon compatible
Message-ID: <247owlllg4dzqdk2sead5xb33x5pclkrhuvnthdepem3dwrecf@xauk2um726he>
References: <20241210125338.104959-1-daniel.baluta@nxp.com>
 <20241210125338.104959-5-daniel.baluta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210125338.104959-5-daniel.baluta@nxp.com>

On Tue, Dec 10, 2024 at 02:53:36PM +0200, Daniel Baluta wrote:
> imx8mp audiomix contains a set of registers used to control
> the DSP.
> 
> The dsp will use this to acquire o reference to audiomix registers
> and handle the registers to control the dsp.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


