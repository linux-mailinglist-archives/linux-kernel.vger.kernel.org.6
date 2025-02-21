Return-Path: <linux-kernel+bounces-526740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00552A402A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB301885067
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0C92512DB;
	Fri, 21 Feb 2025 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huOgWP+P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0404918DB0B;
	Fri, 21 Feb 2025 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176853; cv=none; b=UQF/4/FgiyrsDs/iG0zY+FQf4TZMx8plsiwLHRtEKFHNiW8CGHrSXD393oGbE2HpKPFQrGIMZ4Yei2RZAvPHPzSno4ENKwDpqyfEz7sNZSJ2D4qAl+xSZ5UF6QjK8KOaZleSwnZwD5EzJzfOnHc4Fl/tsAE5N2djODqptvLIV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176853; c=relaxed/simple;
	bh=hpLg+CyS426GDFDENnCL8gdyjYb+/S5yY656wfIhHiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0yjuXp5c5L8wQ248sx9S5OmCWxwP/iH+mit9h1WKV5jUl7zFggsOX0WyR61q808cxkZYR6RrWg6v/z+TyaTBExmCAw5R7za4MWzCi3X4e8s6l9f64VOwJULBOvukTiUMauWQZLLdM65kv+Au0S143vTe8S8XvIyUHGB2Qwslgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huOgWP+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26611C4CED6;
	Fri, 21 Feb 2025 22:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740176852;
	bh=hpLg+CyS426GDFDENnCL8gdyjYb+/S5yY656wfIhHiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huOgWP+PCPcfLJpAoFlO5hbj1FIFE76X+pvJi72UUCMegtDrYOXxSt8uMWZNFJw5V
	 n0ZlBHuM7ajDdnLywJ4LdwTHowmbl9fZ7X53nYCnc+zYD1HGSFwUDJ+JW5yF09Ugjy
	 RcCPfHkItxWOdXuzrr1IUx06t+orVTBsgo6qDzMvmgGvt3GfKI9GQng5BR9WpFTTSN
	 NJ3GV5bnoCnZJRj5+lnsCH4V+fsk/V9ay58H4KdLB35BrTD66tEnSdCgTMGeITpQ0K
	 RgZzSAnv5aB5/v9QlDr33qJ1etUSw+FDDCztXJlobOOaskf1tQ90l3BXKxRTEYhZcx
	 gp4ID8FbhRrfw==
Date: Fri, 21 Feb 2025 16:27:30 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Frank.Li@nxp.com, festevam@gmail.com, p.zabel@pengutronix.de,
	shengjiu.wang@nxp.com, devicetree@vger.kernel.org,
	kernel@pengutronix.de, mathieu.poirier@linaro.org,
	krzk+dt@kernel.org, imx@lists.linux.dev, shawnguo@kernel.org,
	iuliana.prodan@nxp.com, peng.fan@nxp.com, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	laurentiu.mihalcea@nxp.com, s.hauer@pengutronix.de
Subject: Re: [PATCH v2 1/8] dt-bindings: reset: audiomix: Add reset ids for
 EARC and DSP
Message-ID: <174017684977.188535.2655294580002590894.robh@kernel.org>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
 <20250219192102.423850-2-daniel.baluta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219192102.423850-2-daniel.baluta@nxp.com>


On Wed, 19 Feb 2025 21:20:55 +0200, Daniel Baluta wrote:
> Add reset ids used for EARC and DSP on i.MX8MP platform.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  include/dt-bindings/reset/imx8mp-reset-audiomix.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 include/dt-bindings/reset/imx8mp-reset-audiomix.h
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


