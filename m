Return-Path: <linux-kernel+bounces-269368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6670943216
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80191C21C75
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7539F1BBBC7;
	Wed, 31 Jul 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnF4awFp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B710C1AE85E;
	Wed, 31 Jul 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436539; cv=none; b=k5wS10ejS2gJ1KkOg/wgWvyd85gRxYVa0dQdUq+T+KWPNk82vYBjUie1EI66MHcH0dao6yHJn9RxQIrf2KkaZL7U8jYeZ/LabUACQVEmiN4i3YdWXCB0RqMtkZJGnj0PhNYK4wOlkBBQjkp9wSCkRL5CPbWPOU3R8pAgKdQsSs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436539; c=relaxed/simple;
	bh=aBuiK8XVC/AWbFtXlYoTM6uaz8Jl1jAwhv2ZA+LhfkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6BpI68olRc11jG0k9D/aY1s4IYj6GATZLzSGeSSj143r8AQJu7tbu7Fho3y3SW4z2gJXkSoqSz/wD6Z1Rxa039fO3KbiknHnfsSX5k3o1TXR/ipzC0P3I5tSiYe/OPJBYEI+zukidUsMz/7eUaZghAwnyq/H8aCQhd2Mk+gBy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnF4awFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C205C4AF09;
	Wed, 31 Jul 2024 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722436539;
	bh=aBuiK8XVC/AWbFtXlYoTM6uaz8Jl1jAwhv2ZA+LhfkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UnF4awFpEcKehNCV9mHyehl4RgyunVLy6QSZxOOnXxREOjUzFX2Yb4DTlJzH6texu
	 3luCovOUAPwx38M9hc4nJtth7Tduu5pDoA7Pajr1dJ0Rvq3xvzI0acQmROdMX2hStS
	 FLKBWBmhQylNa7DGqmoyVk8zyuU0hjw1xhOh2iYqRp66DCKWsrCEMiaCwXM17iB6SN
	 wBt7qjmc2KRu3g76GzpgNwNsWRYT5ivaRsp15cRrxBhGlTuhrvBaIextjesQe4q3oh
	 b5ExF7koseYy/8Z5OiRDMNJVW495dsMiS/2l/6zKJYvAUJxaD9C8xbAOJKZbfyaGOP
	 exJz2hpcf69EQ==
Date: Wed, 31 Jul 2024 08:35:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Eggers <ceggers@arri.de>
Subject: Re: [PATCH v1] dt-bindings: eeprom: at25: add  fujitsu,mb85rs256
 compatible
Message-ID: <172243652016.744265.5521659278356438675.robh@kernel.org>
References: <20240612092934.12282-1-francesco@dolcini.it>
 <20240626063506.GA4324@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626063506.GA4324@francesco-nb>


On Wed, 26 Jun 2024 08:35:06 +0200, Francesco Dolcini wrote:
> Hello Rob,
> 
> On Wed, Jun 12, 2024 at 11:29:34AM +0200, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> >
> > The fujitsu,mb85rs256 is a 256 Kbit SPI memory FRAM in the same family
> > as the two existing fujitsu,mb85rs* compatibles and at25 compatible.
> >
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> > No changes in the driver is required for this to be used, a device tree
> > file using it will come in a later step. Sending to minimize work
> > slowdown because of TI DT maintainer requirements on DT bindings, see
> > https://lore.kernel.org/all/469be7c2-6865-40d4-bd06-15dc3a08b3e3@kernel.org/
> > for more details.
> > ---
> >  Documentation/devicetree/bindings/eeprom/at25.yaml | 1 +
> 
> Are you going to pick this patch? From what I can see in the past
> it was either you or gregkh to apply patches to this file, however
> gregkh is not in cc: here.
> 
> Francesco
> 
> 
> 

Applied, thanks!


