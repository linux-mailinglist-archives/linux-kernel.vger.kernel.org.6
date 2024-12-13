Return-Path: <linux-kernel+bounces-444523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48179F083D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E34B188C73C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7492D1B392E;
	Fri, 13 Dec 2024 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+ggrJGb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39818FDDF;
	Fri, 13 Dec 2024 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082940; cv=none; b=J+Wktjzc6JFcQ3m3gZCczM3uXWvFc796tUmmrnkbBeWsJWHerB1FtQPV105/IrSCE0HKWcGPnxLU1T69XE3naUVpt71M1/TE24213KSDberloX2QtE2sxjekvME/gdoBGSkt4ENuVMdaxms08vfwXMy/yXn9J6KyANO0fp1XAbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082940; c=relaxed/simple;
	bh=++bhXlD9Y7I5XHvBU93y5RbnTsWThKKRO/NBUtN7RhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuyLtuj3AydBD6W0/OSRltZM55VksGvVpG1wqlPpVZWRAPWfmD+df1HxUkd2MS7gjYvqOPRBGv5vOYp8zvQA4n8mM6Jhtb0s4WsNROQnFf748XSPkoIGoQ1SpynBY6GkyUA/0I5U+mLTPsrWg/Id/qdZ5JK26ozHxre0zgt3AWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+ggrJGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E4DC4CED0;
	Fri, 13 Dec 2024 09:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734082936;
	bh=++bhXlD9Y7I5XHvBU93y5RbnTsWThKKRO/NBUtN7RhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+ggrJGbh8WNoUrxYl6GHuDtRMflrlTKIiKD4tKOzvcS2g9SJInRK698lYvhUVeGb
	 EgczYJPPbg23J8BurEC0ZSp9z5DEjG8AIADfXygLsLX3ynxNkXMdCu2ADMynvX7R2Z
	 huv/FCOPgcg+bUZmZqoL977JQX1+nfgZfSyW07yAFXgQJhQWjCUiI3disR4RVeqbkv
	 bVDj/7fmWzrVcg2xuYeuexsoC/J+wbAh4a1i3HTPal62NbKuaWinnb3GMQGobg1gjL
	 K2OkbKS64+Ywa4hQ80ylj9sGM3lKBedeVAs5dCnyGn8awlEn6EdpGW1I3ndWGoaqRi
	 9yxZqSJgfhjgA==
Date: Fri, 13 Dec 2024 10:42:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	kernel@pengutronix.de, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Leonard =?utf-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>
Subject: Re: [PATCH stm32-next 1/2] dt-bindings: arm: stm32: add compatible
 strings for Linux Automation GmbH LXA FairyTux 2
Message-ID: <h5gcnt6g5py4shyjpxlr77njkihwepdrn62poii6vyoyvwximv@fmb4becmsvwq>
References: <20241210-lxa-fairytux-v1-0-9aea01cdb83e@pengutronix.de>
 <20241210-lxa-fairytux-v1-1-9aea01cdb83e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241210-lxa-fairytux-v1-1-9aea01cdb83e@pengutronix.de>

On Tue, Dec 10, 2024 at 10:32:27AM +0100, Marc Kleine-Budde wrote:
> From: Leonard G=C3=B6hrs <l.goehrs@pengutronix.de>
>=20
> The Linux Automation GmbH FairyTux2 is a small Linux device based on
> an Octavo Systems OSD32MP153c SiP, that occupies just two slots on a
> DIN rail.
>=20
> Add compatible for the generation 1 and 2 based on the STM32MP153c.
>=20
> Signed-off-by: Leonard G=C3=B6hrs <l.goehrs@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


