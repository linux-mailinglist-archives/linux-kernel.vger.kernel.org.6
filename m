Return-Path: <linux-kernel+bounces-564663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C0BA65915
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791C23ABAD7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B957FEBE;
	Mon, 17 Mar 2025 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vqw54D15"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2451A23BB;
	Mon, 17 Mar 2025 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229692; cv=none; b=OV1vPZr0nuXusvtE7DaJY8B8jXHxM/w10IlUjW5VyJH2ADn4sUdZ/i4HUh46QH3RpCQ4YmZ8r3bIWzbIoYcj+Unccb5/HwhLMAxBj8UDojR0XOB2OQ0lq23pWPvp+Y4O4sY39PEacKOXKLgpyTUU3412UCJgM0XYONwzQLXNqoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229692; c=relaxed/simple;
	bh=qqk3y8n83Af/OjpaprlIVmcnrEvTFhBi/Q+EjcKQHEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MELh+X4y0/BAjP7Yq0ayUeyGqeKO5vjEs4j6h/52ZMBKNVIWSBOQog2WP2BFCmFnAfsCVo438Hq2kSVniOtR7kt0zX6QkjotWeJgm+zurVUZ4K6rRZPt6b4teI/En2J6AFqa1HODKluAIlqmiEJiTH8tyZ8C9sdIwkigOGFejIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vqw54D15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62C2C4CEE3;
	Mon, 17 Mar 2025 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229692;
	bh=qqk3y8n83Af/OjpaprlIVmcnrEvTFhBi/Q+EjcKQHEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vqw54D153smXoCgBn4N9/yVqCVOvOtaViIstM5kFKF5lMTTkumCkfpBfNdgTZHVp5
	 6K87d7xCZGX5ysgISRq6/9BJQ6iWaeNUKQyIojq8DgLMdzU8L+dUHbKuo99+Y+Bqj1
	 hnUR3FOmWfLJSqTtUtaL6GyB17qv6i31d3FROmNBq2VpjhyscPpsVHDtTUOrLmy6XY
	 d92I9SCdMZgec+BNbCN9yHIAdqH2567L9WeqMOnpNTqDpP0F3gdqMlk3hcYeFJ1Jpq
	 sTjzsXXljN56fIqUc/atC/IpzRBwckUaZtioedmHm6zhr5vHl/aWxOBiCbwjeQbh5X
	 M5zYZBCHIYigQ==
Date: Mon, 17 Mar 2025 11:41:30 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nayab Sayed <nayabbasha.sayed@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	devicetree@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH RESEND] dt-bindings: mtd: atmel,dataflash: convert txt to
 yaml
Message-ID: <174222968999.190541.5419012872834930399.robh@kernel.org>
References: <20250317-atmel-dataflash-v1-1-1a3247f40299@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-atmel-dataflash-v1-1-1a3247f40299@microchip.com>


On Mon, 17 Mar 2025 19:01:08 +0530, Nayab Sayed wrote:
> Convert atmel-dataflash.txt into atmel,dataflash.yaml
> 
> Signed-off-by: Nayab Sayed <nayabbasha.sayed@microchip.com>
> ---
>  .../devicetree/bindings/mtd/atmel,dataflash.yaml   | 55 ++++++++++++++++++++++
>  .../devicetree/bindings/mtd/atmel-dataflash.txt    | 17 -------
>  2 files changed, 55 insertions(+), 17 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


