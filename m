Return-Path: <linux-kernel+bounces-313239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 248A696A236
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5356282ECA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DFB18E027;
	Tue,  3 Sep 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9YX1tUn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345BC18BBB4;
	Tue,  3 Sep 2024 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376843; cv=none; b=Zn216/Hdp//dB1zJhP73FxLUWQlb4H6SjSOF56XY2fUwUU445HhMGkc0KbhIbJ7aMTpGsx6dgzyRjcHvAPDWCF9BOyKirXrv3hu7qp83nV0DWkZL2L2nzoXt6WsdTQKQvlOwGpfStFnaC2r7RT/TI3W2pSoKV7DPZ79OJB2berM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376843; c=relaxed/simple;
	bh=5iC3YJfhcms46vJFVZprBYhNqUflnATL0Z4TG63eMro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdMv+JudoOQ+Pq4fLeFr5rYemCkbVDhPL3vDsLn5jGkjFm2R5cH03zxdwUF7b6UytcQvxsGu4OeVETZnxshncep4Nbkx7VYf5BC9NrEaq5q4NtC8xT3kop2h06dIrJwY7yrIKtW9eL80pndMjgmtxZ9BNKf3q7kq4V59m0sBa/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9YX1tUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96255C4CEC4;
	Tue,  3 Sep 2024 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725376842;
	bh=5iC3YJfhcms46vJFVZprBYhNqUflnATL0Z4TG63eMro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r9YX1tUn/g5AN4rnuH9BysGElutmb9zFtUvr+j2gnH2hLXqacdNIEU13EnMsByCDE
	 lmJEmSPKxiHAt2gUzfzcSe4GVYi8oZ1eNsaPZnQPMWlZP5Bg0w8LzdpmcAYAIQydVf
	 IdWHUljXB02MBFfVSdVI7Ft6FJf03rJuaQWcXpysqo4xSsfx6Q1YSssEmWMqKq2LOi
	 C/jOQliu4VNNE69SqkpEO3WkeRIh1Ptp3Pn+sqp+Gf+Vmk0cgOj5pNNjwHVdJ/hmlq
	 6LDrdQim6zOIU/kyQxy8wKQhTwb1n9U4k4Rnjuhq8o43gq2h4sD1GavDZFb29L6U67
	 F4s5w5mjNbo6w==
Date: Tue, 3 Sep 2024 10:20:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: krzk+dt@kernel.org, claudiu.beznea@tuxon.dev, dharma.b@microchip.com,
	nicolas.ferre@microchip.com, tglx@linutronix.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	alexandre.belloni@bootlin.com
Subject: Re: [PATCH v7 03/12] dt-bindings: interrupt-controller: Add support
 for sam9x7 aic
Message-ID: <172537684088.1038142.4709954220078086737.robh@kernel.org>
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
 <20240903064240.49415-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903064240.49415-1-varshini.rajendran@microchip.com>


On Tue, 03 Sep 2024 12:12:40 +0530, Varshini Rajendran wrote:
> Document the support added for the Advanced interrupt controller(AIC)
> chip in the sam9x7 SoC family. New compatible is introduced to capture
> the differences like the number of interrupts supported in the
> integration of the IP to that of the previous designs.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v7:
> 
> - Elaborated the commit message by explaining the difference in IP.
> ---
>  .../devicetree/bindings/interrupt-controller/atmel,aic.yaml      | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


