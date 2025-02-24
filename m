Return-Path: <linux-kernel+bounces-529994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187A4A42D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3953A6F87
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E74323FC49;
	Mon, 24 Feb 2025 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLh1QEjv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAE01F416D;
	Mon, 24 Feb 2025 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427822; cv=none; b=OPnAV4Q4orH3vyCMeALqLsFTZElqrBT1CO5EHaZosZpT6VlOfuJnSNbkZeEftxV/rn1nrpOOGqkorGj2TdPuYdaIHo2Rl8crZ45WiXcpQm3knH0mQFo4vnoKZwg4oBzjxfq7IB4NaAoGOE8/uAeLlZgCplp/Vr3s5Nit0wPNTVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427822; c=relaxed/simple;
	bh=//I4s2iMr9J6rEdDAzVgVvZ0bgv+PoI6wUAC1Ve268s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VopgTlJsMjP9ZLJJY2lPfnnFntuE1vazJq/uxEkCXqKygebWkbUhFOqec01Jl4tQmUb6tLe1PF01mbxwoOWWSY/ChEL4TRPQd2ZW6Mx3KhnE7LzeeaQE9Z3r8AlxoRNK4MifiNhUxgCcyLhgFGycbG7y2krwboUr8eULvNWIAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLh1QEjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE86C4CED6;
	Mon, 24 Feb 2025 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740427822;
	bh=//I4s2iMr9J6rEdDAzVgVvZ0bgv+PoI6wUAC1Ve268s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLh1QEjvRNIcuhtCtWxYwMeqdndZeuETHVY2Zuyp83rJDJ9eYOnSB+RDITXFc929h
	 jTaNDmQGFUIFWzu+L5lT4DBF5Fkz9w9vup88nYgrb1Oo8OlSn0CpncSwSK5dBiHu8D
	 5/LD2tsNm+maVu0/2Ik4OkbcA5dOojRMyuqsrlp9hdS2Fr0PN8ZcokvGPvD9G5Jd4S
	 +Xk+7l2PWOxwnVyfd+75hMRTgvwyE8gYtcCTDOGDNWCAkUZzZoZpXXqazTFY4ZMUWV
	 maLviKqCVoJTYK9667ObN1pKQsUfMp31WWjyQd/+pbW8+pk/2jOi8/vtQXpVQxKXl3
	 aMNRBiWr0Lh7A==
Date: Mon, 24 Feb 2025 14:10:20 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: imx@lists.linux.dev, shawnguo@kernel.org, linux-kernel@vger.kernel.org,
	s.hauer@pengutronix.de, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, festevam@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: fsl,imx-asrc: Reference common
 DAI properties
Message-ID: <174042782051.4022847.1009470798524846957.robh@kernel.org>
References: <20250224090413.727911-1-shengjiu.wang@nxp.com>
 <20250224090413.727911-3-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224090413.727911-3-shengjiu.wang@nxp.com>


On Mon, 24 Feb 2025 17:04:13 +0800, Shengjiu Wang wrote:
> Reference the dai-common.yaml schema to allow '#sound-dai-cells' and
> "sound-name-prefix' to be used.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


