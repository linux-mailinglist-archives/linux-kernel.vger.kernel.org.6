Return-Path: <linux-kernel+bounces-291107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA072955D64
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 18:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789E4B20EB2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330411465BA;
	Sun, 18 Aug 2024 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5v1diRX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7338412B93;
	Sun, 18 Aug 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723997531; cv=none; b=Yoc1vX1ZPKyEy1N+JmSTccLnOwZL/IG+kP+Stl89V+SL77vmt2lY24ZQRRHOTZAZRNCoNHjPH6HsjTwc4nuiJocxbOME7/STQo3KbQVN7x/5TMElvfqUYnFPN6Xv8T7rQ+71r7xF1Uo3UFcoidxqI8Tg9KZCBtRRaEcLycsxGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723997531; c=relaxed/simple;
	bh=ruS7y2wKnEPgI7gkRFDbH9dgOjAhSQz1+QJFBGsSogg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umjqgy7nk8joJhCcbtHXsAh7qfJw6uelfQO1sEQbXVmhtLL4f7lqUVEuyYAck167VyB3nfvNs3oZKao9htu2bi3x5sHTMbAGke9MMvKUIWLh43RTlVcdHKClvuztDXQkoy2dkRq+oKgDDxXuek4tkKmbDRi8kHVYshN7lH6Mmzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5v1diRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AFDC32786;
	Sun, 18 Aug 2024 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723997530;
	bh=ruS7y2wKnEPgI7gkRFDbH9dgOjAhSQz1+QJFBGsSogg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5v1diRXjN5kVoybKiTRPIY9aA1UEswchRcP7JWhmjuTH30Uxt/N6e4vImG9MKyi4
	 6bmE2jh2SZ7vn8Rc14BnpHiGM9+6lYeiRZCNJ2CBp9iYQv7LHx4AN6pnEyKkHgw67o
	 KXP16ARCwLB2ZLP39z4dnWHFcbBnBdCIH0d3oz5IJyRqNfVMAStsl4Z6GChM/R36+/
	 c+XRGsJy1IM/v38lc4EfUxHgcXc+dQmjo8V0hRu7abz+Rdx4gJ1U1EDogbnTxF1gFD
	 u+LM+xIPcSZAgsvw9duok9IoCB+1CIBkT1u7slJWeUIPeANwBtM1COkq8JFSEt3H1Q
	 3FGE6dADp0d+Q==
Date: Sun, 18 Aug 2024 10:12:05 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Aryabhatta Dey <aryabhattadey35@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	krzk+dt@kernel.org, vgupta@kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org
Subject: Re: [RFC PATCH] dt-bindings: arc: convert archs-pct.txt to yaml
Message-ID: <172399743227.172916.628419421629636564.robh@kernel.org>
References: <emosjjbdwimwevrf2ew2dpn5sdx254el5fanhhquouu4bz6nbe@zqyp5ra7bmhh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <emosjjbdwimwevrf2ew2dpn5sdx254el5fanhhquouu4bz6nbe@zqyp5ra7bmhh>


On Sat, 17 Aug 2024 08:56:29 +0530, Aryabhatta Dey wrote:
> Convert dt-binding archs-pct from txt to yaml format.
> 
> Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
> ---
>  .../devicetree/bindings/arc/archs-pct.txt     | 17 ----------
>  .../bindings/arc/snps,archs-pct.yaml          | 33 +++++++++++++++++++
>  2 files changed, 33 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arc/archs-pct.txt
>  create mode 100644 Documentation/devicetree/bindings/arc/snps,archs-pct.yaml
> 

Applied, thanks!

However, if you are going to do more conversions, please pick ones more 
widely used first as Krzysztof pointed out.

Rob

