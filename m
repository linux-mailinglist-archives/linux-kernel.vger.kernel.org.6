Return-Path: <linux-kernel+bounces-375620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E589A9841
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB062832F7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E75512F38B;
	Tue, 22 Oct 2024 05:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugu3A4bs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651745A79B;
	Tue, 22 Oct 2024 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574486; cv=none; b=ej1x6WrxDhWYOKgApexaIN1XJTf+Qe9Et8T7LN+Nk363lXriVLa45e7Ozr2asG9bUQsDRzSwvBoqyzvQmko+cn/OPFXwp47ic4/j+jCg4ki/lNzOiETSs8oy1gP13Ex2Ah8tVZscac+WDa3hw7ianHx2Pbpe8E/mGV6j0H1ngeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574486; c=relaxed/simple;
	bh=nZDFAcO6yoRsupbSgjsjHQewvJyGH7Kw3eZxIShUBWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3O855If+biXChxJkYEiHgN76euGmQwJ2iE/9A4iy0AQfv3W7euHD0GCmWUrUs0hjKaaLYO+YqTOqyCbRAGHN4J6zLqWZKC6EFO9ce4n5y/aNmz3JpSrsGcMd0FY0VXOz9/Pu4rPQoNmC5hXtkIAqE2MapzW7EtrCwZo7DI2fl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugu3A4bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B56C4CEC7;
	Tue, 22 Oct 2024 05:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729574486;
	bh=nZDFAcO6yoRsupbSgjsjHQewvJyGH7Kw3eZxIShUBWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ugu3A4bslGKXQIl2HM0BuEVqkKqFuFV8A0YSDL/V2uNdii445fe8qDXY5U9kzYWMa
	 4azUfmktSEEO/M1ok11n3nlIHrhhFxjm7YKCec7FEtpVIT+nItP0G3ng+bUfEaexAL
	 0LBHOQlCyLTee7I7Cc296qFEeEQUEa7LQuJXRMvfd7TNGcCDyMQnEmNP0YFjFM+aGF
	 m0Rmn0Vsc8b12jwrNl77bEQxp7BmzZhiL9SPzEa6vaqgRundKEaBL053w0dsqxkGUl
	 AuERW+O9LoPHRKHp9jln4NBi9m2SKSDoc6+jJPmnYFSrFb+IBPOnMp4Fyo0aKnTJqo
	 TuMMCq5XPDGcg==
Date: Tue, 22 Oct 2024 07:21:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: Add Gateworks GW82XX-2x
 dev kit
Message-ID: <ilooeedyqplrqvgxooylzdjrdqdb4m4e3nl6zhm5bm5cs2ms4b@wc7wsoxrlgej>
References: <20241021205329.1179426-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021205329.1179426-1-tharvey@gateworks.com>

On Mon, Oct 21, 2024 at 01:53:28PM -0700, Tim Harvey wrote:
> Adds support for the Gateworks GW82XX-2X development kit
> based on a GW82XX baseboard and a GW702X System On Module.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v2: no changes

Why? What about my email?

Best regards,
Krzysztof


